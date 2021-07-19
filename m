Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE3C3CEDFB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358502AbhGSURO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 16:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387179AbhGSTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:55:58 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E11C0613DD;
        Mon, 19 Jul 2021 13:31:59 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id o2-20020a0568200402b0290258a7ff4058so2670724oou.10;
        Mon, 19 Jul 2021 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CnGPA9k5jAnGBAAGW5ixT1QhP02OGDK8n1UCPbob07o=;
        b=Pm8yu2gf+hlzn+55X/bDKWMa8As3RwFoGStNgel0D8Uyvvd6jzhTIZYZw3geqPdIMW
         ZGlCrHwftraox+L/LeqzJvUMCpNHt+6NdgbMimP7fHKtZmEPFZxNaQTJe2TJGLgtfuTt
         sU/kZaer8jaN1pvWRGZOp+Fq2Ao5s/uYzPIDq+B+z7G8AZ3PF+ZRcLD1ZpxqHh8pB+sr
         GS5ln6fsrSftTJgfVgGsDJ9lzNwNWOf6MCxDdZND26fB/bUWgxmNeRrsBFX3/YEvXZaX
         ZqWaEyAPqhsKiW4zMEpVrS24BS8QJQ3gyYVBSom/VGzLmg0eNYO3c3kKyb2UmOhSU8DD
         cEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=CnGPA9k5jAnGBAAGW5ixT1QhP02OGDK8n1UCPbob07o=;
        b=H0NSJbEEs47emqu4b5rgVxg/8fj23CRCTG/jEgXPI2fn7WjphANGQBSUl5L/WC/75a
         Gwlg8YwRlfzQlu0b/HPb0IyGaqcN73Qh0ODzgCpWYmlzGdvTZ9jpbMHPtx8WZG9q0yR7
         qnJznPfK85zMO6kzpmwtlJ8nLwkQp6ivJVcS77ecbhKxKk9P74zAPTnSZ457V2RxdQbg
         vmlmSJbTTq6sfuR7YxO9cgtOzWY9Rnj0wcuSOLOq9V9fiBMyk+O+pT+Y3XAvjxVHLIDP
         HVgM1C5KxAGd2TMMrd39NeqzPamLTQTH8thVMLT8aOFlQPQc+fGKiLrde1JrdoFeSUAz
         IZmQ==
X-Gm-Message-State: AOAM531y5z8+p2p3sGcy+E09K91A+/6NUd5PYwLUBAwPNNGYrlIC4YRy
        pmpIaDiFfIN9VK9tE7E2iUw=
X-Google-Smtp-Source: ABdhPJwC+ITNhkPvbxptB2sPYgUDu+tCWQlgRApn/ULuEKeLsTUiChZ4F19JQXpgRQm3lOpfzE1hRQ==
X-Received: by 2002:a4a:5dc6:: with SMTP id w189mr18755739ooa.1.1626726906873;
        Mon, 19 Jul 2021 13:35:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j10sm3084117oog.47.2021.07.19.13.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 13:35:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Jul 2021 13:35:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/14] hwmon: peci: Add cputemp driver
Message-ID: <20210719203504.GA2277987@roeck-us.net>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-12-iwona.winiarska@intel.com>
 <20210715174527.GA3012477@roeck-us.net>
 <66b4a0285ffada1855eb099011bed27b2750b3cc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66b4a0285ffada1855eb099011bed27b2750b3cc.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 08:12:54PM +0000, Winiarska, Iwona wrote:

