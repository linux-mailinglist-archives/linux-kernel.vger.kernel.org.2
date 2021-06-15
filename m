Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046C83A7DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFOL5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFOL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:57:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF9BC0613A2;
        Tue, 15 Jun 2021 04:54:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v22so26602014lfa.3;
        Tue, 15 Jun 2021 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mj0zKnNZimo+b0MCUPLJzY3nx5LlUdHFFIGbFIHkkM=;
        b=F3kUJHf5n5IAORPF+Anp44ff2rZIYN0+3++hNC5IbxpPYWhLoBHM0lQid+Dbj27K5c
         Emb1JZZCTKKILXGee62fPBkhV5GvEKUg7qmm8iIQjhVkMXcF+Se8CkbkJbZ0dO5LpsLL
         C0/9QJ0YvOpW+AFqaKIjkVNp0QDr8tKJY0xLJ/5mu1VzFNCezAeCHw4CFz2y7b/hNuRk
         REy62jgEwxpvKVwrXGSWl9Bqvu2aq31Tw4A1xFFJaAZgzIE+QcJDJmG4oDbfhg80qcY0
         0JiT0o28UDIA85s2evfyTbZUr7GYLa+hclDuIBKZTSjrL7pGSmqcbJAo/UO0AAaUup9J
         Y8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mj0zKnNZimo+b0MCUPLJzY3nx5LlUdHFFIGbFIHkkM=;
        b=S44XBgY5MxZiT8ESX663f9kKNOOUU8Dnbxlkf4fL4iGabYahXY+t6B8v3VB6RO5gMh
         PrSrAN4M2Oih8BYnzqDl8rRXPCHuK0IiBYnOMRbOT7u0E8VRCYo0BQBKxnp2QSrsvbdo
         1GiqzseaD6h67CAcpWJ7GhZ626AZqhL+bfXR3eI9/LEiiNbF/Ki1CihlqCAcZ0Dpv49Z
         /R9daCosjhD3VWEgfvK8uElCCL24wnI5X+E/z67IVqstvSZ9Yq7kDJkGq7+reKnUOebd
         0jsAxYNXWhii2pXU9r9LQ10z+uIU4bhozIsMLALk2niyE240a4Ef5c2AIzB4+F/iR4WX
         GfKQ==
X-Gm-Message-State: AOAM530Pa/MtdIYEPiz5delxH9c7PJo4bBJ1wwlQ9G1eIqJyNnV40GnW
        Yqhd919mSCvIHykcoXdf/W2gMs7q569rlcLaNpGJHAvPZvQ=
X-Google-Smtp-Source: ABdhPJwiVlzj34OhyvcD2auRDwqxFtqF0VbI3x+HBHxv1P4A7y0TdC9bmjb1eEXPOMOwFDe6RQKcgDAbmFW6ff3/dZY=
X-Received: by 2002:ac2:41c5:: with SMTP id d5mr15393177lfi.174.1623758098195;
 Tue, 15 Jun 2021 04:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210613004356.3503995-1-palmer@dabbelt.com>
In-Reply-To: <20210613004356.3503995-1-palmer@dabbelt.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Tue, 15 Jun 2021 14:54:22 +0300
Message-ID: <CAEn-LTrcLL7EvdskX3+f_Youi0ApC8-0p6u8r8LpyATKCOKA9g@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: fu740: fix cache-controller interrupts
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     David Abdurachmanov <david.abdurachmanov@sifive.com>,
        robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        lorenzo.pieralisi@arm.com, Yash Shah <yash.shah@sifive.com>,
        devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 3:51 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From: David Abdurachmanov <david.abdurachmanov@sifive.com>
>
> The order of interrupt numbers is incorrect.
>
> The order for FU740 is: DirError, DataError, DataFail, DirFail
>
> From SiFive FU740-C000 Manual:
> 19 - L2 Cache DirError
> 20 - L2 Cache DirFail
> 21 - L2 Cache DataError
> 22 - L2 Cache DataFail
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
> Olof pointed me to
> https://raw.githubusercontent.com/sifive/meta-sifive/2021.03/recipes-kernel/linux/files/unmatched/0009-riscv-dts-fu740-fix-cache-controller-interrupts.patch
>
> This appears necessary to make the FU740 function properly, but hasn't been
> posted on the mailing lists.  Given the age I'm hoping it's just slipped
> through the cracks somewhere, but I figured I'd send it out to give David a
> chance to comment if there's a different plan.

There are a bunch of stuff that need to be cleaned up and synced with
U-Boot copy of DT for Unmatched.

This patch is required to boot.

There are others patches that do:
- Change compat string for CPUs to report U74MC instead of bullet0.
- Change memory to 16GB from 8GB.
- Change regulator values to match what's in the Rev3 board.
- Add PWM LEDs nodes.
- Add a gpio-poweroff node (this could change depending on what
OpenSBI wants to do).

And most likely the "a00" part should go away from compat strings and
filenames. "A00" was most likely a copy & paste from FU540 / Unleashed
board. Regulator block probably could also go away from DT as Linux
doesn't need to touch it, basically it just runs whatever is
configured in OTP.

I believe the current DT that landed was written for Rev1, but a few
revisions happened afterwards. You can only buy Rev3 boards.

I wonder if we should modify the existing DT file and rename it
"hifive-unmatched.dts" + new compat strings to remove "A00".

> ---
>  arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> index 8eef82e4199f..abbb960f90a0 100644
> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> @@ -273,7 +273,7 @@ ccache: cache-controller@2010000 {
>                         cache-size = <2097152>;
>                         cache-unified;
>                         interrupt-parent = <&plic0>;
> -                       interrupts = <19 20 21 22>;
> +                       interrupts = <19 21 22 20>;
>                         reg = <0x0 0x2010000 0x0 0x1000>;
>                 };
>                 gpio: gpio@10060000 {
> --
> 2.32.0.272.g935e593368-goog
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
