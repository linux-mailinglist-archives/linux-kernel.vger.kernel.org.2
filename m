Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391B6426C93
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhJHOOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhJHOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:14:35 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EEC061570;
        Fri,  8 Oct 2021 07:12:40 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t4so12111787oie.5;
        Fri, 08 Oct 2021 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ec0UXnetl/cUzojliEKcqLDXOEMlqclKc/XRj4PNyXE=;
        b=kLrvKJ4aHZsTuO6lSocllGqMoHF5q/Tep3znQkD8Dx28796e+XZMG9mLO4Z9SEK8qM
         FsKe1gasVsBcasVNBeC+fvzi+5ljEzEwhyS4aQXdQ64mk941AhpqFs4X8T2Z1kGlqJ22
         NsHoST6THQvLjbZ+yQ9JScRRYx5PwUxDzmNAx4eqr4yhuTp2W9JVIaHuvgsehQIZwrKQ
         f4jYXhJNEJLCMh0g+DjPoEc0FzmnXThQr/Skulq2/iOXF2it9Pwp4XBxzbVSVIgG4ZGj
         Cka55QYrE4tOUqRYkCCbZM0KaxOIIwTqgO3BaimLABEHIJQrzb4NeUDilpaW0p8MEtlY
         1KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ec0UXnetl/cUzojliEKcqLDXOEMlqclKc/XRj4PNyXE=;
        b=yFr/nhpTR8fN5Gx7kd34jR8FoMPAz5AUlph1Y6KcwM9pVKoNQJzlmYU76loJ3PRU/e
         oy/YSXm2gLB0oEgedT6jmjQ8FhccqtQ6LpYIxfcZOCGGdz7sQ2Cq7OEYUk3wni+z7Fkp
         ZZ9hsU2tkIW+f8M/szNCcYQlp6CuMBzZ7D2E/HeY9UZwsBxxi67PFUhlwlyiuvsgH9p+
         ormdqqMSfio+GZIQYo6alJYSFEarcVJ+tlbckRfSX22a4z3iRurdlx1xxkMN29xjGsqQ
         aS3no1aJmcNdcVdecUwfikXtY+AjGtWiTUFtEuDdgfPagEJYqmTEhe8FDxGDqV35uZlt
         7XMw==
X-Gm-Message-State: AOAM532LagpDcO2t19e6GbbA+Nuk0drRTBtHU1hB9swKkEIGpGcIw/8E
        1qU4yNNC6rS6BSZS2inr7Rg=
X-Google-Smtp-Source: ABdhPJzOVTiNEosUQAjVv9QO0iXxPxGaeT/gqUshzEInrFSgqW3WwgCltkFL+EjuofaqHQf7o7y0Ug==
X-Received: by 2002:a05:6808:1992:: with SMTP id bj18mr16600754oib.125.1633702357758;
        Fri, 08 Oct 2021 07:12:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10sm514639ooj.24.2021.10.08.07.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:12:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 07:12:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brandon Wyman <bjwyman@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/ibm-cffps) Use MFR_ID to choose version
Message-ID: <20211008141235.GA2044602@roeck-us.net>
References: <20211004144339.2634330-1-bjwyman@gmail.com>
 <20211004144339.2634330-2-bjwyman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004144339.2634330-2-bjwyman@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 02:43:39PM +0000, Brandon Wyman wrote:
> There are multiple power supplies that will indicate
> CFFPS_CCIN_VERSION_1, use the manufacturer ID to determine if it should
> be treated as version cffps1 or version cffps2.
> 
> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>

Applied, after fixing continnuation line alignments.

Guenter

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index 2ee47cbbb665..292c87331f2b 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -502,16 +502,29 @@ static int ibm_cffps_probe(struct i2c_client *client)
>  		u16 ccin_revision = 0;
>  		u16 ccin_version = CFFPS_CCIN_VERSION_1;
>  		int ccin = i2c_smbus_read_word_swapped(client, CFFPS_CCIN_CMD);
> +		char mfg_id[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
>  
>  		if (ccin > 0) {
>  			ccin_revision = FIELD_GET(CFFPS_CCIN_REVISION, ccin);
>  			ccin_version = FIELD_GET(CFFPS_CCIN_VERSION, ccin);
>  		}
>  
> +		rc = i2c_smbus_read_block_data(client, PMBUS_MFR_ID,
> +				mfg_id);
> +		if (rc < 0) {
> +			dev_err(&client->dev,
> +					"Failed to read Manufacturer ID\n");
> +			return rc;
> +		}
> +
>  		switch (ccin_version) {
>  		default:
>  		case CFFPS_CCIN_VERSION_1:
> -			vs = cffps1;
> +			if ((strncmp(mfg_id, "ACBE", 4) == 0) ||
> +					(strncmp(mfg_id, "ARTE", 4) == 0))
> +				vs = cffps1;
> +			else
> +				vs = cffps2;
>  			break;
>  		case CFFPS_CCIN_VERSION_2:
>  			vs = cffps2;
