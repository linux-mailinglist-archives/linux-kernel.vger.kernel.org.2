Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD2141823C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbhIYNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhIYNYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 09:24:47 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BFAC061570;
        Sat, 25 Sep 2021 06:23:11 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id s36-20020a05683043a400b0054d4c88353dso6279073otv.0;
        Sat, 25 Sep 2021 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BWsTt5T3Juc5IhU7ZiF+9B0YI097+6/300x+4nOf8yQ=;
        b=EI6r9FIyhySGjyKQU/Q7klbsHc4gS9xewGaBxQJJHPuLPD0lZ0vR6ZXv7h+veOploM
         IZgBs6rbr49OfSeenNm7VFl9WOXAiqj3KruDiK5+kKZTV/mcKrxjbLrMMIGWH9yZb+xH
         bij7HYbZDAOKemcNw9XnwF2WtqBzrNlwcAOI1FDazXoj4TfzHsbtliA7833rF2/fYvhK
         Kvzeq+8UA048gjYKQR3KDy5D8ck4JYp2d3BTaauu2XBmkILRJ/XHBsCNVejhWtsAxJhH
         WO1wZj56o2qUlNk6uF2GT3hmqMKsCBznmUsizudrhTXJu66c3l4P4D9djomtVNs8CGgO
         qvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BWsTt5T3Juc5IhU7ZiF+9B0YI097+6/300x+4nOf8yQ=;
        b=Uv25Poqi3Q3VvO3mlhAmSBPPT/dF9nq8m39Hv9EUkQXmAmAtbV1fSeFHgMuJOiucrF
         keRxjwpKTgNUkQJIVDc3RHkPitls0SPAtrbXy5Atv5jFMFDMwMao8uurnHXsr61eUdnC
         1YZ+gNcNm/CCj/hxFcx0jNvwFjLQ7DRROKv1zszYV2qkTyApuTEAI2K9a5cGHSzdAGKp
         4QMiOmQGq7kdIlkJ/6LFMVZJNPE4AuRVHYtg2LNwszLIIMVmtws9fjDwFTngbOT4ZAX4
         JVulQ8jqryAxpYQYsTLm1x1IIZOr1o0/kxTO2dmWhfMRAqUNALqbrTQPO9qEUUj8fKmH
         4LVA==
X-Gm-Message-State: AOAM532VzaSUHTD4uwQzYwdGX44H7L6gngF3S8GkC8EVLDrW72trRGlN
        1zXIvdQAQTVskkevX94BxuE=
X-Google-Smtp-Source: ABdhPJy96Q9WcGeFXo3BFNfCCCx2rihcT+HmgEk+jYLGMpbzRE7w3g6ZvWHSb+3HU+9wpSKwn78R3w==
X-Received: by 2002:a9d:7dca:: with SMTP id k10mr8694881otn.54.1632576188941;
        Sat, 25 Sep 2021 06:23:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y84sm2919242oie.16.2021.09.25.06.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 06:23:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 25 Sep 2021 06:23:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     linux-hwmon@vger.kernel.org,
        Alistair John Strachan <alistair@devzero.co.uk>,
        Jean Delvare <jdelvare@suse.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        George Joseph <george.joseph@fairview5.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Juerg Haefliger <juergh@gmail.com>,
        Riku Voipio <riku.voipio@iki.fi>,
        Jim Cromie <jim.cromie@gmail.com>,
        Roger Lucas <vt8231@hiddenengine.co.uk>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: cleanup non-bool "valid" data fields
Message-ID: <20210925132306.GA1240690@roeck-us.net>
References: <20210924113547.GA2694238@roeck-us.net>
 <20210924195202.27917-1-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924195202.27917-1-fercerpav@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 10:52:02PM +0300, Paul Fertser wrote:
> We have bool so use it consistently in all the drivers.
> 

Please _never_ send a patch as reply to a previous patch, unless you
want it to get lost.

I have limited internet access right now, for the next week or so.
I'll review your patch afterwards.

Guenter

