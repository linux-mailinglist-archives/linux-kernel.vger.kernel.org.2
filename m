Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EE0432792
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhJRTaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:30:39 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44736 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhJRTah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:30:37 -0400
Received: by mail-oi1-f179.google.com with SMTP id y207so1208043oia.11;
        Mon, 18 Oct 2021 12:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0YJTgYqkI0d37F5afRzmNLlaPdJh1d4TAnzCXiblq0=;
        b=5rClcNl84ulXxdCHw3smwee0SIdQ9GnX7MCqL2p/9nKP0sbDyZZlWwafi0GFG0qWsF
         IXRUhFo7DpilMUj55qqQREmVakD/5vTLsaMb+gbkT0o/QXjG/u4DRiWVTvPMKpm99yi8
         ZKd1LcHVNVhbtw3RUUT7ERyrlDj6hwyparWHTLDjnx78BQYFU3d7VaH+OE156brClGt7
         W7vUS0fcxSmLv2dddX90pTYQPf5XuIi6DS9xlkLEjTov5tCxTW11+BZiIHrh28KQ6HJM
         /AtnCta2AqWYFuJu82Jc5e/wJ9e0UxJraC1anzcjf6Z5ArjcMx3sLEwp+WnrMAyCygj8
         +0jg==
X-Gm-Message-State: AOAM531GMQVOWK5lyGgnoWHc1xdqUEhXdm7fYuz23bLs0J+d1fHtWA78
        DedYvQCWQdlWq/Qy27f2BQ==
X-Google-Smtp-Source: ABdhPJxQC0Ll46fRBQVLIW3++nUDa/GFT9GC0+aR+CgO0yRDgNhs3+oQs0oc0WQaswcFQ9Pr0Q7IRw==
X-Received: by 2002:aca:f302:: with SMTP id r2mr656586oih.90.1634585305918;
        Mon, 18 Oct 2021 12:28:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x8sm3143146ota.75.2021.10.18.12.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:28:25 -0700 (PDT)
Received: (nullmailer pid 2803420 invoked by uid 1000);
        Mon, 18 Oct 2021 19:28:24 -0000
Date:   Mon, 18 Oct 2021 14:28:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kishon@ti.com, vkoul@kernel.org, andrew@lunn.ch,
        alexandre.belloni@bootlin.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: Add constants for lan966x serdes
Message-ID: <YW3K2GX+hmkwt3EE@robh.at.kernel.org>
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
 <20211015123920.176782-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015123920.176782-3-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 02:39:19PM +0200, Horatiu Vultur wrote:
> Lan966x has: 2 integrated PHYs, 3 SerDes and 2 RGMII interfaces. Which
> requires to be muxed based on the HW representation.
> 
> So add constants for each interface to be able to distinguish them.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/dt-bindings/phy/phy-lan966x-serdes.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-lan966x-serdes.h
> 
> diff --git a/include/dt-bindings/phy/phy-lan966x-serdes.h b/include/dt-bindings/phy/phy-lan966x-serdes.h
> new file mode 100644
> index 000000000000..8a05f93ecf41
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-lan966x-serdes.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +
> +#ifndef __PHY_LAN966X_SERDES_H__
> +#define __PHY_LAN966X_SERDES_H__
> +
> +#define PHY(x)		(x)
> +#define PHY_MAX		PHY(2)
> +#define SERDES6G(x)	(PHY_MAX + 1 + (x))
> +#define SERDES6G_MAX	SERDES6G(3)
> +#define RGMII(x)	(SERDES6G_MAX + 1 + (x))
> +#define RGMII_MAX	RGMII(2)
> +#define SERDES_MAX	(RGMII_MAX + 1)

I still don't understand. #phy-cells description says we have:

<port idx> <serdes idx>

But here it's 3 numbers. How are these defines used to fill in the 2 
cells?

Rob
