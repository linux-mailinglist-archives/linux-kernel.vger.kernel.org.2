Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB23242E128
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhJNS1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:27:52 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:41565 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhJNS1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:27:50 -0400
Received: by mail-oo1-f44.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso2177610ooq.8;
        Thu, 14 Oct 2021 11:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lSGLR+TPyWEX+bgb5ym/EJSPMQUo+T6pVt3I38VRg4o=;
        b=ozoOJmAMKbLP5EGpiz5crH1a4w2dheJySCB+KHdyvZr+JqvTfTd2fNQAi1wgkUQ3Ch
         BZs/sv3qbTlq+XfLsrR8orRWjww3wnMJFeAcGwSUSbbr2u/+OV9vwKsU6zFek7hajsWx
         vK+m/ATGwrlEmW0feAw0rB9xA+HGGrLJmPdp8lzDR5+JhPLJI0qROAWkiHGiRSp0Gku2
         tl3r5LxRtaSDAzVh/k6UHNl/7ei4JZnxA7gVBLgIpqUta/3K87NZDdpfD9bVWhY7hGqi
         mlmUW+npBxU7WbbFPG+UA6VvTBBI7xGEXV2+4MWzOl+T+ikCMYtWPd9gGoc7QDK5j1Mf
         WExQ==
X-Gm-Message-State: AOAM533NcMGp9u0pnufCDnu2Yf9U9wI4kN45dUaFA/1pYSIUoJ3z8SYE
        bF63zgf9bsayIqQbSe1K3w==
X-Google-Smtp-Source: ABdhPJxLbALqLdT/j1AMxSBA5iiUC9rkNODbqRwV6pXrXLNHuI+NpwW64OXR+/SyLkK9muFRv4cd3g==
X-Received: by 2002:a05:6820:514:: with SMTP id m20mr5538063ooj.66.1634235945371;
        Thu, 14 Oct 2021 11:25:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e25sm571055oot.38.2021.10.14.11.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:25:44 -0700 (PDT)
Received: (nullmailer pid 3677639 invoked by uid 1000);
        Thu, 14 Oct 2021 18:25:43 -0000
Date:   Thu, 14 Oct 2021 13:25:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kishon@ti.com, vkoul@kernel.org, linux@armlinux.org.uk,
        andrew@lunn.ch, alexandre.belloni@bootlin.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: Add binding includes for
 lan966x serdes
Message-ID: <YWh2J32hZftzIi+F@robh.at.kernel.org>
References: <20211006063523.3962427-1-horatiu.vultur@microchip.com>
 <20211006063523.3962427-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006063523.3962427-3-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:35:22AM +0200, Horatiu Vultur wrote:
> Add include bindings for lan966x serdes
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/dt-bindings/phy/lan966x_serdes.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/phy/lan966x_serdes.h
> 
> diff --git a/include/dt-bindings/phy/lan966x_serdes.h b/include/dt-bindings/phy/lan966x_serdes.h
> new file mode 100644
> index 000000000000..06e529473475
> --- /dev/null
> +++ b/include/dt-bindings/phy/lan966x_serdes.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +
> +#ifndef __LAN966X_SERDES_H__
> +#define __LAN966X_SERDES_H__
> +
> +#define CU(x)		(x)
> +#define CU_MAX		CU(2)
> +#define SERDES6G(x)	(CU_MAX + 1 + (x))
> +#define SERDES6G_MAX	SERDES6G(3)
> +#define RG(x)		(SERDES6G_MAX + 1 + (x))
> +#define RG_MAX		RG(2)
> +#define SERDES_MAX	(RG_MAX + 1)

I'm guessing these are used for the phy cells? If so, I can't figure out 
how and I shouldn't have to search the driver to figure it out.

What's CU? What's RG?
