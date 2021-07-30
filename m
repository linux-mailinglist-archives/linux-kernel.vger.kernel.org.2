Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52973DC192
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhG3Xd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 19:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhG3Xdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:33:55 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CC7C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 16:33:49 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so11307053oti.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=IIqUaQVWCThJnO1XJXpsWQi9KUFPncSXoVIYf9fM5lI=;
        b=Y+9NIessVwsGP+Bqmrq/k4RftBpENsQscAOjCqXNlyKxiAeOOnsMRStCabUejO47Z4
         UlsP8TOvXWEJYuWw5UxvFWB5prflLMEGZybZsloxPTX+jDQljTkcsoVeH/Zca7zFX217
         kYRPvU0ru9lYgXvFrcfATt7fNNW/kVG6c+qEnFj4InVygVuMSVNze0hQXBvFnByZ8fVK
         Gl3mnKQ9XQ3Ak+SWvwDZJzdDBVG+BZT1uYs+kYT1N7EKFry/ADHpiXeuduMdrTXf4WMc
         Bxp/fVOwn1CabwiY2gsDI71FHoiECoHeCSKvbzaDBiZSQokNJPslKYnNY93HabW9H5MA
         OQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=IIqUaQVWCThJnO1XJXpsWQi9KUFPncSXoVIYf9fM5lI=;
        b=ZBlo6UxCCOCwI7hSUYDbo1bC2VSkBr2HOlZ2+/CGkIW8cf7bL1SMgu90XFt02HDn0T
         GIputCn/869DMvT2nuqG6Ity2h5Jk0n+BYJe5FfbLWsO0iVT9lIw8tfFmOox+7R6zdrA
         bY9+R3slR+hnOhBVbjdKoQdbwKcqL+Qfo+9r1J8Tq4V/WhNIZ/5N37DDk7UzAfqUo+u9
         LsvA/XfAQK0q+902kzDIpT6x/+prO+98QpTTvtMbztjSEFWiQ3/EYtevTTyW4Iy9yPij
         bW/xSidgUiGdDrqleernYmh0fOktx90tx0cJeY3NKJhytCwY2fbrqvFBu9uBNh66Za4f
         90QA==
X-Gm-Message-State: AOAM533a2hBispC1iGAzG9W4U815uzQRbcR1VBC4jyaLMd9Ox4IAWLgi
        MDUuS3rh4+kE1LUqlfN35Q==
X-Google-Smtp-Source: ABdhPJy1pUHowmEqvD5sFDIzhhNiRiaFIGnhHVKFWGZopVpMfA57gc9XySfkZCGfe3Wpqi4J/4WBOw==
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr3969717otq.190.1627688028396;
        Fri, 30 Jul 2021 16:33:48 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id t4sm526595oiw.19.2021.07.30.16.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 16:33:47 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:3c13:1718:6a7:97c2])
        by serve.minyard.net (Postfix) with ESMTPSA id C7212180058;
        Fri, 30 Jul 2021 23:33:46 +0000 (UTC)
Date:   Fri, 30 Jul 2021 18:33:45 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: Re: [PATCH] char: ipmi: use DEVICE_ATTR helper macro
Message-ID: <20210730233345.GF3406@minyard.net>
Reply-To: minyard@acm.org
References: <20210730062951.84876-1-dwaipayanray1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730062951.84876-1-dwaipayanray1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 11:59:51AM +0530, Dwaipayan Ray wrote:
> Instead of open coding DEVICE_ATTR, use the helper macro
> DEVICE_ATTR_RO to replace DEVICE_ATTR with 0444 octal
> permissions.

Looks good, this is queued for the next release.

-corey

> 
> This was detected as a part of checkpatch evaluation
> investigating all reports of DEVICE_ATTR_RO warning
> type.
> 
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 62929a3e397e..1cbc6a6a3ef4 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1605,7 +1605,7 @@ static ssize_t name##_show(struct device *dev,			\
>  									\
>  	return snprintf(buf, 10, "%u\n", smi_get_stat(smi_info, name));	\
>  }									\
> -static DEVICE_ATTR(name, 0444, name##_show, NULL)
> +static DEVICE_ATTR_RO(name)
>  
>  static ssize_t type_show(struct device *dev,
>  			 struct device_attribute *attr,
> @@ -1615,7 +1615,7 @@ static ssize_t type_show(struct device *dev,
>  
>  	return snprintf(buf, 10, "%s\n", si_to_str[smi_info->io.si_type]);
>  }
> -static DEVICE_ATTR(type, 0444, type_show, NULL);
> +static DEVICE_ATTR_RO(type);
>  
>  static ssize_t interrupts_enabled_show(struct device *dev,
>  				       struct device_attribute *attr,
> @@ -1626,8 +1626,7 @@ static ssize_t interrupts_enabled_show(struct device *dev,
>  
>  	return snprintf(buf, 10, "%d\n", enabled);
>  }
> -static DEVICE_ATTR(interrupts_enabled, 0444,
> -		   interrupts_enabled_show, NULL);
> +static DEVICE_ATTR_RO(interrupts_enabled);
>  
>  IPMI_SI_ATTR(short_timeouts);
>  IPMI_SI_ATTR(long_timeouts);
> @@ -1658,7 +1657,7 @@ static ssize_t params_show(struct device *dev,
>  			smi_info->io.irq,
>  			smi_info->io.slave_addr);
>  }
> -static DEVICE_ATTR(params, 0444, params_show, NULL);
> +static DEVICE_ATTR_RO(params);
>  
>  static struct attribute *ipmi_si_dev_attrs[] = {
>  	&dev_attr_type.attr,
> -- 
> 2.28.0
> 
