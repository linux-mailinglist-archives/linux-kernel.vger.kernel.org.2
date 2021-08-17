Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7C3EF504
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 23:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhHQVc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 17:32:29 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41642 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhHQVc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:32:28 -0400
Received: by mail-oi1-f176.google.com with SMTP id be20so1239567oib.8;
        Tue, 17 Aug 2021 14:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kt2Fk44GF+8/cRJD0+ngwDqElp7+xnXStRJ3VhNJcN8=;
        b=NS6wyr5aLe5sONlq4TAV1ZCiu4XSbYIQvAJQ0DA+7n3K7KBa2iEoa4bt/6rnOpyzkr
         DAK71I0FW+A2HilvXtTJ8v8bAS3gQvu2SLeor7Ou52L+HErzow6eF5+nbwaDmWFLPeuT
         v0wzFXhJRszOCgqNQoPkMbl4myMXRSXITgphDHQLSV4RH80XAoBdLJLs5V8IzPyQBtQe
         ALBgcemWXTTtroh61Fkqz+WztoxXG3dRZVdj1J7KGP+SmfeIQT1ZpucZoUSVtolZgIb/
         BvyiyRTzdbVfKoMQp0ZrYaB8fKTgtJdinlsWLe2anzslnwfv5AKEuC0hPNjScjiIb9xh
         SYtw==
X-Gm-Message-State: AOAM532OYz4FTKnZ76agvZ+7i3P5dgoRz5AJUWFF3yBHPn83TE2fLuyQ
        isI2t/2k4xDOAX5nmsYVIw==
X-Google-Smtp-Source: ABdhPJyY88kwSF6xqTb7bptyaFXmhl8XLJolHuRR2HVS2XGv120oK5kfJ2J1hPSymvlFnYjSS7HwQg==
X-Received: by 2002:aca:ac13:: with SMTP id v19mr4280919oie.93.1629235914630;
        Tue, 17 Aug 2021 14:31:54 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z7sm625148oti.65.2021.08.17.14.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:31:54 -0700 (PDT)
Received: (nullmailer pid 877188 invoked by uid 1000);
        Tue, 17 Aug 2021 21:31:53 -0000
Date:   Tue, 17 Aug 2021 16:31:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: soc: rockchip: add rk3568-usb2phy-grf
Message-ID: <YRwqyZEF6FRpkdHQ@robh.at.kernel.org>
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
 <20210812204116.2303617-2-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812204116.2303617-2-pgwipeout@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 16:41:09 -0400, Peter Geis wrote:
> Add the documentation for the rk3568-usb2phy-grf node, which is separate
> from the usb2phy node on this chip.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
