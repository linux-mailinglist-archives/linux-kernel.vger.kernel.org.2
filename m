Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3D306ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhA1B5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhA1B46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:56:58 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A449C061574;
        Wed, 27 Jan 2021 17:56:18 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d1so3733057otl.13;
        Wed, 27 Jan 2021 17:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AIU03VnftoZLyHcSTHkh7PkUpBfxH166feqA1IzM5uQ=;
        b=ZNVfxWyqZ2dFxrmRP1n3WIiqSFP8DRwKQGadKjNYSUKAR+LDff3q+7XUbS2UAUP1nk
         zqBe1ThwbdxbG5/PvajXVQTaiYb3ioZFkE/Qg0WdSTzzUUP7ErnXy0E4DSfpVMxdNK2D
         cqoST78c70G02xNXBQT41QpVWlUfXjh83UUj1dp1E8Hf7hOc274kKSo88leCRoEluu5i
         7wyhW8WwPZ7j4fJjCbsGz+6GbAbwXQvO03dduonvQWbIGacxGs1yyspneSq9nTtQ3K7J
         DJjLRxjJaOs7NRPfTbp2ByYINnfgb3u1XT/okUuXL7j5NkCD9+Ne1jRGmCMhAKCSzuL1
         Bi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIU03VnftoZLyHcSTHkh7PkUpBfxH166feqA1IzM5uQ=;
        b=c/KA+oVqyV5xtC8bah3TYiyktbauIE5pJlp+vCb3EXoOQivPpbRY54bk1FYA9SlBzP
         zltrrKIHYjOw5hE1eWgYxMaA3pKRUcMPA/tiS09l20SMEccGU0QUCU+twevEGUoP/kBr
         94reKAO+ltqD9HsfT3uBvF0HXPz8PjF8lld+/9mnjifnUO6mM3ukrP6BWYxEVPho+gsv
         iJkpHF1SlXGwOZ+EzR4b0KVbut4evLG4/ni+rikjQML4KGSzqaEQjenVl7cQ2LizKa2S
         UBDelY/POMAqTuGKiZO4JRVRlev3j056fpQf9ioqTIsaZClJ6ycLScLAYWx9Ex7eW/3i
         i7Iw==
X-Gm-Message-State: AOAM5303RnlYYxDmv1DfXcE1Z29Chvip72weSYLQ/s5RBKN2nhtJz+hu
        RmpQHo2yitKpgbf3NKm95ODipEhF+fk=
X-Google-Smtp-Source: ABdhPJyfZvX3UXHK1emhsgU9ZmU+9elePOmJliZfbcaiIsfovZWhpa3dkyGBnY7scIOSJs5q0L6i6A==
X-Received: by 2002:a9d:7452:: with SMTP id p18mr9876506otk.49.1611798977704;
        Wed, 27 Jan 2021 17:56:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x31sm726564otb.4.2021.01.27.17.56.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jan 2021 17:56:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Jan 2021 17:56:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus) Simplify the calculation of variables
Message-ID: <20210128015615.GA163697@roeck-us.net>
References: <1611642100-29937-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611642100-29937-1-git-send-email-abaci-bugfix@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:21:40PM +0800, Jiapeng Zhong wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/hwmon/pmbus/pmbus_core.c:1265:24-26: WARNING !A || A && B is
> equivalent to !A || B.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 192442b..a78ae70 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1262,7 +1262,7 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
>  		 * which global bit is set) for this page is accessible.
>  		 */
>  		if (!ret && attr->gbit &&
> -		    (!upper || (upper && data->has_status_word)) &&
> +		    (!upper || data->has_status_word) &&
>  		    pmbus_check_status_register(client, page)) {
>  			ret = pmbus_add_boolean(data, name, "alarm", index,
>  						NULL, NULL,
