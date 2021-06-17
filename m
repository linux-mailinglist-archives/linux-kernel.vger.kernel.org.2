Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952F63AB461
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhFQNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhFQNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:14:17 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D787C061574;
        Thu, 17 Jun 2021 06:12:08 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 67-20020a4a01460000b0290245b81f6261so1562242oor.6;
        Thu, 17 Jun 2021 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R1yhSqOyCTOxsIcvCglHbRy/SpZ1b+YtIXM50m2wYmo=;
        b=FoOoWX1W+Fy8/RnN/fLNDPa/Fo9fJeDV92SoISrLXC1Q4vR5fP9EqTJoQrDVu1VH/3
         HRtP3KAXMuaLD+L1SdSmCvSTBHjTFjPYdBzBjf122Yy+EsJzwvA+yUd7g6DJ4N3kT2Cc
         g1NVex/INTSVlZCk7ynkRzpDo6lKUc5JAObWbpGCfc5w4CYEkgu7H2H9qT9kqtLzVumz
         3aUnngQ+ML8MwFf3tHuZu06LbrydUvyzDK5COVObRHdRZFDePA4EQ7nWqMgiUn2HnFJ1
         yn0bYxpVrCmM8Z3dGo1XpdAIIxgfhGufeqdcAe9l5g2yZrpKquX21RQXzoSKm9QOoMDB
         7Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=R1yhSqOyCTOxsIcvCglHbRy/SpZ1b+YtIXM50m2wYmo=;
        b=U+Nkswyau6HiWsgR41m44YbAy26ZNAIIJoxia6/Ms4CvA5asO12JEZBgS2PtKkAZsD
         xqt2uK3dKJ5eI66cCr/NRokWm2Ugccw4vZM06JsihOVQXexQymq4iP0tmIL7zxpZ8hVv
         OWCiBjHkyKzMtUSYd3c6oKLaYpnRlOVTH64YiwKfaqI8n1f5E3OGTgspXysKRq00+Hg/
         XasUYJpgvTYG4or+4DTT5GCIENzXmMfIm6es6gVcswgwXmN0C8KqnFcunRwlBhE2UPay
         lsViKwtwQmxuV9ZHSMiT+RyRDlJ934oeboiJeRZ4w/B2otXP3ijPOgSwr6VEwhOGhyTt
         y+ZQ==
X-Gm-Message-State: AOAM53086bbMjf6TdL2ljtK9B38Hwid71b+CqOOhVPem4lS4ihcV/dE9
        wnXccxtzly7+46z9QaMg/m8=
X-Google-Smtp-Source: ABdhPJxBoeD6KeM9g13I3LqtWR4C3O/sYZ4yZ1OQx4W6BmyLnU9U/vku0FUkx4m3p0pUlS2U4dWrtA==
X-Received: by 2002:a4a:1d85:: with SMTP id 127mr4447502oog.18.1623935527846;
        Thu, 17 Jun 2021 06:12:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l18sm1233382otr.50.2021.06.17.06.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 06:12:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Jun 2021 06:12:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
Message-ID: <20210617131205.GA59767@roeck-us.net>
References: <20210616190708.1220-1-digetx@gmail.com>
 <20210617001243.GA3211292@roeck-us.net>
 <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:11:19AM +0300, Dmitry Osipenko wrote:
