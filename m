Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDBB4398A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhJYOep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhJYOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A38CC061746;
        Mon, 25 Oct 2021 07:32:19 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u69so15810407oie.3;
        Mon, 25 Oct 2021 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pmebVXES+76mcKv5JBTJdxBg8OzPf8jfiUIeu+qp7AQ=;
        b=KN/5JlHLu6ClZJBbYzBYLzN30uU6RqIWbSRiOnnjfQJEij9D/LgVKKDeLScGYA6FHi
         T1VaKw9qj0ZxqR2cQBrCFbmnyu7zyGbS1D0zjFhwk4NWj1DjgWJd9z5pmvSqAH0ydM8y
         ggrWMs7iqeT/kte2jNs+E1tbTViujJse+QFdVca0TgZenyS/7L3mfkscl/k4itN3g+0c
         h/hH0n/ESvSFqoAHNStD1nmsaX+Bsj2xWRTJTQpTvWqv2eDpzsJJTebMsNw5EEY15yP6
         OIZrwep7oGrBIao0uCKUWRifuLbGd9SkBp9+IIXfV8oukZFHz4oYtcGZTxwXPi/6D2DT
         kmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=pmebVXES+76mcKv5JBTJdxBg8OzPf8jfiUIeu+qp7AQ=;
        b=WyZdaKgawuiuPGLtwKMXcksHi4LuyE6QPAW3u914GJKnyqtiLqjxIY0GbgmcHO+zLG
         D08RFttIm9JuiJucSTyMJ/AM+SuGARTZLxcFKIm7wX9iguJ7Cxe7NqcrSNN4giAlIF0m
         RIxYMgpOQ/RpKJbqAd7rP36NNNM3pHtq5QELpWX66ErJ+E91eLdm0ajLr4mAw5pAwkBs
         NZKLKiGP4G58JT5YC+awc7ijkzqQJ2HhFAVmcQgV4T+gwCGQi2AZkdKvQ5QXZGb3Mn/e
         6L03V2VtvsLqe90O8yC/tsKQrCB1z5quqvQ0g8ikO70/HMogrQnQI/NQbo/g/gYNcCNN
         jiIA==
X-Gm-Message-State: AOAM530HeHlHVA0nP1BEV0ZMJkJdP3XehNUkv1xVV85ADxBrQ4ZDuaMC
        /I83SMG3/ljELrHQt7I05m0=
X-Google-Smtp-Source: ABdhPJyfvhXAD5bAJ8pfK0Z27LAI0zpl8BNKmE4gMYAcmsvoKqH+NrVYIWrZSFD549xjoHGic166/A==
X-Received: by 2002:aca:4b84:: with SMTP id y126mr22465314oia.127.1635172338576;
        Mon, 25 Oct 2021 07:32:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v13sm3560494oto.65.2021.10.25.07.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:32:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Oct 2021 07:32:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, thomas@weissschuh.net,
        Joel =?utf-8?Q?Wir=C4=81mu?= Pauling <jwp@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] hwmon: (nct6775) Add ProArt X570-CREATOR WIFI
 support.
Message-ID: <20211025143216.GA3203621@roeck-us.net>
References: <20211022200032.23267-1-pauk.denis@gmail.com>
 <20211022200032.23267-4-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211022200032.23267-4-pauk.denis@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:00:31PM +0300, Denis Pauk wrote:
> Tested on:
> ```
> BIOS Information
>     Vendor: American Megatrends Inc.
>     Version: 0402
>     Release Date: 08/04/2021
> ```
> 

This is not an appropriate patch description. Also. it should be an independent
patch and not be tied to the other patches of the series.

Guenter

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Tested-by: Joel Wirāmu Pauling <jwp@redhat.com>
> 
> ---
> Changes in v8:
> - Add ProArt X570 support.
> ---
>  drivers/hwmon/nct6775.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index f345e1902ad9..93dca471972e 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -4986,6 +4986,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>  static struct platform_device *pdev[2];
>  
>  static const char * const asus_wmi_boards[] = {
> +	"ProArt X570-CREATOR WIFI",
>  	"Pro WS X570-ACE",
>  	"PRIME B360-PLUS",
>  	"PRIME B460-PLUS",
> -- 
> 2.33.0
> 
