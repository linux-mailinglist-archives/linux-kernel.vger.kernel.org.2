Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD638426C89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhJHOMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbhJHOMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:12:24 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F7C06176A;
        Fri,  8 Oct 2021 07:10:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id y207so10759702oia.11;
        Fri, 08 Oct 2021 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IiXYxUUmxX5fc/N+2AGbIuVJDEoKxiawErZ9srHj0jo=;
        b=c7i9TclqOXC9NQVa/0QKM57Q5QT8fIu2Uv6j4jzQtqYYYbXGO5S2+Mi2nhcO2FrGFz
         a0J77gQXvctEdjS9lqpR1Je3tH+8RCIQvEGk7/QX7qwu9flkFoBepGIbW41dwUO8QV4v
         b1RsXy7mUJOhtan+juYoPJcgW9cvyrktgGHgL3Unx/KE9I4wlHW4JzQOyaRkkbvKBIDE
         GN2x2Cto3WauKEYvajTIvmhXinClt2A5hRoFM1WsOrsNrHhuqYy+K61FpUhKZmvpEl88
         oAoo/KmKydPub5dJNYlaD+WhNG6nDsBhswNmKCtpbPbqNxG3G1W66Xb9GXxHzwUZ6C32
         k4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IiXYxUUmxX5fc/N+2AGbIuVJDEoKxiawErZ9srHj0jo=;
        b=hj23Gdbzcx1UKFntZtIAhKrzNoJHcDMYobpec0gC9hpxzJ8cUHzipE+xBjaKyxtxo+
         wS2tr6K2nmCdEaJVFBlrssHHBGcYe7vfbSP/OtgifNmTGiMwSPRvXwCreJxAV3KnYzUE
         N6+f25B2uxlEm8/Lhr3xqRm7Twj0jjeU9TNMkbRdqvZuDi3VJG6VCPWoTTRXYaSNPJpV
         gzBpdKqAdrp5/uGpqjFKzpPPZiWoGMUnq1TBLH0j/iRKdtJbTmx0GNOF2AoYajbxLz/6
         QH+eqcNLsMXoUgKc1VZOE+fopnvf4BHwYnyRXdXd9I8LEHruI8jFWiRu17jbrxvWaXX0
         McIQ==
X-Gm-Message-State: AOAM531Scflw5e1/tb2gMmqg0KCiZP8aUHhE8okvWVb8GbY3kwwyz60l
        K2bIPhaA/Cj5SyuOFszgF4FDfxlh3cw=
X-Google-Smtp-Source: ABdhPJxhdHlSP1WurrhCIJ8tM/5LxgwSdz5d+pKk7TVEe5llpRNDBiWgwKyHSppItIe/qE9kJftKiw==
X-Received: by 2002:a54:410b:: with SMTP id l11mr16346473oic.74.1633702229084;
        Fri, 08 Oct 2021 07:10:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bg16sm688219oib.30.2021.10.08.07.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:10:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 07:10:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brandon Wyman <bjwyman@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 1/2] hwmon: (pmbus/ibm-cffps) Add mfg_id debugfs entry
Message-ID: <20211008141027.GA1987825@roeck-us.net>
References: <20211004144339.2634330-1-bjwyman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004144339.2634330-1-bjwyman@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 02:43:38PM +0000, Brandon Wyman wrote:
> Add support for the manufacturer ID to the debugfs entries.
> 
> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index df712ce4b164..2ee47cbbb665 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -18,6 +18,7 @@
>  
>  #include "pmbus.h"
>  
> +#define CFFPS_MFG_ID_CMD                        0x99
>  #define CFFPS_FRU_CMD				0x9A
>  #define CFFPS_PN_CMD				0x9B
>  #define CFFPS_HEADER_CMD			0x9C
> @@ -34,7 +35,7 @@
>  #define CFFPS_INPUT_HISTORY_SIZE		100
>  
>  #define CFFPS_CCIN_REVISION			GENMASK(7, 0)
> -#define  CFFPS_CCIN_REVISION_LEGACY		 0xde
> +#define CFFPS_CCIN_REVISION_LEGACY		 0xde
>  #define CFFPS_CCIN_VERSION			GENMASK(15, 8)
>  #define CFFPS_CCIN_VERSION_1			 0x2b
>  #define CFFPS_CCIN_VERSION_2			 0x2e
> @@ -57,6 +58,7 @@
>  
>  enum {
>  	CFFPS_DEBUGFS_INPUT_HISTORY = 0,
> +	CFFPS_DEBUGFS_MFG_ID,
>  	CFFPS_DEBUGFS_FRU,
>  	CFFPS_DEBUGFS_PN,
>  	CFFPS_DEBUGFS_HEADER,
> @@ -158,6 +160,9 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
>  	switch (idx) {
>  	case CFFPS_DEBUGFS_INPUT_HISTORY:
>  		return ibm_cffps_read_input_history(psu, buf, count, ppos);
> +	case CFFPS_DEBUGFS_MFG_ID:
> +		cmd = CFFPS_MFG_ID_CMD;
> +		break;
>  	case CFFPS_DEBUGFS_FRU:
>  		cmd = CFFPS_FRU_CMD;
>  		break;
> @@ -558,6 +563,9 @@ static int ibm_cffps_probe(struct i2c_client *client)
>  	debugfs_create_file("input_history", 0444, ibm_cffps_dir,
>  			    &psu->debugfs_entries[CFFPS_DEBUGFS_INPUT_HISTORY],
>  			    &ibm_cffps_fops);
> +	debugfs_create_file("mfg_id", 0444, ibm_cffps_dir,
> +			    &psu->debugfs_entries[CFFPS_DEBUGFS_MFG_ID],
> +			    &ibm_cffps_fops);
>  	debugfs_create_file("fru", 0444, ibm_cffps_dir,
>  			    &psu->debugfs_entries[CFFPS_DEBUGFS_FRU],
>  			    &ibm_cffps_fops);
