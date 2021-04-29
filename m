Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBD36EBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbhD2ODl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbhD2ODi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18DC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:02:51 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJS0xg5z9t19; Fri, 30 Apr 2021 00:02:47 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210421210647.20836-1-rdunlap@infradead.org>
References: <20210421210647.20836-1-rdunlap@infradead.org>
Subject: Re: [PATCH v3] powerpc: make ALTIVEC select PPC_FPU
Message-Id: <161970488205.4033873.9121048311980600896.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 14:06:47 -0700, Randy Dunlap wrote:
> On a kernel config with ALTIVEC=y and PPC_FPU not set/enabled,
> there are build errors:
> 
> drivers/cpufreq/pmac32-cpufreq.c:262:2: error: implicit declaration of function 'enable_kernel_fp' [-Werror,-Wimplicit-function-declaration]
>            enable_kernel_fp();
> ../arch/powerpc/lib/sstep.c: In function 'do_vec_load':
> ../arch/powerpc/lib/sstep.c:637:3: error: implicit declaration of function 'put_vr' [-Werror=implicit-function-declaration]
>   637 |   put_vr(rn, &u.v);
>       |   ^~~~~~
> ../arch/powerpc/lib/sstep.c: In function 'do_vec_store':
> ../arch/powerpc/lib/sstep.c:660:3: error: implicit declaration of function 'get_vr'; did you mean 'get_oc'? [-Werror=implicit-function-declaration]
>   660 |   get_vr(rn, &u.v);
>       |   ^~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: make ALTIVEC select PPC_FPU
      https://git.kernel.org/powerpc/c/389586333c0229a4fbc5c1a7f89148d141293682

cheers
