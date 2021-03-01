Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7402732810F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhCAOgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbhCAOgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:36:13 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0AEC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:35:33 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n14so17955802iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IuZcaz9M6z7fv3fUG8LG+twPtI8fl3qJP/EQXIzCZw4=;
        b=yQsjymsNwLT2CG2IWunNlaopYSRMClehdBGUknkNaNf5z03W1+ZFYJ4E7id34mwAw+
         2BFyiuYdqVl0ChtVdqmRT+m/aLOqwmXpAZ+yGi2IW3xAoQf16Ioz/5e/379O+TTPESwc
         StsatWEuJRkFvDyq+xOW5CXC4ehHuTQIs7Tip0kHjd8P14uUEB+j1Ti9jP6goTUrzIR/
         XCtALelhW+s/HJAK8X9a6EabjCGXuC+106pfXXA2aKIrb54f3jYg3QGrslAHlIrEA3tN
         pQg4ywX3UPNUb79vVZ8+IEIeWe6X8hMylrmmLwol6i36dG866TD3aNtFTEir0ttoL7cE
         ebwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IuZcaz9M6z7fv3fUG8LG+twPtI8fl3qJP/EQXIzCZw4=;
        b=G8SNRkWWtndndgHv2OiE3SAVEUPHS9W7ZsehrUUj8/loHSpP0kr7Qbb0X0NPK08SEJ
         Pm/SG4VqreTdhvvoSAF4XJaTC/1J1NOQKoZBWJJFxBl0KlfC983sgY4TJXV1n1tB4yg1
         FvzI+VGC8Eyx+jfXApWZ+Xiz38xEtceMh9Mn0oWQXNTmKzrhA73G+G0wMm1nHnaHbjxl
         7PgU227dac/ucxxcbgisQ8wGQEtRGZBHCXw9kv22Zc2gM8Dk8xeli6c/N50LxTOOq29q
         cn7AbKWnI1OXD9xVrw6E/EXQIcZzBZxovcvzVfrliqq0qeZWukzRDRuTkIEyo+iK8iCf
         ndtg==
X-Gm-Message-State: AOAM532evqP6CekRtTuUfPAlNyy3+BnC+B3i0Hb+zwPD3RwxNa4oUNfj
        UEV76D7kwx6sVtz1/d7IZH+yzA==
X-Google-Smtp-Source: ABdhPJxjIcTTq6ER1Ytq5m0JLPzBdfmh63xdfGoCmGyrsdQYyndJ2s4wlknmyKhBX5lxpE6JcmgPQQ==
X-Received: by 2002:a5d:8493:: with SMTP id t19mr14390109iom.28.1614609332755;
        Mon, 01 Mar 2021 06:35:32 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x3sm10437350iof.21.2021.03.01.06.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 06:35:32 -0800 (PST)
Subject: Re: KASAN: null-ptr-deref Write in bdi_put
To:     syzbot <syzbot+aded2f2ab94d81727898@syzkaller.appspotmail.com>,
        aik@ozlabs.ru, akpm@linux-foundation.org, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
References: <00000000000030504905bc792423@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <86fb6e46-2796-3967-3578-5b80d70bef2f@kernel.dk>
Date:   Mon, 1 Mar 2021 07:35:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000030504905bc792423@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 5:56 AM, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 2d2f6f1b4799428d160c021dd652bc3e3593945e
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Jan 7 18:36:40 2021 +0000
> 
>     block: pre-initialize struct block_device in bdev_alloc_inode
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1424a5b6d00000
> start commit:   71c061d2 Merge tag 'for-5.11-rc2-tag' of git://git.kernel...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=33b7f56c5bf0f684
> dashboard link: https://syzkaller.appspot.com/bug?extid=aded2f2ab94d81727898
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143f7fc0d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1089023f500000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: pre-initialize struct block_device in bdev_alloc_inode


-- 
Jens Axboe

