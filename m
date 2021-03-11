Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B8337FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCKVin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhCKVie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:38:34 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89836C061574;
        Thu, 11 Mar 2021 13:38:33 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so361172oto.2;
        Thu, 11 Mar 2021 13:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QIKZ/cIuxfarkAp9T4K0BykcCz0xUFXqUmHsBpDAC+A=;
        b=KDFfHPSV1DwhyNuMe3NRHV1S7Yya/uMvKBwAHYy9EpCVr/mQVBUzDucizl7rQX/UZk
         8MxO2ieAHyBpHoqs9TL3RSjii4+mFd3Nnk4cwr8GxF0y4/a1LGNCBPywwuY6d/56Rexk
         AEtE4Jvelf/T9EeTjyvUYK30WQP/IUCB5BMh3KvEGCoJQrxGZLCcNp8Dz10AUMP6YUL1
         VeTlcjDR5DOaNVSSslJ/69io2iQOO+WR6bN7I07ZFCECkigMkkeSiBc/mmHKcSVfI2Up
         bHBjn2l0OO2Q9Kd+5/8ok1dTdJfpv+83TW88+48qoZ+/ZJQ1wPEohtqgfCiXbHwzDVwk
         JlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QIKZ/cIuxfarkAp9T4K0BykcCz0xUFXqUmHsBpDAC+A=;
        b=Od6MpgalsXMp/Z4zbpBPmV4LeTIuwilQqrP6JWnHP8+cImdb7Jnj7AAgbqwC13Tpsp
         8G7HRhDRSkuXe3vAYUfQ/8H9WewCKbthf8kuhLm/f14MFpm7NbcnMc0j+nojtz8o75mN
         898UI0fVVKgNEO3tduJly0sx/7qF9V0ieTCLglBZNZ43nPQVeFsAAJP6Q9KwXCtc/k9L
         eQGET+oNhYed+yn6Xo0QtcNiae8ZEH7+SBCADsiH7eVChOtths7NdITvkwDVIaIQMnVJ
         GX8/HomBrP4OIkqt98lHo23D2AaoAUJB4bOD7MR6a+sOq6LeoutKT8Z+110pBYm6SObu
         y/8w==
X-Gm-Message-State: AOAM530J6SyWdD9hYopDbThrBQS88Tq+CELi9YqPFi958doGNyomeh7Z
        WmymZuhf2ugbWKn7KZOM+OPOFUHBrNg=
X-Google-Smtp-Source: ABdhPJzbF9ur5BOL7UQ3fhvhqvbsznkZMyxzfJrYMgYa4wF11DEkh0SeOISQGH5d6yjP2tBmi4HwFw==
X-Received: by 2002:a05:6830:1506:: with SMTP id k6mr864592otp.26.1615498713022;
        Thu, 11 Mar 2021 13:38:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11sm758146oov.9.2021.03.11.13.38.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 13:38:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Mar 2021 13:38:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Switch to using the new API kobj_to_dev()
Message-ID: <20210311213831.GA35420@roeck-us.net>
References: <1614071667-5665-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614071667-5665-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 05:14:27PM +0800, Yang Li wrote:
> fixed the following coccicheck:
> ./drivers/hwmon/hwmon.c:82:60-61: WARNING opportunity for kobj_to_dev()
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 6c68405..fd47ab4 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -79,7 +79,7 @@ struct hwmon_thermal_data {
>  static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,
>  					 struct attribute *attr, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  
>  	if (to_hwmon_device(dev)->name == NULL)
>  		return 0;