> The following Coccinelle script was used:
> 
> @@
> identifier T;
> type t = { char, int };
> @@
> struct T {
> ...
> -	t valid;
> +	bool valid;
> ...
> }
> 
> @@
> identifier v;
> @@
> (
> - v->valid = 0
> + v->valid = false
> |
> - v->valid = 1
> + v->valid = true
> )
> 
> followed by sed to fixup the comments:
> sed '/bool valid;/{s/!=0/true/;s/zero/false/}'
> 
> Few whitespace changes were fixed manually. All modified drivers were
> compile-tested.
> 
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> ---
> 
> This was generated against hwmon-next branch.
> 
>  drivers/hwmon/abituguru3.c  |  6 +++---
>  drivers/hwmon/ad7414.c      |  4 ++--
>  drivers/hwmon/ad7418.c      |  6 +++---
>  drivers/hwmon/adm1021.c     |  4 ++--
>  drivers/hwmon/adm1025.c     |  4 ++--
>  drivers/hwmon/adm1026.c     |  4 ++--
>  drivers/hwmon/adm1029.c     |  4 ++--
>  drivers/hwmon/adm1031.c     |  6 +++---
>  drivers/hwmon/amc6821.c     |  8 ++++----
>  drivers/hwmon/applesmc.c    |  2 +-
>  drivers/hwmon/asb100.c      |  4 ++--
>  drivers/hwmon/asc7621.c     |  4 ++--
>  drivers/hwmon/atxp1.c       |  8 ++++----
>  drivers/hwmon/coretemp.c    |  2 +-
>  drivers/hwmon/dme1737.c     |  4 ++--
>  drivers/hwmon/ds1621.c      |  4 ++--
>  drivers/hwmon/ds620.c       |  4 ++--
>  drivers/hwmon/emc6w201.c    |  4 ++--
>  drivers/hwmon/f71805f.c     |  4 ++--
>  drivers/hwmon/f71882fg.c    |  4 ++--
>  drivers/hwmon/f75375s.c     |  4 ++--
>  drivers/hwmon/fschmd.c      |  4 ++--
>  drivers/hwmon/g760a.c       |  2 +-
>  drivers/hwmon/gl518sm.c     |  4 ++--
>  drivers/hwmon/gl520sm.c     |  4 ++--
>  drivers/hwmon/ibmaem.c      |  2 +-
>  drivers/hwmon/ibmpex.c      |  4 ++--
>  drivers/hwmon/it87.c        | 12 ++++++------
>  drivers/hwmon/lineage-pem.c |  2 +-
>  drivers/hwmon/lm63.c        |  6 +++---
>  drivers/hwmon/lm77.c        |  4 ++--
>  drivers/hwmon/lm78.c        |  4 ++--
>  drivers/hwmon/lm80.c        |  6 +++---
>  drivers/hwmon/lm83.c        |  4 ++--
>  drivers/hwmon/lm85.c        |  4 ++--
>  drivers/hwmon/lm87.c        |  4 ++--
>  drivers/hwmon/lm92.c        |  4 ++--
>  drivers/hwmon/lm93.c        |  4 ++--
>  drivers/hwmon/lm95241.c     |  8 ++++----
>  drivers/hwmon/ltc4151.c     |  2 +-
>  drivers/hwmon/ltc4215.c     |  2 +-
>  drivers/hwmon/ltc4261.c     |  4 ++--
>  drivers/hwmon/max16065.c    |  2 +-
>  drivers/hwmon/max1619.c     |  4 ++--
>  drivers/hwmon/max1668.c     |  4 ++--
>  drivers/hwmon/max6639.c     |  4 ++--
>  drivers/hwmon/max6642.c     |  2 +-
>  drivers/hwmon/pc87360.c     |  4 ++--
>  drivers/hwmon/sch5636.c     |  4 ++--
>  drivers/hwmon/sht21.c       |  4 ++--
>  drivers/hwmon/sis5595.c     |  4 ++--
>  drivers/hwmon/smm665.c      |  2 +-
>  drivers/hwmon/smsc47b397.c  |  4 ++--
>  drivers/hwmon/smsc47m192.c  |  4 ++--
>  drivers/hwmon/thmc50.c      |  4 ++--
>  drivers/hwmon/tmp401.c      |  6 +++---
>  drivers/hwmon/tmp421.c      |  6 +++---
>  drivers/hwmon/via686a.c     |  4 ++--
>  drivers/hwmon/vt1211.c      |  4 ++--
>  drivers/hwmon/vt8231.c      |  4 ++--
>  drivers/hwmon/w83627ehf.c   |  8 ++++----
>  drivers/hwmon/w83627hf.c    |  6 +++---
>  drivers/hwmon/w83781d.c     |  4 ++--
>  drivers/hwmon/w83791d.c     |  4 ++--
>  drivers/hwmon/w83792d.c     |  6 +++---
>  drivers/hwmon/w83793.c      |  6 +++---
>  drivers/hwmon/w83795.c      |  6 +++---
>  drivers/hwmon/w83l785ts.c   |  4 ++--
>  drivers/hwmon/w83l786ng.c   |  4 ++--
>  69 files changed, 151 insertions(+), 151 deletions(-)
> 
> diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> index 112dd0d9377c..8229ad30c909 100644
> --- a/drivers/hwmon/abituguru3.c
> +++ b/drivers/hwmon/abituguru3.c
> @@ -145,7 +145,7 @@ struct abituguru3_data {
>  	struct device *hwmon_dev;	/* hwmon registered device */
>  	struct mutex update_lock;	/* protect access to data and uGuru */
>  	unsigned short addr;		/* uguru base address */
> -	char valid;			/* !=0 if following fields are valid */
> +	bool valid;			/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	/*
> @@ -1083,7 +1083,7 @@ static struct abituguru3_data *abituguru3_update_device(struct device *dev)
>  	mutex_lock(&data->update_lock);
>  	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
>  		/* Clear data->valid while updating */
> -		data->valid = 0;
> +		data->valid = false;
>  		/* Read alarms */
>  		if (abituguru3_read_increment_offset(data,
>  				ABIT_UGURU3_SETTINGS_BANK,
> @@ -1117,7 +1117,7 @@ static struct abituguru3_data *abituguru3_update_device(struct device *dev)
>  				goto LEAVE_UPDATE;
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  LEAVE_UPDATE:
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
> index 6a765755d061..0afb89c4629d 100644
> --- a/drivers/hwmon/ad7414.c
> +++ b/drivers/hwmon/ad7414.c
> @@ -37,7 +37,7 @@ static u8 AD7414_REG_LIMIT[] = { AD7414_REG_T_HIGH, AD7414_REG_T_LOW };
>  struct ad7414_data {
>  	struct i2c_client	*client;
>  	struct mutex		lock;	/* atomic read data updates */
> -	char			valid;	/* !=0 if following fields are valid */
> +	bool			valid;	/* true if following fields are valid */
>  	unsigned long		next_update;	/* In jiffies */
>  	s16			temp_input;	/* Register values */
>  	s8			temps[ARRAY_SIZE(AD7414_REG_LIMIT)];
> @@ -95,7 +95,7 @@ static struct ad7414_data *ad7414_update_device(struct device *dev)
>  		}
>  
>  		data->next_update = jiffies + HZ + HZ / 2;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->lock);
> diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
> index d618f6b2f382..22bdb7e5b9e0 100644
> --- a/drivers/hwmon/ad7418.c
> +++ b/drivers/hwmon/ad7418.c
> @@ -46,7 +46,7 @@ struct ad7418_data {
>  	enum chips		type;
>  	struct mutex		lock;
>  	int			adc_max;	/* number of ADC channels */
> -	char			valid;
> +	bool			valid;
>  	unsigned long		last_updated;	/* In jiffies */
>  	s16			temp[3];	/* Register values */
>  	u16			in[4];
> @@ -111,14 +111,14 @@ static int ad7418_update_device(struct device *dev)
>  			goto abort;
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->lock);
>  	return 0;
>  
>  abort:
> -	data->valid = 0;
> +	data->valid = false;
>  	mutex_unlock(&data->lock);
>  	return val;
>  }
> diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
> index 71deb2cd20f5..38b447c6e8cd 100644
> --- a/drivers/hwmon/adm1021.c
> +++ b/drivers/hwmon/adm1021.c
> @@ -72,7 +72,7 @@ struct adm1021_data {
>  	const struct attribute_group *groups[3];
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	char low_power;		/* !=0 if device in low power mode */
>  	unsigned long last_updated;	/* In jiffies */
>  
> @@ -135,7 +135,7 @@ static struct adm1021_data *adm1021_update_device(struct device *dev)
>  						ADM1023_REG_REM_OFFSET_PREC);
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
> index de51e01c061b..4352f6a884e8 100644
> --- a/drivers/hwmon/adm1025.c
> +++ b/drivers/hwmon/adm1025.c
> @@ -97,7 +97,7 @@ struct adm1025_data {
>  	struct i2c_client *client;
>  	const struct attribute_group *groups[3];
>  	struct mutex update_lock;
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  
>  	u8 in[6];		/* register value */
> @@ -148,7 +148,7 @@ static struct adm1025_data *adm1025_update_device(struct device *dev)
>  			      ADM1025_REG_VID4) & 0x01) << 4);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
> index 49cefbadb156..69b3ec752944 100644
> --- a/drivers/hwmon/adm1026.c
> +++ b/drivers/hwmon/adm1026.c
> @@ -259,7 +259,7 @@ struct adm1026_data {
>  	const struct attribute_group *groups[3];
>  
>  	struct mutex update_lock;
> -	int valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_reading;	/* In jiffies */
>  	unsigned long last_config;	/* In jiffies */
>  
> @@ -459,7 +459,7 @@ static struct adm1026_data *adm1026_update_device(struct device *dev)
>  		data->last_config = jiffies;
>  	}	/* last_config */
>  
> -	data->valid = 1;
> +	data->valid = true;
>  	mutex_unlock(&data->update_lock);
>  	return data;
>  }
> diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
> index 50b1df7b008c..3e1999413f32 100644
> --- a/drivers/hwmon/adm1029.c
> +++ b/drivers/hwmon/adm1029.c
> @@ -99,7 +99,7 @@ static const u8 ADM1029_REG_FAN_DIV[] = {
>  struct adm1029_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock; /* protect register access */
> -	char valid;		/* zero until following fields are valid */
> +	bool valid;		/* false until following fields are valid */
>  	unsigned long last_updated;	/* in jiffies */
>  
>  	/* registers values, signed for temperature, unsigned for other stuff */
> @@ -143,7 +143,7 @@ static struct adm1029_data *adm1029_update_device(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> index b538ace2d292..257ec53ae723 100644
> --- a/drivers/hwmon/adm1031.c
> +++ b/drivers/hwmon/adm1031.c
> @@ -65,7 +65,7 @@ struct adm1031_data {
>  	const struct attribute_group *groups[3];
>  	struct mutex update_lock;
>  	int chip_type;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  	unsigned int update_interval;	/* In milliseconds */
>  	/*
> @@ -187,7 +187,7 @@ static struct adm1031_data *adm1031_update_device(struct device *dev)
>  					ADM1031_REG_PWM) >> (4 * chan)) & 0x0f;
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> @@ -650,7 +650,7 @@ static ssize_t fan_div_store(struct device *dev,
>  			    data->fan_min[nr]);
>  
>  	/* Invalidate the cache: fan speed is no longer valid */
> -	data->valid = 0;
> +	data->valid = false;
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 6b1ce2242c61..0c16face3fd3 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -141,7 +141,7 @@ static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
>  struct amc6821_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  
>  	/* register values */
> @@ -258,7 +258,7 @@ static struct amc6821_data *amc6821_update_device(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  	mutex_unlock(&data->update_lock);
>  	return data;
> @@ -511,7 +511,7 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
>  	}
>  
>  	mutex_lock(&data->update_lock);
> -	data->valid = 0;
> +	data->valid = false;
>  
>  	switch (ix) {
>  	case 0:
> @@ -584,7 +584,7 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>  	}
>  
>  EXIT:
> -	data->valid = 0;
> +	data->valid = false;
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index c31759794a29..fc6d6a9053ce 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -391,7 +391,7 @@ static const struct applesmc_entry *applesmc_get_entry_by_index(int index)
>  	cache->len = info[0];
>  	memcpy(cache->type, &info[1], 4);
>  	cache->flags = info[5];
> -	cache->valid = 1;
> +	cache->valid = true;
>  
>  out:
>  	mutex_unlock(&smcreg.mutex);
> diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
> index ba9fcf6f9264..8cf0bcb85eb4 100644
> --- a/drivers/hwmon/asb100.c
> +++ b/drivers/hwmon/asb100.c
> @@ -186,7 +186,7 @@ struct asb100_data {
>  	/* array of 2 pointers to subclients */
>  	struct i2c_client *lm75[2];
>  
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	u8 in[7];		/* Register value */
>  	u8 in_max[7];		/* Register value */
>  	u8 in_min[7];		/* Register value */
> @@ -993,7 +993,7 @@ static struct asb100_data *asb100_update_device(struct device *dev)
>  			(asb100_read_value(client, ASB100_REG_ALARM2) << 8);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  
>  		dev_dbg(&client->dev, "... device update complete\n");
>  	}
> diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
> index 600ffc7e1900..e835605a7456 100644
> --- a/drivers/hwmon/asc7621.c
> +++ b/drivers/hwmon/asc7621.c
> @@ -77,7 +77,7 @@ struct asc7621_data {
>  	struct i2c_client client;
>  	struct device *class_dev;
>  	struct mutex update_lock;
> -	int valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_high_reading;	/* In jiffies */
>  	unsigned long last_low_reading;		/* In jiffies */
>  	/*
> @@ -1032,7 +1032,7 @@ static struct asc7621_data *asc7621_update_device(struct device *dev)
>  		data->last_low_reading = jiffies;
>  	}			/* last_reading */
>  
> -	data->valid = 1;
> +	data->valid = true;
>  
>  	mutex_unlock(&data->update_lock);
>  
> diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
> index 1e08a5431f12..24e7da68c064 100644
> --- a/drivers/hwmon/atxp1.c
> +++ b/drivers/hwmon/atxp1.c
> @@ -63,7 +63,7 @@ static struct atxp1_data *atxp1_update_device(struct device *dev)
>  		data->reg.gpio1 = i2c_smbus_read_byte_data(client, ATXP1_GPIO1);
>  		data->reg.gpio2 = i2c_smbus_read_byte_data(client, ATXP1_GPIO2);
>  
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> @@ -136,7 +136,7 @@ static ssize_t cpu0_vid_store(struct device *dev,
>  						ATXP1_VID, cvid | ATXP1_VIDENA);
>  	}
>  
> -	data->valid = 0;
> +	data->valid = false;
>  
>  	return count;
>  }
> @@ -180,7 +180,7 @@ static ssize_t gpio1_store(struct device *dev, struct device_attribute *attr,
>  
>  		i2c_smbus_write_byte_data(client, ATXP1_GPIO1, value);
>  
> -		data->valid = 0;
> +		data->valid = false;
>  	}
>  
>  	return count;
> @@ -224,7 +224,7 @@ static ssize_t gpio2_store(struct device *dev, struct device_attribute *attr,
>  
>  		i2c_smbus_write_byte_data(client, ATXP1_GPIO2, value);
>  
> -		data->valid = 0;
> +		data->valid = false;
>  	}
>  
>  	return count;
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index bb9211215a68..ccf0af5b988a 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -167,7 +167,7 @@ static ssize_t show_temp(struct device *dev,
>  		 * really help at all.
>  		 */
>  		tdata->temp = tdata->tjmax - ((eax >> 16) & 0x7f) * 1000;
> -		tdata->valid = 1;
> +		tdata->valid = true;
>  		tdata->last_updated = jiffies;
>  	}
>  
> diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
> index c1e4cfb40c3d..e3ad4c2d0038 100644
> --- a/drivers/hwmon/dme1737.c
> +++ b/drivers/hwmon/dme1737.c
> @@ -203,7 +203,7 @@ struct dme1737_data {
>  	unsigned int addr;		/* for ISA devices only */
>  
>  	struct mutex update_lock;
> -	int valid;			/* !=0 if following fields are valid */
> +	bool valid;			/* true if following fields are valid */
>  	unsigned long last_update;	/* in jiffies */
>  	unsigned long last_vbat;	/* in jiffies */
>  	enum chips type;
> @@ -778,7 +778,7 @@ static struct dme1737_data *dme1737_update_device(struct device *dev)
>  		}
>  
>  		data->last_update = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
> index bf1c4b7ecb40..0886abf6ebab 100644
> --- a/drivers/hwmon/ds1621.c
> +++ b/drivers/hwmon/ds1621.c
> @@ -109,7 +109,7 @@ static const u8 DS1621_REG_TEMP[3] = {
>  struct ds1621_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
> -	char valid;			/* !=0 if following fields are valid */
> +	bool valid;			/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  	enum chips kind;		/* device type */
>  
> @@ -213,7 +213,7 @@ static struct ds1621_data *ds1621_update_client(struct device *dev)
>  						  new_conf);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
> index 9ec722798c4a..82d7c3d58f49 100644
> --- a/drivers/hwmon/ds620.c
> +++ b/drivers/hwmon/ds620.c
> @@ -56,7 +56,7 @@ static const u8 DS620_REG_TEMP[3] = {
>  struct ds620_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	s16 temp[3];		/* Register values, word */
> @@ -118,7 +118,7 @@ static struct ds620_data *ds620_update_client(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  abort:
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
> index ec5c98702bf5..29082c8463f4 100644
> --- a/drivers/hwmon/emc6w201.c
> +++ b/drivers/hwmon/emc6w201.c
> @@ -45,7 +45,7 @@ enum subfeature { input, min, max };
>  struct emc6w201_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  
>  	/* registers values */
> @@ -162,7 +162,7 @@ static struct emc6w201_data *emc6w201_update_device(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
> index 67b47de8263a..7f20edb0677c 100644
> --- a/drivers/hwmon/f71805f.c
> +++ b/drivers/hwmon/f71805f.c
> @@ -165,7 +165,7 @@ struct f71805f_data {
>  	struct device *hwmon_dev;
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  	unsigned long last_limits;	/* In jiffies */
>  
> @@ -404,7 +404,7 @@ static struct f71805f_data *f71805f_update_device(struct device *dev)
>  			+ (f71805f_read8(data, F71805F_REG_STATUS(2)) << 16);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index 4dec793fd07d..4673d403759a 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -253,7 +253,7 @@ struct f71882fg_data {
>  
>  	struct mutex update_lock;
>  	int temp_start;			/* temp numbering start (0 or 1) */
> -	char valid;			/* !=0 if following fields are valid */
> +	bool valid;			/* true if following fields are valid */
>  	char auto_point_temp_signed;
>  	unsigned long last_updated;	/* In jiffies */
>  	unsigned long last_limits;	/* In jiffies */
> @@ -1359,7 +1359,7 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
>  							F71882FG_REG_IN(nr));
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index 3e567be60fb1..57c8a473698d 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -85,7 +85,7 @@ struct f75375_data {
>  	const char *name;
>  	int kind;
>  	struct mutex update_lock; /* protect register access */
> -	char valid;
> +	bool valid;
>  	unsigned long last_updated;	/* In jiffies */
>  	unsigned long last_limits;	/* In jiffies */
>  
> @@ -228,7 +228,7 @@ static struct f75375_data *f75375_update_device(struct device *dev)
>  				f75375_read8(client, F75375_REG_VOLT(nr));
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
> index 5191cd85a8d1..c26195e3aad7 100644
> --- a/drivers/hwmon/fschmd.c
> +++ b/drivers/hwmon/fschmd.c
> @@ -264,7 +264,7 @@ struct fschmd_data {
>  	unsigned long watchdog_is_open;
>  	char watchdog_expect_close;
>  	char watchdog_name[10]; /* must be unique to avoid sysfs conflict */
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  
>  	/* register values */
> @@ -1356,7 +1356,7 @@ static struct fschmd_data *fschmd_update_device(struct device *dev)
>  					       FSCHMD_REG_VOLT[data->kind][i]);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
> index a692f7b2f6f7..36717b524dbd 100644
> --- a/drivers/hwmon/g760a.c
> +++ b/drivers/hwmon/g760a.c
> @@ -95,7 +95,7 @@ static struct g760a_data *g760a_update_client(struct device *dev)
>  		data->fan_sta = g760a_read_value(client, G760A_REG_FAN_STA);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
> index 7aaee5a48243..dd683b0a648f 100644
> --- a/drivers/hwmon/gl518sm.c
> +++ b/drivers/hwmon/gl518sm.c
> @@ -107,7 +107,7 @@ struct gl518_data {
>  	enum chips type;
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	u8 voltage_in[4];	/* Register values; [0] = VDD */
> @@ -211,7 +211,7 @@ static struct gl518_data *gl518_update_device(struct device *dev)
>  		    gl518_read_value(client, GL518_REG_VIN3);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
> index 4ae1295cc3ea..096ba9797211 100644
> --- a/drivers/hwmon/gl520sm.c
> +++ b/drivers/hwmon/gl520sm.c
> @@ -64,7 +64,7 @@ struct gl520_data {
>  	struct i2c_client *client;
>  	const struct attribute_group *groups[3];
>  	struct mutex update_lock;
> -	char valid;		/* zero until the following fields are valid */
> +	bool valid;		/* false until the following fields are valid */
>  	unsigned long last_updated;	/* in jiffies */
>  
>  	u8 vid;
> @@ -174,7 +174,7 @@ static struct gl520_data *gl520_update_device(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
> index a4ec85207782..de6baf6ca3d1 100644
> --- a/drivers/hwmon/ibmaem.c
> +++ b/drivers/hwmon/ibmaem.c
> @@ -127,7 +127,7 @@ struct aem_data {
>  	struct device		*hwmon_dev;
>  	struct platform_device	*pdev;
>  	struct mutex		lock;
> -	char			valid;
> +	bool			valid;
>  	unsigned long		last_updated;	/* In jiffies */
>  	u8			ver_major;
>  	u8			ver_minor;
> diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
> index b2ab83c9fd9a..f6ec165c0fa8 100644
> --- a/drivers/hwmon/ibmpex.c
> +++ b/drivers/hwmon/ibmpex.c
> @@ -66,7 +66,7 @@ struct ibmpex_bmc_data {
>  	struct device		*hwmon_dev;
>  	struct device		*bmc_device;
>  	struct mutex		lock;
> -	char			valid;
> +	bool			valid;
>  	unsigned long		last_updated;	/* In jiffies */
>  
>  	struct ipmi_addr	address;
> @@ -239,7 +239,7 @@ static void ibmpex_update_device(struct ibmpex_bmc_data *data)
>  	}
>  
>  	data->last_updated = jiffies;
> -	data->valid = 1;
> +	data->valid = true;
>  
>  out:
>  	mutex_unlock(&data->lock);
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 1f93134afcb9..0e543dbe0a6b 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -519,7 +519,7 @@ struct it87_data {
>  	unsigned short addr;
>  	const char *name;
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	u16 in_scaled;		/* Internal voltage sensors are scaled */
> @@ -844,7 +844,7 @@ static struct it87_data *it87_update_device(struct device *dev)
>  			data->vid &= 0x3f;
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> @@ -980,7 +980,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
>  			regval |= 0x80;
>  			it87_write_value(data, IT87_REG_BEEP_ENABLE, regval);
>  		}
> -		data->valid = 0;
> +		data->valid = false;
>  		reg = IT87_REG_TEMP_OFFSET[nr];
>  		break;
>  	}
> @@ -1079,7 +1079,7 @@ static ssize_t set_temp_type(struct device *dev, struct device_attribute *attr,
>  	it87_write_value(data, IT87_REG_TEMP_ENABLE, data->sensor);
>  	if (has_temp_old_peci(data, nr))
>  		it87_write_value(data, IT87_REG_TEMP_EXTRA, data->extra);
> -	data->valid = 0;	/* Force cache refresh */
> +	data->valid = false;	/* Force cache refresh */
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -1834,7 +1834,7 @@ static ssize_t clear_intrusion(struct device *dev,
>  		config |= BIT(5);
>  		it87_write_value(data, IT87_REG_CONFIG, config);
>  		/* Invalidate cache to force re-read */
> -		data->valid = 0;
> +		data->valid = false;
>  	}
>  	mutex_unlock(&data->update_lock);
>  
> @@ -3229,7 +3229,7 @@ static int __maybe_unused it87_resume(struct device *dev)
>  	it87_start_monitoring(data);
>  
>  	/* force update */
> -	data->valid = 0;
> +	data->valid = false;
>  
>  	mutex_unlock(&data->update_lock);
>  
> diff --git a/drivers/hwmon/lineage-pem.c b/drivers/hwmon/lineage-pem.c
> index 1109fffa76fb..ef5a49cd9149 100644
> --- a/drivers/hwmon/lineage-pem.c
> +++ b/drivers/hwmon/lineage-pem.c
> @@ -191,7 +191,7 @@ static struct pem_data *pem_update_device(struct device *dev)
>  		i2c_smbus_write_byte(client, PEM_CLEAR_INFO_FLAGS);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  abort:
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index c8f93c5d1ccc..339a145afc09 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -139,7 +139,7 @@ struct lm63_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
>  	const struct attribute_group *groups[5];
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	char lut_valid; /* zero until lut fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  	unsigned long lut_last_updated; /* in jiffies */
> @@ -289,7 +289,7 @@ static struct lm63_data *lm63_update_device(struct device *dev)
>  			       LM63_REG_ALERT_STATUS) & 0x7F;
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	lm63_update_lut(data);
> @@ -714,7 +714,7 @@ static ssize_t temp2_type_store(struct device *dev,
>  	reg = i2c_smbus_read_byte_data(client, LM96163_REG_TRUTHERM) & ~0x02;
>  	i2c_smbus_write_byte_data(client, LM96163_REG_TRUTHERM,
>  				  reg | (data->trutherm ? 0x02 : 0x00));
> -	data->valid = 0;
> +	data->valid = false;
>  	mutex_unlock(&data->update_lock);
>  
>  	return count;
> diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
> index 7570c9d50ddc..df6af85e170a 100644
> --- a/drivers/hwmon/lm77.c
> +++ b/drivers/hwmon/lm77.c
> @@ -55,7 +55,7 @@ static const u8 temp_regs[t_num_temp] = {
>  struct lm77_data {
>  	struct i2c_client	*client;
>  	struct mutex		update_lock;
> -	char			valid;
> +	bool			valid;
>  	unsigned long		last_updated;	/* In jiffies */
>  	int			temp[t_num_temp]; /* index using temp_index */
>  	u8			alarms;
> @@ -118,7 +118,7 @@ static struct lm77_data *lm77_update_device(struct device *dev)
>  		data->alarms =
>  			lm77_read_value(client, LM77_REG_TEMP) & 0x0007;
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
> index 1aa35ca0c6fe..5e129cbec1cb 100644
> --- a/drivers/hwmon/lm78.c
> +++ b/drivers/hwmon/lm78.c
> @@ -117,7 +117,7 @@ struct lm78_data {
>  	int isa_addr;
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	u8 in[7];		/* Register value */
> @@ -772,7 +772,7 @@ static struct lm78_data *lm78_update_device(struct device *dev)
>  		data->alarms = lm78_read_value(data, LM78_REG_ALARM1) +
>  		    (lm78_read_value(data, LM78_REG_ALARM2) << 8);
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  
>  		data->fan_div[2] = 1;
>  	}
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index 97ab491d2922..e85e062bbf32 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -117,7 +117,7 @@ struct lm80_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
>  	char error;		/* !=0 if error occurred during last update */
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	u8 in[i_num_in][7];	/* Register value, 1st index is enum in_index */
> @@ -236,14 +236,14 @@ static struct lm80_data *lm80_update_device(struct device *dev)
>  		data->alarms = prev_rv + (rv << 8);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  		data->error = 0;
>  	}
>  	goto done;
>  
>  abort:
>  	ret = ERR_PTR(rv);
> -	data->valid = 0;
> +	data->valid = false;
>  	data->error = 1;
>  
>  done:
> diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
> index 2ff5ecce608e..74fd7aa373a3 100644
> --- a/drivers/hwmon/lm83.c
> +++ b/drivers/hwmon/lm83.c
> @@ -105,7 +105,7 @@ struct lm83_data {
>  	struct i2c_client *client;
>  	const struct attribute_group *groups[3];
>  	struct mutex update_lock;
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  
>  	/* registers values */
> @@ -137,7 +137,7 @@ static struct lm83_data *lm83_update_device(struct device *dev)
>  		    << 8);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index c7bf5de7b70f..88cf2012d34b 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -294,7 +294,7 @@ struct lm85_data {
>  	bool has_vid5;	/* true if VID5 is configured for ADT7463 or ADT7468 */
>  
>  	struct mutex update_lock;
> -	int valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_reading;	/* In jiffies */
>  	unsigned long last_config;	/* In jiffies */
>  
> @@ -541,7 +541,7 @@ static struct lm85_data *lm85_update_device(struct device *dev)
>  		data->last_config = jiffies;
>  	}  /* last_config */
>  
> -	data->valid = 1;
> +	data->valid = true;
>  
>  	mutex_unlock(&data->update_lock);
>  
> diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
> index b2d820125bb6..1750bc588856 100644
> --- a/drivers/hwmon/lm87.c
> +++ b/drivers/hwmon/lm87.c
> @@ -141,7 +141,7 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A, 0x38, 0x2C };
>  
>  struct lm87_data {
>  	struct mutex update_lock;
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* In jiffies */
>  
>  	u8 channel;		/* register value */
> @@ -251,7 +251,7 @@ static struct lm87_data *lm87_update_device(struct device *dev)
>  		data->aout = lm87_read_value(client, LM87_REG_AOUT);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
> index 9bf278cf0bd0..5bae6eedcaf1 100644
> --- a/drivers/hwmon/lm92.c
> +++ b/drivers/hwmon/lm92.c
> @@ -99,7 +99,7 @@ static const u8 regs[t_num_regs] = {
>  struct lm92_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  
>  	/* registers values */
> @@ -126,7 +126,7 @@ static struct lm92_data *lm92_update_device(struct device *dev)
>  				i2c_smbus_read_word_swapped(client, regs[i]);
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> index 78d6dfaf145b..dc67bf954b21 100644
> --- a/drivers/hwmon/lm93.c
> +++ b/drivers/hwmon/lm93.c
> @@ -202,7 +202,7 @@ struct lm93_data {
>  	/* client update function */
>  	void (*update)(struct lm93_data *, struct i2c_client *);
>  
> -	char valid; /* !=0 if following fields are valid */
> +	bool valid; /* true if following fields are valid */
>  
>  	/* register values, arranged by block read groups */
>  	struct block1_t block1;
> @@ -917,7 +917,7 @@ static struct lm93_data *lm93_update_device(struct device *dev)
>  
>  		data->update(data, client);
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
> index 00dbc170c8c6..8ea46ff20be5 100644
> --- a/drivers/hwmon/lm95241.c
> +++ b/drivers/hwmon/lm95241.c
> @@ -78,7 +78,7 @@ struct lm95241_data {
>  	struct mutex update_lock;
>  	unsigned long last_updated;	/* in jiffies */
>  	unsigned long interval;		/* in milli-seconds */
> -	char valid;		/* zero until following fields are valid */
> +	bool valid;		/* false until following fields are valid */
>  	/* registers values */
>  	u8 temp[ARRAY_SIZE(lm95241_reg_address)];
>  	u8 status, config, model, trutherm;
> @@ -118,7 +118,7 @@ static struct lm95241_data *lm95241_update_device(struct device *dev)
>  		data->status = i2c_smbus_read_byte_data(client,
>  							LM95241_REG_R_STATUS);
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> @@ -257,7 +257,7 @@ static int lm95241_write_temp(struct device *dev, u32 attr, int channel,
>  			else
>  				data->config &= ~R2DF_MASK;
>  		}
> -		data->valid = 0;
> +		data->valid = false;
>  		ret = i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
>  						data->config);
>  		break;
> @@ -273,7 +273,7 @@ static int lm95241_write_temp(struct device *dev, u32 attr, int channel,
>  			else
>  				data->config &= ~R2DF_MASK;
>  		}
> -		data->valid = 0;
> +		data->valid = false;
>  		ret = i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
>  						data->config);
>  		break;
> diff --git a/drivers/hwmon/ltc4151.c b/drivers/hwmon/ltc4151.c
> index 13b85367a21f..e3ac004c1ed1 100644
> --- a/drivers/hwmon/ltc4151.c
> +++ b/drivers/hwmon/ltc4151.c
> @@ -77,7 +77,7 @@ static struct ltc4151_data *ltc4151_update_device(struct device *dev)
>  			data->regs[i] = val;
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  abort:
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
> index 1d18c212054f..fa43d26ddd4f 100644
> --- a/drivers/hwmon/ltc4215.c
> +++ b/drivers/hwmon/ltc4215.c
> @@ -64,7 +64,7 @@ static struct ltc4215_data *ltc4215_update_device(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
> index b81e9c3d297b..b91cc4fe84e5 100644
> --- a/drivers/hwmon/ltc4261.c
> +++ b/drivers/hwmon/ltc4261.c
> @@ -73,13 +73,13 @@ static struct ltc4261_data *ltc4261_update_device(struct device *dev)
>  					"Failed to read ADC value: error %d\n",
>  					val);
>  				ret = ERR_PTR(val);
> -				data->valid = 0;
> +				data->valid = false;
>  				goto abort;
>  			}
>  			data->regs[i] = val;
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  abort:
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
> index ae3a6a7bdaa2..daa5d8af1e69 100644
> --- a/drivers/hwmon/max16065.c
> +++ b/drivers/hwmon/max16065.c
> @@ -166,7 +166,7 @@ static struct max16065_data *max16065_update_device(struct device *dev)
>  			  = i2c_smbus_read_byte_data(client, MAX16065_FAULT(i));
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  	mutex_unlock(&data->update_lock);
>  	return data;
> diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
> index 8bd941cae4d1..eae9e68027bc 100644
> --- a/drivers/hwmon/max1619.c
> +++ b/drivers/hwmon/max1619.c
> @@ -79,7 +79,7 @@ enum temp_index {
>  struct max1619_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  
>  	/* registers values */
> @@ -124,7 +124,7 @@ static struct max1619_data *max1619_update_device(struct device *dev)
>  			data->alarms ^= 0x02;
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
> index 5c41c78f0458..78688e6cb87d 100644
> --- a/drivers/hwmon/max1668.c
> +++ b/drivers/hwmon/max1668.c
> @@ -58,7 +58,7 @@ struct max1668_data {
>  	enum chips type;
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	/* 1x local and 4x remote */
> @@ -120,7 +120,7 @@ static struct max1668_data *max1668_update_device(struct device *dev)
>  	data->alarms |= val;
>  
>  	data->last_updated = jiffies;
> -	data->valid = 1;
> +	data->valid = true;
>  abort:
>  	mutex_unlock(&data->update_lock);
>  
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index b71899c641fa..ccc0f047bd44 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -69,7 +69,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
>  struct max6639_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	/* Register values sampled regularly */
> @@ -141,7 +141,7 @@ static struct max6639_data *max6639_update_device(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  abort:
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
> index 23d93142b0b3..699d265aae2e 100644
> --- a/drivers/hwmon/max6642.c
> +++ b/drivers/hwmon/max6642.c
> @@ -181,7 +181,7 @@ static struct max6642_data *max6642_update_device(struct device *dev)
>  					MAX6642_REG_R_STATUS);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
> index 6a9ba23cd302..0828436a1f6c 100644
> --- a/drivers/hwmon/pc87360.c
> +++ b/drivers/hwmon/pc87360.c
> @@ -178,7 +178,7 @@ struct pc87360_data {
>  	struct device *hwmon_dev;
>  	struct mutex lock;
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	int address[3];
> @@ -1673,7 +1673,7 @@ static struct pc87360_data *pc87360_update_device(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
> index a5cd4de36575..39ff1c9b1df5 100644
> --- a/drivers/hwmon/sch5636.c
> +++ b/drivers/hwmon/sch5636.c
> @@ -56,7 +56,7 @@ struct sch5636_data {
>  	struct device *hwmon_dev;
>  
>  	struct mutex update_lock;
> -	char valid;			/* !=0 if following fields are valid */
> +	bool valid;			/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  	u8 in[SCH5636_NO_INS];
>  	u8 temp_val[SCH5636_NO_TEMPS];
> @@ -140,7 +140,7 @@ static struct sch5636_data *sch5636_update_device(struct device *dev)
>  	}
>  
>  	data->last_updated = jiffies;
> -	data->valid = 1;
> +	data->valid = true;
>  abort:
>  	mutex_unlock(&data->update_lock);
>  	return ret;
> diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
> index 7d18ce5d3839..e23dbf287233 100644
> --- a/drivers/hwmon/sht21.c
> +++ b/drivers/hwmon/sht21.c
> @@ -41,7 +41,7 @@ struct sht21 {
>  	unsigned long last_update;
>  	int temperature;
>  	int humidity;
> -	char valid;
> +	bool valid;
>  	char eic[18];
>  };
>  
> @@ -105,7 +105,7 @@ static int sht21_update_measurements(struct device *dev)
>  			goto out;
>  		sht21->humidity = sht21_rh_ticks_to_per_cent_mille(ret);
>  		sht21->last_update = jiffies;
> -		sht21->valid = 1;
> +		sht21->valid = true;
>  	}
>  out:
>  	mutex_unlock(&sht21->lock);
> diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
> index 0c6741f949f5..018cb5a7651f 100644
> --- a/drivers/hwmon/sis5595.c
> +++ b/drivers/hwmon/sis5595.c
> @@ -172,7 +172,7 @@ struct sis5595_data {
>  	struct mutex lock;
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  	char maxins;		/* == 3 if temp enabled, otherwise == 4 */
>  	u8 revision;		/* Reg. value */
> @@ -728,7 +728,7 @@ static struct sis5595_data *sis5595_update_device(struct device *dev)
>  		    sis5595_read_value(data, SIS5595_REG_ALARM1) |
>  		    (sis5595_read_value(data, SIS5595_REG_ALARM2) << 8);
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
> index 62906d9c4b86..8c4ed72e5d68 100644
> --- a/drivers/hwmon/smm665.c
> +++ b/drivers/hwmon/smm665.c
> @@ -265,7 +265,7 @@ static struct smm665_data *smm665_update_device(struct device *dev)
>  			data->adc[i] = val;
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  abort:
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
> index f928b8d4ff48..c26d6eae0e4e 100644
> --- a/drivers/hwmon/smsc47b397.c
> +++ b/drivers/hwmon/smsc47b397.c
> @@ -96,7 +96,7 @@ struct smsc47b397_data {
>  
>  	struct mutex update_lock;
>  	unsigned long last_updated; /* in jiffies */
> -	int valid;
> +	bool valid;
>  
>  	/* register values */
>  	u16 fan[4];
> @@ -137,7 +137,7 @@ static struct smsc47b397_data *smsc47b397_update_device(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  
>  		dev_dbg(dev, "... device update complete\n");
>  	}
> diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
> index 03a87aa2017a..a5db15c087ae 100644
> --- a/drivers/hwmon/smsc47m192.c
> +++ b/drivers/hwmon/smsc47m192.c
> @@ -86,7 +86,7 @@ struct smsc47m192_data {
>  	struct i2c_client *client;
>  	const struct attribute_group *groups[3];
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	u8 in[8];		/* Register value */
> @@ -157,7 +157,7 @@ static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
>  						SMSC47M192_REG_ALARM2) << 8);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
> index fde5e2d0825a..6a804f5036f4 100644
> --- a/drivers/hwmon/thmc50.c
> +++ b/drivers/hwmon/thmc50.c
> @@ -62,7 +62,7 @@ struct thmc50_data {
>  	enum chips type;
>  	unsigned long last_updated;	/* In jiffies */
>  	char has_temp3;		/* !=0 if it is ADM1022 in temp3 mode */
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  
>  	/* Register values */
>  	s8 temp_input[3];
> @@ -107,7 +107,7 @@ static struct thmc50_data *thmc50_update_device(struct device *dev)
>  		data->alarms =
>  		    i2c_smbus_read_byte_data(client, THMC50_REG_INTR);
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index 9dc210b55e69..88007416c210 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -136,7 +136,7 @@ struct tmp401_data {
>  	struct i2c_client *client;
>  	const struct attribute_group *groups[3];
>  	struct mutex update_lock;
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  	enum chips kind;
>  
> @@ -267,7 +267,7 @@ static struct tmp401_data *tmp401_update_device(struct device *dev)
>  		data->temp_crit_hyst = val;
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  abort:
> @@ -413,7 +413,7 @@ static ssize_t reset_temp_history_store(struct device *dev,
>  	}
>  	mutex_lock(&data->update_lock);
>  	i2c_smbus_write_byte_data(client, TMP401_TEMP_MSB_WRITE[5][0], val);
> -	data->valid = 0;
> +	data->valid = false;
>  	mutex_unlock(&data->update_lock);
>  
>  	return count;
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index b963a369c5ab..9063d71fc11b 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -93,7 +93,7 @@ struct tmp421_data {
>  	struct hwmon_channel_info temp_info;
>  	const struct hwmon_channel_info *info[2];
>  	struct hwmon_chip_info chip;
> -	char valid;
> +	bool valid;
>  	unsigned long last_updated;
>  	unsigned long channels;
>  	u8 config;
> @@ -140,14 +140,14 @@ static int tmp421_update_device(struct tmp421_data *data)
>  			data->temp[i] |= ret;
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  exit:
>  	mutex_unlock(&data->update_lock);
>  
>  	if (ret < 0) {
> -		data->valid = 0;
> +		data->valid = false;
>  		return ret;
>  	}
>  
> diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
> index a2eddd2c2538..55634110c2f9 100644
> --- a/drivers/hwmon/via686a.c
> +++ b/drivers/hwmon/via686a.c
> @@ -304,7 +304,7 @@ struct via686a_data {
>  	const char *name;
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	u8 in[5];		/* Register value */
> @@ -800,7 +800,7 @@ static struct via686a_data *via686a_update_device(struct device *dev)
>  				       VIA686A_REG_ALARM1) |
>  		    (via686a_read_value(data, VIA686A_REG_ALARM2) << 8);
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
> index 2fbdc532aed4..4a5e911d26eb 100644
> --- a/drivers/hwmon/vt1211.c
> +++ b/drivers/hwmon/vt1211.c
> @@ -105,7 +105,7 @@ struct vt1211_data {
>  	struct device *hwmon_dev;
>  
>  	struct mutex update_lock;
> -	char valid;			/* !=0 if following fields are valid */
> +	bool valid;			/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	/* Register values */
> @@ -319,7 +319,7 @@ static struct vt1211_data *vt1211_update_device(struct device *dev)
>  				vt1211_read8(data, VT1211_REG_ALARM1);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
> index 6603727e15a0..03275ac8ba72 100644
> --- a/drivers/hwmon/vt8231.c
> +++ b/drivers/hwmon/vt8231.c
> @@ -145,7 +145,7 @@ struct vt8231_data {
>  
>  	struct mutex update_lock;
>  	struct device *hwmon_dev;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	u8 in[6];		/* Register value */
> @@ -929,7 +929,7 @@ static struct vt8231_data *vt8231_update_device(struct device *dev)
>  			data->alarms &= ~0x80;
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index 705a59663d42..af89b32a93a5 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -320,7 +320,7 @@ struct w83627ehf_data {
>  	const u16 *scale_in;
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	/* Register values */
> @@ -688,7 +688,7 @@ static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
>  						W83627EHF_REG_CASEOPEN_DET);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> @@ -1099,7 +1099,7 @@ clear_caseopen(struct device *dev, struct w83627ehf_data *data, int channel,
>  	reg = w83627ehf_read_value(data, W83627EHF_REG_CASEOPEN_CLR);
>  	w83627ehf_write_value(data, W83627EHF_REG_CASEOPEN_CLR, reg | mask);
>  	w83627ehf_write_value(data, W83627EHF_REG_CASEOPEN_CLR, reg & ~mask);
> -	data->valid = 0;	/* Force cache refresh */
> +	data->valid = false;	/* Force cache refresh */
>  	mutex_unlock(&data->update_lock);
>  
>  	return 0;
> @@ -2004,7 +2004,7 @@ static int __maybe_unused w83627ehf_resume(struct device *dev)
>  	w83627ehf_write_value(data, W83627EHF_REG_VBAT, data->vbat);
>  
>  	/* Force re-reading all values */
> -	data->valid = 0;
> +	data->valid = false;
>  	mutex_unlock(&data->update_lock);
>  
>  	return 0;
> diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
> index a07b97400cba..9be277156ed2 100644
> --- a/drivers/hwmon/w83627hf.c
> +++ b/drivers/hwmon/w83627hf.c
> @@ -355,7 +355,7 @@ struct w83627hf_data {
>  	enum chips type;
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	u8 in[9];		/* Register value */
> @@ -448,7 +448,7 @@ static int w83627hf_resume(struct device *dev)
>  	w83627hf_write_value(data, W83781D_REG_SCFG2, data->scfg2);
>  
>  	/* Force re-reading all values */
> -	data->valid = 0;
> +	data->valid = false;
>  	mutex_unlock(&data->update_lock);
>  
>  	return 0;
> @@ -1905,7 +1905,7 @@ static struct w83627hf_data *w83627hf_update_device(struct device *dev)
>  		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS1) |
>  		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS3) << 16;
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> index ce8e2c10e854..b3579721265f 100644
> --- a/drivers/hwmon/w83781d.c
> +++ b/drivers/hwmon/w83781d.c
> @@ -203,7 +203,7 @@ struct w83781d_data {
>  	int isa_addr;
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	struct i2c_client *lm75[2];	/* for secondary I2C addresses */
> @@ -1554,7 +1554,7 @@ static struct w83781d_data *w83781d_update_device(struct device *dev)
>  					       W83781D_REG_BEEP_INTS3) << 16;
>  		}
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
> index 37b25a1474c4..ca577cd2a1c9 100644
> --- a/drivers/hwmon/w83791d.c
> +++ b/drivers/hwmon/w83791d.c
> @@ -270,7 +270,7 @@ struct w83791d_data {
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
>  
> -	char valid;			/* !=0 if following fields are valid */
> +	bool valid;			/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	/* array of 2 pointers to subclients */
> @@ -1603,7 +1603,7 @@ static struct w83791d_data *w83791d_update_device(struct device *dev)
>  				<< 4;
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> index abd5c3a722b9..4bfebdab1c60 100644
> --- a/drivers/hwmon/w83792d.c
> +++ b/drivers/hwmon/w83792d.c
> @@ -261,7 +261,7 @@ struct w83792d_data {
>  	struct device *hwmon_dev;
>  
>  	struct mutex update_lock;
> -	char valid;		/* !=0 if following fields are valid */
> +	bool valid;		/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	/* array of 2 pointers to subclients */
> @@ -743,7 +743,7 @@ intrusion0_alarm_store(struct device *dev, struct device_attribute *attr,
>  	mutex_lock(&data->update_lock);
>  	reg = w83792d_read_value(client, W83792D_REG_CHASSIS_CLR);
>  	w83792d_write_value(client, W83792D_REG_CHASSIS_CLR, reg | 0x80);
> -	data->valid = 0;		/* Force cache refresh */
> +	data->valid = false;		/* Force cache refresh */
>  	mutex_unlock(&data->update_lock);
>  
>  	return count;
> @@ -1595,7 +1595,7 @@ static struct w83792d_data *w83792d_update_device(struct device *dev)
>  		}
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index e7d0484eabe4..81221702951a 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -205,7 +205,7 @@ struct w83793_data {
>  	struct i2c_client *lm75[2];
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
> -	char valid;			/* !=0 if following fields are valid */
> +	bool valid;			/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  	unsigned long last_nonvolatile;	/* In jiffies, last time we update the
>  					 * nonvolatile registers
> @@ -453,7 +453,7 @@ store_chassis_clear(struct device *dev,
>  	mutex_lock(&data->update_lock);
>  	reg = w83793_read_value(client, W83793_REG_CLR_CHASSIS);
>  	w83793_write_value(client, W83793_REG_CLR_CHASSIS, reg | 0x80);
> -	data->valid = 0;		/* Force cache refresh */
> +	data->valid = false;		/* Force cache refresh */
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -2081,7 +2081,7 @@ static struct w83793_data *w83793_update_device(struct device *dev)
>  		data->vid[1] = w83793_read_value(client, W83793_REG_VID_INB);
>  	w83793_update_nonvolatile(dev);
>  	data->last_updated = jiffies;
> -	data->valid = 1;
> +	data->valid = true;
>  
>  END:
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
> index 621b05afa837..45b12c4287df 100644
> --- a/drivers/hwmon/w83795.c
> +++ b/drivers/hwmon/w83795.c
> @@ -379,7 +379,7 @@ struct w83795_data {
>  	u8 enable_beep;
>  	u8 beeps[6];		/* Register value */
>  
> -	char valid;
> +	bool valid;
>  	char valid_limits;
>  	char valid_pwm_config;
>  };
> @@ -684,7 +684,7 @@ static struct w83795_data *w83795_update_device(struct device *dev)
>  			     tmp & ~ALARM_CTRL_RTSACS);
>  
>  	data->last_updated = jiffies;
> -	data->valid = 1;
> +	data->valid = true;
>  
>  END:
>  	mutex_unlock(&data->update_lock);
> @@ -764,7 +764,7 @@ store_chassis_clear(struct device *dev,
>  
>  	/* Clear status and force cache refresh */
>  	w83795_read(client, W83795_REG_ALARM(5));
> -	data->valid = 0;
> +	data->valid = false;
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
> index 656a77102ca6..a41f989d66e2 100644
> --- a/drivers/hwmon/w83l785ts.c
> +++ b/drivers/hwmon/w83l785ts.c
> @@ -98,7 +98,7 @@ static struct i2c_driver w83l785ts_driver = {
>  struct w83l785ts_data {
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
> -	char valid; /* zero until following fields are valid */
> +	bool valid; /* false until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  
>  	/* registers values */
> @@ -270,7 +270,7 @@ static struct w83l785ts_data *w83l785ts_update_device(struct device *dev)
>  				W83L785TS_REG_TEMP_OVER, data->temp[1]);
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  	}
>  
>  	mutex_unlock(&data->update_lock);
> diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
> index 542afff1423b..11ba23c1af85 100644
> --- a/drivers/hwmon/w83l786ng.c
> +++ b/drivers/hwmon/w83l786ng.c
> @@ -113,7 +113,7 @@ DIV_TO_REG(long val)
>  struct w83l786ng_data {
>  	struct i2c_client *client;
>  	struct mutex update_lock;
> -	char valid;			/* !=0 if following fields are valid */
> +	bool valid;			/* true if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  	unsigned long last_nonvolatile;	/* In jiffies, last time we update the
>  					 * nonvolatile registers */
> @@ -209,7 +209,7 @@ static struct w83l786ng_data *w83l786ng_update_device(struct device *dev)
>  		data->tolerance[1] = (reg_tmp >> 4) & 0x0f;
>  
>  		data->last_updated = jiffies;
> -		data->valid = 1;
> +		data->valid = true;
>  
>  	}
>  
> -- 
> 2.17.1
> 
