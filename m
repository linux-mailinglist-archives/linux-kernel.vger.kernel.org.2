Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD732CC0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 06:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhCDFbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 00:31:36 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:48236 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234127AbhCDFb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 00:31:26 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHgZA-0006UU-2S; Thu, 04 Mar 2021 16:30:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Mar 2021 16:30:27 +1100
Date:   Thu, 4 Mar 2021 16:30:27 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     davem@davemloft.net, bjorn.andersson@linaro.org,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Add support for AEAD algorithms in Qualcomm Crypto
 Engine driver
Message-ID: <20210304053027.GC25972@gondor.apana.org.au>
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225182716.1402449-1-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 01:27:09PM -0500, Thara Gopinath wrote:
> Enable support for AEAD algorithms in Qualcomm CE driver.  The first three
> patches in this series are cleanups and add a few missing pieces required
> to add support for AEAD algorithms.  Patch 4 introduces supported AEAD
> transformations on Qualcomm CE.  Patches 5 and 6 implements the h/w
> infrastructure needed to enable and run the AEAD transformations on
> Qualcomm CE.  Patch 7 adds support to queue fallback algorithms in case of
> unsupported special inputs.
> 
> This series is dependant on https://lkml.org/lkml/2021/2/11/1052.

Did this patch series pass the fuzz tests?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
