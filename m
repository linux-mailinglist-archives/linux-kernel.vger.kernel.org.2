Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F16B41FB29
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhJBLmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 07:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhJBLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 07:42:15 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F8C061570;
        Sat,  2 Oct 2021 04:40:30 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so14927642otv.4;
        Sat, 02 Oct 2021 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mRYDN/7Zfb/X9+GCqkJ1Pbz/tDxT8mhcTJ+jdVvwAf0=;
        b=Half5KMIBST7AJ6wUUnVDBlMdou8hLEI6sp0XMK/6/5jsoNvL0GHadrmiyMME1DlOQ
         CVN9L1i1vTwPOUTGWx8T8E41nkBb+rGQ8TF/b36xft628GtZbDWNRxxASjpMuYAfaFpN
         325fjEdfkrv9vqAd45URrOVsLRSGOPgPWMi3RM48EjzubHg6TZy9XlolhJquCm2BD8Cl
         4c9hXUR6fYLTOmQ7LAyRNhdNlXUQKBnd/Y/ApNTEiXoCnLb7QGJNcv5o2IRwJPcFFn9Q
         Xn7t7UrBpNr6BdStaYpOoxEPmVkz8lIbHXv2vCor19BawJG4b46YddGzb0YT1vC6hXno
         g8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mRYDN/7Zfb/X9+GCqkJ1Pbz/tDxT8mhcTJ+jdVvwAf0=;
        b=JNDB4cWHMVDWIKWY2Z0UDBePsKnXHw/UmQiyBehfRwuqpCMZYKKiBcDfSEtRz76Bg5
         OTb6NrwPmpM8FaLH8XvYyb9VPNqvawLE9e1q/5/WRTNEjqMJ4us2Q1j4OkuSeXcxJ4n0
         UiqqAs0H98a9icY0KsGsEdkREzVyQ2nPcHsApW68Dd9Dzzz62gmYM54VexZqnJOsMNTB
         1gGrcQF3DlTmvuw+pMq6qhRoyEiRR5u9VQa/ppDWdOlElvv4dMlxkx0LSD4rAgaluKte
         q8eM6Zqu5/UhHsKpDdBovFADFQ3My+ZNhxAoLQjJC4U3dvn61cU8Tytwnpjn+PqcA/QQ
         OTog==
X-Gm-Message-State: AOAM532n1TvlJkCM0JXdWHK8zgP6OC+FiOy7my9FOG6QmMgdJMvaYIpq
        lGpDe3w9n7IAonCmJgtvsAc=
X-Google-Smtp-Source: ABdhPJx6iIjnTcIW6+ptJYdtsqGBA4AciBxjGFBcibkzWzB3lC/j4q7mlhYTQi6s8Ff/qDI5Ef1BNg==
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr2296505otp.143.1633174829483;
        Sat, 02 Oct 2021 04:40:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17sm1612077ois.45.2021.10.02.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 04:40:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Oct 2021 04:40:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brandon Wyman <bjwyman@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v2] hwmon: (pmbus/ibm-cffps) max_power_out swap changes
Message-ID: <20211002114027.GA1012283@roeck-us.net>
References: <20210928205051.1222815-1-bjwyman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928205051.1222815-1-bjwyman@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:50:51PM +0000, Brandon Wyman wrote:
> The bytes for max_power_out from the ibm-cffps devices differ in byte
> order for some power supplies.
> 
> The Witherspoon power supply returns the bytes in MSB/LSB order.
> 
> The Rainier power supply returns the bytes in LSB/MSB order.
> 
> The Witherspoon power supply uses version cffps1. The Rainier power
> supply should use version cffps2. If version is cffps1, swap the bytes
> before output to max_power_out.
> 
> Tested:
>     Witherspoon before: 3148. Witherspoon after: 3148.
>     Rainier before: 53255. Rainier after: 2000.
> 
> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

Applied, though ...

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index df712ce4b164..79bfcd2749a6 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -171,8 +171,14 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
>  		cmd = CFFPS_SN_CMD;
>  		break;
>  	case CFFPS_DEBUGFS_MAX_POWER_OUT:
> -		rc = i2c_smbus_read_word_swapped(psu->client,
> -						 CFFPS_MAX_POWER_OUT_CMD);
> +		if (cffps1 == psu->version) {

The yoda programming replaced I did.

> +			rc = i2c_smbus_read_word_swapped(psu->client,
> +					CFFPS_MAX_POWER_OUT_CMD);
> +		} else {
> +			rc = i2c_smbus_read_word_data(psu->client,
> +					CFFPS_MAX_POWER_OUT_CMD);
> +		}
> +
>  		if (rc < 0)
>  			return rc;
>  
