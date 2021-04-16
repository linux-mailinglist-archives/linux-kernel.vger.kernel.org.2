Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BC4361ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbhDPLdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:33:37 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53140 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239096AbhDPLdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:33:36 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMib-0003Wk-O3; Fri, 16 Apr 2021 21:33:02 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:33:01 +1000
Date:   Fri, 16 Apr 2021 21:33:01 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] crypto: hisilicon/hpre - add debug log
Message-ID: <20210416113301.GN16633@gondor.apana.org.au>
References: <1618048021-50335-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618048021-50335-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 05:46:58PM +0800, Hui Tang wrote:
> This patchset adds the debug log and cleanup code style.
> 
> Hui Tang (3):
>   crypto: hisilicon/hpre - delete the rudundant space after return
>   crypto: hisilicon/hpre - use the correct variable type
>   crypto: hisilicon/hpre - add debug log
> 
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 11 +++++++++--
>  drivers/crypto/hisilicon/hpre/hpre_main.c   |  4 ++--
>  2 files changed, 11 insertions(+), 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
