Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0435E25A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhDMPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:11:36 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45715 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhDMPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:11:34 -0400
Received: by mail-ot1-f41.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so11277388otf.12;
        Tue, 13 Apr 2021 08:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QMuTH1Egsr5l5TxdCmQaLccrw2mDTTRbOsaUptv9280=;
        b=ZjpAJ4wqVtpY/d+afap8dLP72aHbFOHH048VDcj73+GabRzpYa4qMHgiQoE3fOq4OA
         55TvYgex4rPApDO9Hctn5dWIb5EMwl2BC7MHAE0RB8KSSEcbncXP8mC/q+9fsqk6ttc/
         WGAYZ7/neTlCmCBL3DKJtNRy/lprR7KiJbu7t77sBICvHzeoVMnn508+I5fkF3w5xKaE
         wWtkXKXhux9Mo0hA1POT1YaqVMb3AbwAsj+kusGULdcciZOZ9D4sQT8VUHz+QXTsC/k1
         XKtUGmCZj5IAz4JAWh7tirT8X88Eqc/1cDapiR1TcWrdPksh8RJMcs94jE5M44+rR18G
         xwpw==
X-Gm-Message-State: AOAM5335v6pRGgGL7fFTlbIDnuO2urfe/rWSSy6pdJhxmJOXVhdyRuvU
        DhgO8qJcqGCfJe9K3/EdSQ==
X-Google-Smtp-Source: ABdhPJxYnT6hVjFafVkHnNnJItvm1ImlVGWV/7rtja42gcMg+SuzUUAeCBjK54tIjRLjexyCeCHD/g==
X-Received: by 2002:a9d:170a:: with SMTP id i10mr3652854ota.32.1618326674240;
        Tue, 13 Apr 2021 08:11:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o64sm2903234oif.50.2021.04.13.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:11:13 -0700 (PDT)
Received: (nullmailer pid 1688072 invoked by uid 1000);
        Tue, 13 Apr 2021 15:11:11 -0000
Date:   Tue, 13 Apr 2021 10:11:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, paul@crapouillou.net,
        devicetree@vger.kernel.org, robert.foss@linaro.org,
        dri-devel@lists.freedesktop.org, Laurent.pinchart@ideasonboard.com,
        a.hajda@samsung.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        Phong LE <ple@baylibre.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: display: bridge: add it66121 bindings
Message-ID: <20210413151111.GA1688027@robh.at.kernel.org>
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
 <20210412154648.3719153-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412154648.3719153-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 17:46:46 +0200, Neil Armstrong wrote:
> From: Phong LE <ple@baylibre.com>
> 
> Add the ITE bridge HDMI it66121 bindings.
> 
> Signed-off-by: Phong LE <ple@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/display/bridge/ite,it66121.yaml  | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
