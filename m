Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7D357AE0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhDHDpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDHDpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:45:51 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C8C061760;
        Wed,  7 Apr 2021 20:45:39 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 82so1090067yby.7;
        Wed, 07 Apr 2021 20:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpXyY82hIb+Th5j4vFZ0f7bQvdjavP/oC7bA+N+HLRo=;
        b=ntVXVu5L0RneQrc8Q9HMMHsvxVKwZByhF8LxTqOp1KeHAgcVvIydsECmWIZGlPMWyW
         ms1UmlAXKu0cXHftCqFuQDWgIUMOwpPAh1VRp57wK7mpx60sSJxlQrfvy/NbBfXM0AWG
         iKE5yAMn56HRQ9ri9gTU0oqqeYgZoHvrLGuFCnYBLuG/vQHw+DvKpG1GPPndh/bHMDRm
         PzzunMdViWXxI2zTJ5iJeLtJloIzteDo05cRuleVowX84okO4xLlKW9mzIsCWrB7/h7A
         JTwX+CSuNOv4iLDX+w7vzJG+ZjtfD2NzHTQzOintSNy3JuCqxGACjVR+yJ5FDtldA+c2
         h7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpXyY82hIb+Th5j4vFZ0f7bQvdjavP/oC7bA+N+HLRo=;
        b=HfcQ/Nszve4ZccVD/RFRTBDaZxCc3a/Yt4nsadZcmQu1ewwBxlgpbWs+FHVYQwZR6d
         IHHAfs4/r6z9SPWNr/igqx4siXl++jtABtSSoy4cD9WEsb901laeiRIqon5yLKi1ssb9
         WJaA4YRi+9lsd5J5e9Y5AYmrnqTC9H1odE15rxvmVarCdrY72HncjTsstAAkFwLB164d
         8n6ZAs1e4GaJG+qIvJAsgFJyCrR529mcidBlFfRz3f0rhN+9CQdu7/6Rx1nGVBQKIF55
         LeV7QC7//JaH6bzCQM9+AGKqpMNja0PkcXLkzkdmXmYgCrBuXk/C3pV7ZXspfUsYJDsC
         Sb8Q==
X-Gm-Message-State: AOAM531q2verIfZvXzEIDYVefUPotgFBvuStxGXb8zaiZ0dYid8V2FHC
        rvbw1cn1bY2L6IGa8BZPlw/Hg5nDAzcuap/fKZo=
X-Google-Smtp-Source: ABdhPJxrDGN21/BbNTfevzT0w6+H9gdFlLh3L/VOrZ8aqLPhftv9Ya6tsKrE4JScC+D0oB4InTW/a6BztUY6iXpk1WE=
X-Received: by 2002:a25:f304:: with SMTP id c4mr8455726ybs.236.1617853538936;
 Wed, 07 Apr 2021 20:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201105212116.411422-1-peter.hilber@opensynergy.com> <20201105212116.411422-11-peter.hilber@opensynergy.com>
In-Reply-To: <20201105212116.411422-11-peter.hilber@opensynergy.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 8 Apr 2021 09:15:28 +0530
Message-ID: <CAOh2x==6TH-A8076weSLy7kLqrNZgRgp2GFyAEGGPyikw1rgGg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/10] firmware: arm_scmi: Add virtio transport
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        souvik.chakravarty@arm.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 2:59 AM Peter Hilber
<peter.hilber@opensynergy.com> wrote:

> +static int scmi_vio_probe(struct virtio_device *vdev)
> +{
> +       struct device *dev = &vdev->dev;
> +       struct scmi_vio_channel **vioch;
> +       bool have_vq_rx;
> +       int vq_cnt;
> +       int i;
> +       struct virtqueue *vqs[VIRTIO_SCMI_VQ_MAX_CNT];
> +
> +       vioch = devm_kcalloc(dev, VIRTIO_SCMI_VQ_MAX_CNT, sizeof(*vioch),
> +                            GFP_KERNEL);
> +       if (!vioch)
> +               return -ENOMEM;
> +
> +       have_vq_rx = virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
> +       vq_cnt = have_vq_rx ? VIRTIO_SCMI_VQ_MAX_CNT : 1;
> +
> +       for (i = 0; i < vq_cnt; i++) {
> +               vioch[i] = devm_kzalloc(dev, sizeof(**vioch), GFP_KERNEL);
> +               if (!vioch[i])
> +                       return -ENOMEM;
> +       }
> +
> +       if (have_vq_rx)
> +               vioch[VIRTIO_SCMI_VQ_RX]->is_rx = true;
> +
> +       if (virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_complete_callbacks,
> +                           scmi_vio_vqueue_names, NULL)) {
> +               dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
> +               return -1;
> +       }
> +       dev_info(dev, "Found %d virtqueue(s)\n", vq_cnt);
> +
> +       for (i = 0; i < vq_cnt; i++) {
> +               spin_lock_init(&vioch[i]->lock);
> +               vioch[i]->vqueue = vqs[i];
> +               vioch[i]->vqueue->priv = vioch[i];

The vqueue->priv field is used by core, you can't update it else
notifications won't work.

> +       }
> +
> +       vdev->priv = vioch;
> +
> +       virtio_device_ready(vdev);
> +
> +       return 0;
> +}

diff --git a/drivers/firmware/arm_scmi/virtio.c
b/drivers/firmware/arm_scmi/virtio.c
index f70aa72f34f1..b1af77341b30 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -80,7 +80,8 @@ static int scmi_vio_populate_vq_rx(struct
scmi_vio_channel *vioch,

 static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 {
-       struct scmi_vio_channel *vioch = vqueue->priv;
+       struct scmi_vio_channel **_vioch = vqueue->vdev->priv;
+       struct scmi_vio_channel *vioch = _vioch[vqueue->index];
        unsigned long iflags;
        unsigned int length;

@@ -454,7 +455,6 @@ static int scmi_vio_probe(struct virtio_device *vdev)
        for (i = 0; i < vq_cnt; i++) {
                spin_lock_init(&vioch[i]->lock);
                vioch[i]->vqueue = vqs[i];
-               vioch[i]->vqueue->priv = vioch[i];
        }

        vdev->priv = vioch;
