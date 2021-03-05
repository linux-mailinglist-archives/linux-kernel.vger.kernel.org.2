Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2732432F562
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCEVkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:40:46 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44098 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhCEVkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:40:45 -0500
Received: by mail-oi1-f179.google.com with SMTP id x20so4069159oie.11;
        Fri, 05 Mar 2021 13:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FrtZD0Mxkh4WDaMKcW/EnbPtCK0COhu80YMa0TPWoyA=;
        b=FgoqMBFzgHIFvfkVOwZZTgTsHpvF4OLxSJ3sRZ/OqMZWkX9R5we7lTR7o1b+yFEPI8
         Cyfdd2ncg1lK9+r8kiODTRFpDIKQ2tSl2UmQmEEJEUAKsKJQt98nzkqw57co8/JSZQMW
         eFp7YgZg+GF1DU9Z85oSKj67tmQcGjedIjFkAAtGa2uLYiv4xHwyZBIA1N6gV35eaQw6
         rwnfgOq0OQEUE8izPBjx/KR/pxmt7WJCGYaWIhwwlWFMJUwMivzp3/512QvWIn3mJhyd
         F+o6rt0cj3P0Bz6A5NS3snVqhBDcqYXl9BK/vJlQSWMDwHKjogtkvxvsD2VEipa3KtJ5
         mcpg==
X-Gm-Message-State: AOAM530eHr4eqAWraDn1MnCK7KTM9FIzL0mInVru11lskd8UPsr8SYZL
        l6UYdOzZxHwJkmJ2BO2Z3g==
X-Google-Smtp-Source: ABdhPJxVRhFgsIi1pRC4A6txSVjHyhjaQx3TFOQATWLDTcUHIF2Otv7xYVByzgR19ecgkbJMqxEqKA==
X-Received: by 2002:a05:6808:93:: with SMTP id s19mr8641466oic.115.1614980444871;
        Fri, 05 Mar 2021 13:40:44 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z14sm935904otk.30.2021.03.05.13.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:40:44 -0800 (PST)
Received: (nullmailer pid 693277 invoked by uid 1000);
        Fri, 05 Mar 2021 21:40:43 -0000
Date:   Fri, 5 Mar 2021 15:40:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        linux-amarula@amarulasolutions.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 Chipone ICN6211
Message-ID: <20210305214043.GA693229@robh.at.kernel.org>
References: <20210214175211.105107-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214175211.105107-1-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Feb 2021 23:22:10 +0530, Jagan Teki wrote:
> ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.
> 
> It has a flexible configuration of MIPI DSI signal input and
> produce RGB565, RGB666, RGB888 output format.
> 
> Add dt-bingings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - updated to new dt-bindings style
> 
>  .../display/bridge/chipone,icn6211.yaml       | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
