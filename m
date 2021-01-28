Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317773075B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhA1MPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:15:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34692 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA1MOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:14:31 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611836029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1rfB/IZ4d07bQ4kaZK+SNMWZnaf6ZtvArs5ezTl/PSc=;
        b=vJsf/NU9N6V1aNC54ZJA0dRiWDFy20a0Z9N6u/dxzqmbirOA6xS7gRUYKg67d+wTWLMlww
        7TDyz/jzYQ94WMc/DtX/JGjJZTgXkxEjpYhwd9SE+9xbnxHWC4S59UgBE2wUQgiMzEcLgE
        AIB5ZSsParAfxPgZQB58/040YYli9AXxh7IiCr0FuivsfgVNTVA677TDFKhBYxXKnz1zHm
        XWz46jpyiMGmyKctZQnfEBpIFlrGyFu67khdqV1NDyid6BZU9+Y1kUFKFINUZlGsTu9KxF
        yqCczWoSTxSC/KAt+G238rlxcm8miEu89ywYn0UDJSeYrjagKIlRkf4nM6gvTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611836029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1rfB/IZ4d07bQ4kaZK+SNMWZnaf6ZtvArs5ezTl/PSc=;
        b=YVxBRhQUGQCQALNBhxM/OEiYwbSUV3fnFR7i+H+r7iw1F3RotZd5mFqr+p2dFC1CX3mkF7
        CpxQYZspOXFTdcBA==
To:     kernel test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/core 10/10] sclp_early_core.c:undefined reference to `warn_bogus_irq_restore'
In-Reply-To: <202101281628.n32qBmXh-lkp@intel.com>
References: <202101281628.n32qBmXh-lkp@intel.com>
Date:   Thu, 28 Jan 2021 13:13:49 +0100
Message-ID: <871re5dzsy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28 2021 at 16:29, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> head:   997acaf6b4b59c6a9c259740312a69ea549cc684
> commit: 997acaf6b4b59c6a9c259740312a69ea549cc684 [10/10] lockdep: report broken irq restoration
> config: s390-randconfig-r035-20210128 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 48bdd676a1d1338c10541460bf5beb69ac17e451)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=997acaf6b4b59c6a9c259740312a69ea549cc684
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip locking/core
>         git checkout 997acaf6b4b59c6a9c259740312a69ea549cc684
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    s390x-linux-gnu-ld: arch/s390/boot/sclp_early_core.o: in function `sclp_early_cmd':
>>> sclp_early_core.c:(.text+0x18c): undefined reference to `warn_bogus_irq_restore'
>    s390x-linux-gnu-ld: arch/s390/boot/sclp_early_core.o: in function `sclp_early_set_event_mask':
>    sclp_early_core.c:(.text+0x376): undefined reference to `warn_bogus_irq_restore'
>    s390x-linux-gnu-ld: arch/s390/boot/sclp_early_core.o: in function `__sclp_early_printk':
>    sclp_early_core.c:(.text+0xa90): undefined reference to `warn_bogus_irq_restore'
>>> s390x-linux-gnu-ld: sclp_early_core.c:(.text+0xa9a): undefined reference to `warn_bogus_irq_restore'

That's S390 early boot code which lacks a stub function ....
