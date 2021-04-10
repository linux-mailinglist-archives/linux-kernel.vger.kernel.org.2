Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79635AE51
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhDJO3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhDJO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:29:49 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C88C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:29:34 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FHcp31Dnzz9sWT; Sun, 11 Apr 2021 00:29:31 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <e43d133bf52fa19e577f64f3a3a38cedc570377d.1617616601.git.christophe.leroy@csgroup.eu>
References: <e43d133bf52fa19e577f64f3a3a38cedc570377d.1617616601.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Remove powerpc specific definition of 'ptrdiff_t'
Message-Id: <161806493833.1467223.5146603896377356295.b4-ty@ellerman.id.au>
Date:   Sun, 11 Apr 2021 00:28:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2021 09:57:27 +0000 (UTC), Christophe Leroy wrote:
> For unknown reason, old commit d27dfd388715 ("Import pre2.0.8")
> changed 'ptrdiff_t' from 'int' to 'long'.
> 
> GCC expects it as 'int' really, and this leads to the following
> warning when building KFENCE:
> 
>   CC      mm/kfence/report.o
> In file included from ./include/linux/printk.h:7,
>                  from ./include/linux/kernel.h:16,
>                  from mm/kfence/report.c:10:
> mm/kfence/report.c: In function 'kfence_report_error':
> ./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument of type 'ptrdiff_t', but argument 6 has type 'long int' [-Wformat=]
>     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
>       |                  ^~~~~~
> ./include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
>    11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
>       |                  ^~~~~~~~
> ./include/linux/printk.h:343:9: note: in expansion of macro 'KERN_ERR'
>   343 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~~~
> mm/kfence/report.c:213:3: note: in expansion of macro 'pr_err'
>   213 |   pr_err("Out-of-bounds %s at 0x%p (%luB %s of kfence-#%td):\n",
>       |   ^~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Remove powerpc specific definition of 'ptrdiff_t'
      https://git.kernel.org/powerpc/c/c46bbf5d2defae50d61ddf31502017ee8952af83

cheers
