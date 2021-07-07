Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319463BE02A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 02:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhGGAXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 20:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGAX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 20:23:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C10CC061574;
        Tue,  6 Jul 2021 17:20:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y17so433494pgf.12;
        Tue, 06 Jul 2021 17:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZN70fL0pQwXaj4RrpR87vleSRuBw7yD/HYXaGqinIg=;
        b=ehXnstYyxnDRIYXvGMz//BmQ+uGIu41Ku+Ysc+8QxvwIEtp4AoVFYhBDJ2PvZdxwiw
         3EoCgMt6T13tiJ1dzGQd4F1kQ+Bxvu8s5/PAqJkdv+FpBRwABVdmXGe1FuvWkQiwMz71
         3nkwN+xja8X1OIt+rWxCMsA5pfXIhEjG1h5egx8idbCPgH3Rnb8RMSTaH77brNgi2BgB
         H4R44a9Z9cRnMLC/68CsYkcfo0HoD9TzGVY/ef/C5HqALkf8R7UYf6fImshW9Na3mLUc
         +E/NxvWKE56f5Gyyj5CgRcOFY9IGw+slIR5vIYtt7kPyDjIW/d8inbipprE0zXFapA6b
         /mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZN70fL0pQwXaj4RrpR87vleSRuBw7yD/HYXaGqinIg=;
        b=GsLdwZjYNvNv0jLl0I9p+YZrpXbXQG8tqmKVfI/1lOpPEymZ2xh8sLL82wTDFT0feY
         Fk85RadDe5X59ZylCVQvbO9fBq4kQYGc+S7Ez12LLAg/mtChe6JYlytnsbGtBYjW7NJe
         /kWMN4QctTwLhaSTeaje1hyL4abid1/aVc2E+cDBSycCpdRXnJsoUJFAMEpO6geYVBPD
         lJ3B1MTCTOwz+QxUEAiIrAXX/dDRAv5jF0OLtnXj0yHh7eSXNSzVd/AuVcJ5FqXdSG3i
         h5HnGlp3YRkGOQymsC+fER/degeSWdfLorqNGxhqhkaOGYxTHP/UU/gPDUb4skkGbjIq
         iANQ==
X-Gm-Message-State: AOAM5336wt9V2oW/ohU+6GE7IAgbN84iWCgFFljermhfRB8Jjy4TWAJj
        5hre5wFeqH/PeUO8nHb9gHQ=
X-Google-Smtp-Source: ABdhPJxC2liW9eMKer0esVHcTo05zB2Zwy67Z3H7o2SjWyGBgYyrBOBRmqIW+nkfxR8mLiqwfIjt9Q==
X-Received: by 2002:a63:d0d:: with SMTP id c13mr23746299pgl.384.1625617249533;
        Tue, 06 Jul 2021 17:20:49 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id co12sm3987821pjb.33.2021.07.06.17.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 17:20:48 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id EF707900853;
        Wed,  7 Jul 2021 00:20:45 +0000 (GMT)
Date:   Wed, 7 Jul 2021 00:20:45 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH 2/3] hwmon: da9063: HWMON driver
Message-ID: <20210707002045.571694b2@gmail.com>
In-Reply-To: <20210706174201.GC943349@roeck-us.net>
References: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
        <dff04323fc1b0177c1c08d3670333a839af4c268.1625581991.git.plr.vincent@gmail.com>
        <20210706174201.GC943349@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks a lot for your reviews.

On Tue, 6 Jul 2021 10:42:01 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
> -EINVAL seems wrong. Maybe -EIO or -ETIMEDOUT.

On this topic, I've been hesitating to change this code to the
following. Would it be acceptable ?

  ret = wait_for_completion_timeout(...)
  if (ret == 0)
    warn[_once](...)
  ...
  if (adc_man & DA9063_ADC_MAN) {
    ret = -ETIMEDOUT;
    goto err_mread;
  }

The warn is to make it easier to debug in case of IRQ issue. The reason
I'm caring is that I happen to have triggered such issue while testing
this driver, as the GPIO and PLIC on the hifive-unmatched seem to
disagree with each other. I debugged this and reported to linux-riscv,
and I believe the issue is not in da9063-hwmon: it also affects
da9063-onkey, and my GPIO-level workaround fixes both.

On a tangential topic: this chip is supposed to complete an ADC cycle
in 10ms, so 1s timeout seems a lot to me. On the one hand it made the
IRQ issue obvious, but on the other hand a safety factor of 100 seems
enormous to me. What would be a usual/reasonable safety factor ? 10 ?
2 ?

> > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +					da9063_hwmon_irq_handler,
> > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,  
> 
> Is that correct ? The trigger condition is normally provided by
> devicetree.

At least it is consistent with the existing and related da9063-onkey:

	irq = platform_get_irq_byname(pdev, "ONKEY");
	if (irq < 0)
		return irq;

	error = devm_request_threaded_irq(&pdev->dev, irq,
					  NULL, da9063_onkey_irq_handler,
					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
					  "ONKEY", onkey);

I am not familiar enough with IRQ handling to tell if IRQF_TRIGGER_LOW
has an actual meaning here: in my understanding the regmap handler
decides how to clear an interrupt based on regmap_irq_chip content, and
this is coming from mfd/da9063-irq.c .

Are both devm_request_threaded_irq() equally wrong ?

> > +	/* set trim temperature offset to value read at startup */
> > +	hwmon->tjunc_offset = (signed char)hwmon->da9063->t_offset;  
> 
> Can you explain why this is read in and passed from the mfd driver
> and not here ?

I cannot, at least not with something other than "this is how I found
the code", which I realise is not satisfactory.
I've been holding back on changes as I felt constrained by preserving
the original author's name on the changes (both Author and
Signed-off-by), but this split was indeed bothering me.

Regards,
-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
