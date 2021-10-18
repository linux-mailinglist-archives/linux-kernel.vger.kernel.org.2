Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1695A431F73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhJRO0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhJRO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:26:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304E1C06161C;
        Mon, 18 Oct 2021 07:24:25 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v77so69355oie.1;
        Mon, 18 Oct 2021 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ys6I5q4eaHaMO12ydPPtY/NwG4Nkjx0Yi3Zd0+nJakg=;
        b=Bcqde/YWXL/hX5t4pyx8Rq58U/Mr+hkD1yia/OJWHFIdvL+1lCVACinWAkvNsqf/Ki
         DwvJX8g0lUlsOdlb5WLMDSqf56yuxpvo1fd+xG2hTd7gdyktWW+WQEuoHChmu+qQuPd2
         gjrQV18VMtZ5FrrbQcMxW54lzS4BehvAdz9y04fMSkoFTanI5megvb0zwBWJVGhI+prT
         dVg+VRoZGMKOCRPiocrKQXTgkBFzIcdfbsGxecmpaQPNyKBDr9+wrMFdkjN6J3tO2i/1
         zw7ZMCQuChOfn34ZGkGoJinAqHm+jOUoC5n9HNpny5w5m54nwB3j6h0dul8u1gHUnZvd
         ECkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ys6I5q4eaHaMO12ydPPtY/NwG4Nkjx0Yi3Zd0+nJakg=;
        b=PZi4z+44P/so3mHyq+tNo62kxwELwWuFt9AOWgXvbqW1xJbOuWZ9f+cqugrOcKfdYR
         qMsPG9f6Kq/ZWpKnBy0vpmO+hfvSRU33qFN9XASpgRd65KBOuFQ+7HS2Wzkd8TIDBZcH
         kXLuRN+8mxjg+IuebHHgYH4599abEj/2HWidQEQsyHIKlo7r87ytr9z+FxvA9dVppv+F
         W5Gc/0AGd7vlL7nb9S+JxeKxucffOPK3BWsvZv+FqhbwwNzoMIX1EXnPdgOpEy3VCpMX
         JGFgFONez6E3Pk2vQs6cpE/8X4D+s8v4/FxL+r6Bsq9zaBnQDOzgvINzDwiLsYMBbwv1
         AQDw==
X-Gm-Message-State: AOAM530GE/bWiJYEKCV1gaMnjfZHz/O+zbR3hxSiCgQwuh92qXVK8BB7
        lFv16hk2DXpgySdI4y7xIoE=
X-Google-Smtp-Source: ABdhPJx9bgsZ7w/FtjgvOOdUf0gTbzEG3avG0BHkYIiKQGArkpyotL4DkDij2z1YOyve/QdFKmkpQg==
X-Received: by 2002:aca:1e04:: with SMTP id m4mr49111oic.67.1634567064604;
        Mon, 18 Oct 2021 07:24:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k8sm3044216otp.6.2021.10.18.07.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 07:24:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Oct 2021 07:24:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] hwmon: (tmp421) Add of_node_put() before return
Message-ID: <20211018142421.GA1151312@roeck-us.net>
References: <20211018121538.16482-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018121538.16482-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 08:15:37AM -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/hwmon/tmp421.c:416:1-23: WARNING: Function
> for_each_child_of_node should have of_node_put() before return.
> 
> Early exits from for_each_child_of_node should decrement the
> node reference counter.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/tmp421.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index 31e95b5749c8..1fd8d41d90c8 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -418,8 +418,10 @@ static int tmp421_probe_from_dt(struct i2c_client *client, struct tmp421_data *d
>  			continue;
>  
>  		err = tmp421_probe_child_from_dt(client, child, data);
> -		if (err)
> +		if (err) {
> +			of_node_put(child);
>  			return err;
> +		}
>  	}
>  
>  	return 0;
