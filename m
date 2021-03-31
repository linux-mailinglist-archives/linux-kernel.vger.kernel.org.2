Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CAB34F5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhCaBKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:30 -0400
Received: from ozlabs.org ([203.11.71.1]:52817 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhCaBKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XJ5Y7Cz9sWd; Wed, 31 Mar 2021 12:10:08 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
In-Reply-To: <4b8f8335-0a29-93fc-7943-b4dc16efb908@huawei.com>
References: <20210327094900.938555-1-chenhuang5@huawei.com> <dd6b25d3-006b-be1e-9c4f-89e66aefb519@csgroup.eu> <e8eddfd4-ca07-f2ba-42de-19e636dc2ce9@huawei.com> <4b8f8335-0a29-93fc-7943-b4dc16efb908@huawei.com>
Subject: Re: [PATCH v2] powerpc: Fix HAVE_HARDLOCKUP_DETECTOR_ARCH build configuration
Message-Id: <161715298165.226945.12702425269351759002.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 10:27:00 +0800, Chen Huang wrote:
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
