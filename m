Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545AA34AA6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCZOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCZOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:50:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E183C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:50:06 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id x16so5649297iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NCrS9iSkYyQTH7Kgs8zwkcq/baRWu0lLKcFuH4cqgFg=;
        b=iGK/gRZfeC3cbbqAjOASxYWKK53wUvLo9OenDtjIhCKQlvUE1avGlEYpUsj6gV4ydp
         JQeU50n/4XtXc+5HtNCg139qbO58VXQjcBPvcgQLH9fCnxO/feZnCurbksMS2hEM+vdU
         fMwzgs2BCfQVKDCPqppp6c9hGyuwMwoP4wstuVVZ+UEO2gIjG5JQgIFcTbOy5E7y6vAW
         +xtKKVseu+9UBTxumxF8gKiXJzdqHh7lzn4Fe7UfPaTwHXaD+FkVM+yf8vsevGDoofAU
         jkuQV96v/kw2VzDMBNAJJdJwiSJDQ0kTJkMhxyvvzHllwFhv95N/MZE6NZRTXpiD6dqV
         NCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NCrS9iSkYyQTH7Kgs8zwkcq/baRWu0lLKcFuH4cqgFg=;
        b=MSvmGoe3vhCF5pvqXig5WZ80RzxqGnZrRFOKpFNTxrW8aTz4JVmAzkgGO6PJxm4Kz8
         liT53OCLQgYdEffIEY3fjdw3pCAbr+kwcv+7LZ5yo0hCoQpWzfvNrk+xFm99K1nAh4ol
         s7Ajt7jmcTsOtX7p3ZaZLC15arduKd+mR936MkzYx0OE/bhcNkFLp1gp4BaSotsA8/B4
         I7OZd/6DmM7Czpa+4M5zVmrcQAkoSC/Gqvoh8NKdM4U2CQIEksvX8WlHyzpPOmWvwQYx
         RITqD8JM7Ydov06GJv6J9ZuHyk0RRhefvbQdLVqOBzflCafPPQqAexbgazJ/i+7utuS7
         zFjg==
X-Gm-Message-State: AOAM533nC0mWBu44NEPnesS0Zt4VCQSpiyMrQ74Mg/qeeR3uGtlqyyAV
        RCLe5YmZT4nCzT26J2cVnlLAIs00Kf0YYQ==
X-Google-Smtp-Source: ABdhPJxQJtEQI5UCABz+W+UvbPcm+d2yBOgPoJQMIVxMaqQBXBW4iwT+7Y5WPc1z92XE8UEbGdOMAA==
X-Received: by 2002:a02:7f8c:: with SMTP id r134mr12274121jac.95.1616770205481;
        Fri, 26 Mar 2021 07:50:05 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t9sm4339079ioi.27.2021.03.26.07.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 07:50:04 -0700 (PDT)
Subject: Re: [PATCH 0/6] Allow signals for IO threads
To:     Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20210326003928.978750-1-axboe@kernel.dk>
 <e6de934a-a794-f173-088d-a140d0645188@samba.org>
 <f2c93b75-a18b-fc2c-7941-9208c19869c1@kernel.dk>
 <8efd9977-003b-be65-8ae2-4b04d8dd1224@samba.org>
 <0c91d9e7-82cd-bec2-19ae-cc592ec757c6@kernel.dk>
 <bfaae5fd-5de9-bae4-89b6-2d67bbfb86c6@kernel.dk>
 <66fa3cfc-4161-76fe-272e-160097f32a53@kernel.dk>
 <67a83ad5-1a94-39e5-34c7-6b2192eb7edb@samba.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6f5f10b-b4f7-6674-79f0-31b14cfe3533@kernel.dk>
Date:   Fri, 26 Mar 2021 08:50:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <67a83ad5-1a94-39e5-34c7-6b2192eb7edb@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 8:43 AM, Stefan Metzmacher wrote:
> Am 26.03.21 um 15:38 schrieb Jens Axboe:
>> On 3/26/21 7:59 AM, Jens Axboe wrote:
>>> On 3/26/21 7:54 AM, Jens Axboe wrote:
>>>>> The KILL after STOP deadlock still exists.
>>>>
>>>> In which tree? Sounds like you're still on the old one with that
>>>> incremental you sent, which wasn't complete.
>>>>
>>>>> Does io_wq_manager() exits without cleaning up on SIGKILL?
>>>>
>>>> No, it should kill up in all cases. I'll try your stop + kill, I just
>>>> tested both of them separately and didn't observe anything. I also ran
>>>> your io_uring-cp example (and found a bug in the example, fixed and
>>>> pushed), fwiw.
>>>
>>> I can reproduce this one! I'll take a closer look.
>>
>> OK, that one is actually pretty straight forward - we rely on cleaning
>> up on exit, but for fatal cases, get_signal() will call do_exit() for us
>> and never return. So we might need a special case in there to deal with
>> that, or some other way of ensuring that fatal signal gets processed
>> correctly for IO threads.
> 
> And if (fatal_signal_pending(current)) doesn't prevent get_signal()
> from being called?

Usually yes, but this case is first doing SIGSTOP, so we're waiting in
get_signal() -> do_signal_stop() when the SIGKILL arrives. Hence there's
no way to catch it in the worker themselves.

-- 
Jens Axboe

