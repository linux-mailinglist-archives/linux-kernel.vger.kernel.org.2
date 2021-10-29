Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC19D43FC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhJ2Mdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:33:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56388 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhJ2Mdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:33:49 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mgR2Q-0001j9-GE; Fri, 29 Oct 2021 20:31:14 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mgR2B-0001EN-RN; Fri, 29 Oct 2021 20:30:59 +0800
Date:   Fri, 29 Oct 2021 20:30:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Meng Li <Meng.Li@windriver.com>
Cc:     horia.geanta@nxp.com, pankaj.gupta@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: crypto: caam: instead this_cpu_ptr with
 raw_cpu_ptr
Message-ID: <20211029123059.GA4648@gondor.apana.org.au>
References: <20211019063719.18251-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019063719.18251-1-Meng.Li@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:37:19PM +0800, Meng Li wrote:
> When enable the kernel debug config, there is below calltrace detected:
> BUG: using smp_processor_id() in preemptible [00000000] code: cryptomgr_test/339
> caller is debug_smp_processor_id+0x20/0x30
> CPU: 9 PID: 339 Comm: cryptomgr_test Not tainted 5.10.63-yocto-standard #1
> Hardware name: NXP Layerscape LX2160ARDB (DT)
> Call trace:
>  dump_backtrace+0x0/0x1a0
>  show_stack+0x24/0x30
>  dump_stack+0xf0/0x13c
>  check_preemption_disabled+0x100/0x110
>  debug_smp_processor_id+0x20/0x30
>  dpaa2_caam_enqueue+0x10c/0x25c
>  ......
>  cryptomgr_test+0x38/0x60
>  kthread+0x158/0x164
>  ret_from_fork+0x10/0x38
> According to the comment in commit ac5d15b4519f("crypto: caam/qi2
>  - use affine DPIOs "), it doesn't matter whether preemption is
> disable or not. So, only instead this_cpu_ptr with raw_cpu_ptr to
> avoid above call trace.

Please put the reason why raw is safe into a comment in the code.
Readers shouldn't need to run git whatschanged to figure out why
this is safe.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
