Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F013B4E16
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFZKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:41:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40461 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZKlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:11 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2H5xmCz9sfG; Sat, 26 Jun 2021 20:38:47 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20210429080708.1520360-1-arnd@kernel.org>
References: <20210429080708.1520360-1-arnd@kernel.org>
Subject: Re: [PATCH] powerpc: mark local variables around longjmp as volatile
Message-Id: <162470384692.3589875.5670173938477292479.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 10:06:38 +0200, Arnd Bergmann wrote:
> gcc-11 points out that modifying local variables next to a
> longjmp/setjmp may cause undefined behavior:
> 
> arch/powerpc/kexec/crash.c: In function 'crash_kexec_prepare_cpus.constprop':
> arch/powerpc/kexec/crash.c:108:22: error: variable 'ncpus' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbere
> d]
> arch/powerpc/kexec/crash.c:109:13: error: variable 'tries' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbere
> d]
> arch/powerpc/xmon/xmon.c: In function 'xmon_print_symbol':
> arch/powerpc/xmon/xmon.c:3625:21: error: variable 'name' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'stop_spus':
> arch/powerpc/xmon/xmon.c:4057:13: error: variable 'i' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'restart_spus':
> arch/powerpc/xmon/xmon.c:4098:13: error: variable 'i' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'dump_opal_msglog':
> arch/powerpc/xmon/xmon.c:3008:16: error: variable 'pos' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'show_pte':
> arch/powerpc/xmon/xmon.c:3207:29: error: variable 'tsk' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'show_tasks':
> arch/powerpc/xmon/xmon.c:3302:29: error: variable 'tsk' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'xmon_core':
> arch/powerpc/xmon/xmon.c:494:13: error: variable 'cmd' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c:860:21: error: variable 'bp' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c:860:21: error: variable 'bp' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c:492:48: error: argument 'fromipi' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: mark local variables around longjmp as volatile
      https://git.kernel.org/powerpc/c/a2305e3de819394a7adf68078964a92d06f9db33

cheers
