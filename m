Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8340415073
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhIVT1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:27:11 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39693 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhIVT1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:27:10 -0400
Received: by mail-ot1-f47.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so5055369ota.6;
        Wed, 22 Sep 2021 12:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ROfX8dif1hOUK6DTEujZ26PCAYYwnvSwl8YAfygyhQw=;
        b=wgibplAYi3nFyeUY0evfJIzSwwt6q48TsO08dOUBfBw09hCtpTtbELDFMuLkl2Z5d1
         TrfPTX+jNMpsn/hgKruqBodnctEQ00abTMBDiyjJc1xK+NsWYh7siA627vTFDY7bTTz8
         0qLWtnBAqRqsumD0vbjetrWUTCDTIdNp3zzZEIlhaMucl3bivaIHZbSSiOy+WkOPLqkV
         lVXGhirNKy3X/qFxAhJL+Hw9osWcBucmsrx1GeJivzbzimO4Z2LpNPYFRcaHyaGQS3mu
         Ojcbnvg6T+S6PL5CTT9QknR34RLDZwERwbNFU0aN9mjOBu8GY0qmO8vlSm51uA5dbXzC
         KOPw==
X-Gm-Message-State: AOAM532bHqLV42i5Io0d3Pmb1GS3v8qbOjKGk2JUppIUpNagZl3Vu6EK
        5fOwbEjyxkWP6dn4v22/yw==
X-Google-Smtp-Source: ABdhPJwZcbzkZsQL7s7jpvYc1l7WP+b15tHJqpXusBvQkj9+ALginWqlD3++GJrT2Tc8lFf6Q003vw==
X-Received: by 2002:a9d:411e:: with SMTP id o30mr730096ote.97.1632338739773;
        Wed, 22 Sep 2021 12:25:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j8sm737011ooc.21.2021.09.22.12.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:25:39 -0700 (PDT)
Received: (nullmailer pid 1143320 invoked by uid 1000);
        Wed, 22 Sep 2021 19:25:38 -0000
Date:   Wed, 22 Sep 2021 14:25:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, kishon@ti.com, vkoul@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the
 pad modes of imx8 pcie phy
Message-ID: <YUuDMjBGWfNsMf2n@robh.at.kernel.org>
References: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com>
 <1631845863-24249-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631845863-24249-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 10:31:00AM +0800, Richard Zhu wrote:
> Add binding for reference clock PAD modes of the i.MX8 PCIe PHY.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  include/dt-bindings/phy/phy-imx8-pcie.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-imx8-pcie.h
> 
> diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h b/include/dt-bindings/phy/phy-imx8-pcie.h
> new file mode 100644
> index 000000000000..fe198a0cc12c
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-imx8-pcie.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Perhaps this should match the dts files license...

> +/*
> + * This header provides constants for i.MX8 PCIe.
> + */
> +
> +#ifndef _DT_BINDINGS_IMX8_PCIE_H
> +#define _DT_BINDINGS_IMX8_PCIE_H
> +
> +/* Reference clock PAD mode */
> +#define IMX8_PCIE_REFCLK_PAD_NO_USED	0
> +#define IMX8_PCIE_REFCLK_PAD_INPUT	1
> +#define IMX8_PCIE_REFCLK_PAD_OUTPUT	2
> +
> +#endif /* _DT_BINDINGS_IMX8_PCIE_H */
> -- 
> 2.25.1
> 
> 
