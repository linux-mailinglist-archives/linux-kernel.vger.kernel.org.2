Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E2327ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhCAJa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:30:27 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:55665 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhCAJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:30:08 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 98005A1340;
        Mon,  1 Mar 2021 10:29:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=AF2+aLbHpYk6
        yxg/KMusF89bfRVX3X9/VCCjZ8mooHU=; b=njrad0q9gBYFdXuKLLKrdMQiJrmC
        2BkUzmkCM+/7GTmtBRL4KEei2E9d4aTwbewItdx8ywzFTZ+Wq+o0YIf8ctZOxS6s
        pWUn/fd83sGZ/mCG1K5YR5fADtw4ahaRbEnXVRkPL6sL2RWJlDxJ4xow1k7GxPEl
        wsNo0I+0+kfO+5odG3fJVrIfyApV8XWZNWyz1D/U2mYX25e+aY8VQk5NmK18oKUf
        AXuAStUtmc5vLAuHdldToU4L4wQobXvwR0KNh3CO0PUQIgSbPn1tUFY+nQuOALEY
        zXBiH5ZcCoYx9U6bwN5/r1O8apbH0HBuDUG76grDuZ0I2zjZIrk1jMc/Zw==
Subject: Re: [PATCH v6 6/9] ALSA: virtio: PCM substream operators
To:     Takashi Iwai <tiwai@suse.de>
CC:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-7-anton.yakovlev@opensynergy.com>
 <s5hr1l0juld.wl-tiwai@suse.de>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <f8a4bbf5-3bee-f336-0efd-94410184fb2b@opensynergy.com>
Date:   Mon, 1 Mar 2021 10:29:24 +0100
MIME-Version: 1.0
In-Reply-To: <s5hr1l0juld.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.02.2021 12:32, Takashi Iwai wrote:
> On Sat, 27 Feb 2021 09:59:53 +0100,
> Anton Yakovlev wrote:
>>


[snip]


>> +static snd_pcm_uframes_t
>> +virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
>> +{
>> +     struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
>> +     snd_pcm_uframes_t hw_ptr = SNDRV_PCM_POS_XRUN;
>> +     unsigned long flags;
>> +
>> +     spin_lock_irqsave(&vss->lock, flags);
>> +     if (!vss->xfer_xrun)
>> +             hw_ptr = bytes_to_frames(substream->runtime, vss->hw_ptr);
>> +     spin_unlock_irqrestore(&vss->lock, flags);
> 
> Oh, and if we drop nonatomc PCM, both trigger and pointer callbacks
> are guaranteed to be called inside the spinlock, hence you can remove
> *_irqsave() but just us spin_lock() in those two callbacks.

As I understand, spin_lock_irqsave() disables only local interrupts. But
what about other CPU cores?


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

