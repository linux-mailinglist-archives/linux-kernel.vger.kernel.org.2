Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD52243FD34
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhJ2NOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:14:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56398 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhJ2NOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:14:22 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mgRfe-0002oU-JE; Fri, 29 Oct 2021 21:11:46 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mgRfc-0003Dd-PV; Fri, 29 Oct 2021 21:11:44 +0800
Date:   Fri, 29 Oct 2021 21:11:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp - Make use of the helper macro kthread_run()
Message-ID: <20211029131144.GD12278@gondor.apana.org.au>
References: <20211021083854.1865-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021083854.1865-1-caihuoqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:38:54PM +0800, Cai Huoqing wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/crypto/ccp/ccp-dev-v3.c | 5 ++---
>  drivers/crypto/ccp/ccp-dev-v5.c | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
