Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F20393DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhE1H0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:26:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50184 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232012AbhE1H0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:26:43 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWrc-0003Xj-7f; Fri, 28 May 2021 15:25:00 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWrR-0001wE-7i; Fri, 28 May 2021 15:24:49 +0800
Date:   Fri, 28 May 2021 15:24:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     mpm@selenic.com, zhouyanjie@wanyeetech.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        juergh@canonical.com
Subject: Re: [PATCH] hwrng: Remove leading spaces in Kconfig
Message-ID: <20210528072449.GB7392@gondor.apana.org.au>
References: <20210517095831.81631-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517095831.81631-1-juergh@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:58:31AM +0200, Juerg Haefliger wrote:
> Remove leading spaces before tabs in Kconfig file(s) by running the
> following command:
> 
>   $ find drivers/char/hw_random -name 'Kconfig*' | x\
>     args sed -r -i 's/^[ ]+\t/\t/'
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>  drivers/char/hw_random/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
