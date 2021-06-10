Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33D3A28DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFJJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:59:56 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:33535 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJJ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:59:55 -0400
Received: by mail-lf1-f53.google.com with SMTP id bp38so2334099lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=qwZZjnJPPw+eU6CxNz0JMWxXvn+B/S70Id3jVssorqg=;
        b=cOCnoVQplDUqUOzVcVnQo0tsh/HYNrQ0zL5jhKm8fBMxMGswkR1LVeV5JvEGQKVCYB
         7qHoKvYPnb3Uye8muIAiw+1dHGMBEyp/v0mPVEpf11stxen4GICoqr5yYrblQTJ8sQtl
         1hC1Lc5jx/ir8D14+C+JxVgwCsdSxlMd73uNMQJPBfEVMKXwPydJ9Vk6695KT2LX9MD5
         8OObSRPyhcCXoUHW15jngKUZy+hUWg28SFKGvnPeWKHp/tfFd+bL9YiLan31spw8LLg0
         YSQf0UEbBFybTWwdhtU6pqqnxWjNqFwe3fKNU9iTm6nIvhdqnzksg2EqK3jHned1TTcr
         KAig==
X-Gm-Message-State: AOAM530PbX83rmhNh5VQJvkH1/TW9L3Mu/TK+e/rhDSnWtlKuE8ov4qT
        +DXF/kNVSebocKRPcEAxUrE=
X-Google-Smtp-Source: ABdhPJxWuWM3q8tYOQbGO6sWabkBOlqDtcIbsqGv/QqhSIxx6pUN2lhmm0k4ZKsmCo7+9owbghbHDQ==
X-Received: by 2002:a05:6512:3f9b:: with SMTP id x27mr1471575lfa.279.1623319065468;
        Thu, 10 Jun 2021 02:57:45 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id m12sm280243ljo.94.2021.06.10.02.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:57:45 -0700 (PDT)
Message-ID: <5939eb35e75e9f1288042430c367650b2e8b2996.camel@fi.rohmeurope.com>
Subject: Re: [PATCH RESEND v2 3/5] extcon: extcon-max77693.c: Fix potential
 work-queue cancellation race
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <7f39c731-b644-0122-d68f-7da7e78b4252@samsung.com>
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
         <CGME20210608101022epcas1p1c1623dfb74f412153706d3986b373a03@epcas1p1.samsung.com>
         <cbe8205eed8276f6e6db5003cfe51b8b0d4ac966.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
         <7f39c731-b644-0122-d68f-7da7e78b4252@samsung.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 10 Jun 2021 12:57:40 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2021-06-10 at 18:43 +0900, Chanwoo Choi wrote:
> On 6/8/21 7:10 PM, Matti Vaittinen wrote:
> > The extcon IRQ schedules a work item. IRQ is requested using devm
> > while
> > WQ is cancelld at remove(). This mixing of devm and manual
> > unwinding has
> > potential case where the WQ has been emptied (.remove() was ran)
> > but
> > devm unwinding of IRQ was not yet done. It may be possible the IRQ
> > is
> > triggered at this point scheduling new work item to the already
> > flushed
> > queue.
> > 
> > According to the input documentation the input device allocated by
> > devm_input_allocate_device() does not need to be explicitly
> > unregistered.
> > Use the new devm_work_autocancel() and remove the remove() to
> > simplify the
> > code.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com
> > >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > 
> > Please note that the change is compile-tested only. All proper
> > testing is
> > highly appreciated.
> > ---
> >  drivers/extcon/extcon-max77693.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/extcon/extcon-max77693.c
> > b/drivers/extcon/extcon-max77693.c
> > index 92af97e00828..1f1d9ab0c5c7 100644
> > --- a/drivers/extcon/extcon-max77693.c
> > +++ b/drivers/extcon/extcon-max77693.c
> > @@ -5,6 +5,7 @@
> >  // Copyright (C) 2012 Samsung Electrnoics
> >  // Chanwoo Choi <cw00.choi@samsung.com>
> >  
> > +#include <linux/devm-helpers.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/i2c.h>
> > @@ -1127,7 +1128,10 @@ static int max77693_muic_probe(struct
> > platform_device *pdev)
> >  	platform_set_drvdata(pdev, info);
> >  	mutex_init(&info->mutex);
> >  
> > -	INIT_WORK(&info->irq_work, max77693_muic_irq_work);
> > +	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
> > +				   max77693_muic_irq_work);
> > +	if (ret)
> > +		return ret;
> >  
> >  	/* Support irq domain for MAX77693 MUIC device */
> >  	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
> > @@ -1254,22 +1258,11 @@ static int max77693_muic_probe(struct
> > platform_device *pdev)
> >  	return ret;
> >  }
> >  
> > -static int max77693_muic_remove(struct platform_device *pdev)
> > -{
> > -	struct max77693_muic_info *info = platform_get_drvdata(pdev);
> > -
> > -	cancel_work_sync(&info->irq_work);
> > -	input_unregister_device(info->dock);
> 
> I think that you have to keep the input_unregister_device().

Are you sure? I can add back the remove() if required - but the
kerneldoc for devm_input_allocate_device() seems to be suggesting that
this would not be needed:

 * Managed input devices do not need to be explicitly unregistered or
 * freed as it will be done automatically when owner device unbinds
from
 * its driver (or binding fails). Once managed input device is
allocated,
 * it is ready to be set up and registered in the same fashion as
regular
 * input device. There are no special devm_input_device_[un]register()
 * variants, regular ones work with both managed and unmanaged devices,
 * should you need them. In most cases however, managed input device
need
 * not be explicitly unregistered or freed.

https://elixir.bootlin.com/linux/v5.13-rc5/source/drivers/input/input.c#L1955

I am not going to argue with you though - I am not really familiar with
the input subsystem. I'd appreciate if someone could shed some light on
when the input_unregister_device() can be omitted? 

Best Regards
	Matti Vaittinen


