Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66DC40F053
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbhIQDUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:20:51 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55246 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243846AbhIQDUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:20:41 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mR4PH-0006A2-A1; Fri, 17 Sep 2021 11:19:19 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mR4PG-0001k9-OP; Fri, 17 Sep 2021 11:19:18 +0800
Date:   Fri, 17 Sep 2021 11:19:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/2] crypto: hisilicon/qm - Support the userspace task
 resetting
Message-ID: <20210917031918.GD6559@gondor.apana.org.au>
References: <1630121979-53760-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630121979-53760-1-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 11:39:37AM +0800, Kai Ye wrote:
> Fix the uacce mmap failure because allocated an extra page. Set the
> qp error flags to support the userspace task resetting.
> 
> Kai Ye (2):
>   crypto: hisilicon/qm - fix the uacce mmap failed
>   crypto: hisilicon/qm - support the userspace task resetting
> 
>  drivers/crypto/hisilicon/qm.c | 50 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
