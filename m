Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37819315B74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhBJAlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbhBIVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:07:21 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00580C061A31
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 12:01:18 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id i8so33803156ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 12:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxMxW34HIne7VhehJIzbH8NC+jObHZPWfyBMYgA2cL4=;
        b=YkvXcQzE0TNOuFo4fYdx+eBVmVDkduHNuNxSs4g3LvqByn5M68j1p8z990irDA3xfF
         vdpPI9ZR4SUBbjLDzZEiGTr1Y7mm/jnzC6mBRTaBGIjs6DGWnpYBvDPys4yXzsZpS0Bq
         5JHvHdLukx3cOPaB2eug6fgFBYweXtRr2xv8TpdoAGYNWJ33RH1eTv9S1yKL7VhdjTBE
         mzf5ebJ7HYi/Sxwi4adkdN6vTRo2dERXaJehBnJp9LNcl53XlyTtONo9uhIr1rsWJxHv
         xCCq5Hoo6drqydMG1zIOWWys7EKhkoWI+mx8525vCqMTkTyGQ9GJ5Ck7ateDf9GbnxjW
         DvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxMxW34HIne7VhehJIzbH8NC+jObHZPWfyBMYgA2cL4=;
        b=dobpmu07heh+exkaKCIjpZlmGmaNC0O6sUx+9OqYWMecuntl3NcCIVJC6IiQchH8Mw
         639qvsmEr/MIUzUuxdFxxqNa+3e/cD3VZmSYu6Y9kap7JajWCxTvh/PlG0TX7av8cGmh
         Nk/X97eUuibgcTx3fU6QXs9O0BJoXtAz7Sc8O6pCFkqiQWZFHYBTKpcFHMVlziXABXAM
         HWdU3b+r/X5kd0FGe3kGInRFqYKSPlu03u7BgaXHvirZ7feN7PKHF19buwxq4vge+aPA
         fRqSnlHrit+Rj6eeYFqjqzr3DEKn3eoMv7/l4M83dC4osLEIivfvJqUt2YWPyYOH8/L1
         6unA==
X-Gm-Message-State: AOAM530lHkAmBMyAN76L7WIYJQxVq9VTUb/2rjADu54pu9aiekrI0qYy
        E4p2CIfWnFaEkfK35lUH3WX89pqiaCXx362BHSEaCw==
X-Google-Smtp-Source: ABdhPJw0dKyV8qTWvrjjos7CiHf+Xk4gkz9uAJHrwhrybU+mqa9lqQ9LC9c0Fa+weXzNc57dbJRnwusPUN99xuSRtM4=
X-Received: by 2002:a17:906:d8a1:: with SMTP id qc1mr24763832ejb.523.1612900877645;
 Tue, 09 Feb 2021 12:01:17 -0800 (PST)
MIME-Version: 1.0
References: <161289750572.1086235.9903492973331406876.stgit@djiang5-desk3.ch.intel.com>
 <YCLfETxDjOUPISpw@kroah.com>
In-Reply-To: <YCLfETxDjOUPISpw@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Feb 2021 12:01:06 -0800
Message-ID: <CAPcyv4inpcwh5rH2bJSSqXuWCNxFAzLrbWLy-_yDAuzDenYURg@mail.gmail.com>
Subject: Re: [PATCH] driver core: auxiliary bus: Fix calling stage for
 auxiliary bus init
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 11:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
[..]
> > diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> > index 8336535f1e11..53f93a506626 100644
> > --- a/drivers/base/auxiliary.c
> > +++ b/drivers/base/auxiliary.c
> > @@ -270,7 +270,7 @@ static void __exit auxiliary_bus_exit(void)
> >       bus_unregister(&auxiliary_bus_type);
> >  }
> >
> > -module_init(auxiliary_bus_init);
> > +subsys_initcall(auxiliary_bus_init);
>
> Ah, the linker priority dance.  Are you _SURE_ this will solve this?

All users are module_init() today so it will work.... today. The
moment someone wants to use it in a built-in driver that uses
subsystem_init() it will ultimately be chased into driver_init().

> Why not just call this explicitly in driver_init() so that you know it
> will be ok?  Just like we do for the platform bus?

Cross that bridge when / if it happens?
