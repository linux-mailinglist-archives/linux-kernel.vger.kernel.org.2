Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDED4401B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJ2SLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhJ2SK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:10:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3132C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:08:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a26so9913245pfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xFYea77yp7hHF39j7jIyl1YqhsIj0k6eOQNJFYQ5RKU=;
        b=bvJHJP9yCpPGLyJzDOAMGmnvbTTWHWRmhJRXfAdSCfdAePRvWAOufkkIiXfH3Obgk6
         A7OzZ3NdhixBsooGlavgr2XKjf5c4KHvc5YerFmO3gflcICkNPbumhL51LbWz1HVIZ5r
         NUu6LyZgAuXkQkX3uzvvIOusLLikWswHAk9UUXQ9j3xKIitPaKmmaj6cegLF+86iBmaX
         v6c4Zsq03qvHTrkiOYZSzPt1D4rl5AOtUjVbgmwdv8Sg7G5lSXwBsKAVFVBIHpN0L+Pl
         hJ0/oG6R23DEBwx1x68rCawxxYF3RxlxtvqNrfdYHSXk1Ll2a+zXNMO+jYwx4f6c1dYb
         CA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xFYea77yp7hHF39j7jIyl1YqhsIj0k6eOQNJFYQ5RKU=;
        b=uAahhvsdR+YgAGkhDSHcgM3SNlmNNM5fXsLiOrID1GR+saLVEVSH8/dGvxuhTcgi1o
         KjHJsDeOK3WSAKTZqR7+hNkdF7LMkeyyWKEujAa9y8eyYFkh3Fp00TOnUQMDM+eRJ/Nk
         6k57airBIDOadWsExBi9Vsw5Clk8VSkz9Qw6z0znzplOmuV4XleIKNtQaA9CG/m58ZYq
         F1qqAyqPq4RXdxrEWKNWXXm91unZT1QqB7XHqxrZug2v7QGANi3swpPwoA0UGW0MDMYo
         t9ag5/hFcIDMAlh9mHfwy6R6UrJSaPcwHGiXkWpxChqoZ+JR3sNVKRkPz3XzL+uPGIK8
         cqKA==
X-Gm-Message-State: AOAM530OAW11gQAO3Vg9zd179/tw1rYONEVQlDHvsxLirVFVMvwkhVxN
        Wmt/5T1FJZhNrHaTB8Ke7pfQGQ==
X-Google-Smtp-Source: ABdhPJz5Sqz0A6jeR9OTfM5Fo3ERAYSM4YQaiaZ9xy1sEqYRBmNn0O6vk/ff3JxqslbHJZrGyjGEfg==
X-Received: by 2002:a63:3546:: with SMTP id c67mr9131634pga.201.1635530909069;
        Fri, 29 Oct 2021 11:08:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:b1bb:1ca3:676a:3e09])
        by smtp.gmail.com with ESMTPSA id k8sm8099425pfu.179.2021.10.29.11.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 11:08:28 -0700 (PDT)
Date:   Fri, 29 Oct 2021 11:08:28 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Oct 2021 11:08:25 PDT (-0700)
Subject:     Re: [PATCH v2 0/2] riscv asan-stack fixes
In-Reply-To: <20211029045927.72933-1-alexandre.ghiti@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        alexandre.ghiti@canonical.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexandre.ghiti@canonical.com
Message-ID: <mhng-b840919e-0658-4567-8639-f15c6076a860@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 21:59:25 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> This small patchset fixes asan-stack for riscv.
>
> Changes in v2:
>  * fix KASAN_VMALLOC=n
>  * swap both patches in order not to have a non-bootable kernel commit
>
> Alexandre Ghiti (2):
>   riscv: Do not re-populate shadow memory with
>     kasan_populate_early_shadow
>   riscv: Fix asan-stack clang build
>
>  arch/riscv/Kconfig             |  6 ++++++
>  arch/riscv/include/asm/kasan.h |  3 +--
>  arch/riscv/mm/kasan_init.c     | 14 +++-----------
>  3 files changed, 10 insertions(+), 13 deletions(-)

Thanks, these are on fixes.
