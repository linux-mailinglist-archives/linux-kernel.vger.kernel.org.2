Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDCC3CED63
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384287AbhGSS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383602AbhGSR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:58:03 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF22C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:25:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k20so19905490pgg.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2GDIeoSRCpC7dRtQi/P8zv3DNxVEppuMxPefDLRGLvo=;
        b=OeKjXa48A0pN/3XXle4GeVXRZmcs0TibjoXBcRIdYsE0wWIdF8DuLYtWLvTcn6o81k
         JHl6klHO+oP4Tgu78um0l3O54z+eSY2KSs1SZV7jvtEz8RM5bRYFnpnzokRNoqBR006F
         O8M0y2+DnNqwRWUC9WduzXsuMcuM/mQNmAF/fhbTlXxr8jc9lyTXmplLAUHK1cZCBJCb
         mMZQNBpjp/3geQHIcyWs9CwWlS8dkm1XrSQZBFfvI6PO+SoRxYeJ3U6iERPgO6o9appT
         pLSufwYQTbnqi+CMFgXS7hnWYnXs5CmDKy44sxTOKUV5bMHAcByM6GDutbDkys3Dw+zX
         SP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GDIeoSRCpC7dRtQi/P8zv3DNxVEppuMxPefDLRGLvo=;
        b=FlNB1x0ELbNvyoaiR+drdgvUWh3ItEyUdz9ju4vZm2CKEmYbLhMfS8BxGIWyHPJ71q
         h+ekWxGZFurL32vGacmOgjrn7Zdx2PfPZTkQDED7aPxwK6klv8gBzval0u1NmLfN5JpQ
         mZBTKaX/5ly+DwrCpybhqEXc/AKnqrNtfdbPUrLJ0R2WVTuyAMLn5aUkh8e29aI2RMMh
         ht+n9fOiN3O91iwdAmdAgWhx+UwP/zAqv6KNBnKe+pDM63J0USdFrfp2rZSRj//xm7Kp
         3AnCB3/Fec3O7B9RFC8ItBrpcA5NJKHAVSk1pNTNLG1YoL/5a1RRh0R4No13uXI4DoPk
         LIow==
X-Gm-Message-State: AOAM532/b0NTDvuCZkVfqcPDRoeBfK0xWG0lT6TG8vtO+D9opgEMEyDv
        5sNe21ZWKy5/LakaeKMasy9OXg==
X-Google-Smtp-Source: ABdhPJzFZKkogPgLbbV2IjYWsMbvhfkUBEIbqZhWjB8Cb9H93gbmTY1dTU0gdOOCJdmkUQhnxLwQBA==
X-Received: by 2002:aa7:9a42:0:b029:333:a3d2:8d8f with SMTP id x2-20020aa79a420000b0290333a3d28d8fmr22583136pfj.45.1626719919373;
        Mon, 19 Jul 2021 11:38:39 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id k19sm17420699pji.32.2021.07.19.11.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 11:38:38 -0700 (PDT)
Subject: Re: [syzbot] INFO: task hung in io_sq_thread_park (2)
To:     Pavel Begunkov <asml.silence@gmail.com>,
        syzbot <syzbot+ac957324022b7132accf@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
References: <000000000000e1f38205c73b72cc@google.com>
 <c57f80f7-440b-9f12-a7b7-a58ed7ab400a@gmail.com>
 <3ff29943-0f93-1381-1c8a-46f80aecd0b4@kernel.dk>
 <b48f3e01-c07d-56ac-3624-afc74ef08acd@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <98a5f4a7-428b-fc0c-3f8c-c368f98d79a2@kernel.dk>
Date:   Mon, 19 Jul 2021 12:38:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b48f3e01-c07d-56ac-3624-afc74ef08acd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 11:28 AM, Pavel Begunkov wrote:
> On 7/19/21 6:13 PM, Jens Axboe wrote:
>> On 7/19/21 10:57 AM, Pavel Begunkov wrote:
>>> On 7/16/21 11:57 AM, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>>> WARNING in io_uring_cancel_generic
>>>
>>> __arm_poll doesn't remove a second poll entry in case of failed
>>> __io_queue_proc(), it's most likely the cause here.
>>>
>>> #syz test: https://github.com/isilence/linux.git syztest_sqpoll_hang
>>
>> Was my thought on seeing the last debug run too. Haven't written a test
>> case, but my initial thought was catching this at the time that double
>> poll is armed, in __io_queue_proc(). Totally untested, just tossing
>> it out there.
> 
> Wouldn't help, unfortunately, the way syz triggers it is making a
> request to go through __io_queue_proc() three times.
> 
> Either it's 3 waitqueues or we need to extend the check below to
> the double poll entry.
> 
> if (poll_one->head == head)
> 	return;

Yes good point, that'd depend on single poll erroring first. Given
the variety of cases for it, catching it after the fact like in your
patch is likely the simplest/cleanest way.

-- 
Jens Axboe

