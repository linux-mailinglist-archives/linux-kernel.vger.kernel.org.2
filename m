Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9443393DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhE1HbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:31:25 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50392 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhE1Ham (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:30:42 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWva-0003mo-U6; Fri, 28 May 2021 15:29:06 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWva-00022D-P1; Fri, 28 May 2021 15:29:06 +0800
Date:   Fri, 28 May 2021 15:29:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, liulongfang@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/qm - add MSI detection steps on
 Kunpeng930
Message-ID: <20210528072906.GQ7392@gondor.apana.org.au>
References: <1621666161-51143-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621666161-51143-1-git-send-email-qianweili@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 02:49:21PM +0800, Weili Qian wrote:
> Compared with Kunpeng920, Kunpeng930 adds MSI configuration steps to wait
> for the interrupt to be emptied. In order to be compatible with the
> kunpeng920 driver, 'set_msi' callback is added in 'hisi_qm_hw_ops' to
> configure hardware register. Call 'set_msi' to disable or enable MSI
> during reset.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 124 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 100 insertions(+), 24 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
