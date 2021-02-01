Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FDD30B34E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhBAXTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:19:11 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:2339 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhBAXSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:18:55 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 80A95A1569;
        Tue,  2 Feb 2021 00:18:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=lUMI46TQw0fr
        jF2ARY5V4xhdbBHFJlxLuLVTz4ns2iQ=; b=TkEsI5KLXCuVRFyJkEdLrRZI97d0
        x0e1DpOxZ34WCeJucEcMvvUokEBuXuT9ZcESYewcCwCHu2a3i4OmAHKs/KBbRsKZ
        So5yoUc61267K8VfzO6qL3SEB86qQyDAicDRcqBUtjWvMoM9Cs8A5DwsD4XbwmJI
        YDYSjuHAiHz0BEd/1eHF9hYDBAohHvFdKtu493uJJ8JUVdL0ufOzng8OOQsRx0/H
        zkwPFb0oU1g6xUNSFoG6hGBnh+1DCEg2mI2Lt28e94SyU2uWe6GFpA8z+lCQmTEX
        Rrjpm8gnqLmj/X0W6N/BEPD1vmjqXzXDuQLzymE7ShOwqb9WiaqElkvK8A==
Subject: Re: [virtio-dev] Re: [PATCH v2 2/9] ALSA: virtio: add virtio sound
 driver
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>,
        <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-3-anton.yakovlev@opensynergy.com>
 <8754dae8-114-6383-510-de2ba9dc4fa@intel.com>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <52f71ac6-3ec7-2884-7a64-1995f416d20a@opensynergy.com>
Date:   Tue, 2 Feb 2021 00:18:09 +0100
MIME-Version: 1.0
In-Reply-To: <8754dae8-114-6383-510-de2ba9dc4fa@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guennadi,

Sorry for the late reply and thanks for your comments, they helped me a
lot! Please see my answers inline.


On 25.01.2021 15:54, Guennadi Liakhovetski wrote:

...[snip]...

 >
 >> + * 1. Redistributions of source code must retain the above copyright
 >> + *    notice, this list of conditions and the following disclaimer.
 >> + * 2. Redistributions in binary form must reproduce the above copyright
 >> + *    notice, this list of conditions and the following disclaimer in
 >> the
 >> + *    documentation and/or other materials provided with the
 >> distribution.
 >> + * 3. Neither the name of OpenSynergy GmbH nor the names of its
 >> contributors
 >> + *    may be used to endorse or promote products derived from this
 >> software
 >> + *    without specific prior written permission.
 >> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 >> + * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 >> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 >> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
 >
 > IBM? Also no idea whether this warranty disclaimer is appropriate here. I
 > thought we were transitioning to those SPDX identifiers to eliminate all
 > these headers.

It was a copy-paste mistake, I will edit these lines.


...[snip]...

 >> +
 >> +/**
 >> + * virtsnd_disable_vqs() - Disable all virtqueues.
 >> + * @snd: VirtIO sound device.
 >> + *
 >> + * Also free all allocated events and control messages.
 >> + *
 >> + * Context: Any context.
 >> + */
 >> +static void virtsnd_disable_vqs(struct virtio_snd *snd)
 >> +{
 >> +     struct virtio_device *vdev = snd->vdev;
 >> +     unsigned int i;
 >> +     unsigned long flags;
 >> +
 >> +     for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i) {
 >> +             struct virtio_snd_queue *queue = &snd->queues[i];
 >> +
 >> +             spin_lock_irqsave(&queue->lock, flags);
 >> +             /* Prohibit the use of the queue */
 >> +             if (queue->vqueue)
 >> +                     virtqueue_disable_cb(queue->vqueue);
 >> +             queue->vqueue = NULL;
 >> +             spin_unlock_irqrestore(&queue->lock, flags);
 >> +     }
 >> +
 >> +     if (snd->event_msgs)
 >
 > Check not needed, kfree(NULL) is ok.

Yes, you are right here. I didn't notice that devm_kfree() now works
fine with NULL argument too.


 >> +             devm_kfree(&vdev->dev, snd->event_msgs);
 >
 > I think there are very few cases when managed resources have to be
 > explicitly freed. If explicit freeing is always required, then there's no
 > need to have them managed. If there's a clear case for managed resources,
 > usually you don't need to free them explicitly. Here.event_msgs are
 > allocated in virtsnd_find_vqs() above, which is only called during
 > probing. And this function is only called during release. So, I'd assume,
 > that you don't need to free memory explicitly here.

Here, the reason for explicitly freeing managed resources is in the
current device reset handling logic. At the moment, executing the reset
worker results in a call to virtsnd_disable_vqs. After which the device
is recreated. And since in this case the driver is not detached from the
device, the managed resources are not automatically freed. On the other
hand, managed resources allow not to worry about deallocation if the
probing function returns an error.


 >> +
 >> +     snd->event_msgs = NULL;
 >
 > snd is about to be freed, so do you really need this?

No :)


 >> +}
 >> +
 >> +/**
 >> + * virtsnd_reset_fn() - Kernel worker's function to reset the device.
 >> + * @work: Reset device work.
 >> + *
 >> + * Context: Process context.
 >> + */
 >> +static void virtsnd_reset_fn(struct work_struct *work)
 >> +{
 >> +     struct virtio_snd *snd =
 >> +             container_of(work, struct virtio_snd, reset_work);
 >> +     struct virtio_device *vdev = snd->vdev;
 >> +     struct device *dev = &vdev->dev;
 >> +     int rc;
 >> +
 >> +     dev_info(dev, "sound device needs reset\n");
 >> +
 >> +     /*
 >> +      * It seems that the only way to properly reset the device is to
 >> remove
 >> +      * and re-create the ALSA sound card device.
 >> +      *
 >> +      * Also resetting the device involves a number of steps with
 >> setting the
 >> +      * status bits described in the virtio specification. And the
 >> easiest
 >> +      * way to get everything right is to use the virtio bus interface.
 >> +      */
 >> +     rc = dev->bus->remove(dev);
 >> +     if (rc)
 >> +             dev_warn(dev, "bus->remove() failed: %d", rc);
 >> +
 >> +     rc = dev->bus->probe(dev);
 >> +     if (rc)
 >> +             dev_err(dev, "bus->probe() failed: %d", rc);
 >
 > This looks very suspicious to me. Wondering what ALSA maintainers 
will say
 > to this.

I'm also wondering what the virtio people have to say. This part is a
purely virtio specific thing. And since none of the existing virtio
drivers processes the request to reset the device, it is not clear what
is the best way to proceed here. For this reason, the most
straightforward and simple solution was chosen.


...[snip]...

 >
 > Thanks
 > Guennadi
 >
 > ---------------------------------------------------------------------
 > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
 > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
 >
 >
-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

www.opensynergy.com

