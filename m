Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A194058F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbhIIOZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbhIIOZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:25:26 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8ABC125127
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 05:57:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x5so1794650ill.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VXBqdGZV180Tlah+cVQrTrUES/kEF10pr/rM/UOgwDw=;
        b=ZmrWVy5URFDxQTuLq82DOsdwoy1iv6TWlp3VcRyKlMnmA+xJ9lImnUPPg81fQiu7cT
         U7RaxGExbCGnUPjR6c9MeGu25BnjX0HYiCVwHiFeL1Cbm9TU73tEj5gNsrU/k+OQbmgN
         SGv4KNaiNi77Yngsv0bU4XjFnDQazE3re6UBdhG12d2myTS6V7qnhaFBgYg4llFtQ1or
         S2BaZTyq/0Tj4ufikxBPOq48N3q3ppHYA1Y8U1a7mUhGyts/T3oBAhqpfuwiupQUKgNL
         rx2J62DFPcrW2AdaAMHznekwWft/lTclVyWyuKc5z2FxdmaquOIZ5Simzv/oovzeR68r
         g3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VXBqdGZV180Tlah+cVQrTrUES/kEF10pr/rM/UOgwDw=;
        b=tta994Ra7+74yTGPI/AxTSJUVKIS6M9WvfZwIbG9Drz4/zlgGsME6azGcPj9JNnF55
         tNAUBly9/Ki4vmEfY2LMOROgKOcRUmR4RYIfhmPXmUGV+OFAw7H82qTh+cM1f9OojXG3
         iPr32V7d69zAYAiTrsl+vxZCm8+3S2Re1k1eJ2yRqGdWdf7ZTNzbymzZwLIIgXY/rSXs
         djNKXacSr9ft3lAKoZGEHBS0bUG9YyeI9XYZ2MYuTEzImnjE1mruourZzF1Asc2inekg
         J66YkElurYl6yDzm5WsN6eeegoMopB8xr2EhL4J6DqLJShoO+SH6z9TyMfztlR8q6ZMk
         DJwQ==
X-Gm-Message-State: AOAM532Capu6QHHzE92lstBM/B0kFqGUYolpHMisIZR9bP8ARRlZRTOT
        tNrkU4/wZqhfXIzMzyJIU6KyZWu9f/xWxQ==
X-Google-Smtp-Source: ABdhPJzMLj4KMdCemWGoH+IWSUPRVWmC7R3qrA9F1/T2lw0L3YMR+f+YHVEmHvKE97nyAYiyue/00g==
X-Received: by 2002:a92:cdac:: with SMTP id g12mr2082056ild.201.1631192246585;
        Thu, 09 Sep 2021 05:57:26 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o15sm859294ilo.73.2021.09.09.05.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 05:57:26 -0700 (PDT)
Subject: Re: [PATCH] io-wq: fix memory leak in create_io_worker()
To:     qiang.zhang@windriver.com, asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210909115822.181188-1-qiang.zhang@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ab6186c-1267-a8ac-9da1-3fc83be1f82e@kernel.dk>
Date:   Thu, 9 Sep 2021 06:57:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210909115822.181188-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 5:58 AM, qiang.zhang@windriver.com wrote:
> From: "Qiang.zhang" <qiang.zhang@windriver.com>
> 
> BUG: memory leak
> unreferenced object 0xffff888126fcd6c0 (size 192):
>   comm "syz-executor.1", pid 11934, jiffies 4294983026 (age 15.690s)
>   backtrace:
>     [<ffffffff81632c91>] kmalloc_node include/linux/slab.h:609 [inline]
>     [<ffffffff81632c91>] kzalloc_node include/linux/slab.h:732 [inline]
>     [<ffffffff81632c91>] create_io_worker+0x41/0x1e0 fs/io-wq.c:739
>     [<ffffffff8163311e>] io_wqe_create_worker fs/io-wq.c:267 [inline]
>     [<ffffffff8163311e>] io_wqe_enqueue+0x1fe/0x330 fs/io-wq.c:866
>     [<ffffffff81620b64>] io_queue_async_work+0xc4/0x200 fs/io_uring.c:1473
>     [<ffffffff8162c59c>] __io_queue_sqe+0x34c/0x510 fs/io_uring.c:6933
>     [<ffffffff8162c7ab>] io_req_task_submit+0x4b/0xa0 fs/io_uring.c:2233
>     [<ffffffff8162cb48>] io_async_task_func+0x108/0x1c0 fs/io_uring.c:5462
>     [<ffffffff816259e3>] tctx_task_work+0x1b3/0x3a0 fs/io_uring.c:2158
>     [<ffffffff81269b43>] task_work_run+0x73/0xb0 kernel/task_work.c:164
>     [<ffffffff812dcdd1>] tracehook_notify_signal include/linux/tracehook.h:212 [inline]
>     [<ffffffff812dcdd1>] handle_signal_work kernel/entry/common.c:146 [inline]
>     [<ffffffff812dcdd1>] exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>     [<ffffffff812dcdd1>] exit_to_user_mode_prepare+0x151/0x180 kernel/entry/common.c:209
>     [<ffffffff843ff25d>] __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>     [<ffffffff843ff25d>] syscall_exit_to_user_mode+0x1d/0x40 kernel/entry/common.c:302
>     [<ffffffff843fa4a2>] do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> when create_io_thread() return error, and not retry, the worker object
> need to be freed.

Thanks, this one looks complete.

-- 
Jens Axboe

