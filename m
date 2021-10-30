Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3C4409E5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 17:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhJ3PTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhJ3PTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 11:19:47 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BFC061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 08:17:17 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p204so4551018iod.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XHOmyn9+Jj9reeXZhh7e4vHo+2Fmh7M502bTzbZ0C5c=;
        b=3HOnwGY1NOGZ7l5bbpP91qoF8OGGeShvNEKZDJeq88oXDMdF333DyitWL2DLyYNYXp
         BrZjDdu53FGZGem42C3a+lfDzlPpJyj43wQOerxO3n8IYWsC1UvNkCWzsl1lJEKVrv3A
         hIfEaRVPExh8W+EcWECtXbsN7bD0tx8EjkH6SjIwFoa+exZ7w2W/3cywy82rkq801Hsy
         cQw/anlITEVXrzIPLhO3mOgbjyNdJdXVj8Y+Y3xXkT5S5iqwFG1zSa+2M7ZOKkkR2D11
         nrOjD+TzwPvlHHr4k5R8zyEFd8BSupJEYbthTjkIfyrehgLeqVzN5Wvx5SywjCyHfG9O
         S+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XHOmyn9+Jj9reeXZhh7e4vHo+2Fmh7M502bTzbZ0C5c=;
        b=8JqIne6Soqgs+yz1c4lOLUomAi6YaqTdPYDkpDXrTvYfEF5DTfNw/1fl4x0U6fam5G
         UKAaJ9aN2nWQN5f0fCLRO5A8+N13fL5X7QuW1PBBr78bMs6P2Rq0CCi7IspmNgWb4Gh3
         eOgfirB3Wx2P373xwOHezTQzox1tqS40ReJfjfjfY+piPZMsUzyqegGJVaLqqJC+/jlh
         lMOMxE+3OZsGeob4IKoIWtqvIKqgyqZspYTP8SAqeTRWbNsL5bZ0skB7gIki1tVj+K3p
         nUoGvxl2B1jsAHBDV5JLNYR2RYC268/Hq0Jqu6wHfSeQusQOwu4Hb6/oCGRb3ZtQHHq3
         ZqFw==
X-Gm-Message-State: AOAM532IDANv9DAUQVBul+FI4znr0R4KmVcyzaxYnlimGqB0L2OSmMCI
        9bqZetKLsbeSRLkC4OkcnWsbPQ==
X-Google-Smtp-Source: ABdhPJztp1rNsRnbHl9ECJkGA4HBb+19qREgbQ57QFk66Bxa+NR8B+oegioy0Cco/z86492Xy2iJKw==
X-Received: by 2002:a05:6602:1695:: with SMTP id s21mr2013309iow.10.1635607036541;
        Sat, 30 Oct 2021 08:17:16 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a4sm4700308ild.52.2021.10.30.08.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 08:17:15 -0700 (PDT)
Subject: Re: [Bug 214873] New: man 2 fsync implies possibility to return early
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     bugzilla-daemon@bugzilla.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
References: <bug-214873-216477@https.bugzilla.kernel.org/>
 <480456b0-5e10-9179-73c0-0a92649f8874@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c711ce90-8074-f1de-a7a8-548643a87e38@kernel.dk>
Date:   Sat, 30 Oct 2021 09:17:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <480456b0-5e10-9179-73c0-0a92649f8874@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/21 6:05 AM, Alejandro Colomar (man-pages) wrote:
> [CC += LKML and a few kernel programmers]
> 
> Hi,
> 
> On 10/29/21 23:25, bugzilla-daemon@bugzilla.kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=214873
>>
>>              Bug ID: 214873
>>             Summary: man 2 fsync implies possibility to return early
>>             Product: Documentation
>>             Version: unspecified
>>            Hardware: All
>>                  OS: Linux
>>              Status: NEW
>>            Severity: low
>>            Priority: P1
>>           Component: man-pages
>>            Assignee: documentation_man-pages@kernel-bugs.osdl.org
>>            Reporter: sworddragon2@gmail.com
>>          Regression: No
>>
>> The manpage for the fsync system call (
>> https://man7.org/linux/man-pages/man2/fsync.2.html ) describes as flushing the
>> related caches to a storage device so that the information can even be
>> retrieved after a crash/reboot. But then it does make the statement "The call
>> blocks until the device reports that the transfer has completed." which causes
>> now some interpretation: What happens if the device reports early completion
>> (e.g. via a bugged firmware) of the transfer while the kernel still sees unsent
>> caches in its context? Does fsync() indeed return then as the last referenced
>> sentence implies or does it continue to send the caches the kernel sees to
>> guarantee data integrity as good as possible as the previous documented part
>> might imply?
>>
>> I noticed this discrepancy when reporting a bug against dd (
>> https://debbugs.gnu.org/cgi/bugreport.cgi?bug=51345 ) that causes dd to return
>> early when it is used with its fsync capability while the kernel still sees
>> caches and consulting the fsync() manpage made it not clear if such a
>> theoretical possibility from the fsync() system call would be intended or not
>> so eventually this part could be slighty enhanced.
>>
> 
> I don't know how fsync(2) works.  Could some kernel fs programmer please 
> check if the text matches the implementation, and if that issue reported 
> should be reworded in the manual page?

I don't know what the "see caches" mean in a few spots in the above
text? In simplified terms, fsync will write out dirty data and then
ensure that it is stable on media. The latter is your cache flush, if
the underlying device is using some sort of writeback caching. When the
flush is issued, there is no more dirty kernel cached data.

If the device doesn't honor a cache flush (eg "all writes previously
acked are now stable"), then there's nothing the kernel can do about it.
It would not even know. The only way to know is if a powercut comes in
after a flush, and once power is restored, the media contains stale
data.

There is no issue here. If your storage device is lying to you, buy
better storage devices.

-- 
Jens Axboe

