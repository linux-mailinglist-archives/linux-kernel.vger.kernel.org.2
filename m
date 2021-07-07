Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83A23BE06A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 02:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhGGBAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 21:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhGGBAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 21:00:43 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36579C061574;
        Tue,  6 Jul 2021 17:58:03 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so656136oti.2;
        Tue, 06 Jul 2021 17:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fybc0l0BejJcIFY8fwu+SVn+voPfUoUte83g/+XuDRw=;
        b=fFdeea/u0a8L+8LfgEpEdj4I5NpEYA7Iv6zTbi2dhOkCly6uY8eBQrbqwn1qPVHOoJ
         cIp5QMkC+WU853+FM6yZURWyn6xRYYnhd1CcI/Hx4mdIMRS5BR4fJgd+DsA+YQsYuvAB
         VUvFcrDGY2TfFUikuq6tpkBroSc8z+lPYvqfPveNs+yJAOwotHZPZcLm3ECIOhZaNfeC
         odCtIyTSqIwWHg2DbI1ruF1uUPidBvqP379GkYhcP1HxW4ToNIXgoo6QKHZ5SdTWCgoJ
         6EznXm4aflerqKAjXYD2xBlE2g+bjXv7sG2iLPh6BRWOswZrj4meeiF9oZtcGdU5bhTu
         ztRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Fybc0l0BejJcIFY8fwu+SVn+voPfUoUte83g/+XuDRw=;
        b=X3abiVWjqmD62UNDdtlYmpiewFMNE4URw/xmmM9v94VEvMbC5UMvvRKl1hrygxI/L6
         6dzhoFwNvz8f073ESrCCmqGYkyp82+JkwuC+9y3RT5qvERtABuh7MZMmx8nt2TIUbhoF
         MX+iNTyRzf8t5D8p4SFYREBo7Sdc+Upw3BzQmvBDCHPOG7gG4FqWxi/RFvIiCGgBdwih
         q7KdGmUBHP1pHI5mFdD2KKjREpkM4PKaPHVLj6tAw+WDtzvsIcS5PLcxSlue1UXETtvW
         XNFNUowX5Jvj2IeKITRN6vd/MpA8CMQWU++z1izIPQ6NAAwitlKPK5bajhnhSbpyLtjj
         6eig==
X-Gm-Message-State: AOAM531/vD7wnOrUqJvypKUzaFEnZ41AIOtomzQUQVAS/bdaCTX0ESf0
        neAxzeTwVOWfUnP3hER293s=
X-Google-Smtp-Source: ABdhPJyG3or29pjedbdSe1M8jdSs12vndtOgNQg+JdVFcoY04Ysbndjg7L00DU/+3DOJbEMOVZFtnQ==
X-Received: by 2002:a05:6830:4022:: with SMTP id i2mr12363346ots.9.1625619482567;
        Tue, 06 Jul 2021 17:58:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5sm1247891otm.1.2021.07.06.17.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 17:58:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Jul 2021 17:58:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH 2/3] hwmon: da9063: HWMON driver
Message-ID: <20210707005800.GA2221519@roeck-us.net>
References: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
 <dff04323fc1b0177c1c08d3670333a839af4c268.1625581991.git.plr.vincent@gmail.com>
 <20210706174201.GC943349@roeck-us.net>
 <20210707002045.571694b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707002045.571694b2@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 12:20:45AM +0000, Vincent Pelletier wrote:
> Hello,
> 
> Thanks a lot for your reviews.
> 
> On Tue, 6 Jul 2021 10:42:01 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
> > -EINVAL seems wrong. Maybe -EIO or -ETIMEDOUT.
> 
> On this topic, I've been hesitating to change this code to the
> following. Would it be acceptable ?
> 
>   ret = wait_for_completion_timeout(...)
>   if (ret == 0)
>     warn[_once](...)
>   ...
>   if (adc_man & DA9063_ADC_MAN) {
>     ret = -ETIMEDOUT;
>     goto err_mread;
>   }
> 
> The warn is to make it easier to debug in case of IRQ issue. The reason

"to debug". Then make it a debug message.

> I'm caring is that I happen to have triggered such issue while testing
> this driver, as the GPIO and PLIC on the hifive-unmatched seem to
> disagree with each other. I debugged this and reported to linux-riscv,
> and I believe the issue is not in da9063-hwmon: it also affects
> da9063-onkey, and my GPIO-level workaround fixes both.
> 
> On a tangential topic: this chip is supposed to complete an ADC cycle
> in 10ms, so 1s timeout seems a lot to me. On the one hand it made the
> IRQ issue obvious, but on the other hand a safety factor of 100 seems
> enormous to me. What would be a usual/reasonable safety factor ? 10 ?
> 2 ?

Your call, really.

Guenter

> 
> > > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > > +					da9063_hwmon_irq_handler,
> > > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,  
> > 
> > Is that correct ? The trigger condition is normally provided by
> > devicetree.
> 
> At least it is consistent with the existing and related da9063-onkey:
> 
> 	irq = platform_get_irq_byname(pdev, "ONKEY");
> 	if (irq < 0)
> 		return irq;
> 
> 	error = devm_request_threaded_irq(&pdev->dev, irq,
> 					  NULL, da9063_onkey_irq_handler,
> 					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> 					  "ONKEY", onkey);
> 
> I am not familiar enough with IRQ handling to tell if IRQF_TRIGGER_LOW
> has an actual meaning here: in my understanding the regmap handler
> decides how to clear an interrupt based on regmap_irq_chip content, and
> this is coming from mfd/da9063-irq.c .
> 
> Are both devm_request_threaded_irq() equally wrong ?
> 
No idea. My understanding is that devicetree data is used unless
an explicit method is specified. That is why I was asking _if_ this
is correct, and did not claim that it is wrong.

> > > +	/* set trim temperature offset to value read at startup */
> > > +	hwmon->tjunc_offset = (signed char)hwmon->da9063->t_offset;  
> > 
> > Can you explain why this is read in and passed from the mfd driver
> > and not here ?
> 
> I cannot, at least not with something other than "this is how I found
> the code", which I realise is not satisfactory.
> I've been holding back on changes as I felt constrained by preserving
> the original author's name on the changes (both Author and
> Signed-off-by), but this split was indeed bothering me.
> 
Sorry, that is not a good argument. On the contrary, if I have to assume
that the code has non-technical constraints, I am inclined to just reject
it for that very reason.

Guenter
