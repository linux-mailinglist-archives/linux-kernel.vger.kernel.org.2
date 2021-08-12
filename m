Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049823EA124
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhHLI7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhHLI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:59:23 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3549C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:58:58 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bj40so9269167oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glSRtZn0PFX+XapwdsQxtT//X4Ni5wcQnHCn2+naPE0=;
        b=UHg5LO9a6h4YMLmtIURwo12v57QKDIMxCUykfKcMR4UqfxdWKLCkThvo4Zz4fnXZbO
         oPTjDMSeqwgGAUFRZL47F7L7dDap+mM9lQrpEbdTj+V1PPl2mDD0sMqoAnar7gxzq2tK
         cYaMYMloamBz+t6QO7cTKHRk51NzB+Ic6zfRoHcAdWbx7UP0vj/OSjR3aED9sEORUm1+
         d6h08PAArp8Tk/cEYNCBdttUirJXx8yW2XhuJYG3BY/R9Mr5NJmGGc7ttrikeI+hVDfW
         YTBcxefrIvMsjgjYk8LvEVO/pppWtOVwtsIA/SPDqkM6fJ5j3LKWu1cdAmt3vfEgrIYV
         wQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glSRtZn0PFX+XapwdsQxtT//X4Ni5wcQnHCn2+naPE0=;
        b=HvdGVLVV013TMvGY1Ayok7n2Hx+b3Ou4dGR/yN8Y9g5CmVzPWRNrGMbqo46ZszoNmM
         i7XG8VU1PcAPa+Spv7bxF3WQajpzP2CJ+ohW1ReTivBxrzy97XBBwlDQgnPpAb1UxjHG
         MlTanWogQqOMDaTTh2RWmhewR7Zuc9IIOf9tDKukuXX+KNuBRrorOyjFDCjW4UpDPDu7
         t48zwMXid3Ai5bqSh7DYCT/gCGG5+3+AKkakS3vjUfKj8OItOyElzklI052QZg+eOXjs
         uXq/g0kOOD3aVBLcH4ML/mT9TAn2bvJeeAPeeVcI5/hDHXVKlmX3vejLlYl3Wp0AEWz+
         pu+g==
X-Gm-Message-State: AOAM532j2Ylvb/jqFOtRpUbAb1TgJ/QJgejuk5Eth0DcEXFWtk+7sgHW
        SVYBDZoS2op4/0Qx8PgazDWKXiGztGsQVCS9ExJY2Q==
X-Google-Smtp-Source: ABdhPJztYAQ5HI2PE0ZBReSLN1qSUw8KPkARULQ7RPk0jCEXnuCUozSBipIHcxboDnnLJ/ZPkj/n3nWl76t4BMWSGYQ=
X-Received: by 2002:aca:eb8a:: with SMTP id j132mr2513361oih.121.1628758737993;
 Thu, 12 Aug 2021 01:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <cover.1628709663.git.andreyknvl@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 10:58:46 +0200
Message-ID: <CANpmjNO+mvUF4S5n8QSDrB+caU_V79MH8_iw2=3V_W=Eh+SAHQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] kasan: test: avoid crashing the kernel with HW_TAGS
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:21, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> KASAN tests do out-of-bounds and use-after-free accesses. Running the
> tests works fine for the GENERIC mode, as it uses qurantine and redzones.
> But the HW_TAGS mode uses neither, and running the tests might crash
> the kernel.
>
> Rework the tests to avoid corrupting kernel memory.

Thanks for this!

I think only 1 change is questionable ("kasan: test: avoid corrupting
memory via memset") because it no longer checks overlapping valid to
invalid range writes.

> Andrey Konovalov (8):
>   kasan: test: rework kmalloc_oob_right
>   kasan: test: avoid writing invalid memory
>   kasan: test: avoid corrupting memory via memset
>   kasan: test: disable kmalloc_memmove_invalid_size for HW_TAGS
>   kasan: test: only do kmalloc_uaf_memset for generic mode
>   kasan: test: clean up ksize_uaf
>   kasan: test: avoid corrupting memory in copy_user_test
>   kasan: test: avoid corrupting memory in kasan_rcu_uaf
>
>  lib/test_kasan.c        | 74 ++++++++++++++++++++++++++++-------------
>  lib/test_kasan_module.c | 20 +++++------
>  2 files changed, 60 insertions(+), 34 deletions(-)
>
> --
> 2.25.1
>
