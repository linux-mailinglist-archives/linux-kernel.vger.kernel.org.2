Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40917362B09
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhDPWZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhDPWZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:25:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2469C061574;
        Fri, 16 Apr 2021 15:25:15 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s5so21735313qkj.5;
        Fri, 16 Apr 2021 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=84gt/sK4j/+259WLeY5W9SpttA1mqKzaJ7iCIgGDeTA=;
        b=CRRFAS8w+pVMLZrflfzDfRjo2cmYIm4Yl+qAXu7iRhKX+5l2liyPxA0qinsK36S7yC
         3wvh2co5cNGhloMfpiWp6FEAY78S1ShpwECzele6jApyl6pNOu41WLpXqGn5f6Ynh5Uk
         NMoeUDMKboTOXBCx0FQKRGdSK0cJC/6bVKnGvDUzrYmHR6aeIdv16cNHHD7XsgWBV6tP
         mjb1hdM3/+73uih+W/pjkDIZ+UnoiQjI/EdfjJUx6a96ARBk+BLeHrR9OacxJVdwc7Vv
         7dUkdE9GYh8E4RlfMCCyMvKEZVjCecUp2aAIub+Gl+XIOw5XiirBnkReEdEjGFvxk809
         +6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=84gt/sK4j/+259WLeY5W9SpttA1mqKzaJ7iCIgGDeTA=;
        b=n3ONp35vykPnbfbBwUW4ZZwho4LTPhhUPYt+bJFJb8khSzPH3XuDeQ/eFpDktQ0H7C
         SokVjY3nBamrDk9djIEX4cjv0xjs7zt5a+MGTYMrO5w6QEIIQXknpX6INikRwjSkItxG
         h+fQdt/i5hDLpsfTOOjV76jS3VFoAJsiCBL7kkFBKjz+r9V1gWiFfUT01x8r0YTJwRlb
         IZRJetNOzGC3Azyiv/XKdbqqrtD5w5KTdszP1ElYkxA16xGtydr43ldbIU6kQ1C4pthX
         wtwDcZKx15XzuTATtqSMnS7wI+mOpUzJDx6wd7cYWbs0LViOGuqFcQnaQZj+XQc4nAxP
         mnnA==
X-Gm-Message-State: AOAM533niOcYq8Gymu5G+Fu25FClglTS4M8N8haha5/+nMevtsBkc0EF
        aMTFg6YnVtPt1GBuowfig9A=
X-Google-Smtp-Source: ABdhPJw+3om9w6tjoiF5XF101AhEZCnB3br7T3VAvwn9iuKXUhJmWkKphpy6CJoA6AtKAGA5eMRlUQ==
X-Received: by 2002:a05:620a:950:: with SMTP id w16mr1547553qkw.188.1618611914992;
        Fri, 16 Apr 2021 15:25:14 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id n15sm4790712qti.51.2021.04.16.15.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:25:14 -0700 (PDT)
Date:   Fri, 16 Apr 2021 19:26:08 -0300
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/6] w1: ds2438: fixed if brackets coding style issue
Message-ID: <20210416222608.z7mfxnxhfx2dgytq@LuizSampaio-PC.localdomain>
References: <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210409030942.441830-1-sampaio.ime@gmail.com>
 <20210409030942.441830-3-sampaio.ime@gmail.com>
 <67bacd4825f9c8f1abc225146888c5a50deb924c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67bacd4825f9c8f1abc225146888c5a50deb924c.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 07:40:57AM -0700, Joe Perches wrote:
> On Fri, 2021-04-09 at 00:09 -0300, Luiz Sampaio wrote:
> > Since there is only one statement inside the if clause, no brackets are
> > required.
> []
> > diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
> []
> > @@ -287,9 +287,9 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
> >  	if (!buf)
> >  		return -EINVAL;
> >  
> > 
> > -	if (w1_ds2438_get_current(sl, &voltage) == 0) {
> > +	if (w1_ds2438_get_current(sl, &voltage) == 0)
> >  		ret = snprintf(buf, count, "%i\n", voltage);
> > -	} else
> > +	else
> >  		ret = -EIO;
> >  
> > 
> >  	return ret;
> 
> to me this would look better using a style like the below:
> (and it might be better using sysfs_emit and not snprintf too)
> 
> ---
>  drivers/w1/slaves/w1_ds2438.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
> index 5cfb0ae23e91..9115c5a9bc4f 100644
> --- a/drivers/w1/slaves/w1_ds2438.c
> +++ b/drivers/w1/slaves/w1_ds2438.c
> @@ -279,7 +279,6 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
>  			loff_t off, size_t count)
>  {
>  	struct w1_slave *sl = kobj_to_w1_slave(kobj);
> -	int ret;
>  	int16_t voltage;
>  
>  	if (off != 0)
> @@ -287,12 +286,10 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
>  	if (!buf)
>  		return -EINVAL;
>  
> -	if (w1_ds2438_get_current(sl, &voltage) == 0) {
> -		ret = snprintf(buf, count, "%i\n", voltage);
> -	} else
> -		ret = -EIO;
> +	if (w1_ds2438_get_current(sl, &voltage))
> +		return -EIO;
>  
> -	return ret;
> +	return snprintf(buf, count, "%i\n", voltage);
>  }
>  
>  static ssize_t page0_read(struct file *filp, struct kobject *kobj,
> @@ -330,7 +327,6 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
>  				loff_t off, size_t count)
>  {
>  	struct w1_slave *sl = kobj_to_w1_slave(kobj);
> -	int ret;
>  	int16_t temp;
>  
>  	if (off != 0)
> @@ -338,12 +334,10 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
>  	if (!buf)
>  		return -EINVAL;
>  
> -	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
> -		ret = snprintf(buf, count, "%i\n", temp);
> -	} else
> -		ret = -EIO;
> +	if (w1_ds2438_get_temperature(sl, &temp))
> +		return -EIO;
>  
> -	return ret;
> +	return snprintf(buf, count, "%i\n", temp);
>  }
>  
>  static ssize_t vad_read(struct file *filp, struct kobject *kobj,
> @@ -351,7 +345,6 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
>  			loff_t off, size_t count)
>  {
>  	struct w1_slave *sl = kobj_to_w1_slave(kobj);
> -	int ret;
>  	uint16_t voltage;
>  
>  	if (off != 0)
> @@ -359,12 +352,10 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
>  	if (!buf)
>  		return -EINVAL;
>  
> -	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0) {
> -		ret = snprintf(buf, count, "%u\n", voltage);
> -	} else
> -		ret = -EIO;
> +	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage))
> +		return -EIO;
>  
> -	return ret;
> +	return snprintf(buf, count, "%u\n", voltage);
>  }
>  
>  static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
> @@ -372,7 +363,6 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
>  			loff_t off, size_t count)
>  {
>  	struct w1_slave *sl = kobj_to_w1_slave(kobj);
> -	int ret;
>  	uint16_t voltage;
>  
>  	if (off != 0)
> @@ -380,12 +370,10 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
>  	if (!buf)
>  		return -EINVAL;
>  
> -	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0) {
> -		ret = snprintf(buf, count, "%u\n", voltage);
> -	} else
> -		ret = -EIO;
> +	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage))
> +		return -EIO;
>  
> -	return ret;
> +	return snprintf(buf, count, "%u\n", voltage);
>  }
>  
>  static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
>

Sorry for the late reply! I agree, this would look nicer. I will wait for
the current revision and change this for the next one. 
