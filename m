Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD730B360
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhBAXUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:20:54 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:8219 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhBAXUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:20:46 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id E0387A1570;
        Tue,  2 Feb 2021 00:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=ssfdkDmw6xak
        rwOPLgsefLQO8t7T2+/G9UIklxeWIDE=; b=NOAwJnm3djpRw7B3Z2J3EzeTW/U/
        SH+1zuzXql+yR7YTrw+/qGWPiQvz0aYOvH4GGuwdmfcrKcyDENOxTfCCqFvwJCEJ
        v13+6qI/tPZzYS2uRXqKRqJbNJhESGqXaxRq2Esq9R5gTlG89ZDRM1BHMAaGELZ5
        bBW1Jxx7lSklVzt3mu070UNG9YY+AoCdAVkN9MBez38CQ/NmLQgb0CuaXhY18uVT
        Vv2xCUn1U2ZD+L7I23me1NXVFbEIlNK8H+E0DOhMCnnd6EavKHZPGhXzR+/v7uKk
        iUuflU8H+9MJYMBV9fh8SUXny7ddh/IBd2bpmRnp4shSwpvHE7t5wMs0mw==
Subject: Re: [virtio-dev] Re: [PATCH v2 4/9] ALSA: virtio: build PCM devices
 and substream hardware descriptors
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>,
        <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-5-anton.yakovlev@opensynergy.com>
 <6f93189c-7cfc-25c7-6b2c-ad8e21bf42c@intel.com>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <4eb2f618-1b8d-b339-8f85-ff061a1f563e@opensynergy.com>
Date:   Tue, 2 Feb 2021 00:19:59 +0100
MIME-Version: 1.0
In-Reply-To: <6f93189c-7cfc-25c7-6b2c-ad8e21bf42c@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.01.2021 16:44, Guennadi Liakhovetski wrote:
 > On Sun, 24 Jan 2021, Anton Yakovlev wrote:
 >

...[snip]...

 >>
 >> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
 >> index 955eadc2d858..39fe13b43dd1 100644
 >> --- a/sound/virtio/virtio_card.c
 >> +++ b/sound/virtio/virtio_card.c
 >> @@ -92,6 +92,17 @@ static void virtsnd_event_notify_cb(struct
 >> virtqueue *vqueue)
 >>                       if (!event)
 >>                               break;
 >>
 >> +                     switch (le32_to_cpu(event->hdr.code)) {
 >> +                     case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
 >> +                     case VIRTIO_SND_EVT_PCM_XRUN: {
 >
 > In the previous patch you had a switch-case statement complying to the
 > common kernel coding style. It isn't specified in coding-style.rst, but
 > these superfluous braces really don't seem to be good for anything - in
 > this and multiple other switch-case statements in the series.

I will fix this. Thanks!


...[snip]...


 >> @@ -359,6 +384,8 @@ static int virtsnd_probe(struct virtio_device *vdev)
 >> static void virtsnd_remove(struct virtio_device *vdev)
 >> {
 >>       struct virtio_snd *snd = vdev->priv;
 >> +     struct virtio_pcm *pcm;
 >> +     struct virtio_pcm *pcm_next;
 >>
 >>       if (!snd)
 >>               return;
 >> @@ -376,6 +403,24 @@ static void virtsnd_remove(struct virtio_device
 >> *vdev)
 >>       vdev->config->reset(vdev);
 >>       vdev->config->del_vqs(vdev);
 >>
 >> +     list_for_each_entry_safe(pcm, pcm_next, &snd->pcm_list, list) {
 >> +             unsigned int i;
 >> +
 >> +             list_del(&pcm->list);
 >> +
 >> +             for (i = 0; i < ARRAY_SIZE(pcm->streams); ++i) {
 >> +                     struct virtio_pcm_stream *stream =
 >> &pcm->streams[i];
 >> +
 >> +                     if (stream->substreams)
 >> +                             devm_kfree(&vdev->dev, 
stream->substreams);
 >> +             }
 >> +
 >> +             devm_kfree(&vdev->dev, pcm);
 >
 > Please double-check both devm_kfree() calls above. Probably they aren't
 > needed in the .remove() method.

Then I will redo these parts, and the parts that you noticed in the rest
of the comments to this file.


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

