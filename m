Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0830534A264
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhCZHOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:14:35 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33644 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhCZHOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:14:32 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPgfZ-00010m-Dg; Fri, 26 Mar 2021 18:14:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 18:14:09 +1100
Date:   Fri, 26 Mar 2021 18:14:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     zuoqilin1@163.com
Cc:     smueller@chronox.de, marcelo.cerri@canonical.com,
        tianjia.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] include/linux: Fix typo issue
Message-ID: <20210326071409.GA14594@gondor.apana.org.au>
References: <20210316034213.780-1-zuoqilin1@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316034213.780-1-zuoqilin1@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 11:42:13AM +0800, zuoqilin1@163.com wrote:
> From: zuoqilin <zuoqilin@yulong.com>
> 
> Change 'bufer' to 'buffer'.
> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>
> ---
>  include/linux/mpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please resend to linux-crypto.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
