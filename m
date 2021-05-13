Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3659B37F3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhEMIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhEMIPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:15:16 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF63C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:14:05 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y2so33824106ybq.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdQjvampDreMTbFN7YQGjC8tN7QCrtiBNyMWZhV7gjc=;
        b=dl9Atk4qOCccN7LDFyrHBvQe6HThvviY8YJr/0u6mGlYRmfSqBi8vhXg/YodHgJYGs
         Cm4l47I1IHdrwg1VIO3nd+WcFJeQ6DKtEkyHNmxrzstn50W43JMOBaIMXEZzGoZT+DjL
         1ONa+MQp4Zecs5+ac1WiKlM0JEeoyFD/Z5Ph8TTSCcsvSTDV14ApFtvF5wIuTpG+3Pm8
         clnHXRfIGoaDPYdfucYUXHgZcMFMtSJbodbKu0UG4PNXROuiH6BTFjnwWJC5jvvU1IJR
         xGo+EQdCFmxc5r4cRMpCXNROYH2k04r4fnlXKoh8CvWlWcW9B1J02MliiGCRZrEGKrw6
         uYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdQjvampDreMTbFN7YQGjC8tN7QCrtiBNyMWZhV7gjc=;
        b=KfUkJ3skWHxsk4riM4a1BTNZmjvxlLuR66QNFXE/NTD3BrQzdoo1DHGybHBCh2Mhph
         8Ui+zcUNpkAdMBq09syZV26CQHva021FDuyWyfO03L8s4x3BjFGyLdzFLuXFWE5AeHr0
         H0zEgMvHkESEACHl/KvpJRSLcddT/Awm16kCVA2GRsVT9r32anCBgKNa/kDWGSJ4JPqR
         dixFRnNEtM7P6h9TGFZDapQ5s5W7fhE28ICef2g1XgV+h3oW5P7Ub5N7Uv9FKxYZkyEN
         5NzMyYq0UqV0hSr6Ip73DOxnOdiOmRMp97An4egutTU/KAmNBxHgUZOS6VMC89blfTEe
         JLKw==
X-Gm-Message-State: AOAM533ib07Qz3Zh28Wwhdd0NSVo65jl3EBpusPDUVDrgst3IE/VwaL+
        Yv6x7Z0mXDcAMXKAPkDzsZ0uJ5iMEVoWJzBQkNg=
X-Google-Smtp-Source: ABdhPJwVUNbmqtVppeU9RZiVu6YT4YAW30ViuTqWmSCfSwUbc9qud96qQ5pIbT7Ry/Vq7NgozKaQ+GQU336tZmJOlu8=
X-Received: by 2002:a05:6902:1543:: with SMTP id r3mr21474668ybu.332.1620893645087;
 Thu, 13 May 2021 01:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210216225555.4976-1-gary@garyguo.net>
In-Reply-To: <20210216225555.4976-1-gary@garyguo.net>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 13 May 2021 16:13:53 +0800
Message-ID: <CAEUhbmXPAEjozYuoQpATzjS4E6Yo2eRpF6DJzxO8Cumdm57J3A@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix memmove and optimise memcpy when misalign
To:     Gary Guo <gary@garyguo.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>,
        Nylon Chen <nylon7@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 7:00 AM Gary Guo <gary@garyguo.net> wrote:
>
> 04091d6 introduces an assembly version of memmove but
> it does take misalignment into account (it checks if
> length is a multiple of machine word size but pointers
> need also be aligned). As a result it will generate
> misaligned load/store for the majority of cases and causes
> significant performance regression on hardware that traps
> misaligned load/store and emulate them using firmware.
>
> The current behaviour of memcpy is that it checks if both
> src and dest pointers are co-aligned (aka congruent
> modular SZ_REG). If aligned, it will copy data word-by-word
> after first aligning pointers to word boundary. If src
> and dst are not co-aligned, however, byte-wise copy will
> be performed.
>
> This patch fixes the memmove and optimises memcpy for
> misaligned cases. It will first align destination pointer
> to word-boundary regardless whether src and dest are
> co-aligned or not. If they indeed are, then wordwise copy
> is performed. If they are not co-aligned, then it will
> load two adjacent words from src and use shifts to assemble
> a full machine word. Some additional assembly level
> micro-optimisation is also performed to ensure more
> instructions can be compressed (e.g. prefer a0 to t6).
>
> In my testing this speeds up memcpy 4~5x when src and dest
> are not co-aligned (which is quite common in networking),
> and speeds up memmove 1000+x by avoiding trapping to firmware.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  arch/riscv/lib/memcpy.S  | 223 ++++++++++++++++++++++++---------------
>  arch/riscv/lib/memmove.S | 176 ++++++++++++++++++++----------
>  2 files changed, 257 insertions(+), 142 deletions(-)
>

Looks this patch remains unapplied.

This patch fixed an booting failure of U-Boot SPL on SiFive Unleashed
board, which was built from the latest U-Boot sources that has taken
the assembly version of mem* from the Linux kernel recently.
The exact load misalignment happens in the original memmove()
implementation that it does not handle the alignment correctly. With
this patch, the U-Boot SPL boots again.

Tested-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin
