Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B795E3DC383
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 07:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhGaF1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 01:27:12 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:39806 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhGaF1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 01:27:11 -0400
X-QQ-mid: bizesmtp38t1627709210t835i70l
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 31 Jul 2021 13:26:48 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: s7pJguWOSDAMFImT23sH0iw24VPXGJfxegD2ZKiEalCHy0MMfVGLOoIP/046a
        Ao3Du8N4vAZuxCxa7MtgTPx//64DMo9ih+6gQ8zO+RApdwPQ1JzqPXifOeWOkaWHlupCNCl
        C6KiBqj2UAV95IAHcvZ8APHe3UZwUo7ffjP/8nzq6/PDQ02/IlvluXjCB+RI9INv1VqYM/D
        QWomz7TzdcnGlerPvhdFlZ1+S4gH3pghYK9mQY27Oqpf+pRChmf5Cs7vMip8YyYOIskZjOD
        ngMTOi8BMN6dL55D1ZKrsKExXDFXg3qtWr2C7BOPSg0GdYSELK4C3K6JXb40PdhQEDqA==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, leon@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ALSA: pcxhr: use __func__ to get funcion's name in an output message
Date:   Sat, 31 Jul 2021 13:26:47 +0800
Message-Id: <20210731052647.141046-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer using '"%s...", __func__' to get current function's name in
an output message.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 sound/pci/pcxhr/pcxhr.c | 47 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 96b9371c201a..242bd7e04b3e 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -366,7 +366,7 @@ static int pcxhr_sub_set_clock(struct pcxhr_mgr *mgr,
 		mgr->codec_speed = speed;	/* save new codec speed */
 	}
 
-	dev_dbg(&mgr->pci->dev, "pcxhr_sub_set_clock to %dHz (realfreq=%d)\n",
+	dev_dbg(&mgr->pci->dev, "%s to %dHz (realfreq=%d)\n", __func__,
 		    rate, realfreq);
 	return 0;
 }
@@ -499,7 +499,7 @@ static int pcxhr_set_stream_state(struct snd_pcxhr *chip,
 	else {
 		if (stream->status != PCXHR_STREAM_STATUS_SCHEDULE_STOP) {
 			dev_err(chip->card->dev,
-				"pcxhr_set_stream_state CANNOT be stopped\n");
+				"%s CANNOT be stopped\n", __func__);
 			return -EINVAL;
 		}
 		start = 0;
@@ -524,7 +524,7 @@ static int pcxhr_set_stream_state(struct snd_pcxhr *chip,
 	err = pcxhr_send_msg(chip->mgr, &rmh);
 	if (err)
 		dev_err(chip->card->dev,
-			"ERROR pcxhr_set_stream_state err=%x;\n", err);
+			"ERROR %s err=%x;\n", __func__, err);
 	stream->status =
 	  start ? PCXHR_STREAM_STATUS_STARTED : PCXHR_STREAM_STATUS_STOPPED;
 	return err;
@@ -570,7 +570,7 @@ static int pcxhr_set_format(struct pcxhr_stream *stream)
 		break;
 	default:
 		dev_err(chip->card->dev,
-			"error pcxhr_set_format() : unknown format\n");
+			"error %s() : unknown format\n", __func__);
 		return -EINVAL;
 	}
 
@@ -615,7 +615,7 @@ static int pcxhr_set_format(struct pcxhr_stream *stream)
 	err = pcxhr_send_msg(chip->mgr, &rmh);
 	if (err)
 		dev_err(chip->card->dev,
-			"ERROR pcxhr_set_format err=%x;\n", err);
+			"ERROR %s err=%x;\n", __func__, err);
 	return err;
 }
 
@@ -630,7 +630,7 @@ static int pcxhr_update_r_buffer(struct pcxhr_stream *stream)
 	stream_num = is_capture ? 0 : subs->number;
 
 	dev_dbg(chip->card->dev,
-		"pcxhr_update_r_buffer(pcm%c%d) : addr(%p) bytes(%zx) subs(%d)\n",
+		"%s(pcm%c%d) : addr(%p) bytes(%zx) subs(%d)\n", __func__,
 		is_capture ? 'c' : 'p',
 		chip->chip_idx, (void *)(long)subs->runtime->dma_addr,
 		subs->runtime->dma_bytes, subs->number);
@@ -721,21 +721,20 @@ static void pcxhr_start_linked_stream(struct pcxhr_mgr *mgr)
 	}
 	if (capture_mask == 0 && playback_mask == 0) {
 		mutex_unlock(&mgr->setup_mutex);
-		dev_err(&mgr->pci->dev, "pcxhr_start_linked_stream : no pipes\n");
+		dev_err(&mgr->pci->dev, "%s : no pipes\n", __func__);
 		return;
 	}
 
