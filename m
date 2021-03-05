Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C12432E058
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 05:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCEEDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 23:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEEDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:03:52 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D2C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 20:03:52 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o3so1051126oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 20:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qy+49UERUnQgX3OFYzgPC3L0DOPLQ08jf6F1tpFsi8g=;
        b=dz+z4DIR0CdXh5nz4aXv6kigpxoTFAb67Y5G2TXeINWTt4n7/eUU9iODqeW0NgD7Aw
         wXGgZmxnC0AS/4ZO62HWGJG9wjq2t5nDoWS7PBTbWJDY5yMn4NXGANIFnaN9QF74HlUW
         1ZLwzs5Njv4sy7FLClE1VnJLW1fJK0pAtZwODcEjQeIOGpSq6/SAp2lMNCRTCOOi4+ww
         luEOcgFi1HxZqJCCioSF/m/BxCAdyBR8jxm5UQdWKAqZvKti91OsgSoOWq06+jDcGiGq
         vURBLSst+aJZNTDOUDKHzrOMk2Gv8OKvcDkB63sFIBlnw1iMxuxzhOlkkeUDnq2UPtTl
         s7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qy+49UERUnQgX3OFYzgPC3L0DOPLQ08jf6F1tpFsi8g=;
        b=IYf9YMQk/Q2bw+qXJhSLV4BdB1oUtXXyxQDSS8/6c5kdXk0A5lz2OCvfx9u8rHN5zS
         SPOvh6riSqZvAvvdekiD9LleKyxgXTLOOKuXBYKwOfc9y21n9HUYjF2l9ukrz+VJHD9H
         JxAHQkMiVHYuJER2TSHoUSdZbMdL5Z5tVKumtIM3Ft6zZ1k117yOkFGl32Ig9hP75Hz1
         KOb2SBNMhSIv8MdiGp+jtC3e3KtWclAHFr47oN6/xwqK3xk51vFtAMfLTpZ5sylXOCWF
         fv+LMO2xkrws7CGOtCoWFtX8bJJ2uBc61zq3bhRsWJzpTDQ6WIasaeOnGDsyn/ADb3wr
         hOEw==
X-Gm-Message-State: AOAM530ddsF4OAMEo7mkV85bUSFmoiv7NYhyPT1S3ecxJyeHHUTuKiI4
        5G3zsq/gM+HEvI9a+Fu8XsaF4A==
X-Google-Smtp-Source: ABdhPJxRQFMzR/Euq/TWa8ATlfsRU6jAFLI1bRsK4pHICaxnwbSE69cxqeZl4+bmU+Htd/VBqrwLzw==
X-Received: by 2002:aca:3a42:: with SMTP id h63mr5569017oia.101.1614917031367;
        Thu, 04 Mar 2021 20:03:51 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w23sm313159oow.25.2021.03.04.20.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 20:03:51 -0800 (PST)
Date:   Thu, 4 Mar 2021 22:03:49 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org, sharathv@codeaurora.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] net: qualcomm: rmnet: mark trailer field
 endianness
Message-ID: <YEGtpapsfaAaGu95@builder.lan>
References: <20210304223431.15045-1-elder@linaro.org>
 <20210304223431.15045-2-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304223431.15045-2-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04 Mar 16:34 CST 2021, Alex Elder wrote:

> The fields in the checksum trailer structure used for QMAP protocol
> RX packets are all big-endian format, so define them that way.
> 
> It turns out these fields are never actually used by the RMNet code.
> The start offset is always assumed to be zero, and the length is
> taken from the other packet headers.  So making these fields
> explicitly big endian has no effect on the behavior of the code.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  include/linux/if_rmnet.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
> index 9661416a9bb47..8c7845baf3837 100644
> --- a/include/linux/if_rmnet.h
> +++ b/include/linux/if_rmnet.h
> @@ -32,8 +32,8 @@ struct rmnet_map_dl_csum_trailer {
>  #else
>  #error	"Please fix <asm/byteorder.h>"
>  #endif
> -	u16 csum_start_offset;
> -	u16 csum_length;
> +	__be16 csum_start_offset;
> +	__be16 csum_length;
>  	__be16 csum_value;
>  } __aligned(1);
>  
> -- 
> 2.20.1
> 
