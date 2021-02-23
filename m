Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D992A32242C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhBWCd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBWCdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:33:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADFAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:32:43 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q20so7840883pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GIWAFhm0yAXQbjsvqea5+Fb3rjUr7WgrcLGVKsm40RE=;
        b=vOBhoN7p0hdxqBusqwkXV+lLO0nu4NI5mUmh0D3GO0jhVODgSIvLpE9zD5mYLsaePh
         KGBe1wBD1X/fccVCUgl3jA9X2m7gYRZPdfawrBfQKn01PdcSFzVZuDQRVDbvDgsZgPgn
         HzSNJBelB3liMcaRL/jrcFrWPeHKrkBYbpqI4Tl03VD611W26y46fMeGtU8PJFGXxxjm
         a5T2xx2Iu+v3r4KhWZ9REgtrQEZRyZgVzA7GaEpvtkPe18kv5sCzWmFF3nHIoDyW4UDz
         7ANwRSlP8psIBHRV5uGJR0jeDSZOaBAqoKPfUcw92/vDiaq1U2XRjPWpa4yX7VWCzgdL
         3UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GIWAFhm0yAXQbjsvqea5+Fb3rjUr7WgrcLGVKsm40RE=;
        b=CQwR6vR0YKoTtNMc7QJqAh7Fx5O3HX2jRJ789sJqPteOENlBsIL4uv0UNxt6rScQvs
         wqotsnPh0qf7j5CEbBvYrptYUA9xiOSil5+Kj785Sq5igHy+Uvrho4ddrHyz0DK+CyBy
         q/IxOiqtalTkjaEjhJU+hSLBzVdEvvdSANlRJUflXvxGolWZ7zO3WyBYC+EsWAcU69eX
         2j4G3RgPQA1TNMNOqiWto0BKNa3mDbHjqwwd2xo5DsoYQXGDtDxGF6IFaBu5c5MKAomn
         be4gDbXZbptGozfDhwP79gE4jyGOLWDBhpkfrFm5oCEiL7xJA2K0gYutvzn1raYXXNQI
         IZFQ==
X-Gm-Message-State: AOAM531U8lXAcnn4DUF9HmJcm3/nFBBOjMRImPVjhNxgxt+8WHU2Ij/9
        Z2L/DEnFyorOCmOshAoXiadx6w==
X-Google-Smtp-Source: ABdhPJzr5dOsca7Y6QpIEUtMluuZOZxocSOfKydvprVVOIoPBBUw7L8PfToqcbL1+gk3x7RNV1r0dg==
X-Received: by 2002:a05:6a00:1502:b029:1d2:72e7:a9db with SMTP id q2-20020a056a001502b02901d272e7a9dbmr210954pfu.42.1614047563032;
        Mon, 22 Feb 2021 18:32:43 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e8::11af? ([2620:10d:c090:400::5:c361])
        by smtp.gmail.com with ESMTPSA id j73sm21479975pfd.170.2021.02.22.18.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 18:32:42 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210223124236.7bdf0871@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c64e6f1-e793-5def-af03-c66221d6b4c4@kernel.dk>
Date:   Mon, 22 Feb 2021 19:32:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223124236.7bdf0871@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 6:42 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> fs/io_uring.c: In function 'io_sq_thread':
> fs/io_uring.c:6787:3: error: implicit declaration of function 'io_ctx_disable_sqo_submit' [-Werror=implicit-function-declaration]
>  6787 |   io_ctx_disable_sqo_submit(ctx);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   a6afa091d06a ("io_uring: move SQPOLL thread io-wq forked worker")
> 
> I have used the block tree from next-20210222 for today.

You got very unlucky, that bad commit only lasted for about 1-2 min.

-- 
Jens Axboe

