Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69E735EAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245277AbhDNCdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhDNCdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:33:36 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8072C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:33:15 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so18018922otb.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4bGVy3IS1ndds7KGYWUaL1bSCZo1l76DnRXI2+3xtH0=;
        b=Rcj8T4Idc8cQ43g4vCZ5xYqKvkMxOfAF5+ut5O5fx1I51jilf46DJV5iNnD3cfWT0G
         lAhJXzm0iiakFicIXz+/UvYEinlniTXgedqA+fb7K197LKR2HwDr4obh8UGoV9sbTFBU
         jqwUSBQJfp8oaoJjDzS01JXLLE7/MLnw7RqwPujBVCdY/I8ktZRZZ4P/c+/K7PwMycPj
         kyE1bUNfsqma5y9oWwiKsCg3rLHcWo08eakUbcbAteR3QZ6y8SI34pF25hoGtBRIha2L
         nlN4VtFMG5jAl7B+80ss5B5Bn+Idp1hPQMcK4HZWIbwuwYQ3WbAVLJ7aKZz+SuwJAi+t
         V+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4bGVy3IS1ndds7KGYWUaL1bSCZo1l76DnRXI2+3xtH0=;
        b=hVIPkGNaSYoMw0WVQemfK1WKPlFND33p6YmSamg68mDUritTO7iRmOUMElZ3mDBIgr
         MiLJ7D/49k2NWZombjCqi6kG4LROjfX8SWB/oSxfDnHwuGMDeI4ERrs4RZ2DzfVYCSRi
         tzlo5G+phNqDmnf+vJXRDvZQQD5Sfi9AT9GKboyMkayhgRaI7szdzYbEME0S5WlrGJBZ
         PP4OgJG3q6LckMqi3JIzhbthHgaSo56UCDVUkZSgsOYxqLqHZ+Dh1VVsXPiWhIzuJ2jY
         8IaglUF1EnA57fp9b8MxUt0LAq/oO7y8cla4lG9ZckSxwPCNDyK4sQi9f2A8VwJHCgRf
         bDWQ==
X-Gm-Message-State: AOAM530tHMVXlmZK4Y6bspjPKsa8YBwHz+YdyEIXDI01hy074E734Rlj
        p4vY07fK2vMX4PkNehxvoNeP8w==
X-Google-Smtp-Source: ABdhPJzzjqKSfUu47K1AzhI2cuCnKq/IjRd+LAunHnK6scr7RcyhIud9sx2jA5MGj2qWaGtbJLKXAQ==
X-Received: by 2002:a05:6830:90c:: with SMTP id v12mr30664622ott.179.1618367595103;
        Tue, 13 Apr 2021 19:33:15 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 68sm3833134otc.54.2021.04.13.19.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 19:33:14 -0700 (PDT)
Date:   Tue, 13 Apr 2021 21:33:12 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Julian Braha <julianbraha@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drivers: pinctrl: qcom: fix Kconfig dependency on
 GPIOLIB
Message-ID: <20210414023312.GW1538589@yoga>
References: <20210225083306.25792-1-julianbraha@gmail.com>
 <CACRpkda2Jbm3DmOhxFyyxDZRrUk01TtPbD+OOG=U7o2mnxEB8A@mail.gmail.com>
 <12736456.GqETC5XQ6s@ubuntu-mate-laptop>
 <CACRpkdbSYzeoA5Ojraq-kmJr0V=kM1uoNBzFAduTB-a9UtJqRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbSYzeoA5Ojraq-kmJr0V=kM1uoNBzFAduTB-a9UtJqRw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08 Apr 03:03 CDT 2021, Linus Walleij wrote:

> On Mon, Mar 29, 2021 at 6:41 PM Julian Braha <julianbraha@gmail.com> wrote:
> >
> > On Tuesday, March 2, 2021 9:46:04 AM EDT you wrote:
> > > On Thu, Feb 25, 2021 at 9:33 AM Julian Braha <julianbraha@gmail.com> wrote:
> > >
> > > > When PINCTRL_MSM is enabled, and GPIOLIB is disabled,
> > > > Kbuild gives the following warning:
> > > >
> > > > WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP
> > > >   Depends on [n]: GPIOLIB [=n]
> > > >   Selected by [y]:
> > > >   - PINCTRL_MSM [=y] && PINCTRL [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
> > > >
> > > > This is because PINCTRL_MSM selects GPIOLIB_IRQCHIP,
> > > > without selecting or depending on GPIOLIB, despite
> > > > GPIOLIB_IRQCHIP depending on GPIOLIB. Having PINCTRL_MSM
> > > > select GPIOLIB will cause a recursive dependency error.
> > > >
> > > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > >
> > > Does it work to just:
> > >
> > > select GPIOLIB
> > >
> > > instead?
> > >
> > > The driver needs the library so...
> > >
> > > Yours,
> > > Linus Walleij
> > >
> >
> > Hi Linus,
> >
> > Looks like I confused this patch with another one when
> > I responded last time. This config option cannot select
> > GPIOLIB, because it will cause a recursive dependency
> > error.
> >
> > Any other ideas?
> 
> No we can apply the patch as-is but let Bjorn have  a look at it first,
> I noticed he is not on the To: line of the original patch.
> 
> You may need to resend with Bjorn Andersson in the recipients.
> 

I don't see a resend of this, perhaps I'm just not good at searching
today...I dug up the patch on lore instead.

GPIOLIB is user selectable, so it makes sense to depend on it, rather
than use select. And it seems like our current defconfigs have GPIOLIB
enabled already (directly or indirectly).

So...

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
