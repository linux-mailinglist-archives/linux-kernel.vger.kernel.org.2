Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE834F5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhCaBKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60085 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhCaBKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XJ1RzQz9sWT; Wed, 31 Mar 2021 12:10:08 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Chen Huang <chenhuang5@huawei.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
In-Reply-To: <20210327094900.938555-1-chenhuang5@huawei.com>
References: <20210327094900.938555-1-chenhuang5@huawei.com>
Subject: Re: [PATCH] powerpc: Fix HAVE_HARDLOCKUP_DETECTOR_ARCH build configuration
Message-Id: <161715298133.226945.2164349156598477834.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Mar 2021 09:49:00 +0000, Chen Huang wrote:
> When compiling the powerpc with the SMP disabled, it shows the issue:
> 
> arch/powerpc/kernel/watchdog.c: In function ‘watchdog_smp_panic’:
> arch/powerpc/kernel/watchdog.c:177:4: error: implicit declaration of function ‘smp_send_nmi_ipi’; did you mean ‘smp_send_stop’? [-Werror=implicit-function-declaration]
>   177 |    smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
>       |    ^~~~~~~~~~~~~~~~
>       |    smp_send_stop
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:273: arch/powerpc/kernel/watchdog.o] Error 1
> make[1]: *** [scripts/Makefile.build:534: arch/powerpc/kernel] Error 2
> make: *** [Makefile:1980: arch/powerpc] Error 2
> make: *** Waiting for unfinished jobs....
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Fix HAVE_HARDLOCKUP_DETECTOR_ARCH build configuration
      https://git.kernel.org/powerpc/c/4fe529449d85e78972fa327999961ecc83a0b6db

cheers
