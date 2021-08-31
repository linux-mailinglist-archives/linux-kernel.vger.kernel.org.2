Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477B63FCF28
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 23:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhHaVea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 17:34:30 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46040 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhHaVe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 17:34:29 -0400
Received: by mail-ot1-f44.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso895090otv.12;
        Tue, 31 Aug 2021 14:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DEpQtIcbExJAxj5xWJXZXM2lHBBB0XQwgkBGvLg9dOE=;
        b=pgu5zMJsnScphPDLWBzB+d8smfPulqKFYS3f0OEXoojt4JIEN/ik4Xh/mfde8Ipx/T
         ooNc1+P2wEgvabEs8tPQX0zUkUyqx/D2BU4aDHxmLLJML1mrZj2MVQ2B5cgyK/YQmN4I
         BpMqRNAptircaUmh7jiuRluN4CkFyml/8dww2K+JRUsZMkUHu7vldJfK2X0DG55WCIoW
         qZY1WDExfDg8o+f8xW0ZQuwlF3D/u2p6gq/890y+ZcIrKNsssz0LHVl9cCnIo1XHUtP3
         RGgbJELknTKQV0i5MwEE6JBFBuwpiEtskZvBTb2IomTATyeijhNV/8hIXrvlxGnnOO3U
         2eeA==
X-Gm-Message-State: AOAM532jEI8rfC0/qeyn9W7Wx1kLE5d2zfEUSYH0YN95RrbUOUStrtvb
        Z4GI8rA/mbMGqeA9Zeabuw==
X-Google-Smtp-Source: ABdhPJxGqyVnBtagDTjCeybHyJZZcO2XDDl1qVwChkvfIfIOVQCqHzcY9vD9BRXlCYPbqdWGaP7XtA==
X-Received: by 2002:a9d:2782:: with SMTP id c2mr25865678otb.323.1630445613196;
        Tue, 31 Aug 2021 14:33:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 186sm3929809ood.39.2021.08.31.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 14:33:32 -0700 (PDT)
Received: (nullmailer pid 682925 invoked by uid 1000);
        Tue, 31 Aug 2021 21:33:32 -0000
Date:   Tue, 31 Aug 2021 16:33:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-phy@lists.infradead.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org,
        kishon@ti.com, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip: remove usb-phy fallback
 string for rk3066a/rk3188
Message-ID: <YS6gLG+M4dP+rkl6@robh.at.kernel.org>
References: <20210828111218.10026-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828111218.10026-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2021 13:12:17 +0200, Johan Jonker wrote:
> With the conversion of rockchip-usb-phy.yaml a long time used fallback
> string for rk3066a/rk3188 was added. The linux driver doesn't do much with
> the GRF phy address range, however the u-boot driver rockchip_usb2_phy.c
> does. The bits in GRF_UOC0_CON2 for rk3066a/rk3188 and rk3288 for example
> don't match. Remove the usb-phy fallback string for rk3066a/rk3188
> to prevent possible strange side effects.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/phy/rockchip-usb-phy.yaml     | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
