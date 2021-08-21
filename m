Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B856F3F396A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhHUHvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 03:51:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53814 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233018AbhHUHvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 03:51:06 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mHLlq-0006GV-DF; Sat, 21 Aug 2021 15:50:26 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mHLlq-0000v3-9b; Sat, 21 Aug 2021 15:50:26 +0800
Date:   Sat, 21 Aug 2021 15:50:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, wangzhou1@hisilicon.com,
        liulongfang@huawei.com
Subject: Re: [PATCH v2 0/5] crypto: hisilicon - support runtime PM for
 accelerator devices
Message-ID: <20210821075026.GF3392@gondor.apana.org.au>
References: <1628848209-26398-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628848209-26398-1-git-send-email-qianweili@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 05:50:04PM +0800, Weili Qian wrote:
> Kunpeng930 accelerator devices support runtime power management, this
> patchset enables runtime PM for accelerator devices.
> 
> ---
> v1->v2: fix warning
> ---
> 
> Weili Qian (5):
>   crypto: hisilicon - using 'debugfs_create_file' instead of
>     'debugfs_create_regset32'
>   crypto: hisilicon - add runtime PM ops
>   crypto: hisilicon - support runtime PM for accelerator device
>   crypto: hisilicon - change parameter passing of debugfs function
>   crypto: hisilicon - check _PS0 and _PR0 method
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c |  60 ++++-
>  drivers/crypto/hisilicon/qm.c             | 430 +++++++++++++++++++++++++-----
>  drivers/crypto/hisilicon/qm.h             |   8 +
>  drivers/crypto/hisilicon/sec2/sec_main.c  |  58 +++-
>  drivers/crypto/hisilicon/zip/zip_main.c   |  57 +++-
>  5 files changed, 521 insertions(+), 92 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
