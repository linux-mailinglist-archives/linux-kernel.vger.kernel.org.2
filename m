Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60F731F0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhBRUGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:06:55 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37764 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231320AbhBRUCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:02:38 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lCpUH-0004Y7-OH; Fri, 19 Feb 2021 07:01:22 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Feb 2021 07:01:21 +1100
Date:   Fri, 19 Feb 2021 07:01:21 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     yumeng <yumeng18@huawei.com>
Cc:     davem@davemloft.net, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, tudor.ambarus@microchip.com,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/9] crypto: hisilicon/hpre - add 'ECDH' algorithm
Message-ID: <20210218200121.GA932@gondor.apana.org.au>
References: <1612777137-51067-1-git-send-email-yumeng18@huawei.com>
 <1612777137-51067-8-git-send-email-yumeng18@huawei.com>
 <20210210045756.GB7510@gondor.apana.org.au>
 <a92a1b89-75f2-e275-9a84-004072aadf66@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a92a1b89-75f2-e275-9a84-004072aadf66@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:24:40AM +0800, yumeng wrote:
>
> Ecdh-nist-p384 is supported by HPRE now, currently there is no patch of
> the generic ecdh-nist-p384.

In that case please leave it out until there is:

1) An in-kernel user of p384.
2) There is a generic implementation.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
