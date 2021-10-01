Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FCC41E80F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352347AbhJAHNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352057AbhJAHNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E51660551;
        Fri,  1 Oct 2021 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633072309;
        bh=Dk//hmxp9Ghg4gE573FRig1vcCvDqI1nQn4FlLIiFbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUWh1K7x5bY3xzjS/0A2kmVydSHY149JySt6VscptraAh4vDUYX0lFmT5a/A5yzCU
         jrUZKFhZe1+UjIuS7eh2B1627bgisJMcHgmkOmLb7FQIGLdnTJdIjErmsgT2TlAENo
         Ougdm9W//e0qWEaJiMVAQOcja0d/ch4rp5qg2bPDbLtB3M+wAAr8pj9uX86unK7og7
         u6R9Njh6LbD0N28fKiLe1cyuD7MWgKIO7Nlk/zUBh9eFgkQ67l/G7c2twD1KQf8fDR
         E6lqCRhqWwm9JpxUsG2LIJA9r5uxNcWvK4b2gRJtATObNJc79VUkuwoPN90YX0V1FC
         iNuyH0bHTVXBA==
Date:   Fri, 1 Oct 2021 12:41:42 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] clk/actions/owl-factor.c: remove superfluous
 headers
Message-ID: <20211001071142.GA5821@thinkpad>
References: <20210929065824.23691-1-liumh1@shanghaitech.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929065824.23691-1-liumh1@shanghaitech.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 02:58:24PM +0800, Mianhan Liu wrote:
> owl-factor.c hasn't use any macro or function declared in linux/slab.h.
> Thus, these files can be removed from owl-factor.c safely without
> affecting the compilation of the ./drivers/clk module
> 
> Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani
> 
> ---
>  drivers/clk/actions/owl-factor.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/actions/owl-factor.c b/drivers/clk/actions/owl-factor.c
> index f15e2621f..64f316cf7 100644
> --- a/drivers/clk/actions/owl-factor.c
> +++ b/drivers/clk/actions/owl-factor.c
> @@ -10,7 +10,6 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
> -#include <linux/slab.h>
>  
>  #include "owl-factor.h"
>  
> -- 
> 2.25.1
> 
> 
