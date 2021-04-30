Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D179536F37D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 03:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhD3B0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 21:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhD3B0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 21:26:13 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6690BC06138B;
        Thu, 29 Apr 2021 18:25:24 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so15118844oop.12;
        Thu, 29 Apr 2021 18:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nbTHcZJzZN3m9gPe+IpvTYL1YKm/APBhjXY2rbCV2bI=;
        b=DwoiYVNvGcEQzPcp2cdVAKnvyQuSZD6NPzpz9aBulE2IU1gYxio4+RhJ1Jud2Fsiqo
         VvH9j6v6TM/2/uBBOmPttfKFFiF5FbbA+62nlydnTeHUjzErw7CNanwYAUeltGpTwrlO
         2FkidBsJ6I3WzFK4lhOPpFhKbpY184WMVSMSnSxF/eMcDC68aXDDpv5gGAAzA/YwDbxg
         zCX7Dx6ADHnyeWpYoFZ3BCzgKKeLTf5A1EhXv0S7hQyrYZ/F/0IOW2XV1WiR+fW04e3A
         ok5LjlAfBCTzdKdkUB9gk/J+KfL08ExUVZ6XfMy5XSOwUkMEFtBb7yvYBNSNfkLqfUM3
         yG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nbTHcZJzZN3m9gPe+IpvTYL1YKm/APBhjXY2rbCV2bI=;
        b=ejSNX7/nY7ynCJEomxrbEWjvf2J0C2/sZhKfFxgyOlp0sG2SzfahvflBJW3XcdcQQK
         mEt195HiON4oXEARCPrKcRUIqUec3cmntGYnvau/vHURG01DGMEjjh5prTIUGptdjHlt
         TymKaRsAHnbhCo6aQGiF1OGlDnwihrn4mGsdJhhVNo2SJuVkHRGevwfF5PsbK0MmMxcp
         hXAsMbjLn6pEDp9EcIfqkRqq7dl94X2oUqKBdEL3TwKflpfbgh5XDPjc3xGZCDaD5fQ5
         QBEJVDW2hjvpa9H1Z1amwwfVvdAM4LRR5FFgUa4dMBhRmFrk+B/xhGxnOnTtUJ58t6Fu
         llyg==
X-Gm-Message-State: AOAM5301Hbi8//9D1c7rB7q5cOgZ8A97QVOPiFzFFLzqkF4FCkuOU0+D
        ksc5YTV8zcccAMkwqhwphig=
X-Google-Smtp-Source: ABdhPJxHVRDDusIK5pFQQPwZrEVBKdXC02pdwqYPleRHsmB2am89DxO41S2Nw7wtPJEXbhz9IXr9eg==
X-Received: by 2002:a4a:e748:: with SMTP id n8mr2264006oov.61.1619745923843;
        Thu, 29 Apr 2021 18:25:23 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d6sm395892oom.33.2021.04.29.18.25.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Apr 2021 18:25:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Apr 2021 18:25:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Fix FSP-3Y YH-5151E non-compliant vout encoding
Message-ID: <20210430012522.GA186554@roeck-us.net>
References: <20210429075337.110502-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210429075337.110502-1-kubernat@cesnet.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 09:53:38AM +0200, Václav Kubernát wrote:
> I didn't properly test the driver for YH-5151E, so it was completely
> broken. Firstly, the log/real mapping was incorrect in one case.
> Secondly, PMBus specifies that output voltages should be in the linear16
> encoding. However, the YH-5151E is non-compliant and uses linear11.
> YM-2151E isn't affected by this. Fix this by converting the values
> inside the read functions. linear16 gets the exponent from the VOUT_MODE
> command. The device doesn't support it, so I have to manually supply the
> value for it.
> 
> Both supported devices have now been tested to report correct vout
> values.
> 
> Fixes: 1734b4135a62 ("hwmon: Add driver for fsp-3y PSUs and PDUs")
> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/fsp-3y.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
> index 564649e87e34..655690dde4d7 100644
> --- a/drivers/hwmon/pmbus/fsp-3y.c
> +++ b/drivers/hwmon/pmbus/fsp-3y.c
> @@ -57,7 +57,7 @@ static int page_log_to_page_real(int page_log, enum chips chip)
>  		case YH5151E_PAGE_12V_LOG:
>  			return YH5151E_PAGE_12V_REAL;
>  		case YH5151E_PAGE_5V_LOG:
> -			return YH5151E_PAGE_5V_LOG;
> +			return YH5151E_PAGE_5V_REAL;
>  		case YH5151E_PAGE_3V3_LOG:
>  			return YH5151E_PAGE_3V3_REAL;
>  		}
> @@ -103,8 +103,18 @@ static int set_page(struct i2c_client *client, int page_log)
>  
>  static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
>  {
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct fsp3y_data *data = to_fsp3y_data(info);
>  	int rv;
>  
> +	/*
> +	 * YH5151-E outputs vout in linear11. The conversion is done when
> +	 * reading. Here, we have to inject pmbus_core with the correct
> +	 * exponent (it is -6).
> +	 */
> +	if (data->chip == yh5151e && reg == PMBUS_VOUT_MODE)
> +		return 0x1A;
> +
>  	rv = set_page(client, page);
>  	if (rv < 0)
>  		return rv;
> @@ -114,6 +124,8 @@ static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
>  
>  static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>  {
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct fsp3y_data *data = to_fsp3y_data(info);
>  	int rv;
>  
>  	/*
> @@ -144,7 +156,18 @@ static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase,
>  	if (rv < 0)
>  		return rv;
>  
> -	return i2c_smbus_read_word_data(client, reg);
> +	rv = i2c_smbus_read_word_data(client, reg);
> +	if (rv < 0)
> +		return rv;
> +
> +	/*
> +	 * YH-5151E is non-compliant and outputs output voltages in linear11
> +	 * instead of linear16.
> +	 */
> +	if (data->chip == yh5151e && reg == PMBUS_READ_VOUT)
> +		rv = sign_extend32(rv, 10) & 0xffff;
> +
> +	return rv;
>  }
>  
>  struct pmbus_driver_info fsp3y_info[] = {
