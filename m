Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B834392E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCVGFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCVGFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:05:05 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C86EC061574;
        Sun, 21 Mar 2021 23:05:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o66so5353883ybg.10;
        Sun, 21 Mar 2021 23:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FG1+KPUwtgZN7XZD2JCE4xNXJ7HzuOOFg2FJVhM4QhQ=;
        b=oPnk/Y1ykO+u3txb/44/zCiUU5ZJZYtb3Rr4GzqTyv8t4DW2J1DMnd/5FUGlpWjIxQ
         W/oSo0CKqknuLMj1G5UbP3ohY1Gz7Th3gXWpGWOWP9vqbEOq++7kbP35HwbQTQxTebBH
         /tsmG67csbb4r520awj32c+1Oi2Wjf2fHB01tXtOvLqQoLYrzzZEyBG6gI2m32y/bTrN
         zQRkHdrfNdLUW4lLY78U/yX1ogvElBWce0IA9Mwnxs692BxPKMDM8eb5n3gj4lzCDwmi
         2iJUcMYAIX5yeGRF8SIqkLHqSXBOMffa/DVoKZPB9stDV5pyCFawcjAiyAbJ9pnp/XY3
         4xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FG1+KPUwtgZN7XZD2JCE4xNXJ7HzuOOFg2FJVhM4QhQ=;
        b=mIWgmDwCEL+ophdLVn3TVaoWgVDB1mxHYsPt3aklvtsMBTR/IY8eb5n1o8L2FN0NYI
         3h2iB0KvNEDZQ+2XVg0UV3XOdQbgczqRPCYl4+4coHOaH013temr0Iav0kC7JIHBHMbI
         pJf+nl8PWSIqrBc8pfEjEcz4esYNlA8UU0gvYqaB8jlBhBqFFriIZBNCL1FdjiMYUgkj
         kuP6nfZgizd1iaJQ+XTs4eAN2qmYzCgqDUmPmIaEi5rFVdw3PYxEwB7ikiScaQQ1YHSL
         iHrWgLug5XzE8dsr3W4LVT2bJCouoeFEy2Epfr2W7J8Qx1ZUPH8DMhzc4INgrSZ/GHMJ
         H5WQ==
X-Gm-Message-State: AOAM532I6S8pSoIM6rhVL1EsCTggDVQlXLLMsO2bp3TbBDeUlMwHuswf
        wfyhBvA2ZE2UzuipvjREphSWN4Rxx4gwLz/V9cg=
X-Google-Smtp-Source: ABdhPJxWgca5VI06/RCVPsjBtrXwQqqxodp7vU6Cewbx3Y20Z6XhZNod70oYZjN+Jz3v0YlBYVtnIYLkvKlLuYsYM2E=
X-Received: by 2002:a25:d28b:: with SMTP id j133mr20820720ybg.517.1616393104871;
 Sun, 21 Mar 2021 23:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210303200253.1827553-1-atish.patra@wdc.com> <20210303200253.1827553-4-atish.patra@wdc.com>
In-Reply-To: <20210303200253.1827553-4-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 22 Mar 2021 14:04:53 +0800
Message-ID: <CAEUhbmUYfZ=wnb0L=qgzvo73V5rM-cdKbMshGxKYQ-sph_nSSA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] RISC-V: Initial DTS for Microchip ICICLE board
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 8:48 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Add initial DTS for Microchip ICICLE board having only
> essential devices (clocks, sdhci, ethernet, serial, etc).
> The device tree is based on the U-Boot patch.
>
> https://patchwork.ozlabs.org/project/uboot/patch/20201110103414.10142-6-padmarao.begari@microchip.com/
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/microchip/Makefile        |   2 +
>  .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
>  .../boot/dts/microchip/microchip-mpfs.dtsi    | 329 ++++++++++++++++++
>  4 files changed, 404 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
