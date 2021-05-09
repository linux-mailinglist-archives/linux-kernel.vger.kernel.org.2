Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9592437759E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 07:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhEIFez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 01:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhEIFex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 01:34:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803A3C061573
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 22:33:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id j12so4953374pgh.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 22:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFKDQU5DS343y/NTnTj8Fq7mQFzFjXVMKxe4AC0cmXg=;
        b=N3E5Q68Hvi05h4SbeHN76QpPrhI054UiuR8kJhbjIHyEuoqPUGVy9od/ArqtgFwjPR
         9VMknSlloTTmOC4bOeeUCbNyKqXv4qwkALG7POWBWn9Fhvp733XQWxsgInHHpQ0quc0v
         nSVX0KG2NmHlrSSGOCTXwkRRl//9ouNsddQsxsfgSyyTYaQdP9/ltOz36fb7V9+vebuT
         VZIYvD6mdN/7jTpK9/GMuLT3GHgmqsfLxuQqfzA+eR+RVa5gQY188Xfz+pnppeQ/nb6U
         nUAdkMYp9GDh+P45S3iewsA2iGEIrpR2wzEjU6IS9w4UjsIHgpcz9oTW8/k/7m3dCNW3
         rzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFKDQU5DS343y/NTnTj8Fq7mQFzFjXVMKxe4AC0cmXg=;
        b=acjn5DoE3mhDBB87dIelCgNuuwCPaFc/GPOtdWSUqX55mYzql0HJ2niMGaJJNRkQ9x
         tWfOR3Hkv8AgNLgbMaPB8YeywOMAgUV3GOSX9476jO0mzbgKdRU47fN/sCkmeeZ/4HiQ
         1cbCuCuPTSqQ6DkDoO/GMbbQr4cWQ2J5J+ghyqNSYAx93odFxLOSCpy/ksj4liTPveVm
         K+M6yN7BNQmTuRafh8JogPGqypRrGWf7qnzsoMcj94HM5xW+37gHE/a4uHbfyCUOwbUf
         Def96L+b3M6t1sTLT+QNn7LMdY0vrefWh77gm6s2ahGsQaNzX+8GBSuDPXeLsRVObCqy
         mbhw==
X-Gm-Message-State: AOAM533YdfXh1GaDs1tfMR1NTt48XkRM+CxA8O0HRfKZz9230ABGK3rg
        5HD5cQuuDlEWoGNu1u8Qhf8cJkaIC0A/rSwqqgY=
X-Google-Smtp-Source: ABdhPJycf4ua0//MJBiTPY7efm8rJOJyoy+Y9IaTvvE8yfQPQ47AJMQ458VUk2bryzWtNfy9GGnqyG9D+QENDQ9vfA4=
X-Received: by 2002:aa7:954d:0:b029:29f:d9a6:63d7 with SMTP id
 w13-20020aa7954d0000b029029fd9a663d7mr15739543pfq.58.1620538430058; Sat, 08
 May 2021 22:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210508221328.7338-1-42.hyeyoo@gmail.com> <YJccjBMBiwLqFrB8@casper.infradead.org>
In-Reply-To: <YJccjBMBiwLqFrB8@casper.infradead.org>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 9 May 2021 14:33:38 +0900
Message-ID: <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
Subject: Re: [PATCH] mm: kmalloc_index: remove case when size is more than 32MB
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 12:19:40AM +0100, Matthew Wilcox wrote:
> On Sun, May 09, 2021 at 07:13:28AM +0900, Hyeonggon Yoo wrote:
> > the return value of kmalloc_index is used as index of kmalloc_caches,
>
> it doesn't matter.  every few weeks somebody posts a patch to "optimise"
> kmalloc_index, failing to appreciate that it's only ever run at compile
> time because it's all under __builtin_constant_p().

Oh thanks, I didn't know about __builtin_constant_p.

But I was not optimizing kmalloc_index. isn't it confusing that
kmalloc_caches alllows maximum size of 32MB, and kmalloc_index allows
maximum size of 64MB?

and even if the code I removed is never reached because 64MB is always
bigger than KMALLOC_MAX_CACHE_SIZE, it will cause an error if reached.
