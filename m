Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D283E3AAD25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFQHNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhFQHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:13:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D60C061574;
        Thu, 17 Jun 2021 00:11:22 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 131so7489520ljj.3;
        Thu, 17 Jun 2021 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=trEw8oJfAjxZTRGG7mdA+4VI5+cMXe8fpatm3oLv2NI=;
        b=aEZyEQwotgR9grkuzgNuhofJjnauKzkVhfGlf/ogELeqNMw/4lIZ310ckLKRAT6ITj
         SL8potw+vkubWyQ9ttWLHWjRh+CmNdBxCL+UkOcliQPJo0VgugUVZHYJax0elj1AZMJQ
         fefcXyeM6MVow02zShY0Rs97xVEOqMBz5i9jpZB1rg36jCCrqWHmHDLV8Z9T+vK+uZJi
         MceBECNF074qC1pkZSkkZ6XHX4/jYBPtnlkJ/1PokjfHzUPHvOC9jpNM8IgCz1aDQZdL
         4iTSTzcg7GoPraddxHOatR7e4o4bwvr75d+GwtwVUkPFlfl1HCED1RaPhBLRvcShrkxy
         whCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=trEw8oJfAjxZTRGG7mdA+4VI5+cMXe8fpatm3oLv2NI=;
        b=YRn0/NRRzPllpqkjAyO+JNmd16D+mxx9s2B8j3CF3+7+KatH3IO9RFCKmp7sPGcjCi
         rRyI+2KFKsvAF/QoNA5lfmQRZNDBNp/QeZ1+bpQxz4NeGo6VLyFfT+S9r25IxC40asxz
         cy63HnxU4ZiPn6VssJsKhI3bRjASYyFEVkZRzFqMAor5J66GPZycEZjAKxou69hgbRzj
         eg4GVGImCjNsfJ05/7fPPvlyNCVmhs4YpAcC7q1TAAYIptGD+zK+Q0AyF3kVK+O2Z1sH
         4JfrB8/obDHOexj+Dacm7syPaCVp6Cf6So3f4QxaoGH1rOSbTaM7/AO9y/2eHpV994wv
         2FTQ==
X-Gm-Message-State: AOAM530+HygaNq56YVLhrVt8b/4bPp6OSo74DQrWMLcT04f95rEQVCjz
        MdRJyw2zESXGvAHmD0PC5SpKBrL5Jsg=
X-Google-Smtp-Source: ABdhPJwUQmheprcsngvyOYA1NQYv25ZoAKbuDm6XNl54fxBlWMaa+oIdxHeZU6thYgHwl37R5Vh1Xw==
X-Received: by 2002:a2e:86c6:: with SMTP id n6mr3373346ljj.15.1623913880110;
        Thu, 17 Jun 2021 00:11:20 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id l12sm528365lfk.10.2021.06.17.00.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 00:11:19 -0700 (PDT)
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20210616190708.1220-1-digetx@gmail.com>
 <20210617001243.GA3211292@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
Date:   Thu, 17 Jun 2021 10:11:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617001243.GA3211292@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2021 03:12, Guenter Roeck пишет:
> On Wed, Jun 16, 2021 at 10:07:08PM +0300, Dmitry Osipenko wrote:
>> The LM90 driver uses level-based interrupt triggering. The interrupt
>> handler prints a warning message about the breached temperature and
>> quits. There is no way to stop interrupt from re-triggering since it's
>> level-based, thus thousands of warning messages are printed per second
>> once interrupt is triggered. Use edge-triggered interrupt in order to
>> fix this trouble.
>>
>> Fixes: 109b1283fb532 ("hwmon: (lm90) Add support to handle IRQ")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/hwmon/lm90.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>> index ebbfd5f352c0..ce8ebe60fcdc 100644
>> --- a/drivers/hwmon/lm90.c
>> +++ b/drivers/hwmon/lm90.c
>> @@ -1908,7 +1908,7 @@ static int lm90_probe(struct i2c_client *client)
>>  		dev_dbg(dev, "IRQ: %d\n", client->irq);
>>  		err = devm_request_threaded_irq(dev, client->irq,
>>  						NULL, lm90_irq_thread,
>> -						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>>  						"lm90", client);
> 
> We can't do that. Problem is that many of the devices supported by this driver
> behave differently when it comes to interrupts. Specifically, the interrupt
> handler is supposed to reset the interrupt condition (ie reading the status
> register should reset it). If that is the not the case for a specific chip,
> we'll have to update the code to address the problem for that specific chip.
> The above code would probably just generate a single interrupt while never
> resetting the interrupt condition, which is obviously not what we want to
> happen.

The nct1008/72 datasheet [1] says that reading the status register
doesn't reset interrupt until temperature is returned back into normal
state, which is what I'm witnessing.

[1] https://www.onsemi.com/pdf/datasheet/nct1008-d.pdf

Page 10 "Status Register":

"Reading the status register clears the five flags, Bit 6 to Bit 2,
provided the error conditions causing the flags to beset  have  gone
away.  A  flag  bit  can  be  reset  only  if  the corresponding
value    register    contains    an    in-limit measurement or if the
sensor is good."

So the interrupt handler doesn't actually stop interrupt from
reoccurring and the whole KMSG is instantly spammed with:

...
[  217.484034] lm90 0-004c: temp2 out of range, please check!
[  217.484569] lm90 0-004c: temp2 out of range, please check!
[  217.485006] systemd-journald[179]: /dev/kmsg buffer overrun, some
messages lost.
[  217.485109] lm90 0-004c: temp2 out of range, please check!
[  217.485699] lm90 0-004c: temp2 out of range, please check!
[  217.486235] lm90 0-004c: temp2 out of range, please check!
[  217.486776] lm90 0-004c: temp2 out of range, please check!
[  217.486874] systemd-journald[179]: /dev/kmsg buffer overrun, ...

It's interesting that the very first version of the nct1008-support
patch used edge-triggered interrupt flags [2].

[2] http://lkml.iu.edu/hypermail/linux/kernel/1104.1/01669.html

Limiting the interrupt rate could be an alternative solution.

What do you think about something like this:

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index ce8ebe60fcdc..74886b8066ab 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -79,6 +79,7 @@
  * concern all supported chipsets, unless mentioned otherwise.
  */

+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -201,6 +202,9 @@ enum chips { lm90, adm1032, lm99, lm86, max6657,
max6659, adt7461, max6680,
 #define MAX6696_STATUS2_R2OT2	(1 << 6) /* remote2 emergency limit
tripped */
 #define MAX6696_STATUS2_LOT2	(1 << 7) /* local emergency limit tripped */

+/* Prevent instant interrupt re-triggering */
+#define LM90_IRQ_DELAY		(15 * MSEC_PER_SEC)
+
 /*
  * Driver data (common to all clients)
  */
@@ -1756,10 +1760,12 @@ static irqreturn_t lm90_irq_thread(int irq, void
*dev_id)
 	struct i2c_client *client = dev_id;
 	u16 status;

-	if (lm90_is_tripped(client, &status))
-		return IRQ_HANDLED;
-	else
+	if (!lm90_is_tripped(client, &status))
 		return IRQ_NONE;
+
+	msleep(LM90_IRQ_DELAY);
+
+	return IRQ_HANDLED;
 }

 static void lm90_remove_pec(void *dev)
