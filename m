Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D1341B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhCSLFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:05:37 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60786 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCSLEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:04:41 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lNCvd-00089m-Qq; Fri, 19 Mar 2021 22:04:30 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Mar 2021 22:04:29 +1100
Date:   Fri, 19 Mar 2021 22:04:29 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     wangzhou1@hisilicon.com, xuzaibo@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] crypto:hisilicon/sec - fixes some coding style
Message-ID: <20210319110429.GD8367@gondor.apana.org.au>
References: <1615620505-50018-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615620505-50018-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 03:28:22PM +0800, Longfang Liu wrote:
> 1. Fix a problems.
> 2. Fix some coding style.
> 
> Changes v3 -> v4:
>   - Fixed an unused warning on dev.
>   - Create a patch for bugfix
> 
> Changes v2 -> v3:
>   - Delete shash test error patch.
> 
> Changes v1 -> v2:
>   - Modify the way to fix shash test error.
> 
> Longfang Liu (3):
>   crypto: hisilicon/sec - fixes a printing error
>   crypto: hisilicon/sec - fixes some coding style
>   crypto: hisilicon/sec - fixes some driver coding style
> 
>  drivers/crypto/hisilicon/sec2/sec.h        |   5 +-
>  drivers/crypto/hisilicon/sec2/sec_crypto.c |  77 +++++++++--------
>  drivers/crypto/hisilicon/sec2/sec_crypto.h |   2 -
>  drivers/crypto/hisilicon/sec2/sec_main.c   | 131 +++++++++++++++++------------
>  4 files changed, 116 insertions(+), 99 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
