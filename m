Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5D138C0F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhEUHse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:48:34 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55802 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhEUHsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:48:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1ljzs9-0004N0-Am; Fri, 21 May 2021 15:47:05 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ljzs9-0005pM-7x; Fri, 21 May 2021 15:47:05 +0800
Date:   Fri, 21 May 2021 15:47:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     wangzhou1@hisilicon.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] crypto: hisilicon - switch to memdup_user_nul()
Message-ID: <20210521074705.7neeycmydjqb6va4@gondor.apana.org.au>
References: <1620804439-21392-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620804439-21392-1-git-send-email-zou_wei@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 03:27:19PM +0800, Zou Wei wrote:
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index ce439a0..83a5d30 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -1570,17 +1570,10 @@ static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
>  	if (count > QM_DBG_WRITE_LEN)
>  		return -ENOSPC;
>  
> -	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
> -	if (!cmd_buf)
> +	cmd_buf = memdup_user_nul(buffer, count);
> +	if (IS_ERR(cmd_buf))
>  		return -ENOMEM;

You should return the actual error and not ENOMEM.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
