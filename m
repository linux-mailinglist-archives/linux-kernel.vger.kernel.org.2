Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8328541E752
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 07:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352134AbhJAF7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 01:59:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55754 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhJAF7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 01:59:31 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mWBYI-0006Ag-FJ; Fri, 01 Oct 2021 13:57:46 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mWBYH-0007bI-6I; Fri, 01 Oct 2021 13:57:45 +0800
Date:   Fri, 1 Oct 2021 13:57:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 2/6] crypto: hisilicon/sec - add ahash alg features
 for Kunpeng920
Message-ID: <20211001055745.GA31918@gondor.apana.org.au>
References: <20210924092716.12848-1-yekai13@huawei.com>
 <20210924092716.12848-3-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924092716.12848-3-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 05:27:12PM +0800, Kai Ye wrote:
>
> +static int sec_ahash_import(struct ahash_request *req, const void *in)
> +{
> +	/*
> +	 * Import partial state of the transformation. This function loads the
> +	 * entire state of the ongoing transformation from a provided block of
> +	 * data so the transformation can continue from this point onward.
> +	 */
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct sec_req *sreq = ahash_request_ctx(req);
> +	struct sec_ctx *ctx = crypto_ahash_ctx(tfm);
> +	const struct sec_ahash_req *state = in;
> +
> +	sreq->ctx = ctx;
> +	memcpy(&sreq->hash_req, state, sizeof(struct sec_ahash_req));
> +
> +	return 0;
> +}

It's still not clear how this function actually works.

Could you please explain how can this work in the following scenario?

	x = export_state

	reboot_machine

	import_state(x)

How do you restore all the internal state so that further data
can be hashed onto the existing hash state after a reboot?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
