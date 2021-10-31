Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6744107F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 20:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhJaTnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 15:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhJaTnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 15:43:22 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E343FC061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:40:50 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n11so5964653iod.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MzDrzuzpYnbYB0j0l2jWAFKlpNw8zKCZIf59AYFBfkU=;
        b=VtzIBg9nH2TBJO7RLbVEorGZy2ztmplRMgsK4PAELDA8/WNUpDxGXwzfcjxcFuJSAF
         SAVOFqg+Gv+pW4X4Qvelr8sPUs5DSADDCw3AHIhBFUBOUubMS5NV4LL2DO8J3H8vjJ7O
         G2JljQOzoqIgVZ2oxw99zctxez8hhod2UUmW0YBvSEVISKBokwoVWs189hSxEcUfUhc3
         /W0+rhwwF24IyC8ogtuc+pxL+/BSQtSThe8WyuNfpLltMG9MJonvlMRz3Kh4fnwDU6IR
         0sNkxz/348J/0rygxvs1w5800+gIyXOWkpZJZSC90NInTtBkiR7OKW6AVOo1kh7DF7Ir
         UtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MzDrzuzpYnbYB0j0l2jWAFKlpNw8zKCZIf59AYFBfkU=;
        b=2V2QgewTIJ0aSYV8x4HTmvFd3cDltsCB43vpQgribvtN3PC1OH7Uk9HlZczL6ppscL
         +1if7DrWBp1XUyKnfNWPVxa3iRYsXph8IV+KxZeVJiAhdhWpN2UTMux5QX/C9/ZPsV/K
         ZdBehm+KZN0wRmo+Hn1S3HrAW+t/v6TLk96TXOJrrZH2lqoimKXKvZcCKj3QF2hfMxgX
         MxqbcOBQ+w4Smqi6fo/93X7t+BTUWrGpUsikR1Uk4e9ixzAv1dB9KCsPHVu1tTgiOIDh
         0Iksal0e8DfWH9cwxsqeLgtT4M7BlDBy/47tdfS9uB6mZBg/HnucZirAirL5PWnW6iDF
         qgIg==
X-Gm-Message-State: AOAM533H6fzYRiuhgR9rTQZe8UOiyn3VB3z24Kz9WRN06F/kC/MIoBvd
        anv/aK0yrUg0KTA1d8AhuKj1rg==
X-Google-Smtp-Source: ABdhPJxavGrskLJZx7SWqJM9Byj7QN7LjpAqwfFYPCVd8hoT/PR190/kiFfcZa8ew5N4xoLvuadPUg==
X-Received: by 2002:a02:9701:: with SMTP id x1mr17981931jai.97.1635709250298;
        Sun, 31 Oct 2021 12:40:50 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s12sm2429782iol.30.2021.10.31.12.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:40:49 -0700 (PDT)
Subject: Re: [syzbot] INFO: rcu detected stall in tctx_task_work
To:     syzbot <syzbot+e4f5deeeccdd5a4873fe@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, fweisbec@gmail.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, xiaoguang.wang@linux.alibaba.com
References: <00000000000030c35005cfa98ed5@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <13c4d07e-0e4c-ee55-c3be-1b42125f248d@kernel.dk>
Date:   Sun, 31 Oct 2021 13:40:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000030c35005cfa98ed5@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/21 11:40 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bdcc9f6a5682 Add linux-next specific files for 20211029
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10be38f4b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4b504bcb4c507265
> dashboard link: https://syzkaller.appspot.com/bug?extid=e4f5deeeccdd5a4873fe
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b915d4b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1395f3e2b00000
> 
> The issue was bisected to:
> 
> commit 34ced75ca1f63fac6148497971212583aa0f7a87
> Author: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> Date:   Mon Oct 25 05:38:48 2021 +0000
> 
>     io_uring: reduce frequent add_wait_queue() overhead for multi-shot poll request

This was dropped from the tree last week:

#syz invalid

-- 
Jens Axboe

