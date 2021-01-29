Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF39308F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 22:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhA2VTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 16:19:04 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33441 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhA2VS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 16:18:58 -0500
Received: by mail-wr1-f53.google.com with SMTP id 7so10232880wrz.0;
        Fri, 29 Jan 2021 13:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cspA5TgSavfsCop930QLayxfXE5mnY6tKbYm05EnDsE=;
        b=Qqq+lVcnhSKyuaZmDugYgYEvetbjuSHansPT0P3oV6LSvHIP46hSYG4JQk/FXpfVT4
         AtsjMyQcG9Hp1A/WtPrx+6dwZs0hC7Sy8DD52BDURwVSPG1mtl7m7Oj4MPbLd+thzSzV
         J1O4WB1soBeFsaVfZ7BDFKcz7kuOcvcKL2p8n+UFUp6iW78Y4VxsglqPP+l9FvGufmdW
         9yUE7Ta249crM66zTrLvAQJJ6hySZsB5+MsrQAr5bIkfxQCpyJwOip92ZrlMCGcopD0u
         zlvxmCE4mUWqAxVtqrJPDXBWTTpPAlDiGvbaZQy1OyT/IKXt1t76YCLKriBvizGLSepq
         D3wQ==
X-Gm-Message-State: AOAM531+Y4MTu3wwN6C7Pou3JnLeWGxQXP0QTXgcEeb9qYJKbZ3eTvgk
        jW1povtgoS5LRHNdkovyxug=
X-Google-Smtp-Source: ABdhPJzEkFZsFQABpY4coeNBrEb+TLQoIhC7aumXidAzUn1PNs+lk13FEBL/pTCJc33wlZXe5yyqCA==
X-Received: by 2002:adf:e511:: with SMTP id j17mr6620390wrm.17.1611955096398;
        Fri, 29 Jan 2021 13:18:16 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m22sm12099984wrh.66.2021.01.29.13.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:18:15 -0800 (PST)
Date:   Fri, 29 Jan 2021 22:18:13 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     m.felsch@pengutronix.de, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org
Subject: Re: [PATCH v6 3/3] arm64: defconfig: Enable PF8x00 as builtin
Message-ID: <20210129211813.ooizzkyypu4c2ekl@kozik-lap>
References: <20210128193554.2496095-1-adrien.grassein@gmail.com>
 <20210128193554.2496095-4-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128193554.2496095-4-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 08:35:54PM +0100, Adrien Grassein wrote:
> This driver is mandatory for the nitrogen8m mini board
> when booting from the sdcard slot.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
