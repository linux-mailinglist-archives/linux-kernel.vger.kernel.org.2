Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3032814D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhCAOsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:48:54 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:42893 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbhCAOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:48:33 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 15E3FA135C;
        Mon,  1 Mar 2021 15:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=uUEmvvMwB04Y
        mwuBJMzs1a30v08X3G2vkQsG3+XEfIg=; b=z2ppUMBLGZwtmGcANjI+jX4PnwbM
        0srq7ES/S9p8Kbxts0xyo35ToA5BffV7XPI1ALf8cV0MDBkRmpkdvJmg8HoacwkM
        ESG6ELOdIR3xafWJy/ikS/N73jbX+sFtY+Bi56Evtc93zXhKA1dHdxXPoDTHPHJm
        C7ytXoWVPLIfwC2QA86NxwOu27AN/HizhLZXQVrHLI6AEvxGx/HN1oXviFI6B0HX
        4/k0esw4XlwNfvmvkPBiXH0zSoUhFKIn71Xwsxto5ToXcePPndWFcmUEo4g57/rw
        7fQ0u2ujGUBWlVgUPQHKdrfllOyUJ3fopWoiMFPAXlCUrsnddkxI0N6exQ==
Subject: Re: [PATCH v6 5/9] ALSA: virtio: handling control and I/O messages
 for the PCM device
To:     Takashi Iwai <tiwai@suse.de>
CC:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-6-anton.yakovlev@opensynergy.com>
 <s5hsg5gjutg.wl-tiwai@suse.de>
 <b3de8563-1776-4296-2cf5-883c831dfbe8@opensynergy.com>
 <s5h35xfj8yz.wl-tiwai@suse.de>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <85bbc067-e7ec-903a-1518-5aab01577655@opensynergy.com>
