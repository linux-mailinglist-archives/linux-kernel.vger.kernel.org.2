Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B518B3FA4E9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhH1KBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhH1KBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:01:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A1AC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:00:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mq3so6343528pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TY3mDlTXWax/HqDLpvkheQ+qxKOKWr/MaoaZ0CcFcPw=;
        b=Fo4MXmJ8sommYUY2LVoQOblg0Ngu87fBSXT2biCRmY4eatGBiB/s+etWaDPHMi1iYM
         fUU/N76KhyNHuvaUiG542LsGhXNtqLuL9BZRNsUGe/yA/5afJs+jIu47TTVS06/6QuXr
         6WZVL8JNdIgx5NlKskr8yNiH659D/MbNX5XHZVE508Pfi+chUgf+/NusbYIRPZ1ISvpC
         l1jbA+FFzZmw7D5IgMbEjErKWwsnbLxPrluBBNzMN4zlPPrlM3ktbTQAwjS39uMvaWMH
         Mq3p9onT5JSF5Z2ylSzAiETdYu+yKayMwb9qMH+K3sWbjIIos5Nb+3VhbPWocJjEjA9J
         6vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TY3mDlTXWax/HqDLpvkheQ+qxKOKWr/MaoaZ0CcFcPw=;
        b=qz+XGT/Q78vNSx9hr067WnlI2crwS0qupVJAazQccfMCK3ntMrkYdDrhLCpteqF+99
         svnBkO9JlwH9i/tQ33Vy92ufCEMIcNqBXbHFcK8wkjjjuvVQ4Gx8rNlLtUHxSMUHDyYD
         q7rvRJ4Ylr5028L1iZmr10K/vQ6sobHJ7CRzNJhI23Or2bW7UCUIHnznAKt4dJo0fMAT
         pRMYeSu7sFJXikyfa+w2zjfljRhqMRBKMYKPd0kI7LjkKbkB3MGDrJBR+4hb/xETQTN+
         FRrUJ6VwxXrFGmNibX5x/L6Be29weIhFig1J5vP1xFzEaLr2aqQLSO12qQDumipghel4
         BTVA==
X-Gm-Message-State: AOAM530WQJDA1AE5N6zSg26OZm6sfgnJBf1hGzW0c9wfkzgQ8vXpHoO6
        6yPLwkn3VBne8UN9Aecho0U=
X-Google-Smtp-Source: ABdhPJx4S04mduNRIb1SP+jTgaUYimfAQXRkYLkdTPMJ//ISSGZYKgSwWqXaZnoWuirt0lh3PGF3vw==
X-Received: by 2002:a17:90a:bd18:: with SMTP id y24mr28449763pjr.83.1630144821426;
        Sat, 28 Aug 2021 03:00:21 -0700 (PDT)
Received: from localhost.localdomain (125-237-24-95-adsl.sparkbb.co.nz. [125.237.24.95])
        by smtp.gmail.com with ESMTPSA id d14sm8814087pfl.90.2021.08.28.03.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 03:00:21 -0700 (PDT)
Date:   Sat, 28 Aug 2021 22:00:16 +1200
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hello@bryanbrattlof.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix docs typos and references to
 previous struct names
Message-ID: <20210828100016.GA5485@localhost.localdomain>
References: <20210828000836.GA10188@localhost.localdomain>
 <YSnT5rXxQNE2sPvw@kroah.com>
 <20210828092757.GA3773@localhost.localdomain>
 <YSoFYT+8v979+Y1/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSoFYT+8v979+Y1/@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 11:44:01AM +0200, Greg KH wrote:
> On Sat, Aug 28, 2021 at 09:27:57PM +1200, Paulo Miguel Almeida wrote:
> > On Sat, Aug 28, 2021 at 08:12:54AM +0200, Greg KH wrote:
> > > On Sat, Aug 28, 2021 at 12:08:36PM +1200, Paulo Miguel Almeida wrote:
> > > > In the comments there where some grammar mistakes and references to
> > > > struct names that have gotten renamed over time but not reflected
> > > > in the comments.
> > > > 
> > > > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > > > ---
> > > >  drivers/staging/pi433/pi433_if.h | 25 ++++++++++++-------------
> > > >  1 file changed, 12 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> > > > index d5c1521192c1..1fae62c40661 100644
> > > > --- a/drivers/staging/pi433/pi433_if.h
> > > > +++ b/drivers/staging/pi433/pi433_if.h
> > > > @@ -5,16 +5,15 @@
> > > >   * userspace interface for pi433 radio module
> > > >   *
> > > >   * Pi433 is a 433MHz radio module for the Raspberry Pi.
> > > > - * It is based on the HopeRf Module RFM69CW. Therefore inside of this
> > > > - * driver, you'll find an abstraction of the rf69 chip.
> > > > + * It is based on the HopeRf Module RFM69CW. Therefore, inside of this
> > > > + * driver you'll find an abstraction of the rf69 chip.
> > > >   *
> > > > - * If needed, this driver could be extended, to also support other
> > > > - * devices, basing on HopeRfs rf69.
> > > > + * If needed this driver could also be extended to support other
> > > > + * devices based on HopeRf rf69 as well as HopeRf modules with a similar
> > > > + * interface such as RFM69HCW, RFM12, RFM95 and so on.
> > > >   *
> > > > - * The driver can also be extended, to support other modules of
> > > > - * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
> > > >   * Copyright (C) 2016 Wolf-Entwicklungen
> > > > - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> > > > + * Marcus Wolf <linux@wolf-entwicklungen.de>
> > > 
> > > Indentation of the name should remain here, right?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > you are right, I shouldn't have changed that line. Do you need me to
> > send another patch without that line or can you ignore just that line 
> > before merging it to your branch? I'm flexible with any approach.
> 
> It is impossible to just "ignore a single line" in a diff, sorry.
> 
> Please fix up and resend a new version, remember the work needs to be
> done by the developer, not the maintainer.  Your job is to make it
> trivial for me to accept your change.  Manually having to edit diffs is
> not scalable at all.
> 

Ok. I will do it shortly

Best regards,

Paulo Almeida
