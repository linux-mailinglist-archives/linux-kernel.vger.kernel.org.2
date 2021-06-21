Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668533AECC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFUPxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFUPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:53:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:51:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bb20so6056362pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uXok+abI+/QaFNT9jA8hKXmptxZAJ4Kr1cCJQURaU7Y=;
        b=keU4suHt1fJRTQFBlYKBRC0EMAguG5yl/OEsfzIdYAVmTyomWeSylFT6kDyBWJdBjU
         ZDGzlX32ZDgQoH/aRyJh6E0K4npRE6L1yEaAgCPAlRbe3/45iCjkKDdgy6CrDFx4PMZS
         l0cbm3IwwP7jfs5czMCx5RnMS8Fxkk5L30j/ji9ggkS7L1Tf51Ilz5GemxRjYSADHXRF
         yUvC22gLQu2HP7zLgtz6uDXrrRdcoiB6GfUKPQWrPo4eBfWy2V6PxxriXAwJi6YM6aXe
         HRCNnzUom1QT8qVvXb275q45N5PtZ9x+W1idtkcUWGTNT1DATfr7yPt/fNkVxxiAJCnT
         l+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXok+abI+/QaFNT9jA8hKXmptxZAJ4Kr1cCJQURaU7Y=;
        b=gIoPpDxy0v0AzfO1b9EyTsqvuHzoMSmvWUsZ1qyz5kEhJvkyQe3ITy3fY7JsL3+TCP
         0BQBPOUI6aOWcSTxCUEpX/8dvsU0Q6BHnZXtrqDA7sv3RYr6A9vkDQTNTCX9yHN7doO3
         mh1ZDfYj/01p4AnBnwpnr78F9Y53/0WmubzvTPoB7qEBzfoJ6nLzakhvO8g3huzEruY1
         EH5ODxdax2SMsixsJQufJnAx8ogra85B4VgIUXdUP1O+bzChAO5tEvIjjKsamj3QhCuL
         GVz5IDQou1pMr9FGmg8zypiJQjF/MXc0tY6MgmMz/fBy4o6ywN3pYwsvoUR+RsVCpgmu
         8RzA==
X-Gm-Message-State: AOAM530rWBSuBJ+J0G4+Xdx+bZ69bw+G/haWgq8t+7NWcpwvYwxP2iT+
        VLdIk7mMCu7dVPKVmPgO5w0=
X-Google-Smtp-Source: ABdhPJy6Zwf17fgWA7Hdl+PWaUAEFCFpeJzvpNK0Kqsu8GlNRgdC36ejdamvFNrTEu74JMnuylfj+A==
X-Received: by 2002:a17:902:9a4c:b029:119:d507:dccd with SMTP id x12-20020a1709029a4cb0290119d507dccdmr18368549plv.55.1624290668969;
        Mon, 21 Jun 2021 08:51:08 -0700 (PDT)
Received: from gmail.com (36-229-229-123.dynamic-ip.hinet.net. [36.229.229.123])
        by smtp.gmail.com with ESMTPSA id ge24sm4252254pjb.18.2021.06.21.08.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:51:08 -0700 (PDT)
Date:   Mon, 21 Jun 2021 23:51:04 +0800
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] rtw_security: fix cast to restricted __le32
Message-ID: <20210621155104.6w237avwjto3vysi@gmail.com>
References: <20210619075255.107807-1-fbihjmeric@gmail.com>
 <20210621081928.145203-1-fbihjmeric@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621081928.145203-1-fbihjmeric@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 04:19:28PM +0800, Jhih-Ming Huang wrote:
> This patch fixes the sparse warning of fix cast to restricted __le32.
> 
> There was a change for replacing private CRC-32 routines with in kernel
> ones.
> However, the author used le32_to_cpu to convert crc32_le(), and we
> should cpu_to_le32.
> 
> Ths commit also fixes the payload checking by memcmp instead of checking element
> by element and removes the unused variable.
> 
> Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>

I forgot to add the Reported-by tag. 
already added in PATCH v6

thanks.

jmhuang

> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index a99f439328f1..8dc6a976b487 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -92,7 +92,6 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  {
>  	/*  exclude ICV */
> -	u8 crc[4];
>  	signed int	length;
>  	u32 keylength;
>  	u8 *pframe, *payload, *iv, wepkey[16];
> @@ -119,10 +118,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  		/* decrypt payload include icv */
>  		arc4_setkey(ctx, wepkey, 3 + keylength);
>  		arc4_crypt(ctx, payload, payload,  length);
> -
> -		/* calculate icv and compare the icv */
> -		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> -
>  	}
>  }
>  
> @@ -537,7 +532,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  	u32 pnh;
>  	u8   rc4key[16];
>  	u8   ttkey[16];
> -	u8 crc[4];
> +	__le32 crc;
>  	signed int			length;
>  
>  	u8 *pframe, *payload, *iv, *prwskey;
> @@ -618,10 +613,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  			arc4_setkey(ctx, rc4key, 16);
>  			arc4_crypt(ctx, payload, payload, length);
>  
> -			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +			crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
>  
> -			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
> -			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
> +			if (memcmp(&crc, payload + length - 4, 4) != 0)
>  				res = _FAIL;
>  		} else {
>  			res = _FAIL;
> -- 
> 2.32.0
> 
