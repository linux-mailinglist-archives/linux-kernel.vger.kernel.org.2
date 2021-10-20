Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31947435501
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhJTVNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTVNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:13:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274D1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:10:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r7so49459580wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0+ODNVIZX7vRd9AxlwVc5J2d5e3MBLUBH0erFYZhYs=;
        b=Zk4STNOHYLrnD7MFoziy/CMefZpRri6RVv8M9nAoiz0yysul3IxgALuncRd0h6b3NF
         Zk8s8mxLdehDW87Sm83a1lsAr+kVPqLasps2IpilSdW2nzPMXuCIchlGV1IqtinpSW4X
         ELgvbcowFo7tWo6388755ej6ybWUvZ/yFKX0ecmDa/M39miAuITV7NkW1VHsLGR1PAYK
         AIzKYbt4O9ov78r4PitntN+6TGisgyjloU9mRm8jHqEwqrWVgK5oz/jS/GhaHgblxvw/
         3RV0Z1ARbAGvV7b9376oHc48AEgbXBfMCtYdlLL9shp/sFr73993pD/RzOljs+ujXhkw
         +U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0+ODNVIZX7vRd9AxlwVc5J2d5e3MBLUBH0erFYZhYs=;
        b=raEB1TNJfS2C/aIEbGqaN8mSxqu3X5FkfyWG6AeOSHF3D6+y8yMyzRoDWJodqqvtzQ
         qBXpKDPTvU0SvpSjLLNDfCRkzJMW56+M8Eza8FbVSQoB1SWvEMGvY0CxyoNBs+4/puVQ
         fWiinuWjGMGT9jrT7txyIeHH8lqDObteVTQL3DjjH3/xS5YHXtKOmZDGT+efxySsiWYD
         nNWW18JRfnCD7nIPqJjQQ4uzIzPoIDIvxwuVJEL0c5S7kAULsAGq3bOI0r2m8tW5P2xu
         Q7jCtw38VCRCy1bgpn5q4dVWadJlkwZXKj5GRPgKxbBTvcxOJlOG65o+LRGYKgW1Pj6K
         g8LA==
X-Gm-Message-State: AOAM531+vKrVGi1Cy1yUC468rdaou6u/dgs1rXZChc813DaureNRAnNV
        m3IHxYANgEYs1UcNIE9U0Uouvg==
X-Google-Smtp-Source: ABdhPJwJ7p07cRI4Swbay45ieeHxN7/IRLwbfCvb8k5n/qG4xFGhe8bjXueWFEQfzfdY5XWQlJOnsQ==
X-Received: by 2002:adf:9b97:: with SMTP id d23mr1933314wrc.135.1634764243715;
        Wed, 20 Oct 2021 14:10:43 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id f3sm2878650wml.11.2021.10.20.14.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:10:43 -0700 (PDT)
Date:   Wed, 20 Oct 2021 22:10:41 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: r8188eu: remove unused defines and enums
Message-ID: <YXCF0a3gLosjwhLS@equinox>
References: <20211020195401.12931-1-martin@kaiser.cx>
 <20211020195401.12931-5-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020195401.12931-5-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:54:01PM +0200, Martin Kaiser wrote:
> Remove a couple of unused defines and an unused enum
> from rtl8188e_cmd.h.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/include/rtl8188e_cmd.h | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_cmd.h b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
> index 01404b774ebd..1e01c1662f9a 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_cmd.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
> @@ -27,15 +27,6 @@ enum RTL8188E_H2C_CMD_ID {
>  	/* Class DM */
>  	H2C_DM_MACID_CFG		= 0x40,
>  	H2C_DM_TXBF			= 0x41,
> -
> -	/* Class BT */
> -	H2C_BT_COEX_MASK		= 0x60,
> -	H2C_BT_COEX_GPIO_MODE		= 0x61,
> -	H2C_BT_DAC_SWING_VAL		= 0x62,
> -	H2C_BT_PSD_RST			= 0x63,
> -
> -	/* Class */
> -	 H2C_RESET_TSF			= 0xc0,
>  };
>  
>  struct cmd_msg_parm {
> @@ -44,10 +35,6 @@ struct cmd_msg_parm {
>  	u8 buf[6];
>  };
>  
> -enum {
> -	PWRS
> -};
> -
>  struct setpwrmode_parm {
>  	u8 Mode;/* 0:Active,1:LPS,2:WMMPS */
>  	u8 SmartPS_RLBM;/* LPS= 0:PS_Poll,1:PS_Poll,2:NullData,WMM= 0:PS_Poll,1:NullData */
> -- 
> 2.20.1
> 

Looks good. Built and tested whole series btw :-)

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
