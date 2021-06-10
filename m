Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754B93A36E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhFJWRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:17:19 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:40623 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhFJWRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:17:16 -0400
Received: by mail-pl1-f173.google.com with SMTP id e7so1786809plj.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RwGdicUMfheVC+d8Dis5hfo/dywiEaFfRyskW6FhI08=;
        b=PpinhDMnFjereWpXdRaphbrrBAuaGcP1LyeK8GuwdfCvWgNLa/AzAheh7fDa5inTmz
         3GmhfiBL99Osik1Zr0n2lYaic0IXN26c7+sPFitQ2TB+8leD6OH8htEfkRuQZiGUMgtB
         5ZLlIMI/0ig8Lb4uFHc8+ih7N7g34CFeW3bOZTsmZzE46n4DWXxalTxKTR1I6O+Fs2kD
         owzYR1DlqhT5SiMpekYei7El+wEof88oewOEQAWGVgmtXfLlajmW/BjSTxKUVo0Vgz+T
         dBW7s2SdeRyzLwL2VwbPWiHR8tXvgOkYmwH1QPHqlsdVTBVYuz1QWgmdERqjOqGciTJl
         /nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RwGdicUMfheVC+d8Dis5hfo/dywiEaFfRyskW6FhI08=;
        b=Q1O7OPzUzX0vnE7bJnN+ujCiWA8leBsOc8Oz1GxWpqCSuFqoVU7eOuB2hiRcWtQfqB
         EMngMuol/KvuO3EQERy4snfnvcg8MHo6KhqTGgJc5GZiecIZefmt264IDAtdWU3lw84i
         LUCWyoDszoJWkYtyls08ShVMVUt9gu3m+O4GCgYiG5Sw6hG1yxEWUYerRWby0M3esXrB
         22UF5Ua5K1qHvHgEhOfTiYUj8k9xiCqejDusuZT3X5/fzMc6vJ1SXcHRtRLj8p6nksuI
         j06GsOk4T/EAKctg6YOQ8777yxIPeyjpiJ2hcyDelC6X1K3LMqs5JrQY9KHI2G2SPyH9
         Licw==
X-Gm-Message-State: AOAM532yBmOWUkNzSdibmd2UAXWm0l7Thv5M++Cn8ql8/twDtVFJOeUs
        h5tZwVanZpNkT2WuIeZMsXA=
X-Google-Smtp-Source: ABdhPJzwvetFgklgFJqxHNDfvhyMVW4MaR4yAbb05PI0Jab2JwIqyeWPI+TNUUxtyN1egxSdm77k/Q==
X-Received: by 2002:a17:90b:3c7:: with SMTP id go7mr5492113pjb.113.1623363259769;
        Thu, 10 Jun 2021 15:14:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c4d:75f1:4a69:87ac])
        by smtp.gmail.com with ESMTPSA id q13sm3265407pff.13.2021.06.10.15.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 15:14:18 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:14:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/5] extcon: extcon-max77693.c: Fix potential
 work-queue cancellation race
Message-ID: <YMKOuE/VbLiWjVAw@google.com>
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
 <CGME20210608101022epcas1p1c1623dfb74f412153706d3986b373a03@epcas1p1.samsung.com>
 <cbe8205eed8276f6e6db5003cfe51b8b0d4ac966.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
 <7f39c731-b644-0122-d68f-7da7e78b4252@samsung.com>
 <5939eb35e75e9f1288042430c367650b2e8b2996.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5939eb35e75e9f1288042430c367650b2e8b2996.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:57:40PM +0300, Matti Vaittinen wrote:
> 
> On Thu, 2021-06-10 at 18:43 +0900, Chanwoo Choi wrote:
> > On 6/8/21 7:10 PM, Matti Vaittinen wrote:
> > > The extcon IRQ schedules a work item. IRQ is requested using devm
> > > while
> > > WQ is cancelld at remove(). This mixing of devm and manual
> > > unwinding has
> > > potential case where the WQ has been emptied (.remove() was ran)
> > > but
> > > devm unwinding of IRQ was not yet done. It may be possible the IRQ
> > > is
> > > triggered at this point scheduling new work item to the already
> > > flushed
> > > queue.
> > > 
> > > According to the input documentation the input device allocated by
> > > devm_input_allocate_device() does not need to be explicitly
> > > unregistered.
> > > Use the new devm_work_autocancel() and remove the remove() to
> > > simplify the
> > > code.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com
> > > >
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > > 
> > > Please note that the change is compile-tested only. All proper
> > > testing is
> > > highly appreciated.
> > > ---
> > >  drivers/extcon/extcon-max77693.c | 17 +++++------------
> > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/extcon/extcon-max77693.c
> > > b/drivers/extcon/extcon-max77693.c
> > > index 92af97e00828..1f1d9ab0c5c7 100644
> > > --- a/drivers/extcon/extcon-max77693.c
> > > +++ b/drivers/extcon/extcon-max77693.c
> > > @@ -5,6 +5,7 @@
> > >  // Copyright (C) 2012 Samsung Electrnoics
> > >  // Chanwoo Choi <cw00.choi@samsung.com>
> > >  
> > > +#include <linux/devm-helpers.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/i2c.h>
> > > @@ -1127,7 +1128,10 @@ static int max77693_muic_probe(struct
> > > platform_device *pdev)
> > >  	platform_set_drvdata(pdev, info);
> > >  	mutex_init(&info->mutex);
> > >  
> > > -	INIT_WORK(&info->irq_work, max77693_muic_irq_work);
> > > +	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
> > > +				   max77693_muic_irq_work);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > >  	/* Support irq domain for MAX77693 MUIC device */
> > >  	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
> > > @@ -1254,22 +1258,11 @@ static int max77693_muic_probe(struct
> > > platform_device *pdev)
> > >  	return ret;
> > >  }
> > >  
> > > -static int max77693_muic_remove(struct platform_device *pdev)
> > > -{
> > > -	struct max77693_muic_info *info = platform_get_drvdata(pdev);
> > > -
> > > -	cancel_work_sync(&info->irq_work);
> > > -	input_unregister_device(info->dock);
> > 
> > I think that you have to keep the input_unregister_device().
> 
> Are you sure? I can add back the remove() if required - but the
> kerneldoc for devm_input_allocate_device() seems to be suggesting that
> this would not be needed:
> 
>  * Managed input devices do not need to be explicitly unregistered or
>  * freed as it will be done automatically when owner device unbinds
> from
>  * its driver (or binding fails). Once managed input device is
> allocated,
>  * it is ready to be set up and registered in the same fashion as
> regular
>  * input device. There are no special devm_input_device_[un]register()
>  * variants, regular ones work with both managed and unmanaged devices,
>  * should you need them. In most cases however, managed input device
> need
>  * not be explicitly unregistered or freed.
> 
> https://elixir.bootlin.com/linux/v5.13-rc5/source/drivers/input/input.c#L1955
> 
> I am not going to argue with you though - I am not really familiar with
> the input subsystem. I'd appreciate if someone could shed some light on
> when the input_unregister_device() can be omitted? 

That is correct, you do not need to call input_unregister_device() for
input devices allocated with devm_input_allocate_device().

Thanks.

-- 
Dmitry
