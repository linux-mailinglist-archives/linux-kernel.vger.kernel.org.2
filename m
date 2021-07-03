Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ACA3BA6A4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhGCBhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 21:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGCBhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 21:37:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCBEC061762;
        Fri,  2 Jul 2021 18:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=c8syrHSiy+jYFMMRLiqjgG0DYYtlgGkjJ9xbA0JIXh0=; b=oQFwLlaZZqkSunLSNePMCDWJPr
        vt+/PflLmC2Ay9aIQ931EiHNy5kXJqdeKgSAsXLtMeYWLzGnfo7rYAYJBAb/tZFbCga85aXayDvgP
        VjmvM4E2IShl947a28FtCrCSbDlly1KC0gRTZl0IYq6gnXKoWUUGuZV3NcQyTv+Tiu9LQTSeJRph5
        OrkTCbnXsg/a2vDDcoeSYedftbPTwi81HYEUyRSyigs3g62XfeJQlfIi/23SP44YpVhgz41ATctJm
        pOPgsGZGI73YfSoigDLtPucub+b9WkHk1YB3BK/3uVs3qdEJZqlsSyTO0B7rednLqoyUd4rnpR64H
        VxDC4cow==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzUY8-004Nts-Du; Sat, 03 Jul 2021 01:34:28 +0000
Subject: Re: [PATCH] LICENSES/dual/CC-BY-4.0: Lets switch to utf-8
To:     Nishanth Menon <nm@ti.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Rahul T R <r-ravikumar@ti.com>
References: <20210703012931.30604-1-nm@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b2b1ad6b-92cc-6a90-fcd7-e93183f83ea4@infradead.org>
Date:   Fri, 2 Jul 2021 18:34:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210703012931.30604-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/21 6:29 PM, Nishanth Menon wrote:
> Lets drop the unicode characters that peeped in and replace with
> equivalent utf-8 characters. This makes the CC-BY-4.0 file inline with
> rest of license files.
> 
> This messes up code such as scripts/spdxcheck.py which assumed utf-8
> LICENSE files.
> 
> Fixes: bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")
> 
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Christoph Hellwig <hch@lst.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> 
> Reported-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> also see: https://lore.kernel.org/linux-spdx/20210703012128.27946-1-nm@ti.com/T/#u
> 
>  LICENSES/dual/CC-BY-4.0 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/LICENSES/dual/CC-BY-4.0 b/LICENSES/dual/CC-BY-4.0
> index 45a81b8e4669..869cad3d1643 100644
> --- a/LICENSES/dual/CC-BY-4.0
> +++ b/LICENSES/dual/CC-BY-4.0
> @@ -392,7 +392,7 @@ Section 8 -- Interpretation.
>  Creative Commons is not a party to its public
>  licenses. Notwithstanding, Creative Commons may elect to apply one of
>  its public licenses to material it publishes and in those instances
> -will be considered the “Licensor.” The text of the Creative Commons
> +will be considered the "Licensor." The text of the Creative Commons
>  public licenses is dedicated to the public domain under the CC0 Public
>  Domain Dedication. Except for the limited purpose of indicating that
>  material is shared under a Creative Commons public license or as
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

