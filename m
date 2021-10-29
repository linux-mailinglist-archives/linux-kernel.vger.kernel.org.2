Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93B843FD38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhJ2NOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:14:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56402 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhJ2NOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:14:48 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mgRgA-0002tb-S9; Fri, 29 Oct 2021 21:12:18 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mgRg9-0003EK-U4; Fri, 29 Oct 2021 21:12:17 +0800
Date:   Fri, 29 Oct 2021 21:12:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lei He <helei.sig11@bytedance.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenweipi@bytedance.com
Subject: Re: [PATCH] crypto testmgr: fix wrong key length
Message-ID: <20211029131217.GF12278@gondor.apana.org.au>
References: <20211022124443.61507-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022124443.61507-1-helei.sig11@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 08:44:43PM +0800, Lei He wrote:
> Fix wrong test data at testmgr.h, it seems to be caused
> by ignoring the last '\0' when calling sizeof.
> 
> Signed-off-by: Lei He <helei.sig11@bytedance.com>
> ---
>  crypto/testmgr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
