Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3F6328267
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhCAPZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:25:03 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:20371 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhCAPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:24:50 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 30669A1359;
        Mon,  1 Mar 2021 16:24:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=JTcGEEoX41cX
        WPArQghalzIihhiyHylco6+sqThvEyQ=; b=vMfnkx2jrMZV5YZ82LDH7lWhSTh/
        k8IVM+DlYX6C9/Ql9tfyo4VIuaYlLZL6m034GaIegoOlORbF8tejizJGKON4ZmnW
        DnzAEgNGSAqFkawIM4O6rJdaNYOgjpIZKKZAuMtkWi6naLCixtDYx5lE3lnUB+nS
        LXtOuL+4/wREB/v+27Qj5HxViU4fh05JID2iN2GMVzp5sD5DA4mgn7wmOG5rrbex
        MR8UNwePJ8bZEpfqbsy6uabrmxEnya9tZz1hyuD5/tPI9arHDQjzgMGAa6MOFyv5
        rKHVfgB9H1qgR+Zo2jKUqbGfS6fGTfTjDuDB6A+8Lf157osMENVU+FlqAA==
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
 <85bbc067-e7ec-903a-1518-5aab01577655@opensynergy.com>
 <s5ho8g2j532.wl-tiwai@suse.de>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <b9c93040-52d5-7445-cb1c-c223b4fd59fb@opensynergy.com>
