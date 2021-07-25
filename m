Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726FC3D4E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 16:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhGYNoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 09:44:22 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46217 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhGYNoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 09:44:18 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GXlgT4TlKz1sByw;
        Sun, 25 Jul 2021 16:24:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GXlgT36ssz1rmXy;
        Sun, 25 Jul 2021 16:24:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id c2MbuW-tLki4; Sun, 25 Jul 2021 16:24:36 +0200 (CEST)
X-Auth-Info: S2GRYpvJ6Ix5RcLIMInDsuaROFJPacPETA21g+GmTBpMaYzcOEO82V4CzZyl1ltH
Received: from igel.home (ppp-46-244-170-80.dynamic.mnet-online.de [46.244.170.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 25 Jul 2021 16:24:36 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C05D52C2617; Sun, 25 Jul 2021 16:24:35 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@uclinux.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Fix asm register constraints for atomic ops
References: <20210725104618.365790-1-geert@linux-m68k.org>
X-Yow:  Look!  A ladder!  Maybe it leads to heaven, or a sandwich!
Date:   Sun, 25 Jul 2021 16:24:35 +0200
In-Reply-To: <20210725104618.365790-1-geert@linux-m68k.org> (Geert
        Uytterhoeven's message of "Sun, 25 Jul 2021 12:46:18 +0200")
Message-ID: <87r1fm4gkc.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25 2021, Geert Uytterhoeven wrote:

> Depending on register assignment by the compiler:
>
>     {standard input}:3084: Error: operands mismatch -- statement `andl %a1,%d1' ignored
>     {standard input}:3145: Error: operands mismatch -- statement `orl %a1,%d1' ignored
>     {standard input}:3195: Error: operands mismatch -- statement `eorl %a1,%d1' ignored
>
> Indeed, the first operand must not be an address register.  Fix this by
> adjusting the register constraint from "g" (general purpose register) to
> "d" (data register).

You should also allow immediate ("i").

There is the ASM_DI macro for that, but since CONFIG_RMW_INSNS is never
defined for CONFIG_COLDFIRE, it probably doesn't matter.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
