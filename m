Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC938C1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhEUIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:24:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56108 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhEUIYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:24:44 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lk0RE-00054m-DH; Fri, 21 May 2021 16:23:20 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lk0RE-0007XN-9c; Fri, 21 May 2021 16:23:20 +0800
Date:   Fri, 21 May 2021 16:23:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, liulongfang@huawei.com
Subject: Re: [PATCH 0/4] crypto: hisilicon/qm - modify reset process
Message-ID: <20210521082320.mjjcsce4i2zkasl5@gondor.apana.org.au>
References: <1621075480-52869-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621075480-52869-1-git-send-email-qianweili@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 06:44:36PM +0800, Weili Qian wrote:
> This series of patches modify the process of error initialization and
> recovery and enable the master ooo to be closed when nfe occurs to avoid
> error spread.
> 
> Weili Qian (4):
>   crypto: hisilicon/qm - initialize the device before doing tasks
>   crypto: hisilicon/qm - modify 'QM_RESETTING' clearing error
>   crypto: hisilicon/qm - adjust order of device error configuration
>   crypto: hisilicon/qm - enable to close master ooo when NFE occurs
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c |  42 ++++++---
>  drivers/crypto/hisilicon/qm.c             | 136 +++++++++++++++++++-----------
>  drivers/crypto/hisilicon/sec2/sec_main.c  |  48 ++++++-----
>  drivers/crypto/hisilicon/zip/zip_main.c   |  38 ++++++---
>  4 files changed, 169 insertions(+), 95 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
