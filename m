Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ECD31F080
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhBRTxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhBRTZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:25:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C12164E2F;
        Thu, 18 Feb 2021 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613676306;
        bh=zTgIYlyFaDJGycAett61ACFbsNZyANa5pHJS8Y3xQDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxXcMD6Wg3j5UI9wGwDU9FR2+01yr/5Ai+kpVSL+AJ22vI7CyWMfS5PkvvKHKMbG2
         LvmfEPhSSQ7gPeGhjWYQsMeNiBVm5X+6JG6d0gK6TjbucfWSSC9kgjk6NMOM65QGsZ
         /OgVUsGSxMy4+ZKJSJ3U6Cdp7ayZbnkot/6ksWkYQJRQRtO8K2dcZGGtg9q+gibars
         8+Yg4rPQ7n7ZUzM+MiyPTh01GkueVEBr5Q2keoAHQuiqO8IXzWhd/0J8NALs3GHlVB
         faSiI3d95wb9DigwxDw7wa5d+HOb0NXjsxMEI8UZycysjBheHik6BU05OBWSeRnbRg
         +P6FmbgfjcQAQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F205E40CD9; Thu, 18 Feb 2021 16:25:03 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:25:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Jianlin Lv <Jianlin.Lv@arm.com>, will@kernel.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, guoren@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, iecedge@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5] perf tools: Fix arm64 build error with gcc-11
Message-ID: <YC6/D1KwxnkEPObJ@kernel.org>
References: <20210218031245.2078492-1-Jianlin.Lv@arm.com>
 <bd474bfa-2bdb-53ea-5142-3a6570d63b7f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd474bfa-2bdb-53ea-5142-3a6570d63b7f@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 18, 2021 at 09:26:17AM +0000, John Garry escreveu:
> On 18/02/2021 03:12, Jianlin Lv wrote:
> > gcc version: 11.0.0 20210208 (experimental) (GCC)
> > 
> > Following build error on arm64:
> > 
> > .......
> > In function ‘printf’,
> >      inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
> >      inlined from ‘regs__printf’ at util/session.c:1169:2:
> > /usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
> >    error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]
> > 
> > 107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
> >                  __va_arg_pack ());
> > 
> > ......
> > In function ‘fprintf’,
> >    inlined from ‘perf_sample__fprintf_regs.isra’ at \
> >      builtin-script.c:622:14:
> > /usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
> >      error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
> >    100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
> >    101 |                         __va_arg_pack ());
> > 
> > cc1: all warnings being treated as errors
> > .......
> > 
> > This patch fixes Wformat-overflow warnings. Add helper function to
> > convert NULL to "unknown".
> > 
> > Signed-off-by: Jianlin Lv<Jianlin.Lv@arm.com>
> 
> thanks
> Reviewed-by: John Garry <john.garry@huawei.com>


Thanks, applied.

- Arnaldo

