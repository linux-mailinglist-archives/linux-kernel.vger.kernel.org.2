Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DF934A44C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCZJ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:29:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35320 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhCZJ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:29:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPimN-0003Rf-Jg; Fri, 26 Mar 2021 20:29:20 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:29:19 +1100
Date:   Fri, 26 Mar 2021 20:29:19 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 0/2] PSP TEE driver update and bug fixes
Message-ID: <20210326092919.GB12658@gondor.apana.org.au>
References: <cover.1615796554.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615796554.git.Rijo-john.Thomas@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:55:27PM +0530, Rijo Thomas wrote:
> The first patch helps to improve the response time by reducing the
> polling time of the tee command status variable.
> 
> Second patch is a bug fix to handle multi-threaded use-case.
> During testing, race condition was seen due to missing synchronisation
> in writes to the TEE ring buffer. This patch helps to resolve that.
> 
> v3:
>  * Fixed checkpatch.pl warning
> 
> v2:
>  * Updated copyright year as a part of code change
> 
> Rijo Thomas (2):
>   crypto: ccp - reduce tee command status polling interval from 5ms to
>     1ms
>   crypto: ccp - fix command queuing to TEE ring buffer
> 
>  drivers/crypto/ccp/tee-dev.c | 57 ++++++++++++++++++++++++------------
>  drivers/crypto/ccp/tee-dev.h | 20 +++++++++++--
>  2 files changed, 57 insertions(+), 20 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
