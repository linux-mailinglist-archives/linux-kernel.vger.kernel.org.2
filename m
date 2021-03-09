Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D36332D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCIRQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhCIRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:16:17 -0500
X-Greylist: delayed 57509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Mar 2021 09:16:17 PST
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D02C06174A;
        Tue,  9 Mar 2021 09:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=yZ/aNKIfBBiurPsOI51o3dQGeWvqW69W+SaIV+4rEMc=; b=oLhHgQzujRwECvMkXmDXZCh0y/
        PTz9x4yPrbDrpOwiJca2APXL5UJWYFdCBfxM1cXY5wlWhEsSnZ6/MbjKjS7l12NZtjnAgmABfzQy7
        mu0g1kO2Ye0wp01GwME7CxM5FOXqz+LhV0uI2tCGqhv2nOGxQQDuUla+/+sXx58nkrTZDZVlMWKwW
        JrEY9f57VsfVYm7SJ7pOAp/FlOBEeI3OA4n2+hcWal2zOgEeG0wnjGA3o2Er4VHmgqebWDX3Bao8M
        1g3KlOw9HRtZ/kTV5xVz2AF4b/R7ExN5+QURrZCNKZlwrG/cCGTgHQzvgZzGKBMEoVceaf+Z0iynV
        GxsPbbWQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJfxu-000h5F-CA; Tue, 09 Mar 2021 17:16:14 +0000
Subject: Re: [PATCH] docs: dt: submitting-patches: Fix grammar in subsystem
 section
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210309130650.2318419-1-geert+renesas@glider.be>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <77c82f6c-033e-9757-0b88-4e2e5f5626a2@infradead.org>
Date:   Tue, 9 Mar 2021 09:16:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210309130650.2318419-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 5:06 AM, Geert Uytterhoeven wrote:
> Reword the subsystem bindings section to make sense, from a grammatical
> point of view.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> index 68129ff09967d5d7..1d11c25249ff5465 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -75,8 +75,8 @@ II. For kernel maintainers
>       binding, and it hasn't received an Acked-by from the devicetree
>       maintainers after a few weeks, go ahead and take it.
>  
> -     Subsystem bindings (anything affecting more than a single device)
> -     then getting a devicetree maintainer to review it is required.
> +     For subsystem bindings (anything affecting more than a single device),
> +     getting a devicetree maintainer to review it is required.
>  
>    3) For a series going though multiple trees, the binding patch should be
>       kept with the driver using the binding.
> 


-- 
~Randy

