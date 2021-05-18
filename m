Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9E386F32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbhERBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:31:47 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37762 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345774AbhERBbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:31:46 -0400
Received: by mail-ot1-f44.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so7273095otp.4;
        Mon, 17 May 2021 18:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cx3l6CvtI1ll9g0cgBO35Hn+lFtc7ivvIdqy0JP6JeY=;
        b=TSRMbv27RauBFjmi6DfO4ZIZsqgNS6abKsVReybMGR7kQweOyyKLOpVKcQfuCUuK+m
         mnrdMynH4FCmTW0bRddX2JjGJvLwDN68r3d7IMEKZYQCL2G/NI1A8mkR3T5QUEq/q+W3
         YefDPp6wovANvcfhd2jRDd/PCcUNj4SnfGCrP12JnqLN2AFlMSaZA7NsRYKVhKnppLBK
         fgNjtkawyRSwZ46I0O/3TFrdTPGV4164bOnmWBi0liAB72lLvRWwoVecWnXvRyn+9p7+
         2+zftrv00iqi7ZTNxzS3+M+sC+JkjrKRTC/Rwd+Jb7Sq1xpNWtjinq9c7Be3Jg3KCZVU
         h4XA==
X-Gm-Message-State: AOAM530WX9vsYCOGVJVhxR6aKrfcLzDVdtxRlBSjTJDD9SpggWZixsLX
        xarKIb7Pc9TpySUZehoyFw==
X-Google-Smtp-Source: ABdhPJz+nVjAvJnRO8Ny+80dCbU0wUxAMhuDRrN2qVHjeOr12VQUCQiSxYhYjuHfxBCdZKrOPDW5RQ==
X-Received: by 2002:a05:6830:1e70:: with SMTP id m16mr2082679otr.340.1621301427967;
        Mon, 17 May 2021 18:30:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u14sm3132305oif.41.2021.05.17.18.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:30:27 -0700 (PDT)
Received: (nullmailer pid 3605184 invoked by uid 1000);
        Tue, 18 May 2021 01:30:26 -0000
Date:   Mon, 17 May 2021 20:30:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: usb: dwc2: add compatible for RK3308
 USB controller
Message-ID: <20210518013026.GA3605144@robh.at.kernel.org>
References: <20210514150044.2099298-1-t.schramm@manjaro.org>
 <20210514150044.2099298-4-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514150044.2099298-4-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 17:00:42 +0200, Tobias Schramm wrote:
> The USB controller in the RK3308 is compatible with the RK3066 USB
> controller.
> This patch adds a compatible string for it.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
