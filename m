Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8F328265
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbhCAPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhCAPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:24:30 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081FEC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:23:50 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id s23so4015423oot.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 07:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zLRiotorNgODtDczOZ0iNSSFs1Gejj1kj1CcN2zNn84=;
        b=QU73XM3X8IDYcmxx90iCfLY9YxgupK64FI6pigTuAiWDsELid4fNOces4PQkxkxtp8
         wITTnYCRYn3i5/FAnNrKa71eH5CAniuejvYkqKB/qE3stdA1gAjUIl1CsVBPlCC1YFku
         nVvJ0dy5Gm/74z0dpqXi6GgQR2WIvxNEx8SDtfHP3r2upB8wKEtVsHBl9MzXxzpGJhnZ
         qp5YUJ/wgS+WN7fEAmQKKNe0XR7K+hTbW2GNoL7EUDMrY0V1Z/08mPIpadogXcZSfCsO
         TNwQyPkrYkeovB25Uak1A/zZD4okPwAZbPi6fZumtXaG7JTKaRKBN+Qxk5H6A5c96sXE
         dOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=zLRiotorNgODtDczOZ0iNSSFs1Gejj1kj1CcN2zNn84=;
        b=QBo709Hx8mP9/R/z3VC8xVEJrithFk3BbuTLgdz54poO7EK/6+/OoEb9cQSOXgzz3H
         oJlLrwcR1yGXAXqNNB/j2U13NolRRBsNYFf4FgBdhMIuqDNMjuY88TOVlAAeX6p3wZ9s
         MXvjysW3n+IrcsaiqGMqMlz4r4BV7U14DhNAtBKHZ2ihIi3Sfij26qpjZAb7G6f8dJdZ
         2xcMnjcNvzP2rnrHtRRQoVVhHu4tEwGDNCUS3sOlSNxDzeWl5OYFAWGM3haZc6OdhnH5
         ayWzzjfkb1zkRt1iiCB6+Ca1COMNLVMMW42BzHrlGeeSPmzhYsdJLDV/IZ5xHuoVwOuk
         Upzw==
X-Gm-Message-State: AOAM532iAarsA28QEUg0T9PfR6zBJwSoLbYlEtvcB9pGQexK5HsSZowM
        Zx0q3j4LZwA7yETCtInOgk8hxWKXog==
X-Google-Smtp-Source: ABdhPJzjTLQqvNd6iK0LOi+tng/XkcMkbFQBe36o8UAsc1lmbxczqYzNQPVMhaGiL7qkXGpv/MjdCA==
X-Received: by 2002:a4a:c706:: with SMTP id n6mr13091254ooq.19.1614612229322;
        Mon, 01 Mar 2021 07:23:49 -0800 (PST)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id q131sm3141333oic.45.2021.03.01.07.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 07:23:48 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:dd2:7224:e6c:fce5])
        by serve.minyard.net (Postfix) with ESMTPSA id 14BBB180059;
        Mon,  1 Mar 2021 15:23:48 +0000 (UTC)
Date:   Mon, 1 Mar 2021 09:23:46 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: make ssif_i2c_send() void
Message-ID: <20210301152346.GD507977@minyard.net>
Reply-To: minyard@acm.org
References: <20210301140515.18951-1-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301140515.18951-1-zhangliguang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks ok, it's queued for 5.12.

Thanks,

-corey