-	dev_dbg(&mgr->pci->dev, "pcxhr_start_linked_stream : "
-		    "playback_mask=%x capture_mask=%x\n",
-		    playback_mask, capture_mask);
+	dev_dbg(&mgr->pci->dev, "%s : playback_mask=%x capture_mask=%x\n",
+		    __func__, playback_mask, capture_mask);
 
 	/* synchronous stop of all the pipes concerned */
 	err = pcxhr_set_pipe_state(mgr,  playback_mask, capture_mask, 0);
 	if (err) {
 		mutex_unlock(&mgr->setup_mutex);
-		dev_err(&mgr->pci->dev, "pcxhr_start_linked_stream : "
+		dev_err(&mgr->pci->dev, "%s : "
 			   "error stop pipes (P%x C%x)\n",
-			   playback_mask, capture_mask);
+			   __func__, playback_mask, capture_mask);
 		return;
 	}
 
@@ -778,9 +777,9 @@ static void pcxhr_start_linked_stream(struct pcxhr_mgr *mgr)
 	err = pcxhr_set_pipe_state(mgr, playback_mask, capture_mask, 1);
 	if (err) {
 		mutex_unlock(&mgr->setup_mutex);
-		dev_err(&mgr->pci->dev, "pcxhr_start_linked_stream : "
+		dev_err(&mgr->pci->dev, "%s : "
 			   "error start pipes (P%x C%x)\n",
-			   playback_mask, capture_mask);
+			   __func__, playback_mask, capture_mask);
 		return;
 	}
 
@@ -889,7 +888,7 @@ static int pcxhr_hardware_timer(struct pcxhr_mgr *mgr, int start)
 	}
 	err = pcxhr_send_msg(mgr, &rmh);
 	if (err < 0)
-		dev_err(&mgr->pci->dev, "error pcxhr_hardware_timer err(%x)\n",
+		dev_err(&mgr->pci->dev, "error %s err(%x)\n", __func__,
 			   err);
 	return err;
 }
@@ -904,7 +903,7 @@ static int pcxhr_prepare(struct snd_pcm_substream *subs)
 	int err = 0;
 
 	dev_dbg(chip->card->dev,
-		"pcxhr_prepare : period_size(%lx) periods(%x) buffer_size(%lx)\n",
+		"%s : period_size(%lx) periods(%x) buffer_size(%lx)\n", __func__,
 		    subs->runtime->period_size, subs->runtime->periods,
 		    subs->runtime->buffer_size);
 
@@ -997,12 +996,12 @@ static int pcxhr_open(struct snd_pcm_substream *subs)
 	runtime->hw = pcxhr_caps;
 
 	if( subs->stream == SNDRV_PCM_STREAM_PLAYBACK ) {
-		dev_dbg(chip->card->dev, "pcxhr_open playback chip%d subs%d\n",
-			    chip->chip_idx, subs->number);
+		dev_dbg(chip->card->dev, "%s playback chip%d subs%d\n",
+			    __func__, chip->chip_idx, subs->number);
 		stream = &chip->playback_stream[subs->number];
 	} else {
-		dev_dbg(chip->card->dev, "pcxhr_open capture chip%d subs%d\n",
-			    chip->chip_idx, subs->number);
+		dev_dbg(chip->card->dev, "%s capture chip%d subs%d\n",
+			    __func__, chip->chip_idx, subs->number);
 		if (mgr->mono_capture)
 			runtime->hw.channels_max = 1;
 		else
@@ -1011,8 +1010,8 @@ static int pcxhr_open(struct snd_pcm_substream *subs)
 	}
 	if (stream->status != PCXHR_STREAM_STATUS_FREE){
 		/* streams in use */
-		dev_err(chip->card->dev, "pcxhr_open chip%d subs%d in use\n",
-			   chip->chip_idx, subs->number);
+		dev_err(chip->card->dev, "%s chip%d subs%d in use\n",
+			   __func__, chip->chip_idx, subs->number);
 		mutex_unlock(&mgr->setup_mutex);
 		return -EBUSY;
 	}
@@ -1077,7 +1076,7 @@ static int pcxhr_close(struct snd_pcm_substream *subs)
 
 	mutex_lock(&mgr->setup_mutex);
 
-	dev_dbg(chip->card->dev, "pcxhr_close chip%d subs%d\n",
+	dev_dbg(chip->card->dev, "%s chip%d subs%d\n", __func__,
 		    chip->chip_idx, subs->number);
 
 	/* sample rate released */
@@ -1572,7 +1571,7 @@ static int pcxhr_probe(struct pci_dev *pci,
 	/* init setup mutex*/
 	mutex_init(&mgr->setup_mutex);
 
-	mgr->prmh = kmalloc(sizeof(*mgr->prmh) + 
+	mgr->prmh = kmalloc(sizeof(*mgr->prmh) +
 			    sizeof(u32) * (PCXHR_SIZE_MAX_LONG_STATUS -
 					   PCXHR_SIZE_MAX_STATUS),
 			    GFP_KERNEL);
-- 
2.32.0

