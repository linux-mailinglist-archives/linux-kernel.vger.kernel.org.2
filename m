Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C3E3D6B54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhG0ANv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 20:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhG0ANu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:13:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B2CC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:54:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso1164037wmp.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDW6OpfohRUdqmKeGH0uiSjZritBTc3BdeTuhnbpvPM=;
        b=lvInHRNFRZCLjpXLNGXqIYt6JkpIRwXhjHBDbs7q+hPpmCkU75/kkIzQDSZvaxuojd
         TXQe//PQaWhd4oq7zBgYVTrsP1cc1TUSlbDtV41n6zmcQTVns7Q+c3BNNggzYwMfI4v6
         GLeQDwT3iMTXZuw5Q9KYx4OIgPItMdUIX3FdsdqXe8HMnQpRd3zWWxIgNZTFCOdcFTWi
         tD4fMr+EbnYlqaC/kc3ZJEM0kCfaxkbsPoRdetK1KZy/vEqbAlDzOzFunaazHKUcXDpu
         v8+OmYsR5/AIosr2IqX4mqOZuyNqCpC0P+2aD1Zi+ILuqL0iBcAxQRhZwkvTafNfOX1r
         dC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDW6OpfohRUdqmKeGH0uiSjZritBTc3BdeTuhnbpvPM=;
        b=SQsAe8aKd/HZ2HuwG2qWVH/VO2nlbT39+I/WMRj4PYdeGsFEGeWJnqUEdOjWX5Zgk6
         wEpduQ5pfUTi/jn2rsNiwOOeJuTYCnrhXJHd90Jrhf826neCsmKi7aUnWu4zf9DHyDPx
         FB9tF5d6MR4xtbqL3MVV+WaBdZg/95FiTRJPFQIEpPOXND0eolYyQDXmxzySkNHAfwuR
         iC7C4W2Ow1NhGYR1YYjnqh9NdV5KuS/o0+Bl5Tl2xsbsZW4gPy1arc1/gNsVOevABfcV
         07i/iB6tqEoe8qBkdnH70AUi6p951pMa2j9Ss6nW/OERQ01+IU2JSFuYlx9xdE3QOdfT
         b8LA==
X-Gm-Message-State: AOAM533SZ0DITj/aRjaOvN8D/OXXHDZa1o0mJ2eLqeKB09cnpOr4KjIq
        K9NKT8CATk6gIE5+21dDcKM=
X-Google-Smtp-Source: ABdhPJwYnRK4HlEb7XE/ZWnglxAkiwPPTRFiHQKNi3gobKyUoyfordhuP3j+iTFFfg7OFacfWV9Ibg==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr7460911wmz.177.1627347256599;
        Mon, 26 Jul 2021 17:54:16 -0700 (PDT)
Received: from [192.168.178.40] (ipbcc187b7.dynamic.kabel-deutschland.de. [188.193.135.183])
        by smtp.gmail.com with ESMTPSA id q17sm1349087wre.3.2021.07.26.17.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 17:54:16 -0700 (PDT)
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
 <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
 <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
 <4055ca70-7669-d00d-7c08-86fe75a3d377@gmail.com>
 <618b2bdc-282b-0a1d-1fc5-020cf80d7a7e@acm.org>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <c9cb1f3b-0b3b-c571-4a51-e647f3c1e90a@gmail.com>
