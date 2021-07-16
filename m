Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561213CB565
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhGPJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhGPJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:45:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AC8C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 02:42:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t5so11321135wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i8BbHCY36HWeOSP/Mk5Bqu7RLlSCoqipz9eWFDA1two=;
        b=ZBE66alYfrjz+XhQBRbbqDXrP5r90PrFSpl4xoScyBAoV1nakhvb/7IuPW21/2unAk
         ODfRlDHH94iYoFVsWtaYeJTSb9BKItC2g7R7OEB741DgSvJpN0vjM4LaRi9kAMuSEU37
         aIL6kAoG4AzxiFVNy8e6te2XZFTjAtGFtBn4AvGtOuzgKG1RDt4yS8b1WUy2mcNHOGSi
         0kWL9l+i5gakl4tzknysCS72kJj+O+0mQ5C3qoxtnlExW1K3hwVVVzWyfQestBDSKzmP
         ifUr6m/wjKpN6o1TVGEn94Q1nVob2sZl0sPlLKhhxt4BGR9KCYFbJI2spKz7cxOcaEcL
         J5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i8BbHCY36HWeOSP/Mk5Bqu7RLlSCoqipz9eWFDA1two=;
        b=Ue+QpJXvh6Gvkcq2xK2H4h0RZkACa01UZYccj/ipxf1BestVDufenlYX8zRT3TmqeC
         eE/cZAhWiLspoV+aE8SRlUv2wNMETh07WdJqRBFLohyTvBmoG2wDy+6PrJnJng9g96J1
         xMUaU0QLoH7iesWYUEPqmNFX99D6NZzRbItl6tCa1XOkpDkeoG9NlIui+2aQH7lGaHfh
         JS19xlqSawHhDp9wu9rhjZaU++Mt6zoeZXMdhybgzQM4uAVBjOEsLaboL+VEMdueMBBI
         Ye+MnRbF5WkF7YOPsd3Ll6mgZp1ZIxu4yTxy7U9LRF5wNCYJ4oicuE/EgjN0gU7sT4d+
         b2rg==
X-Gm-Message-State: AOAM5309O7mgUifu2wwYamxWJnp2e3LkSfWdC2VsWnFoDLTIrPM7nj0w
        tOn1Qe4kWzUtXhWpKIMCbkKJGQ==
X-Google-Smtp-Source: ABdhPJwoYjcWEpced0OKX1uPRScV2uuWCMxRE8Q2GTPEAi+F6jfJPs9gqYJ69lOcCYwTllTMBqGu5A==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr10875158wrw.319.1626428575912;
        Fri, 16 Jul 2021 02:42:55 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id w9sm7728661wmc.19.2021.07.16.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:42:55 -0700 (PDT)
Date:   Fri, 16 Jul 2021 10:42:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] TQMx86: TQMx110EB and TQMxE40x MFD/GPIO support
Message-ID: <YPFUnQaC9gWUY1Z4@google.com>
References: <cover.1625227382.git.matthias.schiffer@ew.tq-group.com>
 <YPFPT+5z5J43kBzL@google.com>
 <b98a99330e250b51d09c904c9e274ae461118238.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b98a99330e250b51d09c904c9e274ae461118238.camel@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021, Matthias Schiffer wrote:

> On Fri, 2021-07-16 at 10:20 +0100, Lee Jones wrote:
> > On Fri, 02 Jul 2021, Matthias Schiffer wrote:
> > 
> > > Updated patch series:
> > > 
> > > - A number of new patches (more hardware support and a few fixes)
> > > - Patches 1-3 have gained Fixes tags
> > > - Patch 2 depends on 1, so maybe we can push the GPIO patch through the
> > >   MFD tree to keep them together?
> > > - The change in patch 7 was somewhat controversial. I've added a
> > >   warning, but it is the last patch of the series, so it doesn't affect
> > >   the rest of the series if it is rejected.
> > > 
> > > 
> > > Matthias Schiffer (7):
> > >   gpio: tqmx86: really make IRQ optional
> > >   mfd: tqmx86: clear GPIO IRQ resource when no IRQ is set
> > >   mfd: tqmx86: remove incorrect TQMx90UC board ID
> > >   mfd: tqmx86: fix typo in "platform"
> > >   mfd: tqmx86: add support for TQMx110EB and TQMxE40x
> > >   mfd: tqmx86: add support for TQ-Systems DMI IDs
> > >   mfd: tqmx86: assume 24MHz LPC clock for unknown boards
> > > 
> > >  drivers/gpio/gpio-tqmx86.c |  6 ++---
> > >  drivers/mfd/tqmx86.c       | 48 ++++++++++++++++++++++++++++++--------
> > >  2 files changed, 41 insertions(+), 13 deletions(-)
> > 
> > Patches look good.
> > 
> > Could you please collect up Andrew's acks, remove the suggested Fixes:
> > lines and resubmit please?
> 
> Are you referring to the Fixes: line in "[PATCH v2 3/7] mfd: tqmx86:
> remove incorrect TQMx90UC board ID"?

I'm referring to the lines that Andrew said did not qualify.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
