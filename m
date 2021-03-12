Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2515C338E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhCLNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:13:52 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54538 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231835AbhCLNNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:13:43 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKhbg-0006IM-NK; Sat, 13 Mar 2021 00:13:33 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Mar 2021 00:13:32 +1100
Date:   Sat, 13 Mar 2021 00:13:32 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     clabbe.montjoie@gmail.com, davem@davemloft.net, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@siol.net, mchehab+huawei@kernel.org,
        corbet@lwn.net, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: allwinner: sun8i-ce: fix error return code in
 sun8i_ce_prng_generate()
Message-ID: <20210312131332.GI31502@gondor.apana.org.au>
References: <20210305015717.2908-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305015717.2908-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 05:57:17PM -0800, Jia-Ju Bai wrote:
> When dma_mapping_error() returns an error, no error return code of 
> sun8i_ce_prng_generate() is assigned.
> To fix this bug, err is assigned with -EFAULT as error return code.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
