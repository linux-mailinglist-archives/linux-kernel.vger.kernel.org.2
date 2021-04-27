Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9D36C794
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhD0OMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbhD0OMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:12:51 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552FAC061574;
        Tue, 27 Apr 2021 07:12:08 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id z20-20020a0568301294b02902a52ecbaf18so3038724otp.8;
        Tue, 27 Apr 2021 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XLT1mo/InG76G8mlISQZZDx4FzF1V0+oVDkJE1QMpeQ=;
        b=tdVmYvD3xQ7+Ma3C002cTOY1Rwixl55f9GePtnwe1FXV8PYybrCqQXSYswXtrwGZ7Q
         BhA9DKIIWr9xkdA5Ik8MdDpFg8ILHsSkkhIpD397T6ZtEudALi7tYtIjn7RyU47uyn3h
         c9c0wwq1i8liYObem1KB+OBawQQtvsFve55sK2snIa3BxkzHJcPBuletKtf+CB9Po6vT
         T/af0RzeLaEsZrJWvx0RtsWCmwZe/b3T9cH7lPDk3WQHnIdg75YkdOn0dREX/Jmfib8x
         N8r5rMU0oEZ5BxWlQ6ocgW/SxKmgrgNo+/tpiQMPTBKQgGnyXCbmkEUGOqB0wcF6IKku
         Bitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XLT1mo/InG76G8mlISQZZDx4FzF1V0+oVDkJE1QMpeQ=;
        b=SNV9xcyOBpFjcckpzl6JoGWFtZAJTkho60G197hbiNPzEVAB9tsRO4TvknXhSNYSjt
         M8i6kzxWITsHZxc15zSWL/w4Od10VNfuxVjpQ1nSBhHjBhWLx3gZ7Jaz52VgZwHGv2Xw
         qXL4NqtpfXkGdsHBgoRZS/aq23WZW5/1fNYuwYBE5FJbZXCwMF3wjedMr6y2Jv3MZeBb
         4OxEC2PHX+PSYVLvYEp7TGutbPdAv07eJzIk0lR+yAGWVN0H+pbrHmhiZpNn0YHH84fR
         4PrjKxcrh0vV2ZlwTsh67MXnrviVcMQhx0McxWGyJrmyT9vxg3Nep+4tnmISfKjX8IDE
         p8oA==
X-Gm-Message-State: AOAM531Ru73cPdC3yhOELK9hMKpW/lzGt/UrVDnVw9ycX9Zn7STE762D
        Ix1fXsqwjHa7l6pHRuoSYrY=
X-Google-Smtp-Source: ABdhPJwIxrDxoa4HH5wOFb/a6cPp10+6EkPUqoeQsCngJvHCHK8+zkULSa8qKKd9R3cZui9sXOqe7g==
X-Received: by 2002:a9d:7e95:: with SMTP id m21mr20425769otp.76.1619532727728;
        Tue, 27 Apr 2021 07:12:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y5sm2905oig.18.2021.04.27.07.12.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 07:12:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Apr 2021 07:12:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix FSP-3Y YH-5151E non-compliant vout encoding
Message-ID: <20210427141205.GA202505@roeck-us.net>
References: <20210427135807.2414331-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210427135807.2414331-1-kubernat@cesnet.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:58:06PM +0200, Václav Kubernát wrote:
> I didn't properly test the driver for the PDU, so it was completely
> broken. Firstly, the log/real mapping was incorrect in one case.
> Secondly, PMBus specifies that output voltages should be in the linear16
> encoding. However, the PDU is non-compliant and uses linear11. The PSU

It would be better to refer to YH5151E and YM2151; the reader won't know
how PSU and PDU map to the to the two power supplies supported by the
driver (and I don't know either).

> isn't affected by this.
> 
> pmbus_core didn't allow forcing linear11 format for output voltages, so
> I added a way to force that.
> 

Please don't do that. The driver should convert the linear11 values
to linear16 for the affected device(s) in fsp3y_read_word_data().

Thanks,
Guenter

> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
> ---
>  drivers/hwmon/pmbus/fsp-3y.c     | 3 ++-
>  drivers/hwmon/pmbus/pmbus.h      | 6 +++++-
>  drivers/hwmon/pmbus/pmbus_core.c | 3 ++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
> index 564649e87e34..b4ea1e63272e 100644
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
> @@ -164,6 +164,7 @@ struct pmbus_driver_info fsp3y_info[] = {
>  	},
>  	[yh5151e] = {
>  		.pages = 3,
> +		.format[PSC_VOLTAGE_OUT] = force_linear11,
>  		.func[YH5151E_PAGE_12V_LOG] =
>  			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
>  			PMBUS_HAVE_POUT  |
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 4c30ec89f5bf..4d79a43fc965 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -405,7 +405,11 @@ enum pmbus_sensor_classes {
>  #define PMBUS_PHASE_VIRTUAL	BIT(30)	/* Phases on this page are virtual */
>  #define PMBUS_PAGE_VIRTUAL	BIT(31)	/* Page is virtual */
>  
> -enum pmbus_data_format { linear = 0, direct, vid };
> +/*
> + * force_linear11 is for non-compliant devices that output VOUT in linear11
> + * instead of linear16.
> + */
> +enum pmbus_data_format { linear = 0, force_linear11, direct, vid };
>  enum vrm_version { vr11 = 0, vr12, vr13, imvp9, amd625mv };
>  
>  struct pmbus_driver_info {
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 192442b3b7a2..45a0d0303c19 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -589,7 +589,8 @@ static s64 pmbus_reg2data_linear(struct pmbus_data *data,
>  	s32 mantissa;
>  	s64 val;
>  
> -	if (sensor->class == PSC_VOLTAGE_OUT) {	/* LINEAR16 */
> +	if (sensor->class == PSC_VOLTAGE_OUT &&	/* LINEAR16 */
> +	    data->info->format[sensor->class] != force_linear11) {
>  		exponent = data->exponent[sensor->page];
>  		mantissa = (u16) sensor->data;
>  	} else {				/* LINEAR11 */
> -- 
> 2.31.1
> 
