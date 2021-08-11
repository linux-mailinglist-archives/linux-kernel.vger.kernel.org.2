Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FF3E9B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhHKXSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhHKXSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:18:32 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C8C061765;
        Wed, 11 Aug 2021 16:18:08 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m3so2147583qvu.0;
        Wed, 11 Aug 2021 16:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u5VrrhZ8WwEDwIF2Xg4zoge/faLgqcYEi6kJMpsOjec=;
        b=MjRUcT2j8Z2PDgKvN55Wo4u4k9sLvfWaesW7Swph7d555AhMzpgEJin4+cKlCcC1sZ
         rDzAUVJkpcAMngqDNXtG7WXTkcxcMYD4wLrc9u+GxXYr9r8fTEX+cf5LZePfZoB2mSNR
         VBLJvSCFFnvHI+R65oy750Ejie+lWQ1SxJfP+fZ3/qcdQrv3hlkANidCMWPQEJadFZXj
         Jr+uMPcXt1Tb1SoeCiiX+xKy0dlRj7vGV1hzzCPr52MNWL1ZeuXLD35V8IFgVisENMdO
         bty4mJwHg5LiGDeZOM+naYYvakzf2DEgSaYH+vySQc7xYRpnk4Yt2hYY2CTVFrj+IRRq
         wTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=u5VrrhZ8WwEDwIF2Xg4zoge/faLgqcYEi6kJMpsOjec=;
        b=B2DfxmqvVjf1BL4LJuzSm12K52HLiXvLuTo4ksFHvjUdyb4vh364N72Y6SRGMQFCHE
         YmiecyRVQUzu729bu21aTSPcQKREmlpjt4HCy2ZbPSv4YCgtr5e97VXdRl2O9cQjGAOn
         78KwgySJBotUXPKn73aCdDSxjnmz5mMJottCZe0WQJnnlYzzKuNmeSuUhLYIIxKfl+v2
         crJPJvjXebM7+C2hE6TjvtqPXbk1LrbCGPhAYITkC1eGZDHYRk99zQobDVEipgq9FZAk
         nfy6tSARkdxwu/xoUgnq36TmRfk+9tKpLpeIa+hYalVFFDbQdgudYpi9oO28XwfHiAUF
         Vyxg==
X-Gm-Message-State: AOAM5301nc+PTTkTVB857EgOfNaiTLlS+ePrCaITbA5otPybzgxodJy8
        24TQftlCq+X339TTZcWlcWmdcDiJPlM=
X-Google-Smtp-Source: ABdhPJwIKm7xGb9++CQY8HRA+avpaTcuq7HacIgqo2lkbRwudklbnrsaUSr4F8WlJL6Jr4pmhxBOKg==
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr1099492qvp.12.1628723887578;
        Wed, 11 Aug 2021 16:18:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o10sm316402qtv.31.2021.08.11.16.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 16:18:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 16:18:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/bpa-rs600) Add workaround for
 incorrect Pin max
Message-ID: <20210811231805.GA1095781@roeck-us.net>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
 <20210811041738.15061-3-chris.packham@alliedtelesis.co.nz>
 <20210811195327.GA966160@roeck-us.net>
 <b02c3a4d-4d91-0506-7833-6266efc0a2fc@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b02c3a4d-4d91-0506-7833-6266efc0a2fc@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:19:44PM +0000, Chris Packham wrote:
> 
> On 12/08/21 7:53 am, Guenter Roeck wrote:
> > On Wed, Aug 11, 2021 at 04:17:38PM +1200, Chris Packham wrote:
> >> BPD-RS600 modules running firmware v5.70 misreport the MFR_PIN_MAX.
> >> The indicate a maximum of 1640W instead of 700W. Detect the invalid
> >> reading and return a sensible value instead.
> >>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >> ---
> >>   drivers/hwmon/pmbus/bpa-rs600.c | 21 ++++++++++++++++++++-
> >>   1 file changed, 20 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs600.c
> >> index d495faa89799..f4baed9ce8a4 100644
> >> --- a/drivers/hwmon/pmbus/bpa-rs600.c
> >> +++ b/drivers/hwmon/pmbus/bpa-rs600.c
> >> @@ -65,6 +65,24 @@ static int bpa_rs600_read_vin(struct i2c_client *client)
> >>   	return ret;
> >>   }
> >>   
> >> +/*
> >> + * The firmware on some BPD-RS600 models incorrectly reports 1640W
> >> + * for MFR_PIN_MAX. Deal with this by returning a sensible value.
> >> + */
> >> +static int bpa_rs600_read_pin_max(struct i2c_client *client)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	if (ret == 0x0b34)
> >> +		return 0x095e;
> > The comments from the descriotion need to be here.
> will update
> > Thanks,
> > Guenter
> >
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>   static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int phase, int reg)
> >>   {
> >>   	int ret;
> >> @@ -92,7 +110,8 @@ static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int pha
> >>   		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_IOUT_MAX);
> >>   		break;
> >>   	case PMBUS_PIN_OP_WARN_LIMIT:
> >> -		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
> >> +	case PMBUS_MFR_PIN_MAX:
> >> +		ret = bpa_rs600_read_pin_max(client);
> > So the idea is to return the same value for PMBUS_PIN_OP_WARN_LIMIT
> > (max_alarm) and PMBUS_MFR_PIN_MAX (rated_max) ? That doesn't really
> > make sense. The meaning of those limits is distinctly different.
> For the BPA-RS600/BPD-RS600 these appear to be treated the same.

What a mess. This needs to be documented in the driver, including the
behavior if any of those attributes is written into.

Guenter

> >
> > Guenter
> >
> >>   		break;
> >>   	case PMBUS_POUT_OP_WARN_LIMIT:
> >>   		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_POUT_MAX);
> >> -- 
> >> 2.32.0
> >>
