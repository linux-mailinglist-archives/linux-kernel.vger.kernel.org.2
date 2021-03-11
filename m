Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A66337FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhCKWBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 17:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhCKWA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:00:58 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199AC061574;
        Thu, 11 Mar 2021 14:00:58 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so387640ota.0;
        Thu, 11 Mar 2021 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TQF/LGCOPFatzhvjQlpFSq+Z+gtTSsryBBpoyI/DA0Y=;
        b=MW3anqJK1IvuFT10DnLhKdtmJzlNccK2ZlZyz+/4f3aX/69iB9jKVMBWdeLVWmqxzf
         x2kdrKVKlWobGLU0PjJmWfiO6wa6h/3UycLDHrp37GhsxtSw7fzMEzVK1/gVYcL4EI+R
         9hqbfy5Ptk1VMoCCo+gE2QhRmtK8IV93p3GndCIrnKpSysn4LCduxGpa4o/soUSKdbm3
         5kekdtXYi7Mdu/zg74TVvnhVLg38xqd+6JBh31KKf1F9S5hR/utAI20c27xtZrhK4Lmw
         YSrCasNtbVK8FRo8BsXStKdEU1c5SUcCnzhEfLD0q+NlhQx0zAb0Miv+wiVWkvCDw9jh
         kAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TQF/LGCOPFatzhvjQlpFSq+Z+gtTSsryBBpoyI/DA0Y=;
        b=CjSpjITMYi93VkdiJhOS4Gue9x3rKE5euZhKcxN5k4fJNqLp4DPCBBQWuiU0dvmfIa
         gtc3AS/NIQUjgmBC8rR3WuHRCsTHczB3nFc5SNFw63U1eMpsy5wRMfneoXyl5jpBSvAw
         CPQBfVo6S+hSZCdZI9IUlApVjl2XNcZVsDl4Cr8ArCXKBoGrZRoqHAw6KLCntkoIlSMc
         97A9pf08rHlI7QvEn2OU+sDeRBrYSfi80u2g40+MApxqI72A5wIvjTLUvgLXfzOC17fT
         tyb6xN10V4dxL7HAn5AKJvwiup7WH9b6MWrdZ+D1LT02slDl62xYvr4jE6MgewES5LGR
         mTdQ==
X-Gm-Message-State: AOAM533C7qq/joEtOgmqhFRf1TVYRuWI3dflL9aEb7GvonR7uOCnsALG
        dVg2CIjtzo34NmXzJubZJKVBbVxtdDU=
X-Google-Smtp-Source: ABdhPJxLaWrVyY0NU8iAwT8s4lIqswm98TlXC/mf3MDh3pFUsp6cZXRNLp/kgApUkQInaQn6GR27fw==
X-Received: by 2002:a9d:4808:: with SMTP id c8mr821680otf.181.1615500057877;
        Thu, 11 Mar 2021 14:00:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v1sm952742otk.67.2021.03.11.14.00.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 14:00:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Mar 2021 14:00:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus) Add pmbus_set_update() function to
 set update flag
Message-ID: <20210311220056.GA37350@roeck-us.net>
References: <20210218115249.28513-1-erik.rosen@metormote.com>
 <20210218115249.28513-2-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218115249.28513-2-erik.rosen@metormote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:52:48PM +0100, Erik Rosen wrote:
> For the STPDDC60 chip, the vout alarm-limits are represented as an offset
> relative to the commanded output voltage. This means that the limits are
> dynamic and must not be cached by the pmbus driver. This patch adds a
> pmbus_set_sensor() function to pmbus_core to be able to set the update flag
> on selected sensors after auto-detection of limit attributes.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus.h      |  1 +
>  drivers/hwmon/pmbus/pmbus_core.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 4c30ec89f5bf..3968924f8533 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -475,6 +475,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
>  /* Function declarations */
>  
>  void pmbus_clear_cache(struct i2c_client *client);
> +void pmbus_set_update(struct i2c_client *client, u8 reg, bool update);
>  int pmbus_set_page(struct i2c_client *client, int page, int phase);
>  int pmbus_read_word_data(struct i2c_client *client, int page, int phase,
>  			 u8 reg);
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 192442b3b7a2..a8f910826a18 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -141,6 +141,17 @@ void pmbus_clear_cache(struct i2c_client *client)
>  }
>  EXPORT_SYMBOL_GPL(pmbus_clear_cache);
>  
> +void pmbus_set_update(struct i2c_client *client, u8 reg, bool update)
> +{
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	struct pmbus_sensor *sensor;
> +
> +	for (sensor = data->sensors; sensor; sensor = sensor->next)
> +		if (sensor->reg == reg)
> +			sensor->update = update;
> +}
> +EXPORT_SYMBOL_GPL(pmbus_set_update);
> +
>  int pmbus_set_page(struct i2c_client *client, int page, int phase)
>  {
>  	struct pmbus_data *data = i2c_get_clientdata(client);
