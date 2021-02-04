Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE530EC27
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 06:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhBDFmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 00:42:16 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51580 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhBDFmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 00:42:15 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7XOO-00022g-Af; Thu, 04 Feb 2021 16:41:25 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Feb 2021 16:41:24 +1100
Date:   Thu, 4 Feb 2021 16:41:24 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Saulo Alessandre <saulo.alessandre@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     ardb@kernel.org, daniele.alessandrelli@linux.intel.com,
        davem@davemloft.net, elena.reshetova@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgross@linux.intel.com, prabhjot.khurana@intel.com,
        wangzhou1@hisilicon.com, xuzaibo@huawei.com, yumeng18@huawei.com
Subject: Re: [PATCH v7 4/7] crypto: add ecc curve and expose them
Message-ID: <20210204054124.GB7229@gondor.apana.org.au>
References: <20210128050354.GA30874@gondor.apana.org.au>
 <20210203180344.2418055-1-saulo.alessandre@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203180344.2418055-1-saulo.alessandre@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:03:44PM -0300, Saulo Alessandre wrote:
>
> In this patch I'm using akcipher allocate like ecdsa(sha1,sha256,...), 
> because the ecdsa algo is generic, and using the curve name and ndigits
> inside vli_mmod_fast to discover the curve, but I agree the correct way
> would be allocate ecdsa-nist-p521(sha1,...) and have all params for the
> curve inside strut ecc_curve, remembering that we have anothers curves 
> incoming, like Edwards.

I'm not sure whether we really should encode hash into the algorithm
name.  This may be something that we can move into setkey instead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
