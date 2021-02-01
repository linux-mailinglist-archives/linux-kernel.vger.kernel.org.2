Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A268330B042
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBATUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhBATUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:20:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00775C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:19:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c4so15162206wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpPec5GaqUSpiFKH55nc+mRy05EutxL4zvW4JDLSH2w=;
        b=L1BFVP6DKWTRXYjr/HG5kzKEhOwfZpItCIQI+widwKu8yrXD87Lkr3WHZ+WOh8FijZ
         5Yu5VU4MipyyJdu4pN+2CIL9GE0jLdCHpnVSpNjppS0CngxZjBaH17J+P0iFmdebm5ym
         SNpFdMpRHgguYbfn7wb5MaymuFam3ufPha33+aHG2UjDnQXhe1xjyo5g4GzkxqGCraS6
         G17Ti1vasQlQsUHGZNiqYEvxCROKO9WOe7SRea2EjzigXHmpIWuHinzDoBadufY6zXh/
         PJLmLLh62TqV904Q6DHSUGdNpjJfMXCC3eampfSGwkHCgIZnvIDLWF9LSDff6vnUND78
         xwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpPec5GaqUSpiFKH55nc+mRy05EutxL4zvW4JDLSH2w=;
        b=oF8NxkUWr2xNMxUaiFoT3/pT3ZdUXQOJx6q5pfOyFlGJo5nOo8D9h80nzR9ea9T2Qe
         7SsyK3h4YT77rUx7cZotFs2iFKB1xwUs42CaF47xE3WOtl9R1NhJMp9ArqGw/4veFebp
         8DBrbMf9kaQfSzlkFTpHbhfdW+z2BFsq5NVwJJ2IbU5EDUo9eQM/VzP8MgYFEtkPhtuN
         +jv58/ftVbpSX3ANdeilpgTePR3mjzgM0E5LUVHmzPselsqm2uhxvM2CJmhsGhwtMHNA
         zEisn1GZi/2cD76HES3RqvTKarAvagbWKWXaUvRtDoEjCPGP03IBRuKKypsqIbkturyN
         kHjg==
X-Gm-Message-State: AOAM5323cz1/D97lhZBrLSz54t4oHb4hMFyMqC/DPlcuH5KdswvzTI/p
        FyavcsyZ+S4oXPWBjDVB6fQ=
X-Google-Smtp-Source: ABdhPJx3pMVLb9CkOou36g3t7qqdGANy/dfEotKyLpnw7vAMg5cnQZHLxWuac8auMVYBUSGMG7/Jdw==
X-Received: by 2002:adf:eacc:: with SMTP id o12mr19659558wrn.202.1612207165733;
        Mon, 01 Feb 2021 11:19:25 -0800 (PST)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id p15sm27989090wrt.15.2021.02.01.11.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:19:24 -0800 (PST)
Subject: Re: Very slow unlockall()
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
 <20210108134140.GA9883@dhcp22.suse.cz>
 <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
 <9474cd07-676a-56ed-1942-5090e0b9a82f@suse.cz>
 <e6f84b27-ed29-0fa4-e466-536b529c5720@gmail.com>
 <6eebb858-d517-b70d-9202-f4e84221ed89@suse.cz>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <dfc3fe66-07ac-6aba-e10b-c940cdb01ec1@gmail.com>
Date:   Mon, 1 Feb 2021 20:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6eebb858-d517-b70d-9202-f4e84221ed89@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2021 19:55, Vlastimil Babka wrote:
> On 2/1/21 7:00 PM, Milan Broz wrote:
>> On 01/02/2021 14:08, Vlastimil Babka wrote:
>>> On 1/8/21 3:39 PM, Milan Broz wrote:
>>>> On 08/01/2021 14:41, Michal Hocko wrote:
>>>>> On Wed 06-01-21 16:20:15, Milan Broz wrote:
>>>>>> Hi,
>>>>>>
>>>>>> we use mlockall(MCL_CURRENT | MCL_FUTURE) / munlockall() in cryptsetup code
>>>>>> and someone tried to use it with hardened memory allocator library.
>>>>>>
>>>>>> Execution time was increased to extreme (minutes) and as we found, the problem
>>>>>> is in munlockall().
>>>>>>
>>>>>> Here is a plain reproducer for the core without any external code - it takes
>>>>>> unlocking on Fedora rawhide kernel more than 30 seconds!
>>>>>> I can reproduce it on 5.10 kernels and Linus' git.
>>>>>>
>>>>>> The reproducer below tries to mmap large amount memory with PROT_NONE (later never used).
>>>>>> The real code of course does something more useful but the problem is the same.
>>>>>>
>>>>>> #include <stdio.h>
>>>>>> #include <stdlib.h>
>>>>>> #include <fcntl.h>
>>>>>> #include <sys/mman.h>
>>>>>>
>>>>>> int main (int argc, char *argv[])
>>>>>> {
>>>>>>         void *p  = mmap(NULL, 1UL << 41, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
> So, this is 2TB memory area, but PROT_NONE means it's never actually populated,
> although mlockall(MCL_CURRENT) should do that. Once you put PROT_READ |
> PROT_WRITE there, the mlockall() starts taking ages.
> 
> So does that reflect your use case? munlockall() with large PROT_NONE areas? If
> so, munlock_vma_pages_range() is indeed not optimized for that, but I would
> expect such scenario to be uncommon, so better clarify first.

It is just a simple reproducer of the underlying problem, as suggested here 
https://gitlab.com/cryptsetup/cryptsetup/-/issues/617#note_478342301

We use mlockall() in cryptsetup and with hardened malloc it slows down unlock significantly.
(For the real case problem please read the whole issue report above.)

m.
