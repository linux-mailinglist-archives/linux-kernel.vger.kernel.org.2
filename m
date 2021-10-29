Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FED43F62B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 06:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhJ2Eaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 00:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhJ2Eam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 00:30:42 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DF0C061570;
        Thu, 28 Oct 2021 21:28:14 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y207so11575208oia.11;
        Thu, 28 Oct 2021 21:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sayF8lzX6Bq82OffMWDHJwhA0/74UZDJa9N9zxK7sUA=;
        b=FIvUsfN4rFGGyrjauqIpSJuTO0c7Ebbwhp9TOcLJ/fyiZcTN2QBu8cHlZHe4nxsPSK
         IJ0fEhv+fzDvdwx6uX6Agimk/XohOE00USenl9uQx1s2ULKqOAUI6CL/Fw/4iUB4NBGg
         rVjd7KZeVonFKfRL3nSeRY1r9n6E7cGe2OZLsYpBaVA2hG2cZTh8XlQjhvHfYckD68dH
         cNpWyEswtEjaGw7cxEuCvvHb6+NTq+v3nFm5CdfmRzVv40Pmh7JN8iQ/llNLvim0kDjf
         49gbF3jxkVRZgaPkTUbiPeZLjoaMttT+DpiMns+z5igm7I93PeGhbVLHrQEn8GlG8z6V
         st8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sayF8lzX6Bq82OffMWDHJwhA0/74UZDJa9N9zxK7sUA=;
        b=pFYOp5xk+6APVYA7S0Nvc7WmUgAAGpPA6/CRmrS6ai22s6eQcpQMbxnjD8v4e1NjQ2
         /TIm9aYmuAAc552j64RUytBsdX4M7/KPojCa+xgj++gbHyZ2iESxnfbWekfATTJwE6lP
         DY8a3hIXfcnZoRnCR1SJeojW4P8VgtBoXnWQ0U6203QikuUzS0tdLyCrpqXS/FDzb4bw
         0nGph8KsUmH55pMt2gZpP7bIXILBApbcqI3H3y0BcDMpWLivxVpX/uuGkiLeRwF0B/ml
         W0gdhdx2CqGeHkeEHVI7UFqfE9fGI/gLAFcrOo3XLv1ynSqG8T/VgMFOltRYhMeKX/Mj
         iLbA==
X-Gm-Message-State: AOAM531+VZ5OEwfnZE8nZEZwuZD/BBRyy10pjSypn4cWO4AUmCZz9ZPX
        0+5VtqiSj4LvvymDllovGDaWlo5uKkk=
X-Google-Smtp-Source: ABdhPJwJsLLp9SKIADVbYL7wW+bL8L1qHmyb0lazeAWv6CnRSRu4aScJ/jO3C1+XwMxypPTxZHHQSg==
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr12365821oie.44.1635481694245;
        Thu, 28 Oct 2021 21:28:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p25sm1070009ood.29.2021.10.28.21.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 21:28:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 21:28:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiabing.wan@qq.com
Subject: Re: [PATCH] hwmon: (nct7802) Add of_node_put() before return
Message-ID: <20211029042812.GA818647@roeck-us.net>
References: <20211029024918.5161-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029024918.5161-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:49:18PM -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/hwmon/nct7802.c:1152:2-24: WARNING: Function
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
>  drivers/hwmon/nct7802.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index d56f78327619..d1eeef02b6dc 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -1152,8 +1152,10 @@ static int nct7802_configure_channels(struct device *dev,
>  		for_each_child_of_node(dev->of_node, node) {
>  			err = nct7802_get_channel_config(dev, node, &mode_mask,
>  							 &mode_val);
> -			if (err)
> +			if (err) {
> +				of_node_put(node);
>  				return err;
> +			}
>  		}
>  	}
>  
