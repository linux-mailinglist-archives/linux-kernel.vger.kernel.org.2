Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784CB443347
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhKBQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:44:00 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:46681 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhKBQn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:43:58 -0400
Received: by mail-ot1-f42.google.com with SMTP id w29-20020a056830411d00b0055abaca9349so2388716ott.13;
        Tue, 02 Nov 2021 09:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p4xN9jvUs2HHItSG3zOdut7t8WiHJZSDYDMDaJgMKR0=;
        b=79Bg/QJixdMudUzBVZAWvfoxurpvN1wJ2WL8lWVICONJwu+hjUU2ZOY8Z0HHMFECU4
         cdhCaPe6cSBdbxMritXIcs8aaOrOADrs1ORj+z6aM3sGsML+JHhvfUrJ4xe7FXZkw6RG
         ZKgTnV4FBf2qaYHNxbDWKWBscVsHyqSuhBg/ZT4rxDHnTpZE2pa3ciMxcfrLQCW1bH7R
         xF+o/jfDqZEwf9QR17LNaYIg/wCQd0ODWuExAB3Kl2bWDLjy21SamfhDeAp12G2LmCsu
         fYIcWZi5hfyESlVHZOYwZg4SsqYe7FmfrjcHGNR3SIOMG1yWmx+x1yWe4PFfLjE9cLhe
         OCnw==
X-Gm-Message-State: AOAM530lOMMI94+2lrGuR3rQEy4IU8tErU1Hb1S30Jx9+Xeu2vjtFFEI
        vX+O3BmfYUBtuI/KtwMZRg==
X-Google-Smtp-Source: ABdhPJxgJbDrX4P/USnAKFJxsIIAp3I+zRht84aM87QgsRXfBjioI3ZjPnMCBQ8Ja6zU/xGpsn2srg==
X-Received: by 2002:a9d:6c0c:: with SMTP id f12mr26004890otq.275.1635871283186;
        Tue, 02 Nov 2021 09:41:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p124sm3321331oib.35.2021.11.02.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:41:22 -0700 (PDT)
Received: (nullmailer pid 3034467 invoked by uid 1000);
        Tue, 02 Nov 2021 16:41:21 -0000
Date:   Tue, 2 Nov 2021 11:41:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, vkoul@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org,
        tharvey@gateworks.com, devicetree@vger.kernel.org,
        linux-imx@nxp.com, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        marcel.ziswiler@toradex.com
Subject: Re: [PATCH v5 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and
 name properties
Message-ID: <YYFqMaByELGuWOCu@robh.at.kernel.org>
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
 <1635820355-27009-4-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635820355-27009-4-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021 10:32:30 +0800, Richard Zhu wrote:
> i.MX8MM PCIe has the PHY. Add a PHY phandle and name properties
> in the binding document.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
