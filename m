Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07CD38BBC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhEUBlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:41:49 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37880 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbhEUBlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:41:44 -0400
Received: by mail-oi1-f174.google.com with SMTP id h9so18281661oih.4;
        Thu, 20 May 2021 18:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QUghhfxEpPBhTg2FPZWIXXnyK2qF8xWGXvlE71nYEfk=;
        b=mD3nT1IFiz593ukp9VzmtoWf82RVbAo4HcE6IzUPIFgypDd6kAWhEikGKL3/IAc4at
         oRgeV4R7W6tTF+aRFOOi5I9SZbLZ7qXEi6PRqOuWdj3ya3HmCxFf5sFrR+jvOVYSorXb
         5WPzAzcQ+7Ctyfv95xaz83/iiSzlJVxLNM2jwwXXvVNgkI6M5vSaoDZOVz7x4sDGMmMB
         Wn5VM+w8sWGOEtzqRxDTK4TgiylZBuTIfB8AfyLG9LV4/0pdgQgVIe423k8Phntb9INW
         HkdZT+qqi2KSaJzm6Gzk47F5CxVUWTIhT50s/0yITRuQaZLzsX3bu4HjBLN1hJSu3PM3
         gQlA==
X-Gm-Message-State: AOAM531caP+O3KF6ifIBT4Ilx8i4eDzbjP9SW+dwZHH9eBKo1uqhrSni
        1b0EZ14jgJhI63teLCYkNw==
X-Google-Smtp-Source: ABdhPJwH+KkKDT3WwGvqY7ufqlGVOEsWl2fB3WmHRzUPq3j7OEk7UKbhMDylMLO+rlhWOE6K2/QKOw==
X-Received: by 2002:aca:1819:: with SMTP id h25mr271032oih.168.1621561221154;
        Thu, 20 May 2021 18:40:21 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 7sm973941oti.30.2021.05.20.18.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:40:20 -0700 (PDT)
Received: (nullmailer pid 2461725 invoked by uid 1000);
        Fri, 21 May 2021 01:40:19 -0000
Date:   Thu, 20 May 2021 20:40:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-phy@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-usb@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v6 08/17] dt-bindings: usb: Add H616 compatible string
Message-ID: <20210521014019.GA2461696@robh.at.kernel.org>
References: <20210519104152.21119-1-andre.przywara@arm.com>
 <20210519104152.21119-9-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519104152.21119-9-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 11:41:43 +0100, Andre Przywara wrote:
> The H616 has four PHYs as the H3, along with their respective clock
> gates and resets, so the property description is identical.
> 
> However the PHYs itself need some special bits, so we need a new
> compatible string for it.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml   | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
