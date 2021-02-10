Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CFB315FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhBJHXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:23:37 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50240 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232341AbhBJHXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:23:30 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jpj-0001FV-19; Wed, 10 Feb 2021 18:22:44 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:22:42 +1100
Date:   Wed, 10 Feb 2021 18:22:42 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     daniele.alessandrelli@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ecdh_helper - Ensure 'len >= secret.len' in
 decode_key()
Message-ID: <20210210072242.GF4493@gondor.apana.org.au>
References: <20210203112837.203732-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203112837.203732-1-daniele.alessandrelli@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 11:28:37AM +0000, Daniele Alessandrelli wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> The length ('len' parameter) passed to crypto_ecdh_decode_key() is never
> checked against the length encoded in the passed buffer ('buf'
> parameter). This could lead to an out-of-bounds access when the passed
> length is less than the encoded length.
> 
> Add a check to prevent that.
> 
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  crypto/ecdh_helper.c | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
