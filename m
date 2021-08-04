Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8893DFC33
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhHDHjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 03:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhHDHjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:39:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0762EC0613D5;
        Wed,  4 Aug 2021 00:38:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z3so2073084plg.8;
        Wed, 04 Aug 2021 00:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/1fnGxDd0u/KO3OYmBt1hqVEy3ZVm3ezsLmdUm+AT1k=;
        b=t2al545lGWXDE+IrBUj6kjABFhNlXPKjpi56OsfM7nDToutk0x/+13Lf3lB9dk921F
         NgunzaL3NJsp0ssYMW3cYYlTgmkvmPbi7yuUDgvMXpxMCR22qHZWp+5AXHJm8UHDEEdO
         mmpSwMxWuTn8qexitJAZLwt6O71r6tX1Froe+sCz4tVhTPTUaRH1KQ6qn5JN6aGf0aJ6
         DTAPDpmZE83qkcV+ELy/p3jZao1eb7RovcdF8KxC1QZkcSqvVC84A7uN0gPY7RGVcuiZ
         nm8+X2tmEjWwYJQ2AChm0AvKiEVfkAyNsCquLqeP88hVZA44cOIpnxNNlcTXVlZy5C/w
         KEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/1fnGxDd0u/KO3OYmBt1hqVEy3ZVm3ezsLmdUm+AT1k=;
        b=sqV875GEEtTkMfaTqV5/W4DsfUxBxvv1TBUO6Ko2cHxmkNzoFlUSFvjy7rpTJNo6EF
         wQ89zS/fx/ezgIICqe7Ux4pcCJedTT/rYIFGrrwxYNWLBl9jUZZFNA8Havzg8/aXEFl+
         8v2L9VVN/4Hmodn6w/n2nEbPI6242Skos8m7HF2ZBc+Y2mCO44gBp0gzYXKOHk+h/gXS
         9AkBFGhODi6bwUa7VXqgIq/oJrERX3hUGmUavo/sK006xuYujr3lDJ37YVoT6R9KStky
         NIy77e3q16pgdls4HCO4is5Dkc3tZrAYAqCrKnlWXq3YVT+yRg6+4tL6c3X+0O1UOf1R
         CuCg==
X-Gm-Message-State: AOAM531l7FMvK2fTIQt0Kx+J+3QJLxFKlovonIHJcrMBE+21XboN/BiU
        yIaUa2yx6RjDKAfUO4olYOFpvOprmBrV80rxFjU=
X-Google-Smtp-Source: ABdhPJyo6k11qe9mgZUkeiX2Z9vHXhC8pf9bZuDidjcgojlx9+1dWKRxa087OehLD6AqCLTzmoD9XaA+RTZC00T0z20=
X-Received: by 2002:a17:902:b713:b029:12b:b249:693f with SMTP id
 d19-20020a170902b713b029012bb249693fmr5415074pls.17.1628062738544; Wed, 04
 Aug 2021 00:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210729053937.20281-1-shruthi.sanil@intel.com>
 <20210729053937.20281-2-shruthi.sanil@intel.com> <YQh1HMMkJyO8g/RP@robh.at.kernel.org>
 <BYAPR11MB31281638EBA0C2B815DF56F9F1F19@BYAPR11MB3128.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB31281638EBA0C2B815DF56F9F1F19@BYAPR11MB3128.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Aug 2021 10:38:22 +0300
Message-ID: <CAHp75VeAnm-9oy5BinY8DU5tRj0EhU_vVxkvcp0M+wXPSv8Wdw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
To:     "Sanil, Shruthi" <shruthi.sanil@intel.com>
Cc:     Rob Herring <robh@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 8:35 AM Sanil, Shruthi <shruthi.sanil@intel.com> wro=
te:
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, August 3, 2021 4:14 AM

...

> > > +properties:
> >
> > You need a 'compatible' here. Otherwise, how does one know what 'reg'
> > contains. Also, without it, this schema will never be applied.
> >
>
> This is a parent block that has the common configuration register address=
 defined which we would need during the initialization of the child nodes. =
This block in itself is not doing anything. We have this because, we have a=
 common register that is required to be accessed during all the timers and =
counter initialization.
> The child nodes have the compatible string, which is used in the driver. =
I have validated this on the Keem Bay HW and see that the timer probes are =
being called and the timers are functional as expected.

I think I understand now. The problem is that the current state of
affairs with this block is incorrect software representation. What you
need is to create an MFD device driver (for which the compatible will
exactly the one Rob is telling about) and from it you register the
rest of your drivers. The existing drivers for this block should be
converted to MFD schema.

--=20
With Best Regards,
Andy Shevchenko
