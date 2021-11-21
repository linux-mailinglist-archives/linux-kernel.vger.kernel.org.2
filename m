Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797154580F4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhKTXWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhKTXWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:22:02 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526AAC06173E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:18:52 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so22698972otg.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JTdASFPiON/L+d5lkfaZYqJlAIfhX4rwz0wsWxjgVA8=;
        b=tml7j6wnym+kcgisdcUDIpnQEFPk3UxKrDQbvjVV1hvRYJqlZQl7ny4mB31t2+VPJi
         nN1Iv+ZMw8Xe5Tg17xNs7Ulb/vFxncG64IDus+jTuZdQCBILJvjqGPxze1SZTyrAv44k
         uGFZ+hd7SDicV32/p11M9sCkwT77720PGzfSmPQ3rfX8QK23/wWYa5UwahIt6GK2k76E
         9NuucBFx+hCRBWhoHFTU1raaQKbwLvk7rQzN/GRiYuat3f1supiGSosJXiXHEidHEjWA
         kSUvZchh1g109zZEtNiYmQTTXONkwLMOnvzf4IMdo5Cv5TU/mTGPeLm319eG1WEork6R
         //VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JTdASFPiON/L+d5lkfaZYqJlAIfhX4rwz0wsWxjgVA8=;
        b=i60O0E0+390T0uN3rxqRvPvAQK6eiNpqj7FrQgzqiNse6Bx/yKszxTg0HLuTU5pyxe
         Z9p8kPfjAxT7EcZjXoufP1xRSpjnkFEmANseU0e167FBTtAfmqBSiHQNUueWn8nsENH2
         xY7y+LgGveagR4+X6DkbcVUVZBnSI+iEfY5MHF/w2U5yZEk1ASMXCURQbvNWobM/kSjw
         jFwNgqe1Tw0qj49KBfrVyyrtp+9zfX2Nut57Nu0qOIYUIkslrigdH7L0DNEwQrXi+Y+Z
         IPgvHFinLa1pfw+1i1hD3CaZ/4IPI2Luiekp0GyoA0cV1KUm5G2C0FXinnf9sDo8NCvc
         ZPhA==
X-Gm-Message-State: AOAM531p40x5FZvBD/AKWXcof03ZzE5EsO4bOVAGvotD1JkAXOZf41de
        Cj0ONwFTx1HtnX1kzeFz2/bTDA==
X-Google-Smtp-Source: ABdhPJxCfOPuy6zRkMW/P7tdeY6/cZb/s/wtObVT7fNz9WLykz27BnFkfbdNxmr3GspyZ0Ftyzh02w==
X-Received: by 2002:a05:6830:2253:: with SMTP id t19mr15175847otd.163.1637450331627;
        Sat, 20 Nov 2021 15:18:51 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h6sm801746otb.60.2021.11.20.15.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 15:18:51 -0800 (PST)
Date:   Sat, 20 Nov 2021 15:20:37 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/2] phy: qualcomm: ipq806x-usb: Fix kernel-doc style
Message-ID: <YZmCxaP9dkGAemcF@ripper>
References: <20211120061531.410771-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120061531.410771-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19 Nov 22:15 PST 2021, Vinod Koul wrote:

> The functions are documented but there were style issues, so fix
> the style and add missing description for phy_dwc3
> 
> drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:130:
> drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:174:
> drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:212: warning:
> This comment starts with '/**', but isn't a kernel-doc comment.
> Refer Documentation/doc-guide/kernel-doc.rst
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> Changes in v2: use () for function names
> update description of @phy_dwc3
> 
>  drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 26 +++++++++++----------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> index bfff0c8c9130..fec1da470d26 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> @@ -127,12 +127,13 @@ struct phy_drvdata {
>  };
>  
>  /**
> - * Write register and read back masked value to confirm it is written
> + * usb_phy_write_readback() - Write register and read back masked value to
> + * confirm it is written
>   *
> - * @base - QCOM DWC3 PHY base virtual address.
> - * @offset - register offset.
> - * @mask - register bitmask specifying what should be updated
> - * @val - value to write.
> + * @phy_dwc3: QCOM DWC3 phy context
> + * @offset: register offset.
> + * @mask: register bitmask specifying what should be updated
> + * @val: value to write.
>   */
>  static inline void usb_phy_write_readback(struct usb_phy *phy_dwc3,
>  					  u32 offset,
> @@ -171,11 +172,11 @@ static int wait_for_latch(void __iomem *addr)
>  }
>  
>  /**
> - * Write SSPHY register
> + * usb_ss_write_phycreg() - Write SSPHY register
>   *
> - * @base - QCOM DWC3 PHY base virtual address.
> - * @addr - SSPHY address to write.
> - * @val - value to write.
> + * @phy_dwc3: QCOM DWC3 phy context
> + * @addr: SSPHY address to write.
> + * @val: value to write.
>   */
>  static int usb_ss_write_phycreg(struct usb_phy *phy_dwc3,
>  				u32 addr, u32 val)
> @@ -209,10 +210,11 @@ static int usb_ss_write_phycreg(struct usb_phy *phy_dwc3,
>  }
>  
>  /**
> - * Read SSPHY register.
> + * usb_ss_read_phycreg() - Read SSPHY register.
>   *
> - * @base - QCOM DWC3 PHY base virtual address.
> - * @addr - SSPHY address to read.
> + * @phy_dwc3: QCOM DWC3 phy context
> + * @addr: SSPHY address to read.
> + * @val: pointer in which read is store.
>   */
>  static int usb_ss_read_phycreg(struct usb_phy *phy_dwc3,
>  			       u32 addr, u32 *val)
> -- 
> 2.31.1
> 