On Mon, Mar 01, 2021 at 10:05:15PM +0800, Liguang Zhang wrote:
> This function actually needs no return value. So remove the unneeded
> check and make it void.
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 81 +++++++++--------------------------
>  1 file changed, 20 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 0416b9c9d410..20d5af92966d 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -510,7 +510,7 @@ static int ipmi_ssif_thread(void *data)
>  	return 0;
>  }
>  
> -static int ssif_i2c_send(struct ssif_info *ssif_info,
> +static void ssif_i2c_send(struct ssif_info *ssif_info,
>  			ssif_i2c_done handler,
>  			int read_write, int command,
>  			unsigned char *data, unsigned int size)
> @@ -522,7 +522,6 @@ static int ssif_i2c_send(struct ssif_info *ssif_info,
>  	ssif_info->i2c_data = data;
>  	ssif_info->i2c_size = size;
>  	complete(&ssif_info->wake_thread);
> -	return 0;
>  }
>  
>  
> @@ -531,22 +530,12 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  
>  static void start_get(struct ssif_info *ssif_info)
>  {
> -	int rv;
> -
>  	ssif_info->rtc_us_timer = 0;
>  	ssif_info->multi_pos = 0;
>  
> -	rv = ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
> -			  SSIF_IPMI_RESPONSE,
> -			  ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
> -	if (rv < 0) {
> -		/* request failed, just return the error. */
> -		if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
> -			dev_dbg(&ssif_info->client->dev,
> -				"Error from i2c_non_blocking_op(5)\n");
> -
> -		msg_done_handler(ssif_info, -EIO, NULL, 0);
> -	}
> +	ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
> +		  SSIF_IPMI_RESPONSE,
> +		  ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
>  }
>  
>  static void retry_timeout(struct timer_list *t)
> @@ -620,7 +609,6 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  {
>  	struct ipmi_smi_msg *msg;
>  	unsigned long oflags, *flags;
> -	int rv;
>  
>  	/*
>  	 * We are single-threaded here, so no need for a lock until we
> @@ -666,17 +654,10 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  		ssif_info->multi_len = len;
>  		ssif_info->multi_pos = 1;
>  
> -		rv = ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
> -				  SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
> -				  ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
> -		if (rv < 0) {
> -			if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
> -				dev_dbg(&ssif_info->client->dev,
> -					"Error from i2c_non_blocking_op(1)\n");
> -
> -			result = -EIO;
> -		} else
> -			return;
> +		ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
> +			 SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
> +			 ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
> +		return;
>  	} else if (ssif_info->multi_pos) {
>  		/* Middle of multi-part read.  Start the next transaction. */
>  		int i;
> @@ -738,19 +719,12 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  
>  			ssif_info->multi_pos++;
>  
> -			rv = ssif_i2c_send(ssif_info, msg_done_handler,
> -					   I2C_SMBUS_READ,
> -					   SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
> -					   ssif_info->recv,
> -					   I2C_SMBUS_BLOCK_DATA);
> -			if (rv < 0) {
> -				if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
> -					dev_dbg(&ssif_info->client->dev,
> -						"Error from ssif_i2c_send\n");
> -
> -				result = -EIO;
> -			} else
> -				return;
> +			ssif_i2c_send(ssif_info, msg_done_handler,
> +				  I2C_SMBUS_READ,
> +				  SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
> +				  ssif_info->recv,
> +				  I2C_SMBUS_BLOCK_DATA);
> +			return;
>  		}
>  	}
>  
> @@ -908,8 +882,6 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  static void msg_written_handler(struct ssif_info *ssif_info, int result,
>  				unsigned char *data, unsigned int len)
>  {
> -	int rv;
> -
>  	/* We are single-threaded here, so no need for a lock. */
>  	if (result < 0) {
>  		ssif_info->retries_left--;
> @@ -972,18 +944,9 @@ static void msg_written_handler(struct ssif_info *ssif_info, int result,
>  			ssif_info->multi_data = NULL;
>  		}
>  
> -		rv = ssif_i2c_send(ssif_info, msg_written_handler,
> -				   I2C_SMBUS_WRITE, cmd,
> -				   data_to_send, I2C_SMBUS_BLOCK_DATA);
> -		if (rv < 0) {
> -			/* request failed, just return the error. */
> -			ssif_inc_stat(ssif_info, send_errors);
> -
> -			if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
> -				dev_dbg(&ssif_info->client->dev,
> -					"Error from i2c_non_blocking_op(3)\n");
> -			msg_done_handler(ssif_info, -EIO, NULL, 0);
> -		}
> +		ssif_i2c_send(ssif_info, msg_written_handler,
> +			  I2C_SMBUS_WRITE, cmd,
> +			  data_to_send, I2C_SMBUS_BLOCK_DATA);
>  	} else {
>  		/* Ready to request the result. */
>  		unsigned long oflags, *flags;
> @@ -1012,7 +975,6 @@ static void msg_written_handler(struct ssif_info *ssif_info, int result,
>  
>  static int start_resend(struct ssif_info *ssif_info)
>  {
> -	int rv;
>  	int command;
>  
>  	ssif_info->got_alert = false;
> @@ -1034,12 +996,9 @@ static int start_resend(struct ssif_info *ssif_info)
>  		ssif_info->data[0] = ssif_info->data_len;
>  	}
>  
> -	rv = ssif_i2c_send(ssif_info, msg_written_handler, I2C_SMBUS_WRITE,
> -			  command, ssif_info->data, I2C_SMBUS_BLOCK_DATA);
> -	if (rv && (ssif_info->ssif_debug & SSIF_DEBUG_MSG))
> -		dev_dbg(&ssif_info->client->dev,
> -			"Error from i2c_non_blocking_op(4)\n");
> -	return rv;
> +	ssif_i2c_send(ssif_info, msg_written_handler, I2C_SMBUS_WRITE,
> +		   command, ssif_info->data, I2C_SMBUS_BLOCK_DATA);
> +	return 0;
>  }
>  
>  static int start_send(struct ssif_info *ssif_info,
> -- 
> 2.19.1.6.gb485710b
> 
