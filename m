Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F196A3B2973
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhFXHjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:39:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50848 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231659AbhFXHjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:39:19 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lwJv1-0006Hk-Kc; Thu, 24 Jun 2021 15:36:59 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lwJv1-0004hz-8u; Thu, 24 Jun 2021 15:36:59 +0800
Date:   Thu, 24 Jun 2021 15:36:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wenkai Lin <linwenkai6@hisilicon.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, prime.zeng@hisilicon.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH] crypto: hisilicon/qm - implement for querying hardware
 tasks status.
Message-ID: <20210624073659.GF17892@gondor.apana.org.au>
References: <1624008966-1395-1-git-send-email-linwenkai6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624008966-1395-1-git-send-email-linwenkai6@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 05:36:06PM +0800, Wenkai Lin wrote:
> This patch adds a function hisi_qm_is_q_updated to
> check if the task is ready in hardware queue when
> user polls an UACCE queue.This prevents users from
> repeatedly querying whether the accelerator has
> completed tasks, which wastes CPU resources.
> 
> Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