> > > +static const char *cputemp_label[DEFAULT_CHANNEL_NUMS] = {
> > > +       "Die",
> > > +       "DTS",
> > > +       "Tcontrol",
> > > +       "Tthrottle",
> > > +       "Tjmax",
> > > +};
> > > +
> > > +static int get_temp_targets(struct peci_cputemp *priv)
> > > +{
> > > +       s32 tthrottle_offset, tcontrol_margin;
> > > +       u32 pcs;
> > > +       int ret;
> > > +
> > > +       /*
> > > +        * Just use only the tcontrol marker to determine if target values
> > > need
> > > +        * update.
> > > +        */
> > > +       if (!peci_sensor_need_update(&priv->temp.tcontrol))
> > > +               return 0;
> > > +
> > True for the entire code: Please explain how this avoids race conditions
> > without locking between the condition check here and the call to
> > peci_sensor_mark_updated() below. The explanation needs to be added
> > as comment into the code for later reference.
> > 
> 
> You're right, there is a race here that may cause PECI command to be triggered
> more than once. It doesn't have any impact on correctness though.

That is only correct if multiple read operations of PECI_PCS_TEMP_TARGET
always return the same value. If so, reading those values multiple times
would not make sense. Instead, the values could be read once and cached.
If PECI_PCS_TEMP_TARGET can return different values each time it is called,
the lack of mutex protection could result in inconsistent values for
priv->temp.tjmax.value, priv->temp.tcontrol.value, and
priv->temp.tthrottle.value.

So either this needs a mutex, or the code should be changed to read the
static values only once.

You could instead add a comment stating that multiple unprotected reads
are redundant because the returned data is static, that parallel reads
are thus not racy, and that a mutex is therefore not needed, but I won't
accept such code.

> I could add a comment explaining that, but I guess just adding a mutex to avoid
> the race makes more sense. 
> 
> > > +       ret = peci_pcs_read(priv->peci_dev, PECI_PCS_TEMP_TARGET, 0, &pcs);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       priv->temp.tjmax.value = FIELD_GET(TEMP_TARGET_REF_TEMP_MASK, pcs) *
> > > MILLIDEGREE_PER_DEGREE;
> > > +
> > > +       tcontrol_margin = FIELD_GET(TEMP_TARGET_FAN_TEMP_MASK, pcs);
> > > +       tcontrol_margin = sign_extend32(tcontrol_margin, 7) *
> > > MILLIDEGREE_PER_DEGREE;
> > > +       priv->temp.tcontrol.value = priv->temp.tjmax.value - tcontrol_margin;
> > > +
> > > +       tthrottle_offset = FIELD_GET(TEMP_TARGET_TJ_OFFSET_MASK, pcs) *
> > > MILLIDEGREE_PER_DEGREE;
> > > +       priv->temp.tthrottle.value = priv->temp.tjmax.value -
> > > tthrottle_offset;
> > > +
> > > +       peci_sensor_mark_updated(&priv->temp.tcontrol);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/*
> > > + * Processors return a value of DTS reading in S10.6 fixed point format
> > > + * (sign, 10 bits signed integer value, 6 bits fractional).
> > > + * Error codes:
> > > + *   0x8000: General sensor error
> > > + *   0x8001: Reserved
> > > + *   0x8002: Underflow on reading value
> > > + *   0x8003-0x81ff: Reserved
> > > + */
> > > +static bool dts_valid(s32 val)
> > > +{
> > > +       return val < 0x8000 || val > 0x81ff;
> > > +}
> > > +
> > > +static s32 dts_to_millidegree(s32 val)
> > > +{
> > > +       return sign_extend32(val, 15) * MILLIDEGREE_PER_DEGREE /
> > > DTS_FIXED_POINT_FRACTION;
> > > +}
> > > +
> > > +static int get_die_temp(struct peci_cputemp *priv)
> > > +{
> > > +       s16 temp;
> > > +       int ret;
> > > +
> > > +       if (!peci_sensor_need_update(&priv->temp.die))
> > > +               return 0;
> > > +
> > > +       ret = peci_temp_read(priv->peci_dev, &temp);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       if (!dts_valid(temp))
> > > +               return -EIO;
> > > +
> > > +       /* Note that the tjmax should be available before calling it */
> > > +       priv->temp.die.value = priv->temp.tjmax.value +
> > > dts_to_millidegree(temp);
> > > +
> > > +       peci_sensor_mark_updated(&priv->temp.die);

The same is true here: Either the value returned from peci_temp_read()
is static (which seems unlikely), or there is a race between reading
the temperature, storing it in priv->temp.die.value, and setting the
update flag. With the current code, there is no guarantee that the
stored value is the value that was read by the thread that sets the
updated flag. One could argue that it doesn't really matter because it
is irrelevant which thread stores the temperature and which thread sets
the updated flag, but that is really bad coding style, and I won't
accept it.

This is true for all code which reads a value from the chip, stores
it locally, and then sets the updated flag.

> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int get_dts(struct peci_cputemp *priv)
> > > +{
> > > +       s32 dts_margin;
> > > +       u32 pcs;
> > > +       int ret;
> > > +
> > > +       if (!peci_sensor_need_update(&priv->temp.dts))
> > > +               return 0;
> > > +
> > > +       ret = peci_pcs_read(priv->peci_dev, PECI_PCS_THERMAL_MARGIN, 0, &pcs);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       dts_margin = FIELD_GET(DTS_MARGIN_MASK, pcs);
> > > +       if (!dts_valid(dts_margin))
> > > +               return -EIO;
> > > +
> > > +       /* Note that the tcontrol should be available before calling it */
> > > +       priv->temp.dts.value = priv->temp.tcontrol.value -
> > > dts_to_millidegree(dts_margin);
> > > +
> > > +       peci_sensor_mark_updated(&priv->temp.dts);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int get_core_temp(struct peci_cputemp *priv, int core_index)
> > > +{
> > > +       s32 core_dts_margin;
> > > +       u32 pcs;
> > > +       int ret;
> > > +
> > > +       if (!peci_sensor_need_update(&priv->temp.core[core_index]))
> > > +               return 0;
> > > +
> > > +       ret = peci_pcs_read(priv->peci_dev, PECI_PCS_MODULE_TEMP, core_index,
> > > &pcs);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       core_dts_margin = FIELD_GET(PCS_MODULE_TEMP_MASK, pcs);
> > > +       if (!dts_valid(core_dts_margin))
> > > +               return -EIO;
> > > +
> > > +       /* Note that the tjmax should be available before calling it */
> > > +       priv->temp.core[core_index].value =
> > > +               priv->temp.tjmax.value + dts_to_millidegree(core_dts_margin);
> > > +
> > > +       peci_sensor_mark_updated(&priv->temp.core[core_index]);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int cputemp_read_string(struct device *dev, enum hwmon_sensor_types
> > > type,
> > > +                              u32 attr, int channel, const char **str)
> > > +{
> > > +       struct peci_cputemp *priv = dev_get_drvdata(dev);
> > > +
> > > +       if (attr != hwmon_temp_label)
> > > +               return -EOPNOTSUPP;
> > > +
> > > +       *str = channel < channel_core ?
> > > +               cputemp_label[channel] : priv->coretemp_label[channel -
> > > channel_core];
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int cputemp_read(struct device *dev, enum hwmon_sensor_types type,
> > > +                       u32 attr, int channel, long *val)
> > > +{
> > > +       struct peci_cputemp *priv = dev_get_drvdata(dev);
> > > +       int ret, core_index;
> > > +
> > > +       ret = get_temp_targets(priv);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       switch (attr) {
> > > +       case hwmon_temp_input:
> > > +               switch (channel) {
> > > +               case channel_die:
> > > +                       ret = get_die_temp(priv);
> > > +                       if (ret)
> > > +                               return ret;
> > > +
> > > +                       *val = priv->temp.die.value;
> > > +                       break;
> > > +               case channel_dts:
> > > +                       ret = get_dts(priv);
> > > +                       if (ret)
> > > +                               return ret;
> > > +
> > > +                       *val = priv->temp.dts.value;
> > > +                       break;
> > > +               case channel_tcontrol:
> > > +                       *val = priv->temp.tcontrol.value;
> > > +                       break;
> > > +               case channel_tthrottle:
> > > +                       *val = priv->temp.tthrottle.value;
> > > +                       break;
> > > +               case channel_tjmax:
> > > +                       *val = priv->temp.tjmax.value;
> > > +                       break;
> > > +               default:
> > > +                       core_index = channel - channel_core;
> > > +                       ret = get_core_temp(priv, core_index);
> > > +                       if (ret)
> > > +                               return ret;
> > > +
> > > +                       *val = priv->temp.core[core_index].value;
> > > +                       break;
> > > +               }
> > > +               break;
> > > +       case hwmon_temp_max:
> > > +               *val = priv->temp.tcontrol.value;
> > > +               break;
> > > +       case hwmon_temp_crit:
> > > +               *val = priv->temp.tjmax.value;
> > > +               break;
> > > +       case hwmon_temp_crit_hyst:
> > > +               *val = priv->temp.tjmax.value - priv->temp.tcontrol.value;
> > > +               break;
> > > +       default:
> > > +               return -EOPNOTSUPP;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static umode_t cputemp_is_visible(const void *data, enum hwmon_sensor_types
> > > type,
> > > +                                 u32 attr, int channel)
> > > +{
> > > +       const struct peci_cputemp *priv = data;
> > > +
> > > +       if (channel > CPUTEMP_CHANNEL_NUMS)
> > > +               return 0;
> > > +
> > > +       if (channel < channel_core)
> > > +               return 0444;
> > > +
> > > +       if (test_bit(channel - channel_core, priv->core_mask))
> > > +               return 0444;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int init_core_mask(struct peci_cputemp *priv)
> > > +{
> > > +       struct peci_device *peci_dev = priv->peci_dev;
> > > +       struct resolved_cores_reg *reg = priv->gen_info->reg;
> > > +       u64 core_mask;
> > > +       u32 data;
> > > +       int ret;
> > > +
> > > +       /* Get the RESOLVED_CORES register value */
> > > +       switch (peci_dev->info.model) {
> > > +       case INTEL_FAM6_ICELAKE_X:
> > > +       case INTEL_FAM6_ICELAKE_D:
> > > +               ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
> > > +                                            reg->func, reg->offset + 4,
> > > &data);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               core_mask = (u64)data << 32;
> > > +
> > > +               ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
> > > +                                            reg->func, reg->offset, &data);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               core_mask |= data;
> > > +
> > > +               break;
> > > +       default:
> > > +               ret = peci_pci_local_read(peci_dev, reg->bus, reg->dev,
> > > +                                         reg->func, reg->offset, &data);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               core_mask = data;
> > > +
> > > +               break;
> > > +       }
> > > +
> > > +       if (!core_mask)
> > > +               return -EIO;
> > > +
> > > +       bitmap_from_u64(priv->core_mask, core_mask);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int create_temp_label(struct peci_cputemp *priv)
> > > +{
> > > +       unsigned long core_max = find_last_bit(priv->core_mask,
> > > CORE_NUMS_MAX);
> > > +       int i;
> > > +
> > > +       priv->coretemp_label = devm_kzalloc(priv->dev, core_max * sizeof(char
> > > *), GFP_KERNEL);
> > > +       if (!priv->coretemp_label)
> > > +               return -ENOMEM;
> > > +
> > > +       for_each_set_bit(i, priv->core_mask, CORE_NUMS_MAX) {
> > > +               priv->coretemp_label[i] = devm_kasprintf(priv->dev,
> > > GFP_KERNEL, "Core %d", i);
> > > +               if (!priv->coretemp_label[i])
> > > +                       return -ENOMEM;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void check_resolved_cores(struct peci_cputemp *priv)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = init_core_mask(priv);
> > > +       if (ret)
> > > +               return;
> > > +
> > > +       ret = create_temp_label(priv);
> > > +       if (ret)
> > > +               bitmap_zero(priv->core_mask, CORE_NUMS_MAX);
> > 
> > This needs a comment explaining why it is ok to ignore the above errors.
> > 
> > I understand it is because the non-core data will still be available.
> > Yet, it still needs to be explained so others don't need to examine
> > the code to figure out the reason.
> > 
> 
> Right - I'll add a:
> /*
>  * Failure to resolve cores is non-critical, we're still able to
>  * provide other sensor data.
>  */
> 
> > > +}
> > > +
> > > +static const struct hwmon_ops peci_cputemp_ops = {
> > > +       .is_visible = cputemp_is_visible,
> > > +       .read_string = cputemp_read_string,
> > > +       .read = cputemp_read,
> > > +};
> > > +
> > > +static const u32 peci_cputemp_temp_channel_config[] = {
> > > +       /* Die temperature */
> > > +       HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > > HWMON_T_CRIT_HYST,
> > > +       /* DTS margin */
> > > +       HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > > HWMON_T_CRIT_HYST,
> > > +       /* Tcontrol temperature */
> > > +       HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_CRIT,
> > > +       /* Tthrottle temperature */
> > > +       HWMON_T_LABEL | HWMON_T_INPUT,
> > > +       /* Tjmax temperature */
> > > +       HWMON_T_LABEL | HWMON_T_INPUT,
> > > +       /* Core temperature - for all core channels */
> > > +       [channel_core ... CPUTEMP_CHANNEL_NUMS - 1] = HWMON_T_LABEL |
> > > HWMON_T_INPUT,
> > > +       0
> > > +};
> > > +
> > > +static const struct hwmon_channel_info peci_cputemp_temp_channel = {
> > > +       .type = hwmon_temp,
> > > +       .config = peci_cputemp_temp_channel_config,
> > > +};
> > > +
> > > +static const struct hwmon_channel_info *peci_cputemp_info[] = {
> > > +       &peci_cputemp_temp_channel,
> > > +       NULL
> > > +};
> > > +
> > > +static const struct hwmon_chip_info peci_cputemp_chip_info = {
> > > +       .ops = &peci_cputemp_ops,
> > > +       .info = peci_cputemp_info,
> > > +};
> > > +
> > > +static int peci_cputemp_probe(struct auxiliary_device *adev,
> > > +                             const struct auxiliary_device_id *id)
> > > +{
> > > +       struct device *dev = &adev->dev;
> > > +       struct peci_device *peci_dev = to_peci_device(dev->parent);
> > > +       struct peci_cputemp *priv;
> > > +       struct device *hwmon_dev;
> > > +
> > > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +       if (!priv)
> > > +               return -ENOMEM;
> > > +
> > > +       priv->name = devm_kasprintf(dev, GFP_KERNEL, "peci_cputemp.cpu%d",
> > > +                                   peci_dev->info.socket_id);
> > > +       if (!priv->name)
> > > +               return -ENOMEM;
> > > +
> > > +       dev_set_drvdata(dev, priv);
> > 
> > What is this used for ?
> 
> Our sensors are per-device. We need this to access the corresponding priv in
> cputemp_read_string() and cputemp_read().
> 

The parameter to both cputemp_read_string() and cputemp_read() is the
pointer to the hwmon device, not the pointer to the auxiliary device.
It has its driver data set to 'priv' from the parameter passed to
devm_hwmon_device_register_with_info().

> > 
> > > +       priv->dev = dev;
> > > +       priv->peci_dev = peci_dev;
> > > +       priv->gen_info = (const struct cpu_info *)id->driver_data;
> > > +
> > > +       check_resolved_cores(priv);
> > > +
> > > +       hwmon_dev = devm_hwmon_device_register_with_info(priv->dev, priv-
> > > >name,
> > > +                                                        priv,
> > > &peci_cputemp_chip_info, NULL);
> > > +
> > > +       return PTR_ERR_OR_ZERO(hwmon_dev);
> > > +}
> > > +
> > > +static struct resolved_cores_reg resolved_cores_reg_hsx = {
> > > +       .bus = 1,
> > > +       .dev = 30,
> > > +       .func = 3,
> > > +       .offset = 0xb4,
> > > +};
> > > +
> > > +static struct resolved_cores_reg resolved_cores_reg_icx = {
> > > +       .bus = 14,
> > > +       .dev = 30,
> > > +       .func = 3,
> > > +       .offset = 0xd0,
> > > +};
> > 
> > Please explain those magic numbers.
> > 
> 
> Those magic numbers refer to BDF (bus, device, function) and offset of the PCI
> config register (RESOLVED_CORES_CFG) that can be accessed via PECI to read
> resolved cores configuration.
> Unfortunately, the values are just platform-specific magic numbers.
> Do you think this should be explained with an additional comment?
> 

Yes, please.

Guenter

> Thank you
> -Iwona
> 
> > > +
> > > +static const struct cpu_info cpu_hsx = {
> > > +       .reg            = &resolved_cores_reg_hsx,
> > > +       .min_peci_revision = 0x30,
> > > +};
> > > +
> > > +static const struct cpu_info cpu_icx = {
> > > +       .reg            = &resolved_cores_reg_icx,
> > > +       .min_peci_revision = 0x40,
> > > +};
> > > +
> > > +static const struct auxiliary_device_id peci_cputemp_ids[] = {
> > > +       {
> > > +               .name = "peci_cpu.cputemp.hsx",
> > > +               .driver_data = (kernel_ulong_t)&cpu_hsx,
> > > +       },
> > > +       {
> > > +               .name = "peci_cpu.cputemp.bdx",
> > > +               .driver_data = (kernel_ulong_t)&cpu_hsx,
> > > +       },
> > > +       {
> > > +               .name = "peci_cpu.cputemp.bdxd",
> > > +               .driver_data = (kernel_ulong_t)&cpu_hsx,
> > > +       },
> > > +       {
> > > +               .name = "peci_cpu.cputemp.skx",
> > > +               .driver_data = (kernel_ulong_t)&cpu_hsx,
> > > +       },
> > > +       {
> > > +               .name = "peci_cpu.cputemp.icx",
> > > +               .driver_data = (kernel_ulong_t)&cpu_icx,
> > > +       },
> > > +       {
> > > +               .name = "peci_cpu.cputemp.icxd",
> > > +               .driver_data = (kernel_ulong_t)&cpu_icx,
> > > +       },
> > > +       { }
> > > +};
> > > +MODULE_DEVICE_TABLE(auxiliary, peci_cputemp_ids);
> > > +
> > > +static struct auxiliary_driver peci_cputemp_driver = {
> > > +       .probe          = peci_cputemp_probe,
> > > +       .id_table       = peci_cputemp_ids,
> > > +};
> > > +
> > > +module_auxiliary_driver(peci_cputemp_driver);
> > > +
> > > +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
> > > +MODULE_AUTHOR("Iwona Winiarska <iwona.winiarska@intel.com>");
> > > +MODULE_DESCRIPTION("PECI cputemp driver");
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_IMPORT_NS(PECI_CPU);
> 