Date:   Mon, 1 Mar 2021 16:24:00 +0100
MIME-Version: 1.0
In-Reply-To: <s5ho8g2j532.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.2021 15:56, Takashi Iwai wrote:
> On Mon, 01 Mar 2021 15:47:46 +0100,
> Anton Yakovlev wrote:
>>
>> On 01.03.2021 14:32, Takashi Iwai wrote:
>>> On Mon, 01 Mar 2021 10:25:05 +0100,
>>> Anton Yakovlev wrote:
>>>>
>>>> On 28.02.2021 12:27, Takashi Iwai wrote:
>>>>> On Sat, 27 Feb 2021 09:59:52 +0100,
>>>>> Anton Yakovlev wrote:
>>>>>> +/**
>>>>>> + * virtsnd_pcm_event() - Handle the PCM device event notification.
>>>>>> + * @snd: VirtIO sound device.
>>>>>> + * @event: VirtIO sound event.
>>>>>> + *
>>>>>> + * Context: Interrupt context.
>>>>>
>>>>> OK, then nonatomic PCM flag is invalid...
>>>>
>>>> Well, no. Here, events are kind of independent entities. PCM-related
>>>> events are just a special case of more generic events, which can carry
>>>> any kind of notification/payload. (And at the moment, only XRUN
>>>> notification is supported for PCM substreams.) So it has nothing to do
>>>> with the atomicity of the PCM device itself.
>>>
>>> OK, thanks.
>>>
>>> Basically the only question is how snd_pcm_period_elapsed() is called.
>>> And I see that it's called inside queue->lock, and this already
>>> invalidates the nonatomic PCM mode.  So the code needs the fix: either
>>> fix this locking (and the context is guaranteed not to be an irq
>>> context), or change to the normal PCM mode without nonatomic flag.
>>> Both would bring some side-effect, and we need further changes, I
>>> suppose...
>>
>> Ok, I understood the problem. Well, I would say the nonatomic PCM mode
>> is more important option, since in this mode we can guarantee the
>> correct operation of the device.
> 
> Which operation (except for the resume) in the trigger and the pointer
> callbacks need the action that need to sleep?  I thought the sync with
> the command queue is done in the sync_stop.  And most of others seem
> already taking the spinlock in themselves, so the non-atomic operation
> has little merit for them.

All three commands from the beginning of that switch in trigger op:
ops->trigger(START)
ops->trigger(PAUSE_RELEASE)
ops->trigger(RESUME)

They all result in
virtsnd_ctl_msg_send_sync(VIRTIO_SND_R_PCM_START)

And that command must be sync, i.e. we need to wait/sleep until device
sent response. There are two major reasons for that: we need to be sure,
that substream has been actually started (i.e. device said OK). And we
need to take into account the virtualization overhead as well. Since
substream starting on device side may take some time, we can not
return from the trigger op until it actually happened. In atomic mode
all these nuances are lost, and it may lead to incorrect application
behavior.


>> And if you say, that we need to get rid
>> of irq context here, then probably workqueue for calling
>> snd_pcm_period_elapsed() should be fine (of course, it should be shared
>> between all available substreams).
> 
> That would work, but it's of course just papering over it :)
> 
> 
>>>>>> +/**
>>>>>> + * virtsnd_pcm_sg_num() - Count the number of sg-elements required to represent
>>>>>> + *                        vmalloc'ed buffer.
>>>>>> + * @data: Pointer to vmalloc'ed buffer.
>>>>>> + * @length: Buffer size.
>>>>>> + *
>>>>>> + * Context: Any context.
>>>>>> + * Return: Number of physically contiguous parts in the @data.
>>>>>> + */
>>>>>> +static int virtsnd_pcm_sg_num(u8 *data, unsigned int length)
>>>>>> +{
>>>>>> +     phys_addr_t sg_address;
>>>>>> +     unsigned int sg_length;
>>>>>> +     int num = 0;
>>>>>> +
>>>>>> +     while (length) {
>>>>>> +             struct page *pg = vmalloc_to_page(data);
>>>>>> +             phys_addr_t pg_address = page_to_phys(pg);
>>>>>> +             size_t pg_length;
>>>>>> +
>>>>>> +             pg_length = PAGE_SIZE - offset_in_page(data);
>>>>>> +             if (pg_length > length)
>>>>>> +                     pg_length = length;
>>>>>> +
>>>>>> +             if (!num || sg_address + sg_length != pg_address) {
>>>>>> +                     sg_address = pg_address;
>>>>>> +                     sg_length = pg_length;
>>>>>> +                     num++;
>>>>>> +             } else {
>>>>>> +                     sg_length += pg_length;
>>>>>> +             }
>>>>>> +
>>>>>> +             data += pg_length;
>>>>>> +             length -= pg_length;
>>>>>> +     }
>>>>>> +
>>>>>> +     return num;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * virtsnd_pcm_sg_from() - Build sg-list from vmalloc'ed buffer.
>>>>>> + * @sgs: Preallocated sg-list to populate.
>>>>>> + * @nsgs: The maximum number of elements in the @sgs.
>>>>>> + * @data: Pointer to vmalloc'ed buffer.
>>>>>> + * @length: Buffer size.
>>>>>> + *
>>>>>> + * Splits the buffer into physically contiguous parts and makes an sg-list of
>>>>>> + * such parts.
>>>>>> + *
>>>>>> + * Context: Any context.
>>>>>> + */
>>>>>> +static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
>>>>>> +                             unsigned int length)
>>>>>> +{
>>>>>> +     int idx = -1;
>>>>>> +
>>>>>> +     while (length) {
>>>>>> +             struct page *pg = vmalloc_to_page(data);
>>>>>> +             size_t pg_length;
>>>>>> +
>>>>>> +             pg_length = PAGE_SIZE - offset_in_page(data);
>>>>>> +             if (pg_length > length)
>>>>>> +                     pg_length = length;
>>>>>> +
>>>>>> +             if (idx == -1 ||
>>>>>> +                 sg_phys(&sgs[idx]) + sgs[idx].length != page_to_phys(pg)) {
>>>>>> +                     if (idx + 1 == nsgs)
>>>>>> +                             break;
>>>>>> +                     sg_set_page(&sgs[++idx], pg, pg_length,
>>>>>> +                                 offset_in_page(data));
>>>>>> +             } else {
>>>>>> +                     sgs[idx].length += pg_length;
>>>>>> +             }
>>>>>> +
>>>>>> +             data += pg_length;
>>>>>> +             length -= pg_length;
>>>>>> +     }
>>>>>> +
>>>>>> +     sg_mark_end(&sgs[idx]);
>>>>>> +}
>>>>>
>>>>> Hmm, I thought there can be already a handy helper to convert vmalloc
>>>>> to sglist, but apparently not.  It should have been trivial to get the
>>>>> page list from vmalloc, e.g.
>>>>>
>>>>> int vmalloc_to_page_list(void *p, struct page **page_ret)
>>>>> {
>>>>>            struct vmap_area *va;
>>>>>
>>>>>            va = find_vmap_area((unsigned long)p);
>>>>>            if (!va)
>>>>>                    return 0;
>>>>>            *page_ret = va->vm->pages;
>>>>>            return va->vm->nr_pages;
>>>>> }
>>>>>
>>>>> Then you can set up the sg list in a single call from the given page
>>>>> list.
>>>>>
>>>>> But it's just a cleanup, and let's mark it as a room for
>>>>> improvements.
>>>>
>>>> Yeah, we can take a look into some kind of optimizations here. But I
>>>> suspect, the overall code will look similar. It is not enough just to
>>>> get a list of pages, you also need to build a list of physically
>>>> contiguous regions from it.
>>>
>>> I believe the standard helper does it.  But it's for sg_table, hence
>>> the plain scatterlist needs to be extracted from there, but most of
>>> complex things are in the standard code.
>>>
>>> But it's merely an optimization and something for future.
>>
>> I quickly checked it. I think it's hardly possible to do anything here.
>> These functions to deal with vmalloced areas are not exported. And,
>> according to comments, require some proper locking on top of that. At
>> least, it does not look like a trivial things.
> 
> Sure, it needs a function exposed from vmalloc.c.  But I don't think
> the locking is the problem as find_vmap_area() already takes care of
> it, and we don't release the vmalloced pages while invoking this
> function.  Of course I might overlook something, but my point is that
> this kind of work should be rather in the core (or at least most of
> the important steps in the code should be in the core code).

Then it's definitely some work for future. :)


> 
> Takashi
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

