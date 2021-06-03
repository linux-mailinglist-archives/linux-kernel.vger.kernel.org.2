Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375F239A0F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFCMct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:32:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60920 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFCMcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:32:48 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lomV5-00023c-0V; Thu, 03 Jun 2021 20:31:03 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lomV4-0001fG-RB; Thu, 03 Jun 2021 20:31:02 +0800
Date:   Thu, 3 Jun 2021 20:31:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 0/2] crypto: hisilicon - add new type of sqe for
 Kunpeng930
Message-ID: <20210603123102.GG6161@gondor.apana.org.au>
References: <1622197574-7779-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622197574-7779-1-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 06:26:12PM +0800, Kai Ye wrote:
> Add new type of sqe for Kunpeng930, and modify the driver as needed.
> 
> chages v1->v2:
> 	fix two sparse warnings.
> 
> Kai Ye (2):
>   crypto: hisilicon/sec - add new type of SQE
>   crypto: hisilicon/sec - driver adapt to new SQE
> 
>  drivers/crypto/hisilicon/sec2/sec.h        |   6 +-
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 291 ++++++++++++++++++++++++-----
>  drivers/crypto/hisilicon/sec2/sec_crypto.h | 181 ++++++++++++++++++
>  3 files changed, 434 insertions(+), 44 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
