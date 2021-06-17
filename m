Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775713AA7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhFQAOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhFQAOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:14:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432AC061574;
        Wed, 16 Jun 2021 17:12:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so4371511otk.5;
        Wed, 16 Jun 2021 17:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c1QRfJ3FQUjszVpJw97vQrskX9QRXSSLNiih/kSbDYI=;
        b=ZhGHRq2ULz+JOedfCh0u88xzLZyZDF2DxIF3kyWi8hR3zIVUuPvenaKGKllRQjFyWb
         bEUPSoN1B9sB8PgPUj0v7TxNJZi8fYaoDIrQ7Jd/nnW0XMz+swuLh0cyoLj8NDS4Jj3R
         7zk4RzpoLsq07WwF84JqDZqAvrT+C+6KStgVusjLAYlcMD6VjcqS+NIcRBqGKCDI48/U
         Xd4y1y4NaUAr0sePFLyRc/HjenWFPYPu5TKPkmnzUWJcCsoNwNDm/nqxLO6c/q+Haynm
         AKYleSAYu8ZlIe8cH+vKbTi0ZFnQInCKb04KsBmJs5ASZI3LVyydPaQLB8ocbEQIELjW
         zlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c1QRfJ3FQUjszVpJw97vQrskX9QRXSSLNiih/kSbDYI=;
        b=c+D/b+6Jz2MkFTocmhypYAtfrMuNiURs8cnYSge8+iGl3NXc8G8oqAwfMNuPeqkApG
         RVJ5fj9rG7RLdxQzCtZZPm+0Jz3DIO4mdsE2ntVtSjTtG3WeEpw8qDqxBodgHxC6XXZJ
         9FI4cB7zLeYvUnwUXZlDgKKx4t3qIsR1iMmzpSFsenwd7gzHShqTI1n8ZSBZfwozaosK
         Qg2y/1EoFbPqNdCWPfrz8ojTMd2lwyf802cTp7HxxkKcvo7Qe4prcLlxB3NtBgEhnSgV
         PSwaGbA1j8PnvIJip8NlPrUEZqAkMcoPHnkIOjN/0pL4cWSWp3eU17ch1DFfDtvQhAJO
         oc6w==
X-Gm-Message-State: AOAM532UE4td2Y/285bGyfzbmTBBeDD6196gEmLTFKXBdhO/INcHXyHc
        DDc87fG/50PyAX/YTr/FKWE=
X-Google-Smtp-Source: ABdhPJxA/NzbyZFEhopTCXIpREDwYBfU9OKAhkDRw7BP4Y9E4B9WVvojCamGtcXnwoXk4GuHMXd+8w==
X-Received: by 2002:a9d:bc4:: with SMTP id 62mr2037024oth.253.1623888766030;
        Wed, 16 Jun 2021 17:12:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10sm794271ool.45.2021.06.16.17.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 17:12:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Jun 2021 17:12:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
Message-ID: <20210617001243.GA3211292@roeck-us.net>
References: <20210616190708.1220-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616190708.1220-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:07:08PM +0300, Dmitry Osipenko wrote:
> The LM90 driver uses level-based interrupt triggering. The interrupt
> handler prints a warning message about the breached temperature and
> quits. There is no way to stop interrupt from re-triggering since it's
> level-based, thus thousands of warning messages are printed per second
> once interrupt is triggered. Use edge-triggered interrupt in order to
> fix this trouble.
> 
> Fixes: 109b1283fb532 ("hwmon: (lm90) Add support to handle IRQ")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/hwmon/lm90.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index ebbfd5f352c0..ce8ebe60fcdc 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -1908,7 +1908,7 @@ static int lm90_probe(struct i2c_client *client)
>  		dev_dbg(dev, "IRQ: %d\n", client->irq);
>  		err = devm_request_threaded_irq(dev, client->irq,
>  						NULL, lm90_irq_thread,
> -						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  						"lm90", client);

We can't do that. Problem is that many of the devices supported by this driver
behave differently when it comes to interrupts. Specifically, the interrupt
handler is supposed to reset the interrupt condition (ie reading the status
register should reset it). If that is the not the case for a specific chip,
we'll have to update the code to address the problem for that specific chip.
The above code would probably just generate a single interrupt while never
resetting the interrupt condition, which is obviously not what we want to
happen.

Guenter

>  		if (err < 0) {
>  			dev_err(dev, "cannot request IRQ %d\n", client->irq);
> -- 
> 2.30.2
> 
