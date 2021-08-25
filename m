Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF93F6E83
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhHYElZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 00:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHYElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:41:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688DCC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:40:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id me10so20513876ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DVs+REb065XqkXSI+Yu50Se8g0p/Fqtt0gWQBb3WmuQ=;
        b=FG0vFRLE2hJ4UIWorO3vLdb5chKPQM/8JffhiDTMnSlH4j018y5+QL2z2cWKTomNKA
         NjToakFX9B2UT7Ol3WaYlrmQ56eTRFycjcTxkvNvEqqgNDN/L48rTUsIGCJ1chpYHyzO
         KF8WGu8MZAfA09jVXgVmNInfhcUzM3jdiol1tJ6zOTq9vLEkCh3aN4P3IjVgn54E09SE
         MR0g3+RCqFKHbJ3nvvybzJcChTSLVPksAfIpTzLnojQwtFIVwk/dqy3PElvKLG38q9fK
         FvgUD/mk5cszTZIigR74znk/Lohjr+AtJ4pHTDTCyVPkJzKV8sy/y/uTIz7dT53Mumtn
         kGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DVs+REb065XqkXSI+Yu50Se8g0p/Fqtt0gWQBb3WmuQ=;
        b=f8ywxWfekOrpygbTJEjXRHI+aiTowVq/G4+sqiyuDWGDzl3jBMgbekWFjb2tIVEH73
         w3SKqSKnz4d3T5X43qjxj+rP8Kf9Jb/xA6ohkfIaf2MDBcxhoHvIJG1QGRQgYwWLP+d8
         Y5kRtJtggaPwWssQsK98adubZl6PwxiuYb1Lcq6y1cuBWa2NnJvX/Mq6VnWOSA7ikLV3
         gELKHcqV1mms6rR32AbphIfGybpz+vNnq4dW6kSJz92aKsn3Mc1OV8RTjPhu90YPydb8
         /e30xub9csw+v5LaQVqo8WRMy9bQTuiiex7Dlx7uujPh3KxV3z+vjbqr4XsiCJGzqOJX
         t55A==
X-Gm-Message-State: AOAM533U5/Yi+VXgAeC44OLAoFn8oEbO3vJveDdX6UYeb0Vib63Rw8R2
        8o9JTJ6oMWIUyaOKzJHJU54=
X-Google-Smtp-Source: ABdhPJzuSuiWJk2oISMQEFPsrG1mJrQw4UdH+A6YJ30gbnlMC8R6YvZMqu3o5FxzZNnKx7nKPVFFkg==
X-Received: by 2002:a17:907:10cc:: with SMTP id rv12mr9552230ejb.423.1629866437030;
        Tue, 24 Aug 2021 21:40:37 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id h10sm12718423edb.74.2021.08.24.21.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 21:40:36 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v3 5/6] staging: r8188eu: add error handling of rtw_read32
Date:   Wed, 25 Aug 2021 06:40:35 +0200
Message-ID: <4686124.Q29LyLEoG2@localhost.localdomain>
In-Reply-To: <93bf46ce2d0ce12e94672acf28b64dc341fde038.1629789580.git.paskripkin@gmail.com>
References: <cover.1629789580.git.paskripkin@gmail.com> <93bf46ce2d0ce12e94672acf28b64dc341fde038.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 9:27:42 AM CEST Pavel Skripkin wrote:
> _rtw_read32 function can fail in case of usb transfer failure. But
> previous function prototype wasn't designed to return an error to
> caller. It can cause a lot uninit value bugs all across the driver code,
> since rtw_read32() returns local stack variable to caller.
> 
> Fix it by changing the prototype of this function. Now it returns an
> int: 0 on success, negative error value on failure and callers should pass
> the pointer to storage location for register value.
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>
> [...]
>  
> -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
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
>  
>  	wvalue = (u16)(addr & 0x0000ffff);
>  	len = 4;
>  
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);
> +	if (res < 0) {
> +		dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
> +		return res;
> +	} else if (res != len) {

Dear Pavel,

Please note that if and when my patch "Use usb_control_msg_recv / send () in 
usbctrl_vendorreq ()" will be merged, "if (res! = len)" will always evaluate 'true' 
and usb_read32() will always return -EIO even if usbctrl_vendorreq () succeeds.

> +		dev_err(dvobj_to_dev(pintfhdl->pintf_dev),
> +			"Failed to read 32 bytes, could read only %d bytes\n", res);
> +		return -EIO;
> +	}
> +
> +	*data = le32_to_cpu(tmp);
>  
> -	return le32_to_cpu(data);
> +	return 0;
>  }
>  
> [...]
>
Regards,

Fabio



