Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1D398911
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFBMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:12:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9309C061574;
        Wed,  2 Jun 2021 05:10:35 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h24so1578634qtm.12;
        Wed, 02 Jun 2021 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ceLQ7DX2ahk6MofdGXKHmNmuyjMWe/DQo5AgrxKKavU=;
        b=Gj4LRFDFVt28rRackU52vT0LU44EY5iS9YoU40iDIJ6okYWdJJQ7DXeHo/IjZJPQ86
         Up3HsSSj4WJ1LAf3wPiEFONrSY5KLr3RPW74grEwPkEKh36Ry75vww/sa6mQH9dqehzG
         lDg663TQvTTrmLqkhT+tUT1yzoh2o3fi44a/ujXLPV63YJAzPSkRN3D5poiZOXLoYecw
         pgwEJmscN0a+7oZKYB3hd/praw9Ogyj7B0WgKn9HRPuInbrllc7aolhi49G4Cy9dSnnc
         jlPIamXWs88HBYn/G19zf7PdfISvEJIhQpqTiArVe2BxschigCKCHbVlgIHT7sqdPi1V
         kbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ceLQ7DX2ahk6MofdGXKHmNmuyjMWe/DQo5AgrxKKavU=;
        b=m2EVxo8dafTdq9DiAlqt5xfGJ1rGUy0OFWmfDYErX9Q29J7iduC1VuUMcsjmSU/hbn
         TDs/xnrmt96fed3p3IDAhsc3dSgfjMhBDM+Ts1Xm71Aevd+Ee0AKvUHgX/7kueWcKJND
         nOEo1qUfrVcR4aqnIb0LKHd8/B0FomaFKMJGkzmV8l9xAGthf0eW/iQr3qAOcxpI7jp4
         B6sFo/jasKktZ9ApGFCsz7T5oVU/n9JLpY4VP5NrfczDr9+XnSnIUaHayyrrwTvuHdl7
         02AclTCbWIxakEhIM0+TR21gErhF8EbyaQDmqjDXOi9W3mOBRB7NB0RCsB88eq3Ep+aC
         k6Lw==
X-Gm-Message-State: AOAM532hbtJUn2ZiCTGXAhCto9Vxhq2/bKVQ3TYBByyDwVGIMXsDH5Tr
        ouaZINHudKuSTG37uLvMP2gWZEgj67w=
X-Google-Smtp-Source: ABdhPJw38d2gZaCK/gMOrVE2/UOG16+nr05y2955AdhaSLxJpIbqI+NOJWJkwxolMaRYLfyYrOCT0Q==
X-Received: by 2002:a05:622a:164a:: with SMTP id y10mr24453211qtj.97.1622635834960;
        Wed, 02 Jun 2021 05:10:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g5sm809129qke.101.2021.06.02.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:10:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Jun 2021 05:10:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Daniel Nilsson <daniel.nilsson@flex.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] hwmon: (pmbus/pim4328) Allow phase function even
 if it's not on page
Message-ID: <20210602121032.GA2901466@roeck-us.net>
References: <20210601164320.2907-1-erik.rosen@metormote.com>
 <20210601164320.2907-4-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601164320.2907-4-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 06:43:18PM +0200, Erik Rosen wrote:
> Allow the use of a phase function even if it does not exist not on
> the associated page.
> 
Nit: Too many "not"

Otherwise, for my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index cd80cb574267..7c4f7b6c846e 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1327,14 +1327,14 @@ static int pmbus_add_sensor_attrs(struct i2c_client *client,
>  
>  		pages = paged ? info->pages : 1;
>  		for (page = 0; page < pages; page++) {
> -			if (!(info->func[page] & attrs->func))
> -				continue;
> -			ret = pmbus_add_sensor_attrs_one(client, data, info,
> -							 name, index, page,
> -							 0xff, attrs, paged);
> -			if (ret)
> -				return ret;
> -			index++;
> +			if (info->func[page] & attrs->func) {
> +				ret = pmbus_add_sensor_attrs_one(client, data, info,
> +								 name, index, page,
> +								 0xff, attrs, paged);
> +				if (ret)
> +					return ret;
> +				index++;
> +			}
>  			if (info->phases[page]) {
>  				int phase;
>  
> -- 
> 2.20.1
> 