Date:   Tue, 27 Jul 2021 02:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <618b2bdc-282b-0a1d-1fc5-020cf80d7a7e@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.21 23:52, Bart Van Assche wrote:
> On 7/26/21 2:13 PM, Bodo Stroesser wrote:
>> On 26.07.21 18:26, Bart Van Assche wrote:
>>> On 7/26/21 7:58 AM, Bodo Stroesser wrote:
>>>> On 23.07.21 23:23, Bart Van Assche wrote:
>>>> Let's say user writes 5 times to configfs file while keeping it open.
>>>> On every write() call it writes 1 character only, e.g. first "A", 
>>>> then "B", ...
>>>>
>>>> The original code before the changes 5 times called 
>>>> flush_write_buffer for the
>>>> strings "A\0", "B\0", ... (with the '\0' not included in the count 
>>>> parameter,
>>>> so count is 1 always, which is the length of the last write).
>>>
>>> Isn't that behavior a severe violation of how POSIX specifies that 
>>> the write() system call should be implemented?
>>
>> Hmm. I'm not sure which detail should violate POSIX spec? Is there any
>> definition how data should be flushed from buffer internally? (I'm by
>> far not a POSIX expert!)
>>
>> I would rather say the new behavior, to call flush_write_buffer during 
>> the
>> first write() for the data of that write, and then on the second write to
>> call flush_write_buffer for the concatenated data of the first and the
>> second write, could be a violation of POSIX, because the one times 
>> written
>> data of the first write is flushed twice.
>>
>> I don't like the idea of breaking the "one write, one flush" principle 
>> that
>> was implemented before. The old comment:
>> "There is no easy way for us to know if userspace is only doing a partial
>> write, so we don't support them. We expect the entire buffer to come 
>> on the
>> first write."
>> as I interpret it, makes clear that configfs code has to work 
>> according to
>> that principle. (Or even block all but the first write, but that would 
>> even
>> more break compatibility to old implementation.)
> 
> Hi Bodo,
> 
> The private email that you sent me made it clear that you would like to 
> keep the behavior from kernel 5.13. That means passing "A\0", "B\0", ... 
> to the configfs store callback function if "AB..." is witten one byte at 
> a time. What is not clear to me is how a store callback with argument 
> "B\0" can know at which offset that write happened? From 
> <linux/configfs.h> (I have added argument names):
> 
>      ssize_t (*store)(struct config_item *item, const char *page,
>                           size_t count);

It does not know. It simply handles it as two separate store actions.
One could say, both start from offset 0.

> 
> My understanding of the POSIX specification [1] is that writes should 
> happen at the proper offset. If user space software writes "A" at offset 
> 0 and "B" at offset 1 then the string "AB" should be passed to the 
> configfs store callback.

The comment says, that such a concatenation is not supported. To add
such a support, we would have to buffer all writes and then have a
criterion that triggers the flush_write_buffer. For example that could
be done on close(). But that would also mean, that bad result from store
handler could be reported by close only. And it would mean, that again
the behavior changes, in that the new SW allows one store action only
after one open(). You have to close and re-open before you can start a
new store action.

To me it looks strange to write again all previous data from the 
beginning at each new write. So I think this is not a good solution.

> 
> Regarding the "action" attribute from your tcmu patch, how about 
> checking the last character of the string written into that attribute 
> instead of the first character? Would that be sufficient to write twice 
> into that attribute without having to call close() and open() between 
> the two write actions?

I'm not sure I understand what you mean. If userspace writes a string
byte by byte or in pieces of other sizes, would you still gather
data in the file's buffer and call flush_write_buffer on each write
with all the data gathered up to and including the current write?

Of so, do you want the store handler to detect the end of the string,
e.g by searching for '\n', and discard the write if not found? That
would not work well, because after the store handler detected the '\n',
during the next write it would get the same string again plus what was
added by the new write. Store handler would have to know, how much of
the entire buffer content it already had seen. After a couple of writes
we would even run out of buffer. So again close and re-open is needed.
After close and re-open, how does the store handler know, that the
buffer now is re-started from the beginning?

The new behavior can also cause trouble with existing store handlers. 
Example:
The tcmu attribute files cmd_time_out and qfull_time_out just take a
string containing the decimal formatted number of seconds of the
timeout. Each number up to now had to be transferred in a single write.
Assume the old value is 30 and we want to change to 19. If userspace
writes byte by byte, you end up calling
store(item, "1\0", 1) and then
store(item, "19\9", 2).
If these quick changes do not cause trouble in tcmu's scsi cmd handling,
then think what happens, if userspace is interrupted between the two
writes. Allowing to split the writes cause a loss of "atomicity".

> 
> To me the following comment: "There is no easy way for us to know if 
> userspace is only doing a partial write, so we don't support them. We 
> expect the entire buffer to come on the first write." means that writing 
> "ABCD" by first writing "AB" and next "CD" will trigger two 
> item->store() calls. Triggering a single item->store() call for partial 
> writes is not supported.

Exactly. So IMHO we don't need to handle any offsets during write
processing, since for every write we again start at offset 0.
(We just add the trailing '\0' - not in count - to ease store handler's
work.)

Thank you,
Bodo

