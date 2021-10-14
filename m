Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3042E465
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhJNWuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhJNWuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:50:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6494CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:48:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m14so6717613pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UnvSZQA0ZwUr0GhXwVbqcq8ogB+UmTG+CsAHV9mkjo4=;
        b=TRMnj9Bd+as2J41pVSv6cyvlY9npaN1U5mdqwQtBhBPGtO14Udn2y1rkGMqo0vkBQi
         M9zNo2xQlGDLLmiIylx4oPKhWZ1FMpKkitlM/ydkHykOGzwePI6Fa2TuGxYmFG1kv1zn
         1s9UJouaSjemeU9GM+JDjydi4ZB67PpV7X00AGWj3rxOpenpvm65lzqwGgH5Y+Jvyp7r
         gv16gN06D0JEQ0sOMRUpss9asd2zGqxWD+lS1ok2euL1jjODDEgee0wNNCrPtH3OFMKW
         yk7H5Pm99OU3/+G0kXjGM6a/MhNou7zizADE8Ln2S1tRhedJgasyriXv/1gSLMj++H/n
         FiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UnvSZQA0ZwUr0GhXwVbqcq8ogB+UmTG+CsAHV9mkjo4=;
        b=NV2kmv2nSo3ZkjT7387NMvsNBehPfW1kvXJ/5gc1YUMa87TAjBKqeLgPLV9+3PJ4dl
         WRz2mHzth/dowCtDYE9t8XkIgesV0wRN2I3XHHvze8Y6fbOyWc2LSD8ekadP/l86cv/c
         ab7ICsSXuRmBpKJtQHCP4yoLipbsww435ZatcxcJj3utUuRlcjJKFxTsfM85Eur/BW90
         BX4f9Rx/uYs7wJDi++h4S4eV53hTmS3jxps2NqopRp2ZVOwYsPDPaz1GPGL+wwH3nJaT
         5VGBM2ZK1hLMyp+6Gch/Tao3GrMo/HrVHJl4JlEK7Icu8XZ99xNEjnbKEa3fzA9reoTx
         22fg==
X-Gm-Message-State: AOAM533rdN2+D4vGavZvIfQDpKiV2wPfEya0wn3zi8GbRgKOq2txPlRb
        kP/8wyyCzAFFFnx17JDjCxLjiZ+lbZ4=
X-Google-Smtp-Source: ABdhPJyzuOj9VSgbJ1QLP3uLWblHVQ4Ebssu4SN3L2FlfOF/X4JCCXFqYKr5EcCybv0qaSZ7rO83dA==
X-Received: by 2002:a63:f963:: with SMTP id q35mr6285863pgk.132.1634251692821;
        Thu, 14 Oct 2021 15:48:12 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s17sm3507432pfs.91.2021.10.14.15.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 15:48:12 -0700 (PDT)
Subject: Re: data dependency naming inconsistency
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20211011064233-mutt-send-email-mst@kernel.org>
 <6c362de5-1d79-512c-37d0-81aaf5d335d1@qa2.so-net.ne.jp>
 <20211014013156-mutt-send-email-mst@kernel.org>
 <d253958f-b3d7-67c1-4cf6-38f184adabd6@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <8a9ea500-8f8c-129a-2974-4bdda65dbf64@gmail.com>
Date:   Fri, 15 Oct 2021 07:48:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d253958f-b3d7-67c1-4cf6-38f184adabd6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 23:29:43 +0900, Akira Yokosawa wrote:
> [-CC akys: my 2nd address]
> On Thu, 14 Oct 2021 01:37:17 -0400, Michael S. Tsirkin wrote:
>> On Thu, Oct 14, 2021 at 01:43:24PM +0900, Akira Yokosawa wrote:
>>> On Mon, 11 Oct 2021 07:07:08 -0400, Michael S. Tsirkin wrote:
>>>> Hello Paul, all!
>>>
>>> Hello Michael,
>>>
>>> I thought Paul would respond soon, but looks like he has not
>>> done so.

This is because Michael used Paul's old email address.

Forwarding to his current address.

Paul, you can see the thread at the lore archive:
https://lore.kernel.org/lkml/20211011064233-mutt-send-email-mst@kernel.org/T/

        Thanks, Akira

>>> So, I'm trying to give some hint to your findings.
>>>
>>>> I've been reading with interest Paul's posts about Rust interactions with LKMM
>>>> https://paulmck.livejournal.com/63316.html
>>>> and in particular it states:
>>>> 		A data dependency involves a load whose return value directly or
>>>> 	indirectly determine the value stored by a later store, which results in
>>>> 	the load being ordered before the store.
>>>>
>>>> This matches the perf book:
>>>> 	A data dependency occurs when the value returned by
>>>> 	a load instruction is used to compute the data stored by
>>>> 	a later store instruction.
>>>
>>> You might likely be aware, but these concern "data dependency",
>>> not a _barrier_.
>>>
>>>>
>>>> however, memory-barriers.txt states:
>>>>
>>>>      A data dependency barrier is a partial ordering on interdependent loads
>>>>      only; it is not required to have any effect on stores, independent loads
>>>>      or overlapping loads.
>>>>
>>>> It also says:
>>>> 	A data-dependency barrier is not required to order dependent writes
>>>> 	because the CPUs that the Linux kernel supports don't do writes
>>>> 	until they are certain (1) that the write will actually happen, (2)
>>>> 	of the location of the write, and (3) of the value to be written.
>>>
>>> These concern the historic "data-dependency barrier", or
>>> [smp_]read_barrier_depends(), which existed until Linux kernel v4.14.
> 
> Ah... I should have said ", which existed prior to Linux kernel v4.15".
> This invited off-by-one error below...
> 
>>>
>>>>
>>>> so the result it the same: writes are ordered without a barrier,
>>>> reads are ordered by a barrier.
>>>>
>>>> However, it would seem that a bit more consistency in naming won't
>>>> hurt.
>>>
>>> So, I don't think the historic term of "data-dependency barrier"
>>> can be changed.
>>>
>>> I guess the right approach would be to further de-emphasize
>>> "data-dependency barrier"/"data dependency barrier" in
>>> memory-barriers.txt.
>>>
>>> Rewrite by commit 8ca924aeb4f2 ("Documentation/barriers: Remove
>>> references to [smp_]read_barrier_depends()") did some of such
>>> changes, but it failed to update the introductory section of
>>> "VARIETIES OF MEMORY BARRIER".
>>> The part Michael quoted above belongs to it.
>>> I don't think it has any merit keeping it around.
>>>
>>> Also, there remain a couple of ascii-art diagrams concerning
>>> <data dependency barrier> in the first part of "EXAMPLES OF MEMORY
>>> BARRIER SEQUENCES" section, which, I think, can be removed as well.
>>>
>>> Hope this helps clarify the circumstances.
>>
>> It does, thanks! It might be worth adding a sentence along the lines of
>>
>> "NB: a data dependency barrier is distinct from a data dependency: it's
>> a barrier that used to be required in the presence of a data dependency.
>> Since v4.14 Linux no longer offers an API for a data dependency barrier.
> 
>   Since v4.15
> 
>> Instead, using READ_ONCE is sufficient for ordering in the presence of a
>> data dependency".
> 
> 
> Maybe.
> 
> But I'm more inclined to get rid of remaining contents related to the
> "data dependency barrier".
> 
>         Thanks, Akira
> 
>>
>>
>>> Paul, what is your take on the naming of "data dependency"/
>>> "data dependency barrier"?
>>>
>>>         Thanks, Akira
>>>
>>>>
>>>> Thanks,
>>>>
>>>> -- 
>>>> MST
>>
