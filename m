Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D524360DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhJUL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhJUL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:57:18 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70547C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:54:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id d6so242605qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sko8uAJKVvY3azyAcApvw7U5YpmcilNG2F7HQLW8+ac=;
        b=i0iPPml+HlpEo9alX9gPvVwy2aYqSNrvJGce5VBfQ+2hfAwDRn09gnGujSQMvpO0k0
         E2flkhmHWbmASpLkkarQlX7LVeLUTw0MZi1sJWbO0iNQtY2EggP8NNTyvUpl7AdmoVuf
         IiarKH8AbtPx6nA8gUgxxC4Q20ZbRyic07iNwKsP08D0gvJYTpaj1XIri95u82fxLT2y
         1YDKTa5T5uYx5lh6QE9G2QWWSTOuSJLDtIHed0vXCggQTV1vIDEIerspGMRparDxyByR
         i5rPJ8Qb1X+oP/lN+0Fgpwsn1BqgYgxz/zSkhv7N1Mw9RcIdNAy0y9nnunoyyf0nZ3YG
         +ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=Sko8uAJKVvY3azyAcApvw7U5YpmcilNG2F7HQLW8+ac=;
        b=E8QqBAaQDoQPGUMJ08lRO+UF6KP00Rkkrlej+jEH0tJS1zpbVJWkfDpqlZ46Dbv5QF
         +IXL6rKPlHRYu9F+Hv21evgRR81kK3MRGZeD2jTsrX7YFoAf5e0qG9BF2/IQuCiGDK0V
         Sv0CGUE4DRV5DNrZEyKuzWYE5TzWnDl9oGDhC2FPYgZTmFRIEV6FvXEEuQi8waGkKUX1
         3zGwdRISldPvJhAOhhcHvvMhojS2Cc+23Tz6/CwIG2IiSSLbZ15EC/TFcMI9K8rH6kiU
         D/efA+E4yZeQnJbjW0B03b25uvgldE5bYQpu8YB4EzaSfq/wYJNDq30UBJLVu3FryIrX
         uAtA==
X-Gm-Message-State: AOAM532AiSn0FaKaNKZVHxtGiBLdC/TLTy2ap5bEe+E3HnKq7KtqJLWC
        xS6gj/NgQGVqAsohnr2C4jDcB+gmCw==
X-Google-Smtp-Source: ABdhPJxIEGOOrzAHJSb0WzY9386aKHFadtil47unHy09w4peuSJdqZboPKP5fcyQWa6nx14DKZUn0g==
X-Received: by 2002:a05:6214:87:: with SMTP id n7mr1307319qvr.55.1634817298451;
        Thu, 21 Oct 2021 04:54:58 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id x16sm2296939qtp.56.2021.10.21.04.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:54:57 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:b816:2692:1867:c58b])
        by serve.minyard.net (Postfix) with ESMTPSA id B8D2A180053;
        Thu, 21 Oct 2021 11:54:56 +0000 (UTC)
Date:   Thu, 21 Oct 2021 06:54:55 -0500
From:   Corey Minyard <minyard@acm.org>
To:     cgel.zte@gmail.com
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] char: ipmi: replace snprintf in show functions with
 sysfs_emit
Message-ID: <20211021115455.GW66936@minyard.net>
Reply-To: minyard@acm.org
References: <20211021110608.1060260-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021110608.1060260-1-ye.guojin@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 11:06:08AM +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING  use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
> sense.

Yes, I agree.  It's in my queue.

Thanks,

