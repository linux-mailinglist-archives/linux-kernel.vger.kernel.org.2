Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C032F32FD67
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 22:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCFVSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 16:18:05 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45557 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 16:17:40 -0500
Received: by mail-pg1-f171.google.com with SMTP id p21so3790338pgl.12;
        Sat, 06 Mar 2021 13:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IWHmhpA5Zif3jh65FB3tGXdQJMd1ekxEEqmbz03yaN8=;
        b=gcsSKKsaeYXV3Dkb7X9eHHj0p+yR40+zJ6jToA6DdN+rcZAaB6I/LJmftAzMLz4Bgh
         GBQ3vQyVJAP3Ipfo/yo5chpFWR+zJv5xveJcrrsJupOaDeCo9Yohdrw/VoSGMRuXk8MP
         7xwxcEubvAZ97n3m1RMAW8tnz+R0LzdR09r40w6Cql2/TeJYtLASYeC6iVCo+w7Xcz1o
         7BKt2fwLlGyHuByqaiXaR3mtcFQdDINEsmpksCykoFmVI9PkXqQNc2p3Ca6D5qmeyR14
         fhbhL6CCMwFO6RgKJfc7k2mPu3nV9yaHDrZXbEpzyeDizF5uW+ASAYNdMhvosUvEswdH
         ATgg==
X-Gm-Message-State: AOAM531scKDywBBJbd+GhuL3RW/JdtmY1Fe/3UqTAkSXRE7syo8tsWa2
        /+wH3zjRsbqpJDTjrZi/VA==
X-Google-Smtp-Source: ABdhPJywDi/r2KgcjPXrkjgG6vYPU1S7xfMTuKGVlHqtBL08Xj7le4J0IijdMaIFVwJO3A/0AjkrrQ==
X-Received: by 2002:a63:4808:: with SMTP id v8mr14093452pga.381.1615065457517;
        Sat, 06 Mar 2021 13:17:37 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id o62sm5696367pga.43.2021.03.06.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 13:17:36 -0800 (PST)
Received: (nullmailer pid 1227466 invoked by uid 1000);
        Sat, 06 Mar 2021 21:17:31 -0000
Date:   Sat, 6 Mar 2021 14:17:31 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     jonas.gorski@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mips: bmips: add BCM63268 timer reset definitions
Message-ID: <20210306211731.GA1217377@robh.at.kernel.org>
References: <20210225194201.17001-1-noltari@gmail.com>
 <20210225194201.17001-3-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210225194201.17001-3-noltari@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 08:41:59PM +0100, Álvaro Fernández Rojas wrote:
> Add missing timer reset definitions for BCM63268.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  include/dt-bindings/reset/bcm63268-reset.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-bindings/reset/bcm63268-reset.h
> index 6a6403a4c2d5..d87a7882782a 100644
> --- a/include/dt-bindings/reset/bcm63268-reset.h
> +++ b/include/dt-bindings/reset/bcm63268-reset.h
> @@ -23,4 +23,8 @@
>  #define BCM63268_RST_PCIE_HARD	17
>  #define BCM63268_RST_GPHY	18
>  
> +#define BCM63268_TRST_SW	29
> +#define BCM63268_TRST_HW	30
> +#define BCM63268_TRST_POR	31

Numbering should be local to the provider, so shouldn't this be 0-2? 
Unless these numbers correspond to something in the h/w (bit positions 
for example).

> +
>  #endif /* __DT_BINDINGS_RESET_BCM63268_H */
> -- 
> 2.20.1
> 
