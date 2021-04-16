Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53759361EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbhDPLcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:32:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53110 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240007AbhDPLcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:32:39 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMho-0003UJ-3K; Fri, 16 Apr 2021 21:32:13 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:32:12 +1000
Date:   Fri, 16 Apr 2021 21:32:12 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] bug fix and clear coding style
Message-ID: <20210416113211.GK16633@gondor.apana.org.au>
References: <1617959044-11023-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617959044-11023-1-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 05:03:59PM +0800, Kai Ye wrote:
> Fixup coding style such as delete unneeded variable
> initialization. Add a comment for block size initialization.
> Add a data cleared operation in sg buf unmap, and other misc fix.
> 
> v1 -> v2:
>  1. fix [PATCH v2] error in v1.
>  2. v1 use a macro replace of magic number, v2 use a comment 
>     for block size initialization.
> v2 -> v3:
>  fix a sparse warning
> 
> Kai Ye (5):
>   crypto: hisilicon/sgl - add a comment for block size initialization
>   crypto: hisilicon/sgl - delete unneeded variable initialization
>   crypto: hisilicon/sgl - add some dfx logs
>   crypto: hisilicon/sgl - fix the soft sg map to hardware sg
>   crypto: hisilicon/sgl - fix the sg buf unmap
> 
>  drivers/crypto/hisilicon/sgl.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
