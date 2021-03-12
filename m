Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD20338E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhCLNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:12:13 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54472 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhCLNMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:12:01 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKhZv-0006EJ-Se; Sat, 13 Mar 2021 00:11:45 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Mar 2021 00:11:43 +1100
Date:   Sat, 13 Mar 2021 00:11:43 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     zuoqilin1@163.com
Cc:     tianjia.zhang@linux.alibaba.com, marcelo.cerri@canonical.com,
        smueller@chronox.de, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] include/linux: Fix typo issue
Message-ID: <20210312131143.GD31502@gondor.apana.org.au>
References: <20210302113433.2165-1-zuoqilin1@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302113433.2165-1-zuoqilin1@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 07:34:33PM +0800, zuoqilin1@163.com wrote:
> From: zuoqilin <zuoqilin@yulong.com>
> 
> Change 'bufer' to 'buffer'.
> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>
> ---
>  include/linux/mpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please resend to linux-crypto@vger.kernel.org.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
