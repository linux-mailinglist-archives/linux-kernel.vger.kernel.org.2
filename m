Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD453AB595
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhFQOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFQOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:15:11 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD6C061574;
        Thu, 17 Jun 2021 07:13:02 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t140so6739606oih.0;
        Thu, 17 Jun 2021 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YtXeq7j0JT/6q+PbE1tTbESzTRjybeiXNapEgXvCNhY=;
        b=mJCBRQCLod7wu8zQsI/vjuYZqFvwKwkCuGSnZdgMymBKdcTj4TJclPCtguIwHzzuH+
         QnEqy5XmM3vShyyvq+Tc7Uc/ZLiGjfguh76+s+MOYgabqU+rL1NOB091yo+Ia8xSBu0a
         eDS0eu0a55Y8MaCoZNuBv4cgYXPv+VnI8lC6DHjHl8y9ITzi951oF1Q+YOaA1XUDCl8R
         kOnMM+bgwAiuIvv4D1JOxAWGf5VxmaVSWuQa7m/xLABCrMHdbOXFdRII5MVMbHHAMdwH
         KGrhDBKcZCnwi1Vt47im1DLKh1ScbAR59HKGZZ4bmqx/itrr8phJa/GbTssHQ3lhougM
         eYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=YtXeq7j0JT/6q+PbE1tTbESzTRjybeiXNapEgXvCNhY=;
        b=DrGxwLdGglZEvKoBW6REOtKj6+IR41HomTZzA1t7aSDu2q8/y5wzbllR0/BFQsrlqv
         ags50jsUGw/CuqJWrTm4YPV+6vsP9ZYqJRf8L9yIINcNZLlsanVyxnEz9bF5pJnqB7EA
         h2m3IV4rHcrFIuq/EbFg6hgQLRaniFBeJAnpMLldY0RuusQuDk80cSKWj+E6GJKuGINI
         l7raFrARQOJLaLJfJ4+byKVAtIrAnR3aP9nlW3QRrnYSnzQmWV1EleExmczgypNdA4pU
         +5dfgJAiL+3bLyJBqBK/0HFocLAEzBtooLuwc1ZR9QLu0KMEyltDbWDsYVMCHYYf4yKu
         lm6g==
X-Gm-Message-State: AOAM533+VkXKtqPXulWuW56NX294c58aSSA1/8KNh1N2GT38NaM2NUQg
        i+NP4+haM/b4ItzSmLT8b8U=
X-Google-Smtp-Source: ABdhPJxoJKQQIJEzXyj4okNlxbZT8zAhQqtZvfljsU+vmvCfRzZGRi7PeHLcuJz9prHD3aWSSWESAw==
X-Received: by 2002:aca:410a:: with SMTP id o10mr3472048oia.51.1623939182054;
        Thu, 17 Jun 2021 07:13:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10sm1127298ool.45.2021.06.17.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:13:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Jun 2021 07:13:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
Message-ID: <20210617141300.GA1366442@roeck-us.net>
References: <20210616190708.1220-1-digetx@gmail.com>
 <20210617001243.GA3211292@roeck-us.net>
 <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
 <20210617131205.GA59767@roeck-us.net>
 <de7682c2-ae34-c594-d237-330ea33cbc78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de7682c2-ae34-c594-d237-330ea33cbc78@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 04:48:08PM +0300, Dmitry Osipenko wrote:
