Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5B3A9E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhFPPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhFPPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:00:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B99C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:58:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k6so2403367pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5V0cO8S8LROlmU8bo2iifVgZd0Vyi25vTvYOBJKYB+4=;
        b=X4mm62gINRuuHeYlmYCP4SQ3WVEPw7+mOvJJqo1pO36Zg0AdNrISscamBkSXMhAajv
         /b2qFpJ0Bopxzc50a/aNwHPlhq6pCV+19TEXmOMmxuigl0wvuZp6q3hUhTxsqSc8WPLH
         UJk7OdF9+mO8yx5hqamqcZ4DtDW/R/Cv+qUpVPtjLCkP6518gf3TQoFu2LQE5r1Q8rpb
         zYWkjdDabZEBL++0kTbL5UUR85h9FxNu/hl2FmzyBQD9TEjVhDGdbGQgBGr7leb9TvH4
         3emjNRR8Y0wXfo2YLtgOAlOWStctgMQOxX9IQTPSRXEblEDMkLa3vupaF0vcPZ0RWhF9
         JBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5V0cO8S8LROlmU8bo2iifVgZd0Vyi25vTvYOBJKYB+4=;
        b=dB6hnWsBrdhX5nu+FmWZQ/pGcS5sHkZSZPfvaLSlY28cllLpVKb2yupOyQg2mRww0F
         CFPBrXn5S/q6w4QLPhibapU42/cPMZPYjDjBpzk2Jjr/ml9z9rSUVqe5U8Iox2f4S+Ui
         slKPQLv/NFsc15wJldFalgJKK31ATVHK5NO6+IsGZpxyqGre+qEGZKuNNHZtXffYmX1J
         zPclu93OHFmLwD+hvigM9CbAZe6YAsnXyUu4M5Wrl+areB4eQKHlU6SNvoxTXnNVLFbv
         vF8z/X3AadhDaKlpfXN2Fi04cfAzd8a5wa/cEoDiR7H3O03NWdzYcKJNQbSDXA8fB8I/
         lb0Q==
X-Gm-Message-State: AOAM530uEh2O8pLB/z8k6e0Fdw/CUOS9amdi7ZrFqNYnPOcNApez4dYb
        5+QzBmBnqH0BJNwZA1t0x7vfQl94QWE2LbbYZHo=
X-Google-Smtp-Source: ABdhPJzoWuCfTkrwJyWobl3ClmjHNmhBp0bsA5oHFp/qAUrWPGGbuqNnkjRlJL0KJiZ11o7E4bl3JRNFFrFKTcsKYjM=
X-Received: by 2002:a62:e404:0:b029:2ee:f086:726f with SMTP id
 r4-20020a62e4040000b02902eef086726fmr160828pfh.7.1623855483758; Wed, 16 Jun
 2021 07:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210616143121.46059-1-andriy.shevchenko@linux.intel.com> <YMoOVrJ1ETVhRr4F@kroah.com>
In-Reply-To: <YMoOVrJ1ETVhRr4F@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Jun 2021 17:57:47 +0300
Message-ID: <CAHp75VeenUQxbaUmA8WXyJkjojnZvzF_PZUZgUPoVVR70+doQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pps: generators: pps_gen_parport: Switch to use module_parport_driver()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Alexander (I believe he is the author of the original code, sorry if not)

On Wed, Jun 16, 2021 at 5:47 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 16, 2021 at 05:31:21PM +0300, Andy Shevchenko wrote:
> > Switch to use module_parport_driver() to reduce boilerplate code.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pps/generators/pps_gen_parport.c | 44 +++++-------------------
> >  1 file changed, 9 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
> > index 6a1af7664f3b..565f99782402 100644
> > --- a/drivers/pps/generators/pps_gen_parport.c
> > +++ b/drivers/pps/generators/pps_gen_parport.c
> > @@ -20,8 +20,6 @@
> >  #include <linux/hrtimer.h>
> >  #include <linux/parport.h>
> >
> > -#define DRVDESC "parallel port PPS signal generator"
> > -
> >  #define SIGNAL               0
> >  #define NO_SIGNAL    PARPORT_CONTROL_STROBE
> >
> > @@ -180,6 +178,11 @@ static void parport_attach(struct parport *port)
> >  {
> >       struct pardev_cb pps_cb;
> >
> > +     if (send_delay > SEND_DELAY_MAX) {
> > +             pr_err("delay value should be not greater then %d\n", SEND_DELAY_MAX);
> > +             return -EINVAL;
>
> Note this is at a later point in time than before, are you sure this is
> ok?

Yes, it doesn't matter when we check the module parameter.

If it's writable we even have more flexibility of changing it at
runtime (when built-in the kernel) after this patch.

> > +     }
> > +
> >       if (attached) {
> >               /* we already have a port */
> >               return;
> > @@ -223,6 +226,8 @@ static void parport_detach(struct parport *port)
> >       hrtimer_cancel(&device.timer);
> >       parport_release(device.pardev);
> >       parport_unregister_device(device.pardev);
> > +
> > +     pr_info("hrtimer avg error is %ldns\n", hrtimer_error);
>
> Why is this line needed?  When drivers work properly, they are quiet.
>
> I know the existing code has it, no reason it needs to stay here, that's
> why we created these macros, to remove the ability for drivers to be
> printing junk like this that they do not need to be printing.

I believe it may be useful for some debugging / statistics. But let's
ask Alexander about this.

-- 
With Best Regards,
Andy Shevchenko
