Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072BA32CB78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhCDEm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:42:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:47810 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233529AbhCDEmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:42:14 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHfnS-000610-45; Thu, 04 Mar 2021 15:41:11 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Mar 2021 15:41:10 +1100
Date:   Thu, 4 Mar 2021 15:41:10 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     liulongfang <liulongfang@huawei.com>
Cc:     wangzhou1@hisilicon.com, xuzaibo@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 3/3] crypto: hisilicon/sec - fixes shash test error
Message-ID: <20210304044109.GA25972@gondor.apana.org.au>
References: <1612519857-30714-1-git-send-email-liulongfang@huawei.com>
 <1612519857-30714-4-git-send-email-liulongfang@huawei.com>
 <20210205114435.GA17031@gondor.apana.org.au>
 <6e5d529d-07df-5db0-d5c0-72e90e13852d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5d529d-07df-5db0-d5c0-72e90e13852d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:51:22PM +0800, liulongfang wrote:
.
> Since patch3 is an unnecessary patch,
> can you just remove it and merge patch1 and patch2?

Please repost.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