-corey

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 20 ++++++++++----------
>  drivers/char/ipmi/ipmi_si_intf.c    |  8 ++++----
>  drivers/char/ipmi/ipmi_ssif.c       |  4 ++--
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index a60201d3f735..deed355422f4 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -2716,7 +2716,7 @@ static ssize_t device_id_show(struct device *dev,
>  	if (rv)
>  		return rv;
>  
> -	return snprintf(buf, 10, "%u\n", id.device_id);
> +	return sysfs_emit(buf, "%u\n", id.device_id);
>  }
>  static DEVICE_ATTR_RO(device_id);
>  
> @@ -2732,7 +2732,7 @@ static ssize_t provides_device_sdrs_show(struct device *dev,
>  	if (rv)
>  		return rv;
>  
> -	return snprintf(buf, 10, "%u\n", (id.device_revision & 0x80) >> 7);
> +	return sysfs_emit(buf, "%u\n", (id.device_revision & 0x80) >> 7);
>  }
>  static DEVICE_ATTR_RO(provides_device_sdrs);
>  
> @@ -2747,7 +2747,7 @@ static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
>  	if (rv)
>  		return rv;
>  
> -	return snprintf(buf, 20, "%u\n", id.device_revision & 0x0F);
> +	return sysfs_emit(buf, "%u\n", id.device_revision & 0x0F);
>  }
>  static DEVICE_ATTR_RO(revision);
>  
> @@ -2763,7 +2763,7 @@ static ssize_t firmware_revision_show(struct device *dev,
>  	if (rv)
>  		return rv;
>  
> -	return snprintf(buf, 20, "%u.%x\n", id.firmware_revision_1,
> +	return sysfs_emit(buf, "%u.%x\n", id.firmware_revision_1,
>  			id.firmware_revision_2);
>  }
>  static DEVICE_ATTR_RO(firmware_revision);
> @@ -2780,7 +2780,7 @@ static ssize_t ipmi_version_show(struct device *dev,
>  	if (rv)
>  		return rv;
>  
> -	return snprintf(buf, 20, "%u.%u\n",
> +	return sysfs_emit(buf, "%u.%u\n",
>  			ipmi_version_major(&id),
>  			ipmi_version_minor(&id));
>  }
> @@ -2798,7 +2798,7 @@ static ssize_t add_dev_support_show(struct device *dev,
>  	if (rv)
>  		return rv;
>  
> -	return snprintf(buf, 10, "0x%02x\n", id.additional_device_support);
> +	return sysfs_emit(buf, "0x%02x\n", id.additional_device_support);
>  }
>  static DEVICE_ATTR(additional_device_support, S_IRUGO, add_dev_support_show,
>  		   NULL);
> @@ -2815,7 +2815,7 @@ static ssize_t manufacturer_id_show(struct device *dev,
>  	if (rv)
>  		return rv;
>  
> -	return snprintf(buf, 20, "0x%6.6x\n", id.manufacturer_id);
> +	return sysfs_emit(buf, "0x%6.6x\n", id.manufacturer_id);
>  }
>  static DEVICE_ATTR_RO(manufacturer_id);
>  
> @@ -2831,7 +2831,7 @@ static ssize_t product_id_show(struct device *dev,
>  	if (rv)
>  		return rv;
>  
> -	return snprintf(buf, 10, "0x%4.4x\n", id.product_id);
> +	return sysfs_emit(buf, "0x%4.4x\n", id.product_id);
>  }
>  static DEVICE_ATTR_RO(product_id);
>  
> @@ -2847,7 +2847,7 @@ static ssize_t aux_firmware_rev_show(struct device *dev,
>  	if (rv)
>  		return rv;
>  
> -	return snprintf(buf, 21, "0x%02x 0x%02x 0x%02x 0x%02x\n",
> +	return sysfs_emit(buf, "0x%02x 0x%02x 0x%02x 0x%02x\n",
>  			id.aux_firmware_revision[3],
>  			id.aux_firmware_revision[2],
>  			id.aux_firmware_revision[1],
> @@ -2869,7 +2869,7 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
>  	if (!guid_set)
>  		return -ENOENT;
>  
> -	return snprintf(buf, UUID_STRING_LEN + 1 + 1, "%pUl\n", &guid);
> +	return sysfs_emit(buf, "%pUl\n", &guid);
>  }
>  static DEVICE_ATTR_RO(guid);
>  
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 6f3272b58ced..64dedb3ef8ec 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1603,7 +1603,7 @@ static ssize_t name##_show(struct device *dev,			\
>  {									\
>  	struct smi_info *smi_info = dev_get_drvdata(dev);		\
>  									\
> -	return snprintf(buf, 10, "%u\n", smi_get_stat(smi_info, name));	\
> +	return sysfs_emit(buf, "%u\n", smi_get_stat(smi_info, name));	\
>  }									\
>  static DEVICE_ATTR_RO(name)
>  
> @@ -1613,7 +1613,7 @@ static ssize_t type_show(struct device *dev,
>  {
>  	struct smi_info *smi_info = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, 10, "%s\n", si_to_str[smi_info->io.si_type]);
> +	return sysfs_emit(buf, "%s\n", si_to_str[smi_info->io.si_type]);
>  }
>  static DEVICE_ATTR_RO(type);
>  
> @@ -1624,7 +1624,7 @@ static ssize_t interrupts_enabled_show(struct device *dev,
>  	struct smi_info *smi_info = dev_get_drvdata(dev);
>  	int enabled = smi_info->io.irq && !smi_info->interrupt_disabled;
>  
> -	return snprintf(buf, 10, "%d\n", enabled);
> +	return sysfs_emit(buf, "%d\n", enabled);
>  }
>  static DEVICE_ATTR_RO(interrupts_enabled);
>  
> @@ -1646,7 +1646,7 @@ static ssize_t params_show(struct device *dev,
>  {
>  	struct smi_info *smi_info = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, 200,
> +	return sysfs_emit(buf,
>  			"%s,%s,0x%lx,rsp=%d,rsi=%d,rsh=%d,irq=%d,ipmb=%d\n",
>  			si_to_str[smi_info->io.si_type],
>  			addr_space_to_str[smi_info->io.addr_space],
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 20d5af92966d..0c62e578749e 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1190,7 +1190,7 @@ static ssize_t ipmi_##name##_show(struct device *dev,			\
>  {									\
>  	struct ssif_info *ssif_info = dev_get_drvdata(dev);		\
>  									\
> -	return snprintf(buf, 10, "%u\n", ssif_get_stat(ssif_info, name));\
> +	return sysfs_emit(buf, "%u\n", ssif_get_stat(ssif_info, name));\
>  }									\
>  static DEVICE_ATTR(name, S_IRUGO, ipmi_##name##_show, NULL)
>  
> @@ -1198,7 +1198,7 @@ static ssize_t ipmi_type_show(struct device *dev,
>  			      struct device_attribute *attr,
>  			      char *buf)
>  {
> -	return snprintf(buf, 10, "ssif\n");
> +	return sysfs_emit(buf, "ssif\n");
>  }
>  static DEVICE_ATTR(type, S_IRUGO, ipmi_type_show, NULL);
>  
> -- 
> 2.25.1
> 