> 17.06.2021 16:12, Guenter Roeck пишет:
> > On Thu, Jun 17, 2021 at 10:11:19AM +0300, Dmitry Osipenko wrote:
> >> 17.06.2021 03:12, Guenter Roeck пишет:
> >>> On Wed, Jun 16, 2021 at 10:07:08PM +0300, Dmitry Osipenko wrote:
> >>>> The LM90 driver uses level-based interrupt triggering. The interrupt
> >>>> handler prints a warning message about the breached temperature and
> >>>> quits. There is no way to stop interrupt from re-triggering since it's
> >>>> level-based, thus thousands of warning messages are printed per second
> >>>> once interrupt is triggered. Use edge-triggered interrupt in order to
> >>>> fix this trouble.
> >>>>
> >>>> Fixes: 109b1283fb532 ("hwmon: (lm90) Add support to handle IRQ")
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  drivers/hwmon/lm90.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> >>>> index ebbfd5f352c0..ce8ebe60fcdc 100644
> >>>> --- a/drivers/hwmon/lm90.c
> >>>> +++ b/drivers/hwmon/lm90.c
> >>>> @@ -1908,7 +1908,7 @@ static int lm90_probe(struct i2c_client *client)
> >>>>  		dev_dbg(dev, "IRQ: %d\n", client->irq);
> >>>>  		err = devm_request_threaded_irq(dev, client->irq,
> >>>>  						NULL, lm90_irq_thread,
> >>>> -						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> >>>> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >>>>  						"lm90", client);
> >>>
> >>> We can't do that. Problem is that many of the devices supported by this driver
> >>> behave differently when it comes to interrupts. Specifically, the interrupt
> >>> handler is supposed to reset the interrupt condition (ie reading the status
> >>> register should reset it). If that is the not the case for a specific chip,
> >>> we'll have to update the code to address the problem for that specific chip.
> >>> The above code would probably just generate a single interrupt while never
> >>> resetting the interrupt condition, which is obviously not what we want to
> >>> happen.
> >>
> >> The nct1008/72 datasheet [1] says that reading the status register
> >> doesn't reset interrupt until temperature is returned back into normal
> >> state, which is what I'm witnessing.
> >>
> >> [1] https://www.onsemi.com/pdf/datasheet/nct1008-d.pdf
> >>
> >> Page 10 "Status Register":
> >>
> >> "Reading the status register clears the five flags, Bit 6 to Bit 2,
> >> provided the error conditions causing the flags to beset  have  gone
> >> away.  A  flag  bit  can  be  reset  only  if  the corresponding
> >> value    register    contains    an    in-limit measurement or if the
> >> sensor is good."
> >>
> >> So the interrupt handler doesn't actually stop interrupt from
> >> reoccurring and the whole KMSG is instantly spammed with:
> >>
> >> ...
> >> [  217.484034] lm90 0-004c: temp2 out of range, please check!
> >> [  217.484569] lm90 0-004c: temp2 out of range, please check!
> >> [  217.485006] systemd-journald[179]: /dev/kmsg buffer overrun, some
> >> messages lost.
> >> [  217.485109] lm90 0-004c: temp2 out of range, please check!
> >> [  217.485699] lm90 0-004c: temp2 out of range, please check!
> >> [  217.486235] lm90 0-004c: temp2 out of range, please check!
> >> [  217.486776] lm90 0-004c: temp2 out of range, please check!
> >> [  217.486874] systemd-journald[179]: /dev/kmsg buffer overrun, ...
> >>
> >> It's interesting that the very first version of the nct1008-support
> >> patch used edge-triggered interrupt flags [2].
> >>
> >> [2] http://lkml.iu.edu/hypermail/linux/kernel/1104.1/01669.html
> >>
> > A lot of this depends on the chip and its wiring, as well as on chip
> > configuration. Even for a specific chip there may be configuration
> > dependencies. The interrupt configuration in situations like this
> > should really be determined by devicetree configuration, and not
> > be hardcoded. Is this a devicetree based system ? If so, there should
> > be an entry for this chip pointing to the interrupt, and that entry
> > should include a trigger mask. That mask should be set to edge
> > triggered.
> 
> This is a device-tree based system, in particular it's NVIDIA Tegra30
> Nexus 7. The interrupt support was originally added to the lm90 driver
> by Wei Ni who works at NVIDIA and did it for the Tegra boards. The Tegra
> device-trees are specifying the trigger mask and apparently they all are
> cargo-culted and wrong because they use IRQ_TYPE_LEVEL_HIGH, while it

Be fair, no one is perfect.

> should be IRQ_TYPE_EDGE_FALLING.

It should probably be both IRQ_TYPE_EDGE_FALLING and IRQ_TYPE_EDGE_RISING,
and the interrupt handler should call hwmon_notify_event() instead of
clogging the kernel log, but that should be done in a separate patch.

Anyway, the tegra30 dts files in the upstream kernel either use
IRQ_TYPE_LEVEL_LOW or no interrupts for nct1008. The Nexus 7 dts file
in the upstream kernel has no interrupt configured (and coincidentally
it was you who added that entry). Where do you see IRQ_TYPE_LEVEL_HIGH ?

> 
> The IRQF flag in devm_request_threaded_irq() overrides the trigger mask
> specified in a device-tree. IIUC, the interrupt is used only by OF-based
> devices, hence I think we could simply remove the IRQF flag from the
> code and fix the device-trees. Does it sound good to you?

Yes, that is a better approach.

Thanks,
Guenter
