Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA18364945
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbhDSR4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbhDSR4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:56:52 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30C1C061763
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:56:21 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e186so35769532iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UaHhG9GjhH16KyT6wD+AMErOXAvHsspPbBTiFIqnuaI=;
        b=o+t5ZaauRNLZB/NkC22jEe2WM29+J9dvtwmzjqajMX9136E1PLxCAL67mX4z/9zGxa
         dE7B36ZUxx7hwJ12zc75LQ92fxQ/6BZfJR0fGyARnZ5jJh+edWsDSZH5AzUaH4mtNCkZ
         62ZvyNp4P8Zarvc1U6inYSc5yBMS6RrREqH0IZlCZidUdCpLkfDFVAXBGU2PM+bwwjZe
         vvdm21ELaxzmmN1BO3XUR+2coqcgdwX6ge3u+HaR2ikmYeHECxVZL/ZoUD6PTBsXkiRm
         iHbrF0GAoUBuYZ2kb+wMC6WkuZa52Dc/SekbgDRMzPSbtrVrsTcJbicVQvcLBz6YHlzM
         3H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UaHhG9GjhH16KyT6wD+AMErOXAvHsspPbBTiFIqnuaI=;
        b=fthTTVYVXmQThaU1XFXtfuVrjj2k6HgzAFCTnLyPHki6gnirklMVPxlCjdak7OVlHj
         voQzhuaPAH9xa22uxssFMewwFduYZv74uxViaU64/YEmitYaiNxlxeV35d5ZGE6cM48l
         4oYG+3F27sI0a0RSIEy9tBMaPSChLPTMNjs1mDo0yJ45RskMEXTYxjf0HS1HPBt4gqhw
         gKK7Udmqui9kVlQ+FOS8AWf+tDUk0sh4q8+Bfi8znvFkHwJmtoBb/W0ymcJRHKO+ZQuL
         KNLwih8PLi4C8zACBLcIZ904KZ1fxMNp+mY1U/yUEWOGp1OKAq82IPyO40nZKpypQN1K
         xF4A==
X-Gm-Message-State: AOAM531nL2DW1+Mz8twA1O5GilkaWk0T7JFpSwxrLkKUf4Bt7gM9fd5a
        0TZsS9hKuXV4tYqkvnAODwYaCyyHoT8dgA==
X-Google-Smtp-Source: ABdhPJzcUoaPEMhNhyNqr210rk8IlMIG/uYe7qF61kR71/dLorG2qPOtfnA8Ox3lIrcs28uCaaqLTw==
X-Received: by 2002:a02:cc:: with SMTP id 195mr18099419jaa.73.1618854980993;
        Mon, 19 Apr 2021 10:56:20 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 1sm7324479ilz.11.2021.04.19.10.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 10:56:20 -0700 (PDT)
Subject: Re: [PATCH] io_uring: check ctx->sq_data before io_sq_offload_start
To:     Palash Oswal <hello@oswalpalash.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210419123630.62212-1-hello@oswalpalash.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <857554eb-d020-7e45-edd5-0b15bc2d1945@kernel.dk>
Date:   Mon, 19 Apr 2021 11:56:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210419123630.62212-1-hello@oswalpalash.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 6:36 AM, Palash Oswal wrote:
> syzkaller identified KASAN: null-ptr-deref Read in io_uring_create
> bug on the stable 5.11-y tree.
> 
> BUG: KASAN: null-ptr-deref in io_sq_offload_start fs/io_uring.c:8254 [inline]
> BUG: KASAN: null-ptr-deref in io_disable_sqo_submit fs/io_uring.c:8999 [inline]
> BUG: KASAN: null-ptr-deref in io_uring_create+0x1275/0x22f0 fs/io_uring.c:9824
> Read of size 8 at addr 0000000000000068 by task syz-executor.0/4350
> 
> A simple reproducer for this bug is:
> 
> int main(void)
> {
>   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
>   intptr_t res = 0;
>   pid_t parent = getpid();
>   *(uint32_t*)0x20000084 = 0;
>   *(uint32_t*)0x20000088 = 0x42;
>   *(uint32_t*)0x2000008c = 0;
>   *(uint32_t*)0x20000090 = 0;
>   *(uint32_t*)0x20000098 = -1;
>   *(uint32_t*)0x2000009c = 0;
>   *(uint32_t*)0x200000a0 = 0;
>   *(uint32_t*)0x200000a4 = 0;
>   if (fork() == 0) {
>     kill(parent,SIGKILL);
>     exit(0);
>   }
>   res = syscall(__NR_io_uring_setup, 0x7994, 0x20000080ul);
>   return 0;
> }
> 
> Due to the SIGKILL sent to the process before io_uring_setup
> completes, ctx->sq_data is NULL. Therefore, io_sq_offload_start
> does a null pointer dereferenced read. More details on this bug
> are in [1]. Discussion for this patch happened in [2].
> 
> [1] https://oswalpalash.com/exploring-null-ptr-deref-io-uring-submit
> [2] https://lore.kernel.org/io-uring/a08121be-f481-e9f8-b28d-3eb5d4f
> a5b76@gmail.com/

This should be a backport of the 5.12 fix, not a separate patch.

-- 
Jens Axboe