> 17.06.2021 03:12, Guenter Roeck пишет:
> > On Wed, Jun 16, 2021 at 10:07:08PM +0300, Dmitry Osipenko wrote:
> >> The LM90 driver uses level-based interrupt triggering. The interrupt
> >> handler prints a warning message about the breached temperature and
> >> quits. There is no way to stop interrupt from re-triggering since it's
> >> level-based, thus thousands of warning messages are printed per second
> >> once interrupt is triggered. Use edge-triggered interrupt in order to
> >> fix this trouble.
> >>
> >> Fixes: 109b1283fb532 ("hwmon: (lm90) Add support to handle IRQ")
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/hwmon/lm90.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> >> index ebbfd5f352c0..ce8ebe60fcdc 100644
> >> --- a/drivers/hwmon/lm90.c
> >> +++ b/drivers/hwmon/lm90.c
> >> @@ -1908,7 +1908,7 @@ static int lm90_probe(struct i2c_client *client)
> >>  		dev_dbg(dev, "IRQ: %d\n", client->irq);
> >>  		err = devm_request_threaded_irq(dev, client->irq,
> >>  						NULL, lm90_irq_thread,
> >> -						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> >> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >>  						"lm90", client);
> > 
> > We can't do that. Problem is that many of the devices supported by this driver
> > behave differently when it comes to interrupts. Specifically, the interrupt
> > handler is supposed to reset the interrupt condition (ie reading the status
> > register should reset it). If that is the not the case for a specific chip,
> > we'll have to update the code to address the problem for that specific chip.
> > The above code would probably just generate a single interrupt while never
> > resetting the interrupt condition, which is obviously not what we want to
> > happen.
> 
> The nct1008/72 datasheet [1] says that reading the status register
> doesn't reset interrupt until temperature is returned back into normal
> state, which is what I'm witnessing.
> 
> [1] https://www.onsemi.com/pdf/datasheet/nct1008-d.pdf
> 
> Page 10 "Status Register":
> 
> "Reading the status register clears the five flags, Bit 6 to Bit 2,
> provided the error conditions causing the flags to beset  have  gone
> away.  A  flag  bit  can  be  reset  only  if  the corresponding
> value    register    contains    an    in-limit measurement or if the
> sensor is good."
> 
> So the interrupt handler doesn't actually stop interrupt from
> reoccurring and the whole KMSG is instantly spammed with:
> 
> ...
> [  217.484034] lm90 0-004c: temp2 out of range, please check!
> [  217.484569] lm90 0-004c: temp2 out of range, please check!
> [  217.485006] systemd-journald[179]: /dev/kmsg buffer overrun, some
> messages lost.
> [  217.485109] lm90 0-004c: temp2 out of range, please check!
> [  217.485699] lm90 0-004c: temp2 out of range, please check!
> [  217.486235] lm90 0-004c: temp2 out of range, please check!
> [  217.486776] lm90 0-004c: temp2 out of range, please check!
> [  217.486874] systemd-journald[179]: /dev/kmsg buffer overrun, ...
> 
> It's interesting that the very first version of the nct1008-support
> patch used edge-triggered interrupt flags [2].
> 
> [2] http://lkml.iu.edu/hypermail/linux/kernel/1104.1/01669.html
> 
A lot of this depends on the chip and its wiring, as well as on chip
configuration. Even for a specific chip there may be configuration
dependencies. The interrupt configuration in situations like this
should really be determined by devicetree configuration, and not
be hardcoded. Is this a devicetree based system ? If so, there should
be an entry for this chip pointing to the interrupt, and that entry
should include a trigger mask. That mask should be set to edge
triggered.

> Limiting the interrupt rate could be an alternative solution.
> 
> What do you think about something like this:
> 
A sleep in an interrupt handler to "prevent" an interrupt storm
is never acceptable.

Guenter

> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index ce8ebe60fcdc..74886b8066ab 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -79,6 +79,7 @@
>   * concern all supported chipsets, unless mentioned otherwise.
>   */
> 
> +#include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -201,6 +202,9 @@ enum chips { lm90, adm1032, lm99, lm86, max6657,
> max6659, adt7461, max6680,
>  #define MAX6696_STATUS2_R2OT2	(1 << 6) /* remote2 emergency limit
> tripped */
>  #define MAX6696_STATUS2_LOT2	(1 << 7) /* local emergency limit tripped */
> 
> +/* Prevent instant interrupt re-triggering */
> +#define LM90_IRQ_DELAY		(15 * MSEC_PER_SEC)
> +
>  /*
>   * Driver data (common to all clients)
>   */
> @@ -1756,10 +1760,12 @@ static irqreturn_t lm90_irq_thread(int irq, void
> *dev_id)
>  	struct i2c_client *client = dev_id;
>  	u16 status;
> 
> -	if (lm90_is_tripped(client, &status))
> -		return IRQ_HANDLED;
> -	else
> +	if (!lm90_is_tripped(client, &status))
>  		return IRQ_NONE;
> +
> +	msleep(LM90_IRQ_DELAY);
> +
> +	return IRQ_HANDLED;
>  }
> 
>  static void lm90_remove_pec(void *dev)
