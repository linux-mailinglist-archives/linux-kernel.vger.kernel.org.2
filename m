Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F93327B85
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhCAKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:06:22 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:17017 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhCAKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:03:58 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 84EF2A1344;
        Mon,  1 Mar 2021 11:03:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=TYThy1gXWt2N
        GLWZE4+BNvfDquT8rOEI1kVicn0HVsg=; b=y+hHA5oyvhs9pArzHttMuyoKdxP1
        Fwlbcir93mQ/6UUIuo+Ic+uw7QoZBRETjmBckBQT2dbKzSu1eTdQmrf8S6/mpmv7
        mMEIknuE/CU/jezBM/VLDdDgSqiCggLP8iPwWnLfGBPLAlIg8vdsqEjjrqn8p9wY
        yvZLGk+qhwhmzvATxARQSyAPebd142F+ve1d0HyZ+q09n4HzhZ/lRy/Lgwxj6wB/
        aBwAkiW6/G3XqPE4DgEWh5V5dpfd5LA6IfwyJhUnHfwIKObPXChG5vsWdjBNNV1h
        d7BogU8h562dy0T9lSWv6/M+agyifUWIv/XhelwNk/RYqwbsZ7QttVLNhg==
Subject: Re: [PATCH v6 9/9] ALSA: virtio: introduce device suspend/resume
 support
To:     Takashi Iwai <tiwai@suse.de>
CC:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-10-anton.yakovlev@opensynergy.com>
 <s5hpn0kjt31.wl-tiwai@suse.de>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <54854cb9-99c3-4c05-3b43-f41d89a29aec@opensynergy.com>
Date:   Mon, 1 Mar 2021 11:03:04 +0100
MIME-Version: 1.0
In-Reply-To: <s5hpn0kjt31.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.02.2021 13:05, Takashi Iwai wrote:
> On Sat, 27 Feb 2021 09:59:56 +0100,
> Anton Yakovlev wrote:
>>
>> All running PCM substreams are stopped on device suspend and restarted
>> on device resume.
>>
>> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> ---
>>   sound/virtio/virtio_card.c    | 56 +++++++++++++++++++++++++++++++++++
>>   sound/virtio/virtio_pcm.c     |  1 +
>>   sound/virtio/virtio_pcm_ops.c | 41 ++++++++++++++++++++-----
>>   3 files changed, 90 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
>> index 59455a562018..c7ae8801991d 100644
>> --- a/sound/virtio/virtio_card.c
>> +++ b/sound/virtio/virtio_card.c
>> @@ -323,6 +323,58 @@ static void virtsnd_remove(struct virtio_device *vdev)
>>        kfree(snd->event_msgs);
>>   }
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +/**
>> + * virtsnd_freeze() - Suspend device.
>> + * @vdev: VirtIO parent device.
>> + *
>> + * Context: Any context.
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +static int virtsnd_freeze(struct virtio_device *vdev)
>> +{
>> +     struct virtio_snd *snd = vdev->priv;
>> +
>> +     virtsnd_ctl_msg_cancel_all(snd);
>> +
>> +     vdev->config->del_vqs(vdev);
>> +     vdev->config->reset(vdev);
>> +
>> +     kfree(snd->event_msgs);
>> +
>> +     /*
>> +      * If the virtsnd_restore() fails before re-allocating events, then we
>> +      * get a dangling pointer here.
>> +      */
>> +     snd->event_msgs = NULL;
>> +
>> +     return 0;
> 
> I suppose some cancel of inflight works is needed?
> Ditto for the device removal, too.

It's not necessary here, since the device is reset and all of this are
happened automatically. But in the device remove it makes sense also to
disable events before calling snd_card_free(), since the device is still
able to send notifications at that moment. Thanks!


>> --- a/sound/virtio/virtio_pcm.c
>> +++ b/sound/virtio/virtio_pcm.c
>> @@ -109,6 +109,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>>                SNDRV_PCM_INFO_BATCH |
>>                SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>                SNDRV_PCM_INFO_INTERLEAVED |
>> +             SNDRV_PCM_INFO_RESUME |
>>                SNDRV_PCM_INFO_PAUSE;
> 
> Actually you don't need to set SNDRV_PCM_INFO_RESUME.
> This flag means that the driver supports the full resume procedure,
> which isn't often the case; with this, the driver is supposed to
> resume the stream exactly from the suspended position.

If I understood you right, that's exactly how resume is implemented now
in the driver. Although we fully restart substream on the device side,
from an application point of view it is resumed exactly at the same
position.


> Most drivers don't set this but implement only the suspend-stop
> action.  Then the application (or the sound backend) will re-setup the
> stream and restart accordingly.

And an application must be aware of such possible situation? Since I
have no doubt in alsa-lib, but I don't think that for example tinyalsa
can handle this right.


>> @@ -309,6 +318,21 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
>>        int rc;
>>
>>        switch (command) {
>> +     case SNDRV_PCM_TRIGGER_RESUME: {
>> +             /*
>> +              * We restart the substream by executing the standard command
>> +              * sequence.
>> +              */
>> +             rc = virtsnd_pcm_hw_params(substream, NULL);
>> +             if (rc)
>> +                     return rc;
>> +
>> +             rc = virtsnd_pcm_prepare(substream);
>> +             if (rc)
>> +                     return rc;
> 
> And this won't work at all unless nonatomic PCM ops.
> 
> 
> thanks,
> 
> Takashi
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

