Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65C139EBFB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhFHC2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhFHC2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:28:43 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6914C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 19:26:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FzYyw4vchz9sRK;
        Tue,  8 Jun 2021 12:26:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623119209;
        bh=1ZMCtGsRYb+WTlaPJy8Xif1EF1dRkTA6KPQq2Az4Xm0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JjYtuWG8uPyxyAso3igoDZ43oYu5ua+FqU6qrpMCjU0Dt0AZfOoLd7StCE7rNLPEf
         nZUomKPfvnoBsoCX+4wY+vqeQk64ug23pkSXC2EeZltWptR6FcnqltP72Bspg8KmG0
         2jTIKYQ7J1PXlm4CPTFhOWQeFKF0Ls/zIuMCEPUvq5oFEqi3C0iWQLibVZf8B2+Cvs
         v0MKQ27Rcxw3skIfW/vzawV4tJ3bQr0I2UJFyX0+YO+JQrUvHzKoJeuGaGZL+z7cmR
         V6vsUdM2Rr6oJGYuFAOHz2sdme4qesbZuqrI9zs2okMFN7bzs97GDOxKzagwpI2185
         l9QNnExi2iSmw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] powerpc: Fix duplicate included _clear.h
In-Reply-To: <1623061512-31651-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1623061512-31651-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Date:   Tue, 08 Jun 2021 12:26:43 +1000
Message-ID: <874ke9f5wc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:
> Clean up the following includecheck warning:
>
> ./arch/powerpc/perf/req-gen/perf.h: _clear.h is included more than once.

That's by design.

See the error reported by the kbuild robot.

> No functional change.

Not true.

cheers

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/powerpc/perf/req-gen/perf.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/req-gen/perf.h b/arch/powerpc/perf/req-gen/perf.h
> index fa9bc80..59fa588 100644
> --- a/arch/powerpc/perf/req-gen/perf.h
> +++ b/arch/powerpc/perf/req-gen/perf.h
> @@ -51,7 +51,6 @@ enum CAT2(NAME_LOWER, _requests) {
>   *	r_fields
>   * };
>   */
> -#include "_clear.h"
>  #define STRUCT_NAME__(name_lower, r_name) name_lower ## _ ## r_name
>  #define STRUCT_NAME_(name_lower, r_name) STRUCT_NAME__(name_lower, r_name)
>  #define STRUCT_NAME(r_name) STRUCT_NAME_(NAME_LOWER, r_name)
> -- 
> 1.8.3.1
