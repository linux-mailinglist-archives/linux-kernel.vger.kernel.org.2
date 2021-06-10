Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9B13A2F76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhFJPkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:40:09 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43813 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhFJPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:40:06 -0400
Received: by mail-ot1-f44.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso77584otu.10;
        Thu, 10 Jun 2021 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uscoCCIMohFxBDDb3Te91Dlm8R7xrxz4+PygaqFS3BE=;
        b=EGGnQjEyyOmLI1z0BHEofLAqlgL55eNhiquIbC8qx2iyvfo01gnhVz4qskycU3FnHt
         Nl1EW6UrAoP7QGxwzjgegD5kGzvZywvipKSNoYfZrKMh/hkJxQfqkCeG0/ygUUBSgcKj
         adkD6+oIPjWVrspJBjdLCuLBF8rzUJLUoxKZX2bFyAjO75vhFz8uR+tJlFkKfgPvqnbl
         UMoNXU1ZHR9ZZ1pIr/PeIC5zH7ELLXDLro5YU+LRydJTgx/lN9gkYiXd2SqnswuMYvg8
         jqtkNBxcojtlyXPzOy7ltR3mpCEG3UwWDF+RNFd8Lg1FZGjAmArRHNTJyle9l+biYIYU
         T0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uscoCCIMohFxBDDb3Te91Dlm8R7xrxz4+PygaqFS3BE=;
        b=n/eYMZYmbVh2YFFH9o7KYR1f+uMu4NPXD1mbrhuucd3o46TDmn2IvMmhEQuRmMG7Yc
         yCtH8WeCODIEuZyXCeSeWOcyFB+nOkUpldAN1LD8Ddu8bdkQFZrHO8o2z5/g1FWfdwDK
         pihRDkcYiIxqPRyg0lBlK1yzN1NeOMv2TSg04HMjIHjBci29+wJNkbTWnpxHkRagAeMM
         AWdzpzjetS1nDQH6iUL0y/rWCo+dlj7fGE2EmsuYOlteNZHwooP77CO3NoI9W2ZhIqEf
         QftynqVJlKWRm9LWKDhj04YWqSLF1JWg9fzFArMGTFNpbG3F/PIVSnMXqsU8e6ha2dYU
         zmYQ==
X-Gm-Message-State: AOAM5303UiJwQyqCGR1b7u12eDrPBju0K5ARMH4sc8ltzuluu29pvv1m
        3MXFQl4F+cHGYoDjwbLS74k=
X-Google-Smtp-Source: ABdhPJxbjXaD0sLmXIFDzB4cTd2OW+4OJbuyU8hplLBprxYreMa+B3Zl1fRVKaNxKTabYOGVj89MYQ==
X-Received: by 2002:a05:6830:1e37:: with SMTP id t23mr2868655otr.318.1623339414639;
        Thu, 10 Jun 2021 08:36:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w69sm613369oia.22.2021.06.10.08.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:36:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Jun 2021 08:36:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Subject: Re: [PATCH 1/3] hwmon: (tps23861) define regmap max register
Message-ID: <20210610153652.GA3858775@roeck-us.net>
References: <20210609220728.499879-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609220728.499879-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:07:26AM +0200, Robert Marko wrote:
> Define the max register address the device supports.
> This allows reading the whole register space via
> regmap debugfs, without it only register 0x0 is visible.
> 
> This was forgotten in the original driver commit.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/tps23861.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> index c2484f15298b..fd0be8883829 100644
> --- a/drivers/hwmon/tps23861.c
> +++ b/drivers/hwmon/tps23861.c
> @@ -117,6 +117,7 @@ struct tps23861_data {
>  static struct regmap_config tps23861_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> +	.max_register = 0x6f,
>  };
>  
>  static int tps23861_read_temp(struct tps23861_data *data, long *val)
