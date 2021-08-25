Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4653F6E78
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhHYEf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 00:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHYEf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:35:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D96C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:35:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h9so48858794ejs.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnVkSyJgN3E1sDFilQH189RfendGOGfI1/ufZRZKyB0=;
        b=Cco65m4HBzBTv5b8p+0hDWptfNctJ7xmLI2VkvaRSCIRXeS2lcwfYCJx1TakW/zrB/
         vBm+AhQNFZuLtPcsAieUcgf+06flF3tDmudZ+wNG/LwyweO6IgiIga+cK2VEv6kVphZa
         bWwVskoq6mgw31zYgX9ocyPqW8jPOMtp1H1Q2dsd2fRu9mGHy8UTESBoRmy9Pa1CltWT
         AyBHLW2Y4zVpLep+696g9UTNSo27PvANqWC5NrMZ1tKEwFRYB4r2/Fbuz7CQ4kQLSwNh
         I168HLpgNZdTkp5GqGy7Rn3XBehwH6nMCvQgUrdIXkOV2AU5usEx2gfJnr691a10XB7L
         XaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnVkSyJgN3E1sDFilQH189RfendGOGfI1/ufZRZKyB0=;
        b=YbOM1vGb4X3m2xvThK7AvBQT86mR1r4Gg/1QZjbhualfOBfYVVkhZDCMiY5cwmdgEd
         rM12onXrEz0lVKmZx8HUpsusKONHajN11Z+ZhKWHwzVNWs3eHnV/rdX03Gl+45/M/CzJ
         rmmpdBPksOUVSe1jkzqxrkmz4Aiob3ZmJUz4fgWmKqwb7lYVRtNElvHE7WJWbenoAzeS
         2wMUJJ+Mrm/wVU7nZO3AoqN6oH8E2yK4alhDAzclFR+SmIotN/Jsqga72DQcZpdmdw4h
         XI5+4it5J9xEIgRNZ6tcvCLFFJe7SepOViRYIZeMAzcsEmQPgj1B+hzthhW35ei+jp6s
         ZcPw==
X-Gm-Message-State: AOAM531BZGIekSQ7/x648i38XYmEG62iiAo/CIzu+1/NprXLdUH2YoTz
        nO+B9mRy5vAnnH5XNUSJxUs=
X-Google-Smtp-Source: ABdhPJwUciuGXzKcuga0wgY2pqKDLFo5GDsUCC35UCs1jFKLv6eiNgf6mXYx4rZhcerDanUrAdtxrw==
X-Received: by 2002:a17:906:b183:: with SMTP id w3mr30349862ejy.394.1629866110430;
        Tue, 24 Aug 2021 21:35:10 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id v12sm10292649ejq.36.2021.08.24.21.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 21:35:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
Date:   Wed, 25 Aug 2021 06:35:08 +0200
Message-ID: <1665728.ljvk3MsED4@localhost.localdomain>
In-Reply-To: <d06f3173e0a4c6f5449d5551cbfb0202849332b7.1629789580.git.paskripkin@gmail.com>
References: <cover.1629789580.git.paskripkin@gmail.com> <d06f3173e0a4c6f5449d5551cbfb0202849332b7.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 9:27:35 AM CEST Pavel Skripkin wrote:
> _rtw_read16 function can fail in case of usb transfer failure. But
> previous function prototype wasn't designed to return an error to
> caller. It can cause a lot uninit value bugs all across the driver code,
> since rtw_read16() returns local stack variable to caller.
> 
> Fix it by changing the prototype of this function. Now it returns an
> int: 0 on success, negative error value on failure and callers should pass
> the pointer to storage location for register value.
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> 
> [...]
>
> -static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
> +static int usb_read16(struct intf_hdl *pintfhdl, u32 addr, u16 *data)
>  {
>  	u8 requesttype;
>  	u16 wvalue;
>  	u16 len;
> -	__le32 data;
> +	int res;
> +	__le32 tmp;
> +
> +	if (WARN_ON(unlikely(!data)))
> +		return -EINVAL;
>  
>  	requesttype = 0x01;/* read_in */
>  	wvalue = (u16)(addr & 0x0000ffff);
>  	len = 2;
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);
> +	if (res < 0) {
> +		dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 16 bytes: %d\n", res);
> +		return res;
> +	} else if (res != len) {

Dear Pavel,

Please note that if and when my patch "Use usb_control_msg_recv / send () in 
usbctrl_vendorreq ()" will be merged, "if (res! = len)" will always evaluate 'true' 
and usb_read16 () will always return -EIO even if usbctrl_vendorreq () succeeds.

> +		dev_err(dvobj_to_dev(pintfhdl->pintf_dev),
> +			"Failed to read 16 bytes, could read only %d bytes\n", res);
> +		return -EIO;
> +	}
>  
> -	return (u16)(le32_to_cpu(data) & 0xffff);
> +	*data = le32_to_cpu(tmp) & 0xffff;
> +
> +	return 0;
>  }

[...]

Regards,

Fabio



