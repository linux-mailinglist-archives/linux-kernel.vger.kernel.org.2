Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618B5457B16
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhKTE3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:29:50 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:56896 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhKTE3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:29:49 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1moHxd-0001IN-RL; Sat, 20 Nov 2021 12:26:45 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1moHxc-0006id-Fe; Sat, 20 Nov 2021 12:26:44 +0800
Date:   Sat, 20 Nov 2021 12:26:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     sgoutham@marvell.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwrng: cavium: Check health status while reading
 random data
Message-ID: <20211120042644.GB25752@gondor.apana.org.au>
References: <1635527999-21780-1-git-send-email-sgoutham@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635527999-21780-1-git-send-email-sgoutham@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 10:49:59PM +0530, sgoutham@marvell.com wrote:
> From: Sunil Goutham <sgoutham@marvell.com>
> 
> This RNG device is present on Marvell OcteonTx2 silicons as well and
> also provides entropy health status.
> 
> HW continuously checks health condition of entropy and reports
> faults. Fault is in terms of co-processor cycles since last fault
> detected. This doesn't get cleared and only updated when new fault
> is detected. Also there are chances of detecting false positives.
> So to detect a entropy failure SW has to check if failures are
> persistent ie cycles elapsed is frequently updated by HW.
> 
> This patch adds support to detect health failures using below algo.
> 1. Consider any fault detected before 10ms as a false positive and ignore.
>    10ms is chosen randomly, no significance.
> 2. Upon first failure detection make a note of cycles elapsed and when this
>    error happened in realtime (cntvct).
> 3. Upon subsequent failure, check if this is new or a old one by comparing
>    current cycles with the ones since last failure. cycles or time since
>    last failure is calculated using cycles and time info captured at (2).
> 
> HEALTH_CHECK status register is not available to VF, hence had to map
> PF registers. Also since cycles are in terms of co-processor cycles,
> had to retrieve co-processor clock rate from RST device.
> 
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
> v1->v2:
>  - Fixed COMPILE_TEST failures
>  - Since silicon checks are done using standard ARM specific macros
>    had to remove COMPILE_TEST.
> ---
>  drivers/char/hw_random/Kconfig         |   2 +-
>  drivers/char/hw_random/cavium-rng-vf.c | 194 +++++++++++++++++++++++++++++++--
>  drivers/char/hw_random/cavium-rng.c    |  11 +-
>  3 files changed, 190 insertions(+), 17 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
