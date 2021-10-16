Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D964300CE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhJPHT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:19:26 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54778 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbhJPHTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:19:23 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Oct 2021 03:19:22 EDT
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4HWZ2j2GfSz1qwdY;
        Sat, 16 Oct 2021 09:07:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4HWZ2j0mb5z1qqkG;
        Sat, 16 Oct 2021 09:07:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id e3wCBQBOMcud; Sat, 16 Oct 2021 09:07:23 +0200 (CEST)
X-Auth-Info: No1qsPtfFRC9ZuIkUUM30dyIMijkYssVQQxOsW3Cr6nnbsovXVT8eKA04H+4eQ0m
Received: from tiger.home (ppp-46-244-180-223.dynamic.mnet-online.de [46.244.180.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 16 Oct 2021 09:07:23 +0200 (CEST)
Received: by tiger.home (Postfix, from userid 1000)
        id AA29C6AEEA; Sat, 16 Oct 2021 09:07:22 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, atish.patra@wdc.com, maz@kernel.org,
        tglx@linutronix.de, palmer@dabbelt.com, heiko@sntech.de,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH V4 2/3] dt-bindings: update riscv plic compatible string
References: <20211016032200.2869998-1-guoren@kernel.org>
        <20211016032200.2869998-3-guoren@kernel.org>
X-Yow:  PUNK ROCK!!  DISCO DUCK!!  BIRTH CONTROL!!
Date:   Sat, 16 Oct 2021 09:07:22 +0200
In-Reply-To: <20211016032200.2869998-3-guoren@kernel.org> (guoren@kernel.org's
        message of "Sat, 16 Oct 2021 11:21:59 +0800")
Message-ID: <87mtn9mor9.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 16 2021, guoren@kernel.org wrote:

> +  The C9xx PLIC does not comply with the interrupt claim/completion process defined
> +  by the RISC-V PLIC specification because C9xx PLIC will mask an IRQ when it is
> +  claimed by PLIC driver (i.e. readl(claim) and the IRQ will be unmasked upon
> +  completion by PLIC driver (i.e. writel(claim). This behaviour breaks the handling

Missing close paren in both parenthetical remarks above.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
