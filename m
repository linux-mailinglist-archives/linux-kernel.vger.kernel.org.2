Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337F843D2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbhJ0Uj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:39:57 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39796 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbhJ0Ujz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:39:55 -0400
Received: by mail-ot1-f48.google.com with SMTP id x16-20020a9d7050000000b00553d5d169f7so3706075otj.6;
        Wed, 27 Oct 2021 13:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q0zXxFUMfRsheSwFSYSrrmgSHaEKLYEnkxd1RYCn5mw=;
        b=7remUe5b3Dn3ly3GeQQEQC7H0FBefiQ2zZSm05DFthJ1ncokzSNVSf9VAgxR4y373R
         AyoYsYM7dDi98lUbqnLdyXFiiNSfakkiJBnrg5R7BvEIbk227VXEfklGh8bywXHKtLmY
         14as4GQ4Nr3iu/Ct9uv776zTc+3ltPGaNkJmua38SIAFwPvHkCQaBJga5H1PSDYERi/n
         Vzdzb70ouU7EnVGpx8q5OjX/3UtyMqKPK2CE9I20nQzA/KCvexQ8msLmHyXsY0MbR2pM
         +vc3JVv5OruMsAhkZzgYSyO1cAYm9iQSxo2KKIQComYAg9Z/psKiAFGzItJV/BXm8lkY
         95gw==
X-Gm-Message-State: AOAM533aZFvQJisek5oVb33De7J5+gx5l1iUtL/xmMb4V2T3897Qrw+M
        hGwyhRjGBJSS4LMeqiDDtw==
X-Google-Smtp-Source: ABdhPJzQKEVp4TsU7aIgvYDowq66KQMA/JA+sv/s/4xd1KiQE+X5YObrygEVxYRU1R/ZQtrhms0G8w==
X-Received: by 2002:a9d:6f15:: with SMTP id n21mr9700otq.278.1635367049370;
        Wed, 27 Oct 2021 13:37:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bd39sm466444oib.2.2021.10.27.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:37:28 -0700 (PDT)
Received: (nullmailer pid 2111038 invoked by uid 1000);
        Wed, 27 Oct 2021 20:37:28 -0000
Date:   Wed, 27 Oct 2021 15:37:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kishon@ti.com, andrew@lunn.ch, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: Add constants for lan966x serdes
Message-ID: <YXm4iO4r5Ka2VtKF@robh.at.kernel.org>
References: <20211020094229.1760793-1-horatiu.vultur@microchip.com>
 <20211020094229.1760793-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020094229.1760793-3-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 11:42:28 +0200, Horatiu Vultur wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
