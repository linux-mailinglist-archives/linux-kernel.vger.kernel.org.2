Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8043A4A19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFKU0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFKU0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:26:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F81FC061574;
        Fri, 11 Jun 2021 13:24:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k25so6293561eja.9;
        Fri, 11 Jun 2021 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+dQpQl+uCaHWxj358F0QEZFc7ikOW5DB/iODbuCA6Bo=;
        b=MOUo8P7M9qdEIG8LWpwG8oLhvsWO07zAGYwJ8BdYnmZ9pjT0vrIIM/ihQbyHWpVkBK
         i+vgTfrewH5QgNISDGetGS6E0ygfJrYnfnYeR+NHynZDTu6h96fRVoc9ovey2UKcHL7l
         QYAKB3ui4M8fPSv287ODj2K3kuYIVmH/9IV3vAoCuDhGM09j2UxevJx7Onfrdd+45dpd
         fGt4rGNrMwu2powuZ+XQxbmOHZYQVNB9RKouMTTJCZKdHzc2DUkKx66fVLkWJJEZQVoO
         3eF/fzMJC+O2j0spwrZ0S25mS5cmapTPqgNRNnzItarcnJfe78DQGz7i0EzwN2rOWukH
         Gu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+dQpQl+uCaHWxj358F0QEZFc7ikOW5DB/iODbuCA6Bo=;
        b=ZLThxkyUpg3sdnMfikjaALM/YmXXBfcvrtYNXGLqEjIKIgxprVhEfU2Ux66yUFruge
         8e6aGsK0/Fhg6MhQkEKyHltxmmmXatkMTzVeY8Knz87tF9YHcPyIT818tQcDC6yu+ivh
         JBfAH3szKqKQfXrlOW18YUclDY7kJsG6JpptSSGrXodj2x6hBI4s7aPPoGm8GKsLGQkp
         yqzwkYKjuA5ZRtScMGw6IpfBSV+EzWcGkhEBi3Hau2WXMpXignoVjdJfk4/FkohcgPCs
         DfdIvKlBwsskMYcaQjHGmDIDCCe5gNtAknBFx02Pgjd267f1ZLwoQE8J+m33+LIz9+LU
         GFKg==
X-Gm-Message-State: AOAM530avNUZ7jhoFpEDdRFW2nj5COPJmeMiZ5t56GgtsU7OLS9t2QOI
        yelDZPDCt8UsjKJlwDAbwMA=
X-Google-Smtp-Source: ABdhPJwn0zaoJnSvp7caqYDvwC27ySoMhITMCdGC7cD6Vb9O61GJvtDJHbVtst6yea7wXmuT39FPXw==
X-Received: by 2002:a17:906:5049:: with SMTP id e9mr5160780ejk.30.1623443077111;
        Fri, 11 Jun 2021 13:24:37 -0700 (PDT)
Received: from skbuf ([188.26.52.84])
        by smtp.gmail.com with ESMTPSA id b24sm2951033edw.4.2021.06.11.13.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:24:35 -0700 (PDT)
Date:   Fri, 11 Jun 2021 23:24:34 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] ARM: dts: NSP: Add Meraki MX64/MX65 to Makefile
Message-ID: <20210611202434.flnqrzbbxicw5c3t@skbuf>
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
 <20210610232727.1383117-3-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610232727.1383117-3-mnhagan88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:27:14AM +0100, Matthew Hagan wrote:
> Add Makefile entries for the Meraki MX64/MX65 series devices.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f8f09c5066e7..033d9604db60 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -154,6 +154,12 @@ dtb-$(CONFIG_ARCH_BCM_NSP) += \
>  	bcm958525xmc.dtb \
>  	bcm958622hr.dtb \
>  	bcm958623hr.dtb \
> +	bcm958625-meraki-mx64.dtb \
> +	bcm958625-meraki-mx64-a0.dtb \
> +	bcm958625-meraki-mx64w.dtb \
> +	bcm958625-meraki-mx64w-a0.dtb \
> +	bcm958625-meraki-mx65.dtb \
> +	bcm958625-meraki-mx65w.dtb \
>  	bcm958625hr.dtb \
>  	bcm988312hr.dtb \
>  	bcm958625k.dtb
> -- 
> 2.26.3
> 

It is odd to add the device trees to the Makefile in a separate patch
compared to their actual introduction. Does the tree even compile at
this stage?
