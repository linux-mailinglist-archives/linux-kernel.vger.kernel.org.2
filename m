Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5951B3F825E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhHZGVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbhHZGVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:21:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC3AC061796
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:20:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id e21so3707574ejz.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T99lzSum7lx0H0eLIVXXXKSQFMXc/FiDCDjfW8+qt7E=;
        b=YDQw6YYp1Q+e3JAJKpV9SIj7NSipKUumvtRA5vDaUyUqVu1CCLC2NGhimLqq7QMf0v
         L3ocVOOeZLwCwpW/48Hzdm8AZkEJALbzsqjgihIcJX0KvJxMghcDqWiIcQVvAioFk/72
         O7AC3T//xi9If/k69Y1bE7j2t9INx5OZf5Z4yppNioTqpyFRqboAbs5nwZ959Aa8/WzY
         I75w/WOU+XLuHlyFZAhj2zSVda9b4Xs4359xSfwiycM//qcFkOGeJGL13cnq6DKRc9zz
         sF5lxFXBJNxrP9AF6jfwciaT5EuluTmkRTeoEGDQVQJMeu0rwi1FvJBx107EBg6Cva+0
         rf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T99lzSum7lx0H0eLIVXXXKSQFMXc/FiDCDjfW8+qt7E=;
        b=US2xQwjU4z9yXGCnhbK2qWTqNxYIe44CmlvRaikr/dFbqK473mU835wCJlT2D07I3g
         O8HiiZHVo94KRSGgSczmpzNehuuqV96pKaj+Rsm1WBaLfxdvCOpd4vgMXFqKI2E2aQrJ
         5TZqJbpSs6MZgbD3I7j9QQb5r7XAxARE6wsD1hjiEUUgTdBLrtwGafgsfwzS3xuRduSj
         FlzPq3tEz651DTrf2Bt9aUllAV3KLKSRZwDD3s8baClE49eIS/qrgSz2OpQKAx+eVEGB
         QEkL5rZWkf7nL+GwcHrxAPY3g1pUjo6ZnoXpRjbpvk/2Su4PPkQm44UcFHWeyVp7B2Uv
         t8pQ==
X-Gm-Message-State: AOAM531UaFmLtriPF5IBK6mi28S3oP1ysmp8XAbIA3k/qUvI1HS5Brma
        y1ZbQF3SKtLB0PFcbJquZ8f4mcjCcV7GAMVrQ6E=
X-Google-Smtp-Source: ABdhPJxRTpCTLDh6BG6miJ50+ZZxnnE6C1yC+UQeTxlO72m2FHwt/XN411Ij8QRRbVFXpEB6/fvhXunrINI5rqogxog=
X-Received: by 2002:a17:906:3a57:: with SMTP id a23mr2534109ejf.469.1629958826448;
 Wed, 25 Aug 2021 23:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210826060509.2470960-1-palmer@dabbelt.com>
In-Reply-To: <20210826060509.2470960-1-palmer@dabbelt.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Thu, 26 Aug 2021 09:20:10 +0300
Message-ID: <CAOJsxLFyxKOBmzOGCojxWRsrOB1k7jy8P+kNTUtLH6DgdrOZCQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix VDSO build for !MMU
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>, abdulras@google.com,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 9:09 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> We don't have a VDSO for the !MMU configurations, so don't try to build
> one.
>
> Fixes: fde9c59aebaf ("riscv: explicitly use symbol offsets for VDSO")
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>
