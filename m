Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E99B45807B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 22:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhKTVju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 16:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhKTVjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 16:39:49 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 13:36:45 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h23so13950780ila.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 13:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=2ym3jgXfty8UXyjcPml2J7z3wKvOhRl8Is0wkpPJJXk=;
        b=VENRBHWdL293tBfK7NMYlY9+H+I5W+mKSFe/RAa0BYXM+qD1WdHG8CiFicXIiEM6V0
         ijexNlm9D+r/yavf/gPn5b1iSs38u7EZec5U8smKWnTNmKGkqUg+lq0W/PtGmkZjMcnL
         HoQOB0DVREmM9su89gvOWBjquu5DvqKQcKYlOeULyrTm+7Tw95WiNxdKr2ttRqRtmQq3
         gLgJ44SCfaXB5R+SmkOyC6F4mzTHPt2OuBCO26h+3K1PyXUPXfkrPqPWDVHkrQD1/1Aj
         cRa8YdkBZsPmUCTxivkL0qUiKCGmGezsCOFH3gyrUeSz1bFxbkiq9PqwTuEn+NLwhVqd
         NZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=2ym3jgXfty8UXyjcPml2J7z3wKvOhRl8Is0wkpPJJXk=;
        b=E6C81RHYOeBNBOOdJg1NARpGmfCXEJKMLuR9pUAuXABKS7AJ5YhITjy0yOJGrI3W4k
         f5pJ6G/V1fjxBo+KTjOHGABF4zWpUpAWOpzVtnUn+/0NCgZXWPgtczNNpg7N0vm1bN9V
         roi6SXfySdNcO7+C7lr1YgvLS54UOhBKVwUuis/diZB3YUstGdiD5KV7MqtkEzdEl9aW
         o8p282Wvt2KjcjORiMMCRAuPh/GXLhWLjbiMi4mA2MSy1EK9BsZRjlrpAbOpvyrkgtop
         BEiwkXD6H8CV4UdRk8zb3CS+NNn7ok9iE/ELQaJN/toO5Evod7KQ9GSRVzbIIZrHtdka
         m41A==
X-Gm-Message-State: AOAM531TRyyKC8LHQcCKsNeoTUZXrvuc9eJiVmWKYwi0sSU+323XrMO+
        DVm2HDCirqS0F5el2kajNxNEGfz/ogL8S48=
X-Google-Smtp-Source: ABdhPJwNBChRQ+t9fbcpGdKC/acImTmcF9oEnTJMarJeXzokb8qvzNfwiywvGK2+7TTrpeP1xCeZxw==
X-Received: by 2002:a05:6e02:160c:: with SMTP id t12mr10853621ilu.308.1637444204755;
        Sat, 20 Nov 2021 13:36:44 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:2ba9:697d:eeec:13b? ([2601:281:8300:4e0:2ba9:697d:eeec:13b])
        by smtp.gmail.com with ESMTPSA id h18sm2097231ilq.60.2021.11.20.13.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 13:36:44 -0800 (PST)
Message-ID: <5f5798b3f021c419e94714ba557be0e3a40c671e.camel@egauge.net>
Subject: Re: [PATCH v2 2/2] hwmon: (sht4x) Add device tree match table and
 document it
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Nov 2021 14:36:39 -0700
In-Reply-To: <4ebe1f6a-575f-2d34-7839-9055545e5e6b@roeck-us.net>
References: <20211120204053.2299501-1-davidm@egauge.net>
         <20211120204053.2299501-2-davidm@egauge.net>
         <4ebe1f6a-575f-2d34-7839-9055545e5e6b@roeck-us.net>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-11-20 at 13:12 -0800, Guenter Roeck wrote:
> On 11/20/21 12:40 PM, David Mosberger-Tang wrote:
> > This patch enables automatic loading of the sht4x module via a device
> > tree table entry.
> > 
> > Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> > ---
> >   .../bindings/hwmon/sensirion,sht4x.yaml       | 50 +++++++++++++++++++
> >   drivers/hwmon/sht4x.c                         |  7 +++
> 
> This needs to be two separate patches, one the devicetree change and the other
> the source code change. DT maintainers need to be copied on the devicetree
> patch.

Isn't that going to be confusing if one but not the other patch makes
it into a repository?  Either you end up with an undocumented device
tree property or you end up with documentation for an unsupported
property.

> Also, please consider adding the device to trivial-devices.yaml instead since
> there are no special bindings.

I didn't know it existed.  Sure, that's much easier.

  --david

> Thanks,
> Guenter
> 
> >   2 files changed, 57 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml
> > new file mode 100644
> > index 000000000000..588c2e37b035
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/sensirion,sht4x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sensirion SHT4x Humidity and Temperature Sensor IC
> > +
> > +maintainers:
> > +  - Navin Sankar Velliangiri navin@linumiz.com
> > +
> > +description: |
> > +  The SHT4x is a high-accuracy digital humidity and temperature sensor
> > +  designed especially for battery-driven high-volume consumer
> > +  electronics applications.  For further information refere to
> > +  Documentation/hwmon/sht4x.rst
> > +
> > +  This binding document describes the binding for the hardware monitor
> > +  portion of the driver.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sensirion,sht4x
> > +
> > +  reg:
> > +    const: 0x44
> > +    description:
> > +      The I2c base address of the SHT4x.  0x44 for all chip versions
> > +      except for SHT41-BD1B, where it is 0x45.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      clock-frequency = <400000>;
> > +
> > +      sht4x@44 {
> > +        compatible = "sensirion,sht4x";
> > +        reg = <0x44>;
> > +      };
> > +    };
> > +...
> > diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> > index 3415d7a0e0fc..6e53d81e32d4 100644
> > --- a/drivers/hwmon/sht4x.c
> > +++ b/drivers/hwmon/sht4x.c
> > @@ -281,9 +281,16 @@ static const struct i2c_device_id sht4x_id[] = {
> >   };
> >   MODULE_DEVICE_TABLE(i2c, sht4x_id);
> >   
> > +static const struct of_device_id sht4x_of_match[] = {
> > +	{ .compatible = "sensirion,sht4x" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sht4x_of_match);
> > +
> >   static struct i2c_driver sht4x_driver = {
> >   	.driver = {
> >   		.name = "sht4x",
> > +		.of_match_table = sht4x_of_match
> >   	},
> >   	.probe		= sht4x_probe,
> >   	.id_table	= sht4x_id,
> > 

