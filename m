Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65F343772E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJVMiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:38:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56242 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhJVMix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:38:53 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mdtmj-00031C-Dl; Fri, 22 Oct 2021 20:36:33 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mdtmX-0001oa-5L; Fri, 22 Oct 2021 20:36:21 +0800
Date:   Fri, 22 Oct 2021 20:36:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Matt Mackall <mpm@selenic.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hw_random: replace snprintf in show functions with
 sysfs_emit
Message-ID: <20211022123621.GB6920@gondor.apana.org.au>
References: <1634095561-4030-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634095561-4030-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 08:26:01PM -0700, Qing Wang wrote:
> coccicheck complains about the use of snprintf() in sysfs show functions.
> 
> Fix the following coccicheck warning:
> drivers/char/hw_random/s390-trng.c:114:8-16: WARNING: use scnprintf or sprintf.
> drivers/char/hw_random/s390-trng.c:122:8-16: WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/char/hw_random/s390-trng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
