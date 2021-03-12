Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A472C338E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhCLM7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:59:52 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54334 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhCLM7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:59:38 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKhNu-0005xD-BK; Fri, 12 Mar 2021 23:59:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Mar 2021 23:59:18 +1100
Date:   Fri, 12 Mar 2021 23:59:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     wangzhou1@hisilicon.com, xuzaibo@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] crypto: hisilicon/sec - fixes some log printing
 style
Message-ID: <20210312125918.GA12149@gondor.apana.org.au>
References: <1614838735-52668-1-git-send-email-liulongfang@huawei.com>
 <1614838735-52668-2-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614838735-52668-2-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 02:18:54PM +0800, Longfang Liu wrote:
>
> @@ -727,7 +725,7 @@ static void sec_cipher_pbuf_unmap(struct sec_ctx *ctx, struct sec_req *req,
>  	struct aead_request *aead_req = req->aead_req.aead_req;
>  	struct sec_cipher_req *c_req = &req->c_req;
>  	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
> -	struct device *dev = SEC_CTX_DEV(ctx);
> +	struct device *dev = ctx->dev;
>  	int copy_size, pbuf_length;
>  	int req_id = req->req_id;
>  
> @@ -737,11 +735,9 @@ static void sec_cipher_pbuf_unmap(struct sec_ctx *ctx, struct sec_req *req,
>  		copy_size = c_req->c_len;
>  
>  	pbuf_length = sg_copy_from_buffer(dst, sg_nents(dst),
> -				qp_ctx->res[req_id].pbuf,
> -				copy_size);
> -
> +			qp_ctx->res[req_id].pbuf, copy_size);
>  	if (unlikely(pbuf_length != copy_size))
> -		dev_err(dev, "copy pbuf data to dst error!\n");
> +		dev_err(ctx->dev, "copy pbuf data to dst error!\n");
>  }

This triggers an unused warning on dev.  Please fix.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
