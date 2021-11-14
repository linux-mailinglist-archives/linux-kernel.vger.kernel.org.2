Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BF844F929
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhKNQz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNQzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:55:36 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB61C061746;
        Sun, 14 Nov 2021 08:52:42 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so23131065otm.10;
        Sun, 14 Nov 2021 08:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MRfYRqfdtAtytB7GUySQrkfY8EngWOMRjnRpM9T7TJk=;
        b=GmoiSoBTeY2Gps4ZWVXCqHdzwhSFseFKqltxk7IDwOHiarglKV9D9Q+KSQvxGzMgeH
         zQ+u72Z3osSiPSFwFTW8xYJRI3NccnZrn0rAGnuCJEno3wbA/QhhNvL0Gu6h1HqgWNNO
         NOpxSyPARMELaQLAWH4ncjX/VyFbqczFJ+EPq1vT/fp8XC1J7CpgETq0d51PjcxTUaZP
         JT72vUxPYU6Qi7Yf4Tv6cGTUKf2oWN18tl6xO9a64P4qruxU+JqxOV1ZtJX2JA8S+4B9
         dx2U4B0Y2phvLulPy0N01kSNiHaIei1n9xzIg7CFEqhD6mApMAjn4yZqN1/nWxRYgJzX
         Qngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=MRfYRqfdtAtytB7GUySQrkfY8EngWOMRjnRpM9T7TJk=;
        b=ku/qsjNs9xUFjapfxG2PjWtGmW7hAMpiHH6ULGtFeno/0xVpGp2Uur7dVx+mAxxeRa
         EVB2GZMctWKhaCOZ/Ly65fN5LOSU8WUvuY1mXF8WRSS5Y1JzvkIDQ4h3OL3LIBEwJFce
         g5GYdVRIey6AwQtW71NMMeQun/I2KX5kTjxj+vx24fvVEvNf9n0hmR/jB/NIJpfdEY0O
         gDabfYBgJ/C70UupTb9ziNwa3htb7NQKRBpbQ0v2fuV5HdEhYaXdkSQLq76VmN3GLd0y
         bFCkmIwSjZipqQ5ePBRj0lLiTGT999Z2rIsHxtyeSl6epnGa5RcutwZ3WHVS9jPtz5lk
         fQ4A==
X-Gm-Message-State: AOAM532OGgEQqEI7fp8LcsWNGxYItIHkJGWQ9CO7oF06eOCgqU+X5apK
        vK8GoV28x/VQLbhISjHweNJ2wf5iRG8=
X-Google-Smtp-Source: ABdhPJyueoVkudaXMr+/sQWgibiCMYCB5DCGceJ3m52FkybO+PVu5IKNobDDnKrV75MXooXCaCUghw==
X-Received: by 2002:a05:6830:2645:: with SMTP id f5mr12447827otu.193.1636908761600;
        Sun, 14 Nov 2021 08:52:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f18sm2506501otl.28.2021.11.14.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:52:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 14 Nov 2021 08:52:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Fix warning on /proc/i8k creation error
Message-ID: <20211114165240.GA1969093@roeck-us.net>
References: <20211112171440.59006-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211112171440.59006-1-W_Armin@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 06:14:40PM +0100, Armin Wolf wrote:
> The removal function is called regardless of whether
> /proc/i8k was created successfully or not, the later
> causing a WARN() on module removal.
> Fix that by only registering the removal function
> if /proc/i8k was created successfully.
> 
> Tested on a Inspiron 3505.
> 
> Fixes: 039ae58503f3 ("hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Acked-by: Pali Rohár <pali@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index eaace478f508..5596c211f38d 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -627,10 +627,9 @@ static void __init i8k_init_procfs(struct device *dev)
>  {
>  	struct dell_smm_data *data = dev_get_drvdata(dev);
> 
> -	/* Register the proc entry */
> -	proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data);
> -
> -	devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
> +	/* Only register exit function if creation was successful */
> +	if (proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data))
> +		devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
>  }
> 
>  #else
