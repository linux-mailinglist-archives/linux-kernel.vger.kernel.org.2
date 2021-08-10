Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747813E09CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhHDVDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbhHDVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:03:24 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCEBC061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:03:07 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id kl2so1791825qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zdp6WltwdPJTiYOXAA38Zmu1ytNFtDVTLeWSJfJQUTA=;
        b=pYDFpii+lgAAPWns/N8L4Cmo0xyRztJF7JYeWgj8oHRZZO0s6PKpyDemjtdowSWg/S
         t/RRf2/vebxyVqxstAUzy1XQVdpo8U8CcM+yCecg6xK1+EBidwwDlR2nd79tC2teo5oe
         ZCU+GD5GpyO+cpGLLnCG9QZHL7wgVOIa2+Z78QvHvuPFzFbA5+hmYx8TocrlDUcXnwKN
         s7P1cVm4hI9QbQd5xaUp9Tsl9IAFgJAZBcz6tbSZ2qOmwBCbqsRGxKd7EdvtOugP08lB
         9F/qPbRjJ9qKRp4eN5wwt4phJ1ZXLovPrW7FFMti7r/jNmc5C6U/6nY50hYv5ByHBdo+
         rNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zdp6WltwdPJTiYOXAA38Zmu1ytNFtDVTLeWSJfJQUTA=;
        b=cMTLPbDgbdmLOmWTID2UH1HjhICAkprOzEdI6mqJxqlGwxfUs0ibHcUtuqKRrTu+72
         znxBr+hGkKxYH16ShcTXYvm6ajJ5jU/CJmmIZ+BwKXYsQilaOn5K1UVsSonCdqpa+N7a
         xMUN2yCqfXmHssU9iC0ybJ3KiB/qFEuTR7Dvbtw4wGnuSvoZjihtm3tPrHrW5NIETLbn
         gFNGpcTCIoKozXLFtg+34BJWdE57vl9fbgpClL9xyLRiel2h6U0ZdbO83y6H2N4bQJJp
         oOZPGMZcYG7WvkIPscsMSk+DJxdrtEsxvM1s85fQFHYPmUADCH/+qHpdz99V8h/Sz6Fz
         EwhQ==
X-Gm-Message-State: AOAM532pAXPeegB42cc2uYkeJNS7TAg9wWcBg4npDJwqXzKpH4tvQK8P
        e93TUgGJwwXxP0fEqblGbDFWVNqJCRYXiDkv0JjZTw==
X-Google-Smtp-Source: ABdhPJwzRxAtYtsckH8eXVYGse7q8J4o42yWbF/cUsPjzKXnvsENpPibR4PjjuetgtQCFE0DxrNZ7FJB/59wegVXnLA=
X-Received: by 2002:a0c:aa42:: with SMTP id e2mr1547891qvb.23.1628110987030;
 Wed, 04 Aug 2021 14:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210731195034.979084-1-dmitry.baryshkov@linaro.org>
 <20210731195034.979084-2-dmitry.baryshkov@linaro.org> <CAJZ5v0gWD8WSQU4oPMSdZFM9VpNpc4TAFJ=_wQLB60XFxw-Ciw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gWD8WSQU4oPMSdZFM9VpNpc4TAFJ=_wQLB60XFxw-Ciw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 5 Aug 2021 00:02:54 +0300
Message-ID: <CAA8EJpq5DB2a=C+eo_S7QgVMzpm=mvUcC4DkWwGoKQ1g8trmgA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: runtime: add devm_pm_runtime_enable helper
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021 at 21:07, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Jul 31, 2021 at 9:50 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > A typical code pattern for pm_runtime_enable() call is to call it in the
> > _probe function and to call pm_runtime_disable() both from _probe error
> > path and from _remove function. For some drivers the whole remove
> > function would consist of the call to pm_remove_disable().
> >
> > Add helper function to replace this bolierplate piece of code. Calling
> > devm_pm_runtime_enable() removes the need for calling
> > pm_runtime_disable() both in the probe()'s error path and in the
> > remove() function.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 17 +++++++++++++++++
> >  include/linux/pm_runtime.h   |  4 ++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 8a66eaf731e4..ec94049442b9 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1447,6 +1447,23 @@ void pm_runtime_enable(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pm_runtime_enable);
> >
> > +static void pm_runtime_disable_action(void *data)
> > +{
> > +       pm_runtime_disable(data);
> > +}
> > +
> > +/**
> > + * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
> > + * @dev: Device to handle.
> > + */
> > +int devm_pm_runtime_enable(struct device *dev)
> > +{
> > +       pm_runtime_enable(dev);
> > +
> > +       return devm_add_action_or_reset(dev, pm_runtime_disable_action, dev);
>
> When exactly is pm_runtime_disable_action() going to run by this rule?
>  When the device goes away or when the driver is unbound from it?

When the driver is unbound (either because probe() returns an error or
because __device_release_driver() is being called).
This corresponds to a typical call to pm_runtime_disable() from the
probe()'s error path or in the remove() callback.

> > +}
> > +EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
> > +
> >  /**
> >   * pm_runtime_forbid - Block runtime PM of a device.
> >   * @dev: Device to handle.
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index aab8b35e9f8a..222da43b7096 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -59,6 +59,8 @@ extern void pm_runtime_put_suppliers(struct device *dev);
> >  extern void pm_runtime_new_link(struct device *dev);
> >  extern void pm_runtime_drop_link(struct device_link *link);
> >
> > +extern int devm_pm_runtime_enable(struct device *dev);
> > +
> >  /**
> >   * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
> >   * @dev: Target device.
> > @@ -253,6 +255,8 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
> >  static inline void pm_runtime_allow(struct device *dev) {}
> >  static inline void pm_runtime_forbid(struct device *dev) {}
> >
> > +static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
> > +
> >  static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
> >  static inline void pm_runtime_get_noresume(struct device *dev) {}
> >  static inline void pm_runtime_put_noidle(struct device *dev) {}
> > --
> > 2.30.2
> >



-- 
With best wishes
Dmitry
