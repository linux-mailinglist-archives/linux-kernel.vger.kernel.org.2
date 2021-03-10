Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12257334903
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCJUkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhCJUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:40:27 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3FAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:40:27 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z13so19422358iox.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DOt2uzG5UdlIpzOf4PwD5PjSE+FFilkpfVBNl0BIvD4=;
        b=0RuQSIfe6Bg9s6XzpiKi+YtnsV43XXno+xYwYNEUZssZwrNYQlpWCM06r1H1xuv2HT
         waaZfIV8fgWHqEQlL43DscRNc7N7hmUblElv9e0NbjC75lZWvCKxV7LF+szxRAPkFl+n
         /r/fkHiYBQKXjqhYG9bgt1NY+kH9WbGrBRibZkqmEEdcjX/QsvJbgjYUIVu7jYQhahve
         t9MLBSvaFsg2Cb7Bz9nE8vw7zMTGWrjvWJjP1jUpPETKME4A0n4u+78kfkrrLQOo/UA7
         KCwlnPmovdY/nr/4ZAINNbAjWS7+7eshSpc43/ttYmvldCWmYVYL9xj6Sj4U7pzZE4nb
         mfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DOt2uzG5UdlIpzOf4PwD5PjSE+FFilkpfVBNl0BIvD4=;
        b=N1LjNYf7puVJZk7wKAFU9nw7vdcG3+e7kncDNj5FaG6z6/dvXeh7WrnERU1wJfhes9
         ZnwGY3IgGq1Mw/GRaTroH7akE+1oeYJCrTIut8IKcncz1+YLI1cKEFeuIOmf+oiiT+po
         NaHJOxf8WylOldUC2eBxkyPN+W+v4+nL/2iwj1/bN0ZBT9yYZQYoCpMo+f1BgPla80hQ
         6poU1xXviRaRh6+sR3KYxfdWRGbdWPpZS+ZUnEQJMDZUwsV+9OMYpDAhwnobkT8iI+Nt
         26Jp+GMSlTbKmLmEEZ3Rm8+y+5n3aGq+tuWRvxwT4rbxZVrRhFEgFS5LdfJNfoNuvBBw
         9FyA==
X-Gm-Message-State: AOAM531zt0VpuNYyXo7uZUrkH1iIvCH9UQqsSNzfi3NSOMtExu6qDF3g
        Ng+oSKtt+qttOSD/FRJ41lNgx7c8BFdw7Q==
X-Google-Smtp-Source: ABdhPJzrL66CEnJ5j3MXWw7GIN3Wl2X0RziWK5/q8dk34mOYXqHpBRiilZ7AfwFSk5ErX/sGzwvz4Q==
X-Received: by 2002:a05:6638:3809:: with SMTP id i9mr343389jav.24.1615408826452;
        Wed, 10 Mar 2021 12:40:26 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k14sm203630ilv.41.2021.03.10.12.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 12:40:26 -0800 (PST)
Subject: Re: -Walign-mismatch in block/blk-mq.c
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
 <99cf90ea-81c0-e110-4815-dd1f7df36cb4@kernel.dk>
 <20210310203323.35w2q7tlnxe23ukg@Ryzen-9-3900X.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e43dba61-8c74-757d-862d-99d23559cf50@kernel.dk>
Date:   Wed, 10 Mar 2021 13:40:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310203323.35w2q7tlnxe23ukg@Ryzen-9-3900X.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 1:33 PM, Nathan Chancellor wrote:
> On Wed, Mar 10, 2021 at 01:21:52PM -0700, Jens Axboe wrote:
>> On 3/10/21 11:23 AM, Nathan Chancellor wrote:
>>> Hi Jens,
>>>
>>> There is a new clang warning added in the development branch,
>>> -Walign-mismatch, which shows an instance in block/blk-mq.c:
>>>
>>> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
>>> 32-byte aligned parameter 2 of 'smp_call_function_single_async' may
>>> result in an unaligned pointer access [-Walign-mismatch]
>>>                 smp_call_function_single_async(cpu, &rq->csd);
>>>                                                     ^
>>> 1 warning generated.
>>>
>>> There appears to be some history here as I can see that this member was
>>> purposefully unaligned in commit 4ccafe032005 ("block: unalign
>>> call_single_data in struct request"). However, I later see a change in
>>> commit 7c3fb70f0341 ("block: rearrange a few request fields for better
>>> cache layout") that seems somewhat related. Is it possible to get back
>>> the alignment by rearranging the structure again? This seems to be the
>>> only solution for the warning aside from just outright disabling it,
>>> which would be a shame since it seems like it could be useful for
>>> architectures that cannot handle unaligned accesses well, unless I am
>>> missing something obvious :)
>>
>> It should not be hard to ensure that alignment without re-introducing
>> the bloat. Is there some background on why 32-byte alignment is
>> required?
>>
> 
> This alignment requirement was introduced in commit 966a967116e6 ("smp:
> Avoid using two cache lines for struct call_single_data") and it looks
> like there was a thread between you and Peter Zijlstra that has some
> more information on this:
> https://lore.kernel.org/r/a9beb452-7344-9e2d-fc80-094d8f5a0394@kernel.dk/

Ah now I remember - so it's not that it _needs_ to be 32-byte aligned,
it's just a handy way to ensure that it doesn't straddle two cachelines.
In fact, there's no real alignment concern, outside of performance
reasons we don't want it touching two cachelines.

So... what exactly is your concern? Just silencing that warning? Because
there doesn't seem to be an issue with just having it wherever in struct
request.

-- 
Jens Axboe

