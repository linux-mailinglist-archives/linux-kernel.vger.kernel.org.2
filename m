Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9D3A3CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhFKHZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:25:25 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50558 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231350AbhFKHZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:25:24 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lrbVl-0005M7-S7; Fri, 11 Jun 2021 15:23:25 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lrbVk-0002Mp-Tq; Fri, 11 Jun 2021 15:23:24 +0800
Date:   Fri, 11 Jun 2021 15:23:24 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/4] crypto: hisilicon - supports new aeads for new
 hardware
Message-ID: <20210611072324.GF23016@gondor.apana.org.au>
References: <1622770289-21588-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622770289-21588-1-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 09:31:25AM +0800, Kai Ye wrote:
> The driver adds new aeads, add fallback tfm supporting.
> Modify the driver as needed. The crypto fuzzing test has been passed.
> 
> Kai Ye (4):
>   crypto: hisilicon/sec - add new algorithm mode for AEAD
>   crypto: hisilicon/sec - add fallback tfm supporting for aeads
>   crypto: hisilicon/sec - add hardware integrity check value process
>   crypto: hisilicon/sec - modify the SEC request structure
> 
>  drivers/crypto/hisilicon/sec2/sec.h        |  13 +-
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 575 ++++++++++++++++++++++++-----
>  drivers/crypto/hisilicon/sec2/sec_crypto.h |   9 +
>  3 files changed, 507 insertions(+), 90 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
