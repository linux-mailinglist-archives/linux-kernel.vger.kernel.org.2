Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20E1425F44
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhJGVlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbhJGVlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:41:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4CAC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 14:39:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s16so6503765pfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mABlAwLHsZ2a12EUjiNkKav9QrrHKT70s/HzdqkWE9E=;
        b=KOXShFYrpT17QDKG0QhwkvnzbPTN/YOi70RVHOLm1gt/YtfyuuNn1yHFuZsNlYYbI/
         Ytl+mCjoVpFHGlAf+mQsNd8MKB8YXWFPthHCMjoR0qJeUcKjCLVcx1CI/kUFjRxswbc4
         U11nPNpmz6ZGzj9bYnUXKEs3XpDXH7tqGkVrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mABlAwLHsZ2a12EUjiNkKav9QrrHKT70s/HzdqkWE9E=;
        b=PHFzkvExNmIyCCxj53nRVAlV83Vtu+MqxtiZx5Gd2nJyhiQQlfCiUyKZtXW4qkksv+
         QWJJZVJtj9wayeV5M9IuAegsCYYfT3N7lgYLUPZl5OqhamZ7Rt+Ijm3j4RKNIe0zNOel
         60LOwgQZcxhlyNgwL/EpWBi/+qgiIcWyfQvm3MMwjac8Q8r0WXMm4dhgsPV9FFpGvHd0
         v81d/8ZU6JkX373lTMprSe+RCP/aP7SM0H6hn1KHzbpuSmaL5KyDDxlRg7u2oZg8PJmW
         zOslgxprkI91wAKwR+T08CkCXM33gB2D0lBZ0x1Wsb7TV0I45weRR8Crm6dmzwyIwotP
         1PPQ==
X-Gm-Message-State: AOAM533dJoalB+14O4eWuB3k+sAeGWytXAzxtE0is+1SXI8HLTWoJFz2
        yfQTzu9CJWeWZf7XVq+0qlvS5LRPxiAybQ==
X-Google-Smtp-Source: ABdhPJyAED2YrFgboeDMPxBa7moFr7wAhAa18qXeOgpGTZydDq7tKK+1kKeHeFAcYJMjL0ilfeNh1w==
X-Received: by 2002:a63:e216:: with SMTP id q22mr1525009pgh.3.1633642755379;
        Thu, 07 Oct 2021 14:39:15 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id x7sm341231pfj.164.2021.10.07.14.39.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 14:39:14 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id o133so190886pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 14:39:14 -0700 (PDT)
X-Received: by 2002:a63:1a64:: with SMTP id a36mr1565093pgm.225.1633642753857;
 Thu, 07 Oct 2021 14:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com> <YV8jfavX/W9T25YX@smile.fi.intel.com>
In-Reply-To: <YV8jfavX/W9T25YX@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 7 Oct 2021 15:39:02 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BbXA0GEuzUy68=W94ArMiO=3Sbg-HQNqUdtSTcvWOF0A@mail.gmail.com>
Message-ID: <CAHQZ30BbXA0GEuzUy68=W94ArMiO=3Sbg-HQNqUdtSTcvWOF0A@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mmc: sdhci-pci: Add some CD GPIO related quirks
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like you were previously using the `cd-gpios` DT property to
determine this. It also sounds like you switched from DT to ACPI so
you lost the ability to use this field?

Can you not use something like the following:
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.10/drivers/mmc/host/sdhci-acpi.c;l=945

p.s.,
Sorry for resending. I sent it as rich text before.


On Thu, Oct 7, 2021 at 10:47 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 05, 2021 at 01:24:24PM +0300, Andy Shevchenko wrote:
> > It appears that one of the supported platform magically worked with the
> > custom IRQ handler (any hints how?) while having two PCB designs with
> > an opposite CD sense level. Here is an attempt to fix it by quirking out
> > CD GPIO.
> >
> > Patch 1 introduces two additional quirks (it's done this way due to
> > patch 3, see below). Patch 2 is an actual fix for the mentioned platform.
> > If backported need to be taken with patch 1 together. Patch 3 is (RFT)
> > clean up. The questionable part here is the locking scheme. Shouldn't
> > we do something similar in the generic IRQ handler of SDHCI? Or Broxton
> > case has something quite different in mind?
> >
> > Patches 4-6 are dead-code removals. Patch 4 accompanying patch 2, patches
> > 5-6 just similar to it, but (functionally) independent. Would like to hear
> > if it's okay to do.
> >
> > Any comments, hints, advice are welcome!
>
> Adrian, Ulf, any comments on this? At least first two fix the regression and
> would be nice to have them in sooner than later (I can split them separately
> if required).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