Date:   Mon, 1 Mar 2021 15:47:46 +0100
MIME-Version: 1.0
In-Reply-To: <s5h35xfj8yz.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.2021 14:32, Takashi Iwai wrote:
> On Mon, 01 Mar 2021 10:25:05 +0100,
> Anton Yakovlev wrote:
>>
>> On 28.02.2021 12:27, Takashi Iwai wrote:
>>> On Sat, 27 Feb 2021 09:59:52 +0100,
>>> Anton Yakovlev wrote:
>>>> +/**
>>>> + * virtsnd_pcm_event() - Handle the PCM device event notification.
>>>> + * @snd: VirtIO sound device.
>>>> + * @event: VirtIO sound event.
>>>> + *
>>>> + * Context: Interrupt context.
>>>
>>> OK, then nonatomic PCM flag is invalid...
>>
>> Well, no. Here, events are kind of independent entities. PCM-related
>> events are just a special case of more generic events, which can carry
>> any kind of notification/payload. (And at the moment, only XRUN
>> notification is supported for PCM substreams.) So it has nothing to do
>> with the atomicity of the PCM device itself.
> 
> OK, thanks.
> 
> Basically the only question is how snd_pcm_period_elapsed() is called.
> And I see that it's called inside queue->lock, and this already
> invalidates the nonatomic PCM mode.  So the code needs the fix: either
> fix this locking (and the context is guaranteed not to be an irq
> context), or change to the normal PCM mode without nonatomic flag.
> Both would bring some side-effect, and we need further changes, I
> suppose...

Ok, I understood the problem. Well, I would say the nonatomic PCM mode
is more important option, since in this mode we can guarantee the
correct operation of the device. And if you say, that we need to get rid
of irq context here, then probably workqueue for calling
snd_pcm_period_elapsed() should be fine (of course, it should be shared
between all available substreams).


>>>> +/**
>>>> + * virtsnd_pcm_sg_num() - Count the number of sg-elements required to represent
>>>> + *                        vmalloc'ed buffer.
>>>> + * @data: Pointer to vmalloc'ed buffer.
>>>> + * @length: Buffer size.
>>>> + *
>>>> + * Context: Any context.
>>>> + * Return: Number of physically contiguous parts in the @data.
>>>> + */
>>>> +static int virtsnd_pcm_sg_num(u8 *data, unsigned int length)
>>>> +{
>>>> +     phys_addr_t sg_address;
>>>> +     unsigned int sg_length;
>>>> +     int num = 0;
>>>> +
>>>> +     while (length) {
>>>> +             struct page *pg = vmalloc_to_page(data);
>>>> +             phys_addr_t pg_address = page_to_phys(pg);
>>>> +             size_t pg_length;
>>>> +
>>>> +             pg_length = PAGE_SIZE - offset_in_page(data);
>>>> +             if (pg_length > length)
>>>> +                     pg_length = length;
>>>> +
>>>> +             if (!num || sg_address + sg_length != pg_address) {
>>>> +                     sg_address = pg_address;
>>>> +                     sg_length = pg_length;
>>>> +                     num++;
>>>> +             } else {
>>>> +                     sg_length += pg_length;
>>>> +             }
>>>> +
>>>> +             data += pg_length;
>>>> +             length -= pg_length;
>>>> +     }
>>>> +
>>>> +     return num;
>>>> +}
>>>> +
>>>> +/**
>>>> + * virtsnd_pcm_sg_from() - Build sg-list from vmalloc'ed buffer.
>>>> + * @sgs: Preallocated sg-list to populate.
>>>> + * @nsgs: The maximum number of elements in the @sgs.
>>>> + * @data: Pointer to vmalloc'ed buffer.
>>>> + * @length: Buffer size.
>>>> + *
>>>> + * Splits the buffer into physically contiguous parts and makes an sg-list of
>>>> + * such parts.
>>>> + *
>>>> + * Context: Any context.
>>>> + */
>>>> +static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
>>>> +                             unsigned int length)
>>>> +{
>>>> +     int idx = -1;
>>>> +
>>>> +     while (length) {
>>>> +             struct page *pg = vmalloc_to_page(data);
>>>> +             size_t pg_length;
>>>> +
>>>> +             pg_length = PAGE_SIZE - offset_in_page(data);
>>>> +             if (pg_length > length)
>>>> +                     pg_length = length;
>>>> +
>>>> +             if (idx == -1 ||
>>>> +                 sg_phys(&sgs[idx]) + sgs[idx].length != page_to_phys(pg)) {
>>>> +                     if (idx + 1 == nsgs)
>>>> +                             break;
>>>> +                     sg_set_page(&sgs[++idx], pg, pg_length,
>>>> +                                 offset_in_page(data));
>>>> +             } else {
>>>> +                     sgs[idx].length += pg_length;
>>>> +             }
>>>> +
>>>> +             data += pg_length;
>>>> +             length -= pg_length;
>>>> +     }
>>>> +
>>>> +     sg_mark_end(&sgs[idx]);
>>>> +}
>>>
>>> Hmm, I thought there can be already a handy helper to convert vmalloc
>>> to sglist, but apparently not.  It should have been trivial to get the
>>> page list from vmalloc, e.g.
>>>
>>> int vmalloc_to_page_list(void *p, struct page **page_ret)
>>> {
>>>           struct vmap_area *va;
>>>
>>>           va = find_vmap_area((unsigned long)p);
>>>           if (!va)
>>>                   return 0;
>>>           *page_ret = va->vm->pages;
>>>           return va->vm->nr_pages;
>>> }
>>>
>>> Then you can set up the sg list in a single call from the given page
>>> list.
>>>
>>> But it's just a cleanup, and let's mark it as a room for
>>> improvements.
>>
>> Yeah, we can take a look into some kind of optimizations here. But I
>> suspect, the overall code will look similar. It is not enough just to
>> get a list of pages, you also need to build a list of physically
>> contiguous regions from it.
> 
> I believe the standard helper does it.  But it's for sg_table, hence
> the plain scatterlist needs to be extracted from there, but most of
> complex things are in the standard code.
> 
> But it's merely an optimization and something for future.

I quickly checked it. I think it's hardly possible to do anything here.
These functions to deal with vmalloced areas are not exported. And,
according to comments, require some proper locking on top of that. At
least, it does not look like a trivial things.


> 
> Takashi
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

