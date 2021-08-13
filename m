Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00803EAFFB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbhHMGZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbhHMGZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:25:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F60C061756;
        Thu, 12 Aug 2021 23:24:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d1so10573637pll.1;
        Thu, 12 Aug 2021 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQOgsa59p3OqAoKwO2wbmemr8LIvk6W1Ex9qIpv1D+8=;
        b=XSCXFQhSWV7wnRv57pbuYofo7JuIdaxxRNPHMw/xEfbe6NmKM6ykVQdgYUBklVGXPt
         rKfSyNKxoD29KTu5xqVebvxgmj+HQIl2JkmioID0fJg/LzUNPvhIXG3Vcop3nFkuj14I
         FGY3Kbp96asKLB5ByhIos71CS14z4hsdaJ4VUTenxmYD3kvEgp+NFBhyD62R7+MDP5Eh
         kc5BpCXKg5uoxoPF87mD53VtYGw/nk/dtYu/9aS09wyJh1wWFYwDpv7WObJGyxYfjYb0
         KFQc89cK+uSTT0QzyBh73WoCtc5MWPanA8P+1T2arRjN6gIb0+zsOloGRsV6Wg9K8jFx
         9OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQOgsa59p3OqAoKwO2wbmemr8LIvk6W1Ex9qIpv1D+8=;
        b=rTjTvWSf5LIJaZO7iagcq2yeFcuKM6616hK4ylrxSMbo4ZeVfFIXV9WMEOVfa0QY+y
         j3Pxa//YBAs1ux5P0lKbsJ67MMv98aQZ+Z8QxInWnGMBiLkmD8Bbx5TxdWZw5uemFg2R
         slGwa4ZZv0D3vD4V8nr5Hi0kvkTSEYiKr2bvvW6jF+C+5rdagKBPE4QK8qbOoTlLUBzt
         6A4fh8zuez6XtEOu7zjfiaR1omhOmV9/HCETpgOKTLrvHNSzzdRgBuksp8GiyeNSnmeb
         75lIRbxakO1TfQoKi/BZA8PEedaKo2hdCJjP0QyFXD+u4NyW8YUwEBddvvIpBwlahCWv
         9BVA==
X-Gm-Message-State: AOAM53201VFcw57E6fpWf5bK4mFzRwE9l0UGlgSLTW88v/cVL3wwfV2e
        4Kr9K2Z7zUJwlZr1F1L5/Iw=
X-Google-Smtp-Source: ABdhPJxsJUWbeaU62Wj9coO/fud1cjIRqM6Z84ZOc4FvCf3W9tPAlNR+vMa1GvVoUW+NjYXNOmbNdA==
X-Received: by 2002:a05:6a00:aca:b029:392:9c79:3a39 with SMTP id c10-20020a056a000acab02903929c793a39mr931084pfl.57.1628835882167;
        Thu, 12 Aug 2021 23:24:42 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-92-48-112.hsd1.ca.comcast.net. [73.92.48.112])
        by smtp.gmail.com with ESMTPSA id b7sm790956pfl.195.2021.08.12.23.24.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Aug 2021 23:24:42 -0700 (PDT)
Date:   Thu, 12 Aug 2021 23:24:35 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH] ARM: dts: aspeed: minipack: Update flash partition table
Message-ID: <20210813062435.GA24497@taoren-ubuntu-R90MNF91>
References: <20210720002704.7390-1-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720002704.7390-1-rentao.bupt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

Looks like the patch is not included in "dt-for-v5.15". Any comments? Or
should I send v2 if the email was not delivered?


Cheers,

Tao

On Mon, Jul 19, 2021 at 05:27:04PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Update firmware flash "data0" partition size from 4MB to 8MB for larger
> persistent storage on minipack BMC.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
> index 9eb23e874f19..230d16cd9967 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
> @@ -265,19 +265,19 @@
>  		};
>  
>  		/*
> -		 * FIT image: 59.5 MB.
> +		 * FIT image: 55.5 MB.
>  		 */
>  		fit@80000 {
> -			reg = <0x80000 0x3b80000>;
> +			reg = <0x80000 0x3780000>;
>  			label = "fit";
>  		};
>  
>  		/*
> -		 * "data0" partition (4MB) is reserved for persistent
> +		 * "data0" partition (8MB) is reserved for persistent
>  		 * data store.
>  		 */
>  		data0@3800000 {
> -			reg = <0x3c00000 0x400000>;
> +			reg = <0x3800000 0x800000>;
>  			label = "data0";
>  		};
>  
> -- 
> 2.17.1
> 
