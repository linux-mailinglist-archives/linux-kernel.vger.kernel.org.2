Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB60454723
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbhKQN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbhKQN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:26:35 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5176CC061570;
        Wed, 17 Nov 2021 05:23:37 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso4682054ots.6;
        Wed, 17 Nov 2021 05:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JpcC4e4rsVEA5qZKmhjIiquAG4OB5LHCYUwoQQFuZ4A=;
        b=m8ga3yPVjpLMru7uIOlFGHmtHhRnr8H0Uhtv5FaKKEMEcG95rnmjYRlyfz2Tz5U46V
         2GKztYNF75qBOvIrQ9DHchA0rh/oPr2fJVfQJpaZomBVSm6CKDAKpIbeUqkstHZTdqo2
         5GIfvBvCdYO42rufAxILnl763GKwx1ZpB5zfCwikDEgB69i35QvBtdXFLi/r69lrFZ2V
         6XWJ8oQlvD7NSANJRwOgTMemNiuQ8Vem3xoHoy89VjOYO70fjJZHfoE27gtHbP2d+iwF
         uV+DLGheXyuiok/dzlw6nsX6OrvmD/cENO+sPn+Kq5NbxhI65m6kQE9iuLL9CcQ3ZNSO
         vq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JpcC4e4rsVEA5qZKmhjIiquAG4OB5LHCYUwoQQFuZ4A=;
        b=7Wafpi+GvoQJYjvAtNnqoQvEbxXNA8HMz5KAGPz8kDWMnHgjw3cVpGFl74YGpDNRyk
         nHS2clr4Oh4HjHMwJuxHVBjglkyRFq0v45YtUiRsQUOJshBpNpI1aP2qMYGx1nhZ4ner
         iInZ0gwu4n0KgV3qOXPyBktjc8P2SuC7jGKmKf7kBxiJKANk+/YFS9Ssb8Oc/+FjqbIc
         RdxqsiUCdkwvkdkoTHmchR0/z5ePql1Et2YAKlYLS7neWCi+MpNdDyyGPgnyGd2hlDND
         8df4Ax2PtLUXuW+bjZBnOuwNrCI3xOz/PeSZP9ZOvekQTWHC0/lhwwna7oT1mL+FLqff
         OGyw==
X-Gm-Message-State: AOAM531F29oMD/hl6f3D0rc016LQxrmq5q2gZcu27a3Jy7qf90JlFrAZ
        W06d84sPrT5/MhYcDqOt5sCrRtBy8RE=
X-Google-Smtp-Source: ABdhPJw9CgQHgVoa1QsXkrAKBbafuxM2CW9sqaBc7ooky0XvJo9UWHzs5X9QzwruC3gOfvJdGjbLaA==
X-Received: by 2002:a9d:6855:: with SMTP id c21mr13936653oto.357.1637155416727;
        Wed, 17 Nov 2021 05:23:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r24sm4256009otc.12.2021.11.17.05.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 05:23:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 17 Nov 2021 05:23:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, SophieHu <sophiehu@aaeon.com.tw>
Subject: Re: [PATCH] hwmon: f71882fg: Add F81966 support
Message-ID: <20211117132333.GA2201569@roeck-us.net>
References: <20211117024320.2428144-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117024320.2428144-1-acelan.kao@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:43:20AM +0800, AceLan Kao wrote:
> From: Menghui Wu <Menghui_Wu@aaeon.com.tw>
> 
> This adds hardware monitor support the Fintek F81966 Super I/O chip.
> Testing was done on the Aaeon SSE-IPTI
> 
> Signed-off-by: Menghui Wu <Menghui_Wu@aaeon.com.tw>
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/f71882fg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index 4673d403759a..938a8b9ec70d 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -49,6 +49,7 @@
>  #define SIO_F81768D_ID		0x1210	/* Chipset ID */
>  #define SIO_F81865_ID		0x0704	/* Chipset ID */
>  #define SIO_F81866_ID		0x1010	/* Chipset ID */
> +#define SIO_F81966_ID		0x1502	/* Chipset ID */
>  
>  #define REGION_LENGTH		8
>  #define ADDR_REG_OFFSET		5
> @@ -2672,6 +2673,7 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
>  		sio_data->type = f81865f;
>  		break;
>  	case SIO_F81866_ID:
> +	case SIO_F81966_ID:
>  		sio_data->type = f81866a;
>  		break;
>  	default:
