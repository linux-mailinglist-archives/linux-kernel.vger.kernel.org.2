Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093923FA4C0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhH1J2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhH1J2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:28:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE49C0613D9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 02:28:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d5so540719pjx.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t2gh2e1eSUqxcgphBN/1MmXz34Vdl7UeCQSsSHkYwEg=;
        b=JQMUhsU+CnPRz9mvNLMJFxqy1XfIDXUdeF6pPic0hcajolOYTFv2V4Bn1mv2QVMimN
         VxwWrH+RuQvQMqG+MZfDQWnpLw1URjZQRtO7etGSA7k+no27cCvh3SmXFPUY8QYv2pB5
         CuLgd75me9aPUPFZJlMJmDfApRGaQOsIgzaQYZQcnPmnRdtleG0H1XPdL8VgHeC2Wyyb
         T+TWXU+QaVGKbx00ss2u2XoA4jW7vgFzSbn1DEPpOnG/kDsmXDNqFaEvoawLZVp44cnq
         hsc3Js1rwre9zTHTsrAfDtnyHASeHJXn0hi1+4zW29u+zyd5rvIDHQeujfxB57/SbZzY
         xx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t2gh2e1eSUqxcgphBN/1MmXz34Vdl7UeCQSsSHkYwEg=;
        b=A20sp9ri+tKqlKg8kqA1Gh/Dg+94orLpSLUxEJLhOW/r9YsWVlAtUMQneIU6PG3tDP
         ehG1Q8JC/wFDqdaJBWNPJnKiYKhlrmeMdvRIZx1xzNA7hiKo8SZ6YiRGJZ3XanDDpXXI
         BTEYjBjYce4fPHo5ocMgtFEOiVVUJWKqVV/n5F2pk9lirb1BqDMAjd+AJ1Z25A/tHuMH
         fFfHui+uooXmlWqCWA5UAej/oeAOuJ4DGV/cRd9UQyyq9GW2XKAN4dI8rSJ6LtvWEHEH
         mqMmGaUzmqTXR657cvEZabnRPdPvvSeL1tW3BSgRdIkrl879J66zCiKU9LVNtglcq5lG
         MZ/Q==
X-Gm-Message-State: AOAM532NQEaFN22kpJtKcsqQBr3dkgFBMUswyiTHx/WLhHdFznpjxMTV
        J1Bgub1n1HUgiivdv/Sor1A=
X-Google-Smtp-Source: ABdhPJy8mDZkMPCDH4/RjT7uQ9eTMyb0TdA1DVrOfOMM6TF2n1SszvKJAfGPYXxWY+gSXlsaxXuYEg==
X-Received: by 2002:a17:90a:8005:: with SMTP id b5mr28129197pjn.190.1630142882526;
        Sat, 28 Aug 2021 02:28:02 -0700 (PDT)
Received: from localhost.localdomain (125-237-24-95-adsl.sparkbb.co.nz. [125.237.24.95])
        by smtp.gmail.com with ESMTPSA id v3sm8765864pjd.27.2021.08.28.02.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 02:28:02 -0700 (PDT)
Date:   Sat, 28 Aug 2021 21:27:57 +1200
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hello@bryanbrattlof.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix docs typos and references to
 previous struct names
Message-ID: <20210828092757.GA3773@localhost.localdomain>
References: <20210828000836.GA10188@localhost.localdomain>
 <YSnT5rXxQNE2sPvw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSnT5rXxQNE2sPvw@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 08:12:54AM +0200, Greg KH wrote:
> On Sat, Aug 28, 2021 at 12:08:36PM +1200, Paulo Miguel Almeida wrote:
> > In the comments there where some grammar mistakes and references to
> > struct names that have gotten renamed over time but not reflected
> > in the comments.
> > 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> >  drivers/staging/pi433/pi433_if.h | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> > index d5c1521192c1..1fae62c40661 100644
> > --- a/drivers/staging/pi433/pi433_if.h
> > +++ b/drivers/staging/pi433/pi433_if.h
> > @@ -5,16 +5,15 @@
> >   * userspace interface for pi433 radio module
> >   *
> >   * Pi433 is a 433MHz radio module for the Raspberry Pi.
> > - * It is based on the HopeRf Module RFM69CW. Therefore inside of this
> > - * driver, you'll find an abstraction of the rf69 chip.
> > + * It is based on the HopeRf Module RFM69CW. Therefore, inside of this
> > + * driver you'll find an abstraction of the rf69 chip.
> >   *
> > - * If needed, this driver could be extended, to also support other
> > - * devices, basing on HopeRfs rf69.
> > + * If needed this driver could also be extended to support other
> > + * devices based on HopeRf rf69 as well as HopeRf modules with a similar
> > + * interface such as RFM69HCW, RFM12, RFM95 and so on.
> >   *
> > - * The driver can also be extended, to support other modules of
> > - * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
> >   * Copyright (C) 2016 Wolf-Entwicklungen
> > - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> > + * Marcus Wolf <linux@wolf-entwicklungen.de>
> 
> Indentation of the name should remain here, right?
> 
> thanks,
> 
> greg k-h

you are right, I shouldn't have changed that line. Do you need me to
send another patch without that line or can you ignore just that line 
before merging it to your branch? I'm flexible with any approach.

Best regards,

Paulo Almeida

