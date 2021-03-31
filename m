Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE034A48F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCZJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:35:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35558 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhCZJem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:34:42 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPirS-0003ci-Qv; Fri, 26 Mar 2021 20:34:35 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:34:34 +1100
Date:   Fri, 26 Mar 2021 20:34:34 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, corbet@lwn.net, rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: amcc: fix incorrect kernel-doc comment syntax in
 files
Message-ID: <20210326093434.GQ12658@gondor.apana.org.au>
References: <20210321120832.12837-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321120832.12837-1-yashsri421@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 05:38:32PM +0530, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in drivers/crypto/amcc, which follow this syntax,
> but the content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc.
> 
> E.g., presence of kernel-doc like comment in
> drivers/crypto/amcc/crypto4xx_alg.c at header, and some other lines,
> causes these warnings by kernel-doc:
> 
> "warning: expecting prototype for AMCC SoC PPC4xx Crypto Driver(). Prototype was for set_dynamic_sa_command_0() instead"
> "warning: Function parameter or member 'dir' not described in 'set_dynamic_sa_command_0'"
> etc..
> 
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  drivers/crypto/amcc/crypto4xx_alg.c     | 12 ++++++------
>  drivers/crypto/amcc/crypto4xx_core.c    | 18 +++++++++---------
>  drivers/crypto/amcc/crypto4xx_core.h    |  4 ++--
>  drivers/crypto/amcc/crypto4xx_reg_def.h |  8 ++++----
>  drivers/crypto/amcc/crypto4xx_sa.h      | 18 +++++++++---------
>  drivers/crypto/amcc/crypto4xx_trng.h    |  2 +-
>  6 files changed, 31 insertions(+), 31 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
