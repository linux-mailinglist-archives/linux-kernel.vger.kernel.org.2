Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483E1386F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbhERBbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:31:31 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:35509 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbhERBba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:31:30 -0400
Received: by mail-oi1-f177.google.com with SMTP id v22so8279184oic.2;
        Mon, 17 May 2021 18:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oiChmmm3c4jQ/mjCqDyUKJLtpixrBak0jzUaVwVqz5o=;
        b=f7+ixw2J+HGg0n+hfH3afEOKmraffSsutlwcnRpMg3mTLKEvKVzzrEcGMZgQJ8gcM/
         y3aEQeXfMTHayr6fQBoME+mqM49sPoDZxSZcBD+3SN0LZz6zElRfSb2SldP8x36F/BkD
         DV3PaO0bdL8G2rLUx0iBwZR6LEKlR7tgOvRCoYZlOc9J7RQgjLY8WHKTUzvy0C22xJUE
         oYY0yc822oboCNdQ7JzDSOcnkAitHuVRSi2wSJdSsoXaF1CAovHwUuedJfecDD7LkDjj
         jnKfs1K4N06YJl4igrSqhqv1vNyzyQqxt/DbUBj67Fxu11S8trjShMde0R8f1jIQuYyW
         0J1g==
X-Gm-Message-State: AOAM530a00uiypulsVcu5TgeBe+xcbGnb0QYDYtX2DTVN7p3GVZbs6Hs
        GD3lTmfRVaIwQQZcyYl6vA==
X-Google-Smtp-Source: ABdhPJyxdV0Mr4rv6ASsJEiOUDxby5DAJBSRvp3cezJZCDJozkHkPwp+yZtsKluvwzG0ue1LMi/r1w==
X-Received: by 2002:a54:4396:: with SMTP id u22mr1504292oiv.118.1621301412607;
        Mon, 17 May 2021 18:30:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e6sm3424903otk.64.2021.05.17.18.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:30:12 -0700 (PDT)
Received: (nullmailer pid 3604678 invoked by uid 1000);
        Tue, 18 May 2021 01:30:10 -0000
Date:   Mon, 17 May 2021 20:30:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>, linux-usb@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: rockchip-inno-usb2: add
 compatible for rk3308 USB phy
Message-ID: <20210518013010.GA3604623@robh.at.kernel.org>
References: <20210514150044.2099298-1-t.schramm@manjaro.org>
 <20210514150044.2099298-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514150044.2099298-2-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 17:00:40 +0200, Tobias Schramm wrote:
> The RK3308 features a slightly different USB phy than other Rockchip SoCs.
> This patch adds a compatible string for it.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
