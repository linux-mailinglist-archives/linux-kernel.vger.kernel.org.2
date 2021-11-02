Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C2F443301
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhKBQja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:39:30 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:39513 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhKBQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:38:51 -0400
Received: by mail-ot1-f52.google.com with SMTP id x16-20020a9d7050000000b00553d5d169f7so29103501otj.6;
        Tue, 02 Nov 2021 09:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Accs2bGcaINGxdMfGMGAXDWboqW4zXxOfrIFX49zW/g=;
        b=m7S+CpiyXBQF0sROAFTy6W4PaMLt65INTqQYyDLfJ2VNKO0W/YXVPJDXdg7GYE0Rwp
         +f1ISxDU0fyE2tcoLPvw1bZe2/kdC6HvoYRu+tqLGaNCMX2vH/RFMH2mam6tdcHUuBD2
         zZ4vYq6kq4ib27uHrh4sz/FVhJ7Bv3rT4EfoJmucvU6kZwR/Fpknz3opmsrKSEYYN6Wc
         U7R2+FdEoUXCgC1jEarGcsaG5B07XkGxufJ+8MWVNSpqIPNGJj1D7JOssG6nOlSoGURL
         j6wzMu+pfagF4abqr20Asz/SCsd1RcHNF/GXLpZXC1J1nQD2ZbCWg801fFt5N3VISk9+
         1d5A==
X-Gm-Message-State: AOAM530JSmCF99AeeHpF4Osq8O+ude+bdu0R2bgq9eDSSOqD+3RxFNJf
        sdEXVxs8uFvimnHkVDZdvpooKKiBKQ==
X-Google-Smtp-Source: ABdhPJxaoTt5eEe9SxJRqvWvBTfY1lg5SYIUsz8HIaJRDx2qR4eGO4dPCweQz01EtMiDXJwL4qkEDA==
X-Received: by 2002:a9d:e8b:: with SMTP id 11mr4218359otj.43.1635870976471;
        Tue, 02 Nov 2021 09:36:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a23sm3490659ool.3.2021.11.02.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:36:15 -0700 (PDT)
Received: (nullmailer pid 3025339 invoked by uid 1000);
        Tue, 02 Nov 2021 16:36:14 -0000
Date:   Tue, 2 Nov 2021 11:36:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kishon@ti.com, marcel.ziswiler@toradex.com,
        shawnguo@kernel.org, vkoul@kernel.org, galak@kernel.crashing.org,
        l.stach@pengutronix.de, tharvey@gateworks.com
Subject: Re: [PATCH v5 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for
 the pad modes of imx8 pcie phy
Message-ID: <YYFo/hZ3p7XZysVq@robh.at.kernel.org>
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
 <1635820355-27009-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635820355-27009-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021 10:32:28 +0800, Richard Zhu wrote:
> Add binding for reference clock PAD modes of the i.MX8 PCIe PHY.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  include/dt-bindings/phy/phy-imx8-pcie.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-imx8-pcie.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
