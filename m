Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311D03A6802
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhFNNgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhFNNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:36:27 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB30C061787;
        Mon, 14 Jun 2021 06:34:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f84so15544575ybg.0;
        Mon, 14 Jun 2021 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UV8GgpkywRc80yJBzURQ2ueKO8QT60yu6MzWe3gxGQo=;
        b=vGSYmNGxl+C6HflqoOw75ZmW8RORicMDf6Gv5FRyH0JQcQxcSF6FeEs4GXB/X4nFj0
         tdErD9xB5ZVPHofLxe8zi0zzKV0PQ8Uxh9cyHgOY6NzM68jE9AXXvZnwkRZ8xujvABBL
         Dx2S7oupGxUYNv5/8uv25WK0rClLeEuA3jVG6omBXhZLq32aFXsfcgNXisKP2iDnrlv/
         UOwsOf+GEFdNPdTgR5y5oaPi4b/wRvP4bSXyZ65ZyQsv/iRBHbb4AqzWeZW3/pw0wMte
         rvlU4JSYBBHsI56P5ckPoUjJM/r9dYZpoxuI3n1z05E6Vc2bEZVmGsCzreRzAmaJyTjC
         yhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UV8GgpkywRc80yJBzURQ2ueKO8QT60yu6MzWe3gxGQo=;
        b=BynGYL2xoh+mRbbyXQeTk8NbAupdKS/pisVFdd3d3ROM6nP2tSdvs1SLEu65Pmmimx
         AyqeoszA91ejVuzFZZ7GIXIurGKvqsD6LrvfHWjEO+xY+FuaDcnMXrsn05TS4Fx3rzm3
         6mIWpZnPYbZ3BIxnYy2G87Gip7XXzBJhvnySgq81CwUNmdfq82dHczfbCuQe/yUXd2sN
         nmS8h2v5jKztDqS31Vd86Q/CXC2o3zPw9PLdbZMpoEZH+4KPjJXq4gUljB0o7dOwvYqt
         5AcNu/J7NJ5MKY5L/vtzpkRSu47t7q6tpugFSAgITV4NcuZYZuYWvxejNmMG/gfUZeyq
         RK4g==
X-Gm-Message-State: AOAM5313TmK4EMXfn4iZSuIj2+MnXPSptTiJB/FDaaZ7gEJan/NLnN4p
        NPaGimH3mIlh/aR6E01mQPCO5SBOm3cTrjjAqB4=
X-Google-Smtp-Source: ABdhPJylNzdCIx5gB/SSt4ArZfgpf4B7gA665R73OuUCObZaJ0ySbNIP6vT5VHAYvJxqu39giVxqRUr7yMRZ7qZ7ypw=
X-Received: by 2002:a25:cf8f:: with SMTP id f137mr23334946ybg.314.1623677653776;
 Mon, 14 Jun 2021 06:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-7-anup.patel@wdc.com>
In-Reply-To: <20210612160422.330705-7-anup.patel@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 14 Jun 2021 21:34:01 +0800
Message-ID: <CAEUhbmXJW6BKPY81hsTHJc=yHkuY+1_fQYhRPT5AanzFJh7rcw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 06/10] RISC-V: Select ACLINT SWI driver for virt machine
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 12:08 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> The QEMU virt machine has provision to emulate ACLINT SWI device
> for supervisor-mode so let's select corresponding driver from
> SOC_VIRT kconfig option.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/Kconfig.socs | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
