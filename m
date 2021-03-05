Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD7832E0E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 05:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCEEyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 23:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCEEyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:54:22 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009E8C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 20:54:21 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id b8so630193oti.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 20:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5vUH7jZFg89PccMthKJVQxPCOGJqn1GXklu4BKBrBs=;
        b=JuvOf4VVEYS89LfkQM53QREtjLbjv+M6xBZrd6lInijt/o4C39mz4CXUCN78+4APWG
         cLRHwmUDY7sOY0CJpIUt1MLqwEwkp1q0GYdNbESH1KjA3aDqbVR9FDVoTXe1Sk9Xr16U
         EDSsihGqbI4f6atWBiikbF9SUDcJpOuV44QOr6gLiZUUCkfV1dI/pBntjWMZppicxZWJ
         dW8KwZrWbsQoLFVRzDCdhfr557JEkWfkC0+deY/U34AU8tJqLLVo3B8S1/pcJ5PtfxrD
         GvEXPoJhZuSf2/8yRzyJEEiLXWaCpRkPfP9OOoYp2RR3FRJFbcdI5OqtY7LaOFRiJL/R
         /kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5vUH7jZFg89PccMthKJVQxPCOGJqn1GXklu4BKBrBs=;
        b=JdLVzNxFslOHurjCXDHoBcNRpe2eVjrmXSvdgGGJ043DFkAx302/5ABgjOVGQhKA/j
         azz1n4YQ9ejypB3LnvBHAyG2GgICVZjV9KoYd+ErMtWVCDNiqx3GrsGqHfRLCDxu3NUQ
         GXqu9AzMDo1zl6ixzSYonyMKuR1KDBLFzosw7yz7vnUZ62OMkVjkyIdFdx9PpVpnVP4G
         b0o6YCc327mIbWGD0Kje7yHLAT0+GXTHgo4/yk/886EHax64Bp4TV1HKg/7BD4nc4KRA
         9te+rZdwl4P9Jn810BqF6i7v0N8SkU7U1i3w/d/XpwF0c3vWvoJuMtQ6asCQEGITmRLa
         tQEQ==
X-Gm-Message-State: AOAM531Hfk0oHHi59RPxBOipYVpFyVg/+OR0JN5WLtTSPL/4+LybvIr4
        TEho8xQCgt0SsLwcJfEJv0TWp9F2ajx6YQ==
X-Google-Smtp-Source: ABdhPJx8mwLwoYpU80IxbM0PI2U+kNY5M/A1Cshqk+6PQRbHjEc7b3FUZ69dHwffF+iR/BW9pkEVGQ==
X-Received: by 2002:a9d:7196:: with SMTP id o22mr6403661otj.107.1614920061290;
        Thu, 04 Mar 2021 20:54:21 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c25sm400317otk.35.2021.03.04.20.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 20:54:20 -0800 (PST)
Date:   Thu, 4 Mar 2021 22:54:19 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org, sharathv@codeaurora.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: qualcomm: rmnet: don't use C
 bit-fields in rmnet checksum trailer
Message-ID: <YEG5e3K/gElI3bSh@builder.lan>
References: <20210304223431.15045-1-elder@linaro.org>
 <20210304223431.15045-6-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304223431.15045-6-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04 Mar 16:34 CST 2021, Alex Elder wrote:

> Replace the use of C bit-fields in the rmnet_map_dl_csum_trailer
> structure with a single one-byte field, using constant field masks
> to encode or get at embedded values.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  .../ethernet/qualcomm/rmnet/rmnet_map_data.c    |  2 +-
>  include/linux/if_rmnet.h                        | 17 +++++++----------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 3291f252d81b0..29d485b868a65 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -365,7 +365,7 @@ int rmnet_map_checksum_downlink_packet(struct sk_buff *skb, u16 len)
>  
>  	csum_trailer = (struct rmnet_map_dl_csum_trailer *)(skb->data + len);
>  
> -	if (!csum_trailer->valid) {
> +	if (!u8_get_bits(csum_trailer->flags, MAP_CSUM_DL_VALID_FMASK)) {
>  		priv->stats.csum_valid_unset++;
>  		return -EINVAL;
>  	}
> diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
> index 4824c6328a82c..1fbb7531238b6 100644
> --- a/include/linux/if_rmnet.h
> +++ b/include/linux/if_rmnet.h
> @@ -19,21 +19,18 @@ struct rmnet_map_header {
>  #define MAP_PAD_LEN_FMASK		GENMASK(5, 0)
>  
>  struct rmnet_map_dl_csum_trailer {
> -	u8  reserved1;
> -#if defined(__LITTLE_ENDIAN_BITFIELD)
> -	u8  valid:1;
> -	u8  reserved2:7;
> -#elif defined (__BIG_ENDIAN_BITFIELD)
> -	u8  reserved2:7;
> -	u8  valid:1;
> -#else
> -#error	"Please fix <asm/byteorder.h>"
> -#endif
> +	u8 reserved1;
> +	u8 flags;			/* MAP_CSUM_DL_*_FMASK */
>  	__be16 csum_start_offset;
>  	__be16 csum_length;
>  	__be16 csum_value;
>  } __aligned(1);
>  
> +/* rmnet_map_dl_csum_trailer flags field:
> + *  VALID:	1 = checksum and length valid; 0 = ignore them
> + */
> +#define MAP_CSUM_DL_VALID_FMASK		GENMASK(0, 0)
> +
>  struct rmnet_map_ul_csum_header {
>  	__be16 csum_start_offset;
>  #if defined(__LITTLE_ENDIAN_BITFIELD)
> -- 
> 2.20.1
> 
