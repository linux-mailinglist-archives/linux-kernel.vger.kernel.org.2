Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2D4584BA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 17:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbhKUQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 11:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhKUQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 11:34:45 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743B0C061574;
        Sun, 21 Nov 2021 08:31:40 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso25111661otf.12;
        Sun, 21 Nov 2021 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PFGXxEL/mHus5qxCVVaZQN5AEb5maimOW1ctbt5bKrY=;
        b=UMGehJOvwXSNGXB7HR1Tj5QmB7Ps6g9HuDmOfqkKKz/7C2WVMlZ/k03LH1r1KoaQLA
         Nonwp9fGhTd5a2PvnaCupbohW06LGk1PxfX7nhFX6rgHKM5tEqBp83Qd0usK61AdxCGR
         K1nA9TSpg+QNgEEQZKv2U6QxQEVtgs2ddkzr1QU6TqZVFnbPLv1yXsx2YZzGIvmVqK6p
         U6b4uelK3QhzqtY8bmpOqOs65F2zOQpfxWE5CjDp1y6RnMvcuqnxRss+XmyYKZFQkHP1
         3xMmqUtFPKKI4z96JDyha+BwU0AapqkyivQMstlZ8e5pKP2wamWZXUzWZ8HaWj0KAq6W
         y8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PFGXxEL/mHus5qxCVVaZQN5AEb5maimOW1ctbt5bKrY=;
        b=24HaxnnQ82RQ3n0b+PhXaGLNesE2ixozgCY+SzBOnKXgmTIGzQ/uzVSAOQJQ+Ggfik
         PS4iRExXxltyCWCDCnLtbhStaHkhH/xUDLMdxOCRQrINJznTrKKswY17xDoDXmJaUtX6
         4+N3UlWLzTTtI7sBrMcmxHSsKWVlclO+Vtyr3IS+L17VOqmFm/bVYda0VyjRjqzvFcyK
         6aNndj4dgtcSvMeKKyqhV7lRfKcEdMa8YjcDXK3OzkAByzUYDdZz/xVGzR0+hvn4o2uT
         dvb75l4tWTmMbX37edm749LR7QBlNojboO2hNvAXwmxnt+8My3vIEj1vsnt9OA4ZgcnO
         IdOA==
X-Gm-Message-State: AOAM5305ojFbmvPpUFXgvrziLkbrbmRy3pUCmlInfxvLCfdZyIee+3qI
        HBack4I7jUDnnrjUUoelQsVU+Wa6KfU=
X-Google-Smtp-Source: ABdhPJzAGE8GfIPBbQzqZGIYyU4dhwE5QPL7G1ZTMfNbPPJmnUtiQkZyd+5GxP3DWG8dksu+CdaqgA==
X-Received: by 2002:a9d:7516:: with SMTP id r22mr19356569otk.81.1637512299814;
        Sun, 21 Nov 2021 08:31:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n19sm1179099otq.11.2021.11.21.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 08:31:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 21 Nov 2021 08:31:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     Navin Sankar Velliangiri <navin@linumiz.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (sht4x) Add device tree match table
Message-ID: <20211121163137.GA3534505@roeck-us.net>
References: <20211121160637.2312106-1-davidm@egauge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121160637.2312106-1-davidm@egauge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 04:07:02PM +0000, David Mosberger-Tang wrote:
> This patch enables automatic loading of the sht4x module via a device
> tree table entry.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

I'll wait for the DT patch to be approved before applying.

Please send related patches as series in the future; this should have been
patch 2/2, with the DT patch as first patch.

Thanks,
Guenter

> ---
>  drivers/hwmon/sht4x.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index 3415d7a0e0fc..6e53d81e32d4 100644
> --- a/drivers/hwmon/sht4x.c
> +++ b/drivers/hwmon/sht4x.c
> @@ -281,9 +281,16 @@ static const struct i2c_device_id sht4x_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, sht4x_id);
>  
> +static const struct of_device_id sht4x_of_match[] = {
> +	{ .compatible = "sensirion,sht4x" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sht4x_of_match);
> +
>  static struct i2c_driver sht4x_driver = {
>  	.driver = {
>  		.name = "sht4x",
> +		.of_match_table = sht4x_of_match
>  	},
>  	.probe		= sht4x_probe,
>  	.id_table	= sht4x_id,
> -- 
> 2.25.1
> 
