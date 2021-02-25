Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB20324A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 07:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhBYG2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 01:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhBYG1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 01:27:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783A6C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 22:26:33 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p5so2646252plo.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 22:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hGA9u86pgJ/h+4ARie57RSKx/4zZugYIPz84nY+12w8=;
        b=r7RwTThHs5yeyOptz2vk37ZktRyKG3WRN/vYFJEcKVD+DLh+GZgH/kpij7Oiyigodf
         ZPbRh/7aPYvNM8ENbgPofp35wG5FHCNdj6PRno3LpSIkBjqYAyYZUHzpn3LXKq0wFDqD
         b3SU4+sgyiTGTjzEUCb3N9CSF16YcyZhb2cCHsF9VqZSpAQU3JCPApXuMyd0ruHusOvu
         65O1V8xKHw2XVwkipbLAxh2v49lOx0Dka666U6pWJPWFtWj7c7N5gHjnaQch8f58A8uo
         o4H0UXxvZqT0Q4Tclm7cQH+pRWerVmiAh7ARCbIE3ncTXcIrXRdwMhyn3NU6dHz9pqCQ
         gWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hGA9u86pgJ/h+4ARie57RSKx/4zZugYIPz84nY+12w8=;
        b=nhYLs2OMk3dgcb/RwkNHS0zPTM4PS8I3vlSHY+HtfS7ex9wsQP0IGG3bgO99QAslmi
         ChVixxr8FmQ3IrvMDTMIdLicOejWPPjLmLMEM1Lzch0H0y4On5rPLy8/Y4ikIWiVE24s
         FhnYVcb4BKQldmNElHSHP4usKnIbZ4OAmGJd/83iH5jwgvtmt0I3ziI61PJ4Xbpa/me8
         we488cPDgQXslsMv1g58WQmYlxc3347UHD8tVLX71rNSeHdUQK9qXZ7fjm+j1sWy9FXI
         zdIthnIC6q092sLe4BN2vamDYkpBLsacLcsC4amefEeOmKiZrlsP0y4G3NlH1PgV9JsI
         4AXw==
X-Gm-Message-State: AOAM531UKE98ZifXE4FvpiFB1VUMJp1nnLsxUt1sC57Q/4XX0XZ0FSGm
        oiwpFB7P8TqpHD5aZJEld58=
X-Google-Smtp-Source: ABdhPJzYRSM3iTmqYW9vck+GGHcfjUmiktS6Bh+PDQ4Hi2+R52jeFd9eQJ6EDHKoAi50EIFjdq9MBQ==
X-Received: by 2002:a17:90a:c386:: with SMTP id h6mr1784727pjt.145.1614234393002;
        Wed, 24 Feb 2021 22:26:33 -0800 (PST)
Received: from google.com ([2620:15c:202:201:552:720f:2933:5745])
        by smtp.gmail.com with ESMTPSA id r2sm4599521pgv.50.2021.02.24.22.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 22:26:32 -0800 (PST)
Date:   Wed, 24 Feb 2021 22:26:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Chris Ye <lzye@google.com>, Cameron Gutman <aicommander@gmail.com>
Cc:     Chris Ye <linzhao.ye@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] Input: Add "Share" button to Microsoft Xbox One
 controller.
Message-ID: <YDdDFfMFFbuqvL43@google.com>
References: <20210225040032.684590-1-lzye@google.com>
 <YDcoduCkBjC8EM3F@google.com>
 <CAFFuddKYhOV8NY9vqrmzRNe0P_n0H+zzAMarV9iGc_qt=+40xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFFuddKYhOV8NY9vqrmzRNe0P_n0H+zzAMarV9iGc_qt=+40xg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 08:44:37PM -0800, Chris Ye wrote:
> Hi Dmitry,
> The latest Xbox One X series has this button, I can add a new
> XTYPE_XBOXONE_X and only apply the change to the new type.

Sounds good to me. Cameron, what do you think?

> The controller supports bluetooth and the HID usage for this button is
> consumer 0xB2:
> 0x05, 0x0C,        //   Usage Page (Consumer)
> 0x0A, 0xB2, 0x00,  //   Usage (Record)

I see, thank you.

> 
> Thanks!
> Chris
> 
> On Wed, Feb 24, 2021 at 8:33 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Chris,
> >
> > On Thu, Feb 25, 2021 at 04:00:32AM +0000, Chris Ye wrote:
> > > Add "Share" button input capability and input event mapping for
> > > Microsoft Xbox One controller.
> > > Fixed Microsoft Xbox One controller share button not working under USB
> > > connection.
> > >
> > > Signed-off-by: Chris Ye <lzye@google.com>
> > > ---
> > >  drivers/input/joystick/xpad.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> > > index 9f0d07dcbf06..08c3e93ccb2f 100644
> > > --- a/drivers/input/joystick/xpad.c
> > > +++ b/drivers/input/joystick/xpad.c
> > > @@ -368,6 +368,14 @@ static const signed short xpad360_btn[] = {  /* buttons for x360 controller */
> > >       -1
> > >  };
> > >
> > > +static const signed short xpad_xboxone_btn[] = {
> > > +     /* buttons for xbox one controller */
> > > +     BTN_TL, BTN_TR,         /* Button LB/RB */
> > > +     BTN_MODE,               /* The big X button */
> > > +     KEY_RECORD,             /* The share button */
> >
> > If I understand this correctly, not all Xbox One controllers have this
> > new key. Is it possible to determine if it is present and only set
> > capability for controllers that actually have it?
> >
> > Also, I am unsure if KEY_RECORD is the best keycode for this. It might,
> > but does your controller supports bluetooth? What HID usage code does it
> > send for this key?
> >
> > Thanks.
> >
> > --
> > Dmitry

-- 
Dmitry
