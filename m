Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25C832AA5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835746AbhCBTSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:18:55 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:10191 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579551AbhCBQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:58:57 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id D10B9A17C5;
        Tue,  2 Mar 2021 17:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=Iq2O+faTDVb2
        vlZ2E3J4cQ1DqJ4S6FQ6CtKxj20OPQk=; b=GQmy+uqTDKQMXUfXaTOMxHbzM90U
        Xc12b7KSYDXBgpIBWyic2EXqMqnCUxPk524Jtg+/ttlnits6oevMe0UEhs0kZ3G6
        fLPxvbCMKlqGQREzs8NC4Tf2vDS8VuvGUqdtoXqyNOXlbP7ZJrxFDdMoY8UNQ1Jf
        Gom5ot4aEZLMb/yVb4I0vThpupY/Ubn3h//xuliIuM8i9XZLjKy8rx8lIG/RkBzz
        wr0TSgASOkRarqr3Q7H2EsUEdDgxVD2os7bIJzQ/hfmdrIOc1JLQ6IhxAGO3b6QY
        ynoyIAXC/u5I3NueXPuwGKyOPVbXdH1mvIopY8o+efoknKEN8NMq/4hhsQ==
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
To:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 9/9] ALSA: virtio: introduce device suspend/resume support
Date:   Tue, 2 Mar 2021 17:47:09 +0100
Message-ID: <20210302164709.3142702-10-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
References: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All running PCM substreams are stopped on device suspend and restarted
on device resume.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/virtio_card.c    | 56 +++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h     |  3 ++
 sound/virtio/virtio_pcm_ops.c | 33 ++++++++++++++++-----
 3 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 1c03fcc41c3b..ae9128063917 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -362,6 +362,58 @@ static void virtsnd_remove(struct virtio_device *vdev)
 	kfree(snd->event_msgs);
 }
 
+#ifdef CONFIG_PM_SLEEP
+/**
+ * virtsnd_freeze() - Suspend device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_freeze(struct virtio_device *vdev)
+{
+	struct virtio_snd *snd = vdev->priv;
+	unsigned int i;
+
+	virtsnd_disable_event_vq(snd);
+	virtsnd_ctl_msg_cancel_all(snd);
+
+	vdev->config->del_vqs(vdev);
+	vdev->config->reset(vdev);
+
+	for (i = 0; i < snd->nsubstreams; ++i)
+		cancel_work_sync(&snd->substreams[i].elapsed_period);
+
+	kfree(snd->event_msgs);
+	snd->event_msgs = NULL;
+
+	return 0;
+}
+
+/**
+ * virtsnd_restore() - Resume device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_restore(struct virtio_device *vdev)
+{
+	struct virtio_snd *snd = vdev->priv;
+	int rc;
+
+	rc = virtsnd_find_vqs(snd);
+	if (rc)
+		return rc;
+
+	virtio_device_ready(vdev);
+
+	virtsnd_enable_event_vq(snd);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_SOUND, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -374,6 +426,10 @@ static struct virtio_driver virtsnd_driver = {
 	.validate = virtsnd_validate,
 	.probe = virtsnd_probe,
 	.remove = virtsnd_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtsnd_freeze,
+	.restore = virtsnd_restore,
+#endif
 };
 
 static int __init init(void)
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 1353fdc9bd69..062eb8e8f2cf 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -31,6 +31,8 @@ struct virtio_pcm_msg;
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
  *           side.
+ * @suspended: True if the substream is suspended and must be reconfigured on
+ *             the device side at resume.
  * @msgs: Allocated I/O messages.
  * @nmsgs: Number of allocated I/O messages.
  * @msg_last_enqueued: Index of the last I/O message added to the virtqueue.
@@ -52,6 +54,7 @@ struct virtio_pcm_substream {
 	bool xfer_enabled;
 	bool xfer_xrun;
 	bool stopped;
+	bool suspended;
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
 	int msg_last_enqueued;
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 0682a2df6c8c..f8bfb87624be 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -115,6 +115,7 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
 	vss->stopped = !!virtsnd_pcm_msg_pending_num(vss);
+	vss->suspended = false;
 
 	/*
 	 * If the substream has already been used, then the I/O queue may be in
@@ -272,16 +273,31 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	struct virtio_device *vdev = vss->snd->vdev;
 	struct virtio_snd_msg *msg;
 
-	if (virtsnd_pcm_msg_pending_num(vss)) {
-		dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
-			vss->sid);
-		return -EBADFD;
+	if (!vss->suspended) {
+		if (virtsnd_pcm_msg_pending_num(vss)) {
+			dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
+				vss->sid);
+			return -EBADFD;
+		}
+
+		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+		vss->hw_ptr = 0;
+		vss->msg_last_enqueued = -1;
+	} else {
+		struct snd_pcm_runtime *runtime = substream->runtime;
+		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+		unsigned int period_bytes = snd_pcm_lib_period_bytes(substream);
+		int rc;
+
+		rc = virtsnd_pcm_dev_set_params(vss, buffer_bytes, period_bytes,
+						runtime->channels,
+						runtime->format, runtime->rate);
+		if (rc)
+			return rc;
 	}
 
-	vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
-	vss->hw_ptr = 0;
 	vss->xfer_xrun = false;
-	vss->msg_last_enqueued = -1;
+	vss->suspended = false;
 	vss->msg_count = 0;
 
 	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
@@ -336,6 +352,9 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 		}
 
 		return virtsnd_ctl_msg_send_sync(snd, msg);
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		vss->suspended = true;
+		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
 		vss->stopped = true;
 		fallthrough;
-- 
2.30.1


