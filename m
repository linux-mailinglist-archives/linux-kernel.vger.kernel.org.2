Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0A3EFFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhHRI6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhHRI6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:58:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617D7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:57:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dj8so2015080edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yyB09rflCzHIn1ju5X9fd70kpkBZLkV0jkVgx5Jum1M=;
        b=eUXyKdJAzmmk9t9EBWMwn5DQQ/3lULWEUIXsJT6jM89cXNHXUK+6MhzdMrncDYiKdE
         3LtdGmfp1B7S/lU3UCxJLF9bM2hjDv350E1zN4Xsbsmo/pTOkY9ErxHacO2nm7Sd3mRm
         yh/CK53CmSUPNd1H6VYQechEs9zkG9LFweVaADOOfpNXJ2osI0aUZKBPiLFqmlwViXJv
         ha5Hk+7eKJ3jOiJYHascMT/otfIdpe320Z7iQ3AzXwXi+/BzxXKk9Qn73lvz/vD5Cyfo
         2IhGDb9ZmPpLtOXYH4I6CLMuZi2EfYiqcXZvuNuEgUL78PluLKvPncpOhR6zSmPnXBdB
         quHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yyB09rflCzHIn1ju5X9fd70kpkBZLkV0jkVgx5Jum1M=;
        b=TN3BJVj8MBnJJrZkpJrmJt2UDnZHA7YLAqEgZTkOusov6+s+YdAzaxCqzGz/MDbu+5
         MbJUdpV4NaGiGUOIg+S0TI1UJp7oxGNWdIs6NQgNDaDEwkGkWqbriHlHgm7/kNka0n8Z
         NnIZDjAyteqjLQjm+giqEzJRwi3OHbnEHRYQWLxelBPfl2ZxfxlpPRGe0qmP8Hxv8OT/
         EjZxB0KkTesOoL2c+qOthfjB90PRDsWn6CssLKCVza676OXKiB6YWRmbRfQW5cFlL3U/
         NtcNGXZ0DLyVrXoFouGhpyvrRLB7WHvd8N06oQ8PV/fjR/CHzkbCu6KWexUTvpyvThpD
         NcZQ==
X-Gm-Message-State: AOAM5301apkbKHd5xlTUi28byDoDMKpw4K5fDk2RRDaeqjJ4Vy19iJGD
        InPi7w8lwwDzI9IVpbIVWoU1pA==
X-Google-Smtp-Source: ABdhPJzGR88Pk3GJEFXwZCriKTFugvn/HeIUrvcrkEfL+IGeE0KfFWsxaBzduCrnXLd9v8ytkPDFXw==
X-Received: by 2002:aa7:c894:: with SMTP id p20mr8907066eds.42.1629277058064;
        Wed, 18 Aug 2021 01:57:38 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.192])
        by smtp.gmail.com with ESMTPSA id n10sm1759880ejk.86.2021.08.18.01.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:57:37 -0700 (PDT)
Subject: Re: [syzbot] KFENCE: use-after-free in kvm_fastop_exception
To:     Pavel Skripkin <paskripkin@gmail.com>,
        syzbot <syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com>,
        davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, mathew.j.martineau@linux.intel.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000012030e05c9c8bc85@google.com>
 <58cef9e0-69de-efdb-4035-7c1ed3d23132@tessares.net>
 <6736a510-20a1-9fb5-caf4-86334cabbbb6@gmail.com>
 <32aeb66e-d4f0-26b5-a140-4477bb87067f@tessares.net>
 <3a8dd8db-61d6-603e-b270-5faf1be02c6b@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <f9c5ec7f-4014-c073-164f-5152111c1d31@tessares.net>
Date:   Wed, 18 Aug 2021 10:57:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3a8dd8db-61d6-603e-b270-5faf1be02c6b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2021 10:55, Pavel Skripkin wrote:
> On 8/18/21 11:21 AM, Matthieu Baerts wrote:
>> Hi Pavel,
>>
> [snip]
>>>>
>>>> I'm pretty sure the commit c4512c63b119 ("mptcp: fix 'masking a bool'
>>>> warning") doesn't introduce the reported bug. This minor fix is
>>>> specific
>>>> to MPTCP which doesn't seem to be used here.
>>>>
>>>> I'm not sure how I can tell syzbot this is a false positive.
>>>>
>>>
>>>
>>> looks like it's fs/namei bug. Similar reports:
>>>
>>> https://syzkaller.appspot.com/bug?id=517fa734b92b7db404c409b924cf5c997640e324
>>>
>>>
>>>
>>> https://syzkaller.appspot.com/bug?id=484483daf3652b40dae18531923aa9175d392a4d
>>>
>>
>> Thank you for having checked!
>> Should we mark them as "#syz dup" if you think they have the same root
>> cause?
>>
> 
> I think, yes, but I want to receive feedback from fs people about this
> bug. There were huge updates last month, and, maybe, I am missing some
> details. Alloc/free calltrace is the same, but anyway, I want some
> confirmation to not close different bugs by mistake :)
> 
> If these bugs really have same root case I will close them manually
> after fix posted.

Thank you for the explanation. Sounds good to me!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
