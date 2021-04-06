Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2D35573C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345431AbhDFPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhDFPFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:05:36 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40730C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:05:28 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so14896271otq.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DN+Pv7shK2P5BW650iRpB29dWVvYcWcUHF2JuKWInlk=;
        b=Ku1nVe5iO8Xtqeg8NkdHqrYdN21nd8yNnCo+E/U016S9pQabMx3O8P+3jQ0YAykN+Z
         yKuil8NO5EmGUWi+vPhbdxWBxGZC/HiGdyD6tgX2nK1hvA8HEnO8/mgbyl3fxXVfO96i
         edZs8cxghO6icquJGY3+z9X7XlK8q+XJjH2b8hjrLv+yDS2vYOtZmAALPmiUfbFwqLDN
         f0UVl3T8AcfL0fiHd6lnIXFeWc5PaFLiCoQ7bXuhN0sKUskgF1YxYo2Yvy/oAQC2B5Rd
         LGqsZbaR2Aw4xXqPrdAMjv4hZQTcWUpnjiNQ38C6FrlhLNAHdHvxI39s1hsKY8N37ffB
         yHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DN+Pv7shK2P5BW650iRpB29dWVvYcWcUHF2JuKWInlk=;
        b=WTUN6TUvwrU4bvEoiMULTGCOouplYhLZxI5FrikwqlTtjeRRzQabgFZA6dyEWTCgxJ
         zbl0sHlww+qtn5n9R7tV/e2vUBPto7QjWah6yvKHzaQDB2UyZhfuyYxzTm2fvDMe/WBY
         kpg0DqcKoLAHB7GOEvscLXuLX2LLJMTK6rVH94W1ZwRJRnb5X8D1x7bStxckbCcWj7kR
         iwjsVnVYWDHFbSZBgB2PTeryN+mbq1nhc6/jfFzjH19kndxxH8UcVFDDVjNMvHCcgTAq
         aJp5YbiIaVCaslKP+RbpZV5otxANc/OiKPqpaHMbtLHflRMi91+Mj1GizcpKiH74RhUg
         OoEw==
X-Gm-Message-State: AOAM5327WLMWrsMg+mUuAO5K/6Zlg8mNukznIRqvoAlne351HvLTFkpY
        NiY5ofJcunonL+WlH3axvrD1i5zmw/0VxVAqHRM=
X-Google-Smtp-Source: ABdhPJxMmR4LNN56EPbSCX8BVUWg86qNpB+y7ccxvarcSgUadi7QTQ2hahI9B6z8WD7xNHJJwllxLNzogaENQhQq868=
X-Received: by 2002:a9d:7f8a:: with SMTP id t10mr26302185otp.239.1617721525118;
 Tue, 06 Apr 2021 08:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210406130556.1417-1-fmdefrancesco@gmail.com>
 <YGxsExq2fcQvrN99@kroah.com> <CAPj211u9MHgtjeZGUPsLxU3HkbJ8cr2EUL0v9HA7LE9-b1uUoA@mail.gmail.com>
 <alpine.DEB.2.22.394.2104061652590.2882@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2104061652590.2882@hadrien>
From:   FMDF <fmdefrancesco@gmail.com>
Date:   Tue, 6 Apr 2021 17:05:09 +0200
Message-ID: <CAPj211uct7K7e2Kcz7drmWGcfuTRQYTWHFRvrA9ah-JmBTotsg@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: hal: Remove
 camelcase in Hal8723BReg.h
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 4:55 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 6 Apr 2021, FMDF wrote:
>
> > On Tue, Apr 6, 2021 at 4:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Apr 06, 2021 at 03:05:56PM +0200, Fabio M. De Francesco wrote:
> > > > Remove camelcase in some symbols defined in Hal8723BReg.h. These symbols
> > > > are not used anywhere else, therefore this patch does not break the driver.
> > > >
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > If this is "v2", you need to put below the --- line what changed from
> > > v1.
> >
> > It is a v2 only because you made me notice that I forgot to cc
> > linux-staging and linux-kernel.
> > So I sent it again, but probably I shouldn't have changed the version
> > number because nothing else had changed.
> >
> > > Please fix up and send a v3.
> > >
> >
> > No problem at all. I can explain in the patch v3 what I wrote above.
> > May you please confirm that a patch v3 is the correct solution even
> > when nothing changes in the code?
>
> When Greg acknowledges your patch, everyone who is concerned with the
> patch should see it.  So he needs to pick up the right version of the
> patch that has everyone in CC.  He can use the version number to choose
> the most recent one.
>
> The version numbers don't appear anywhere once the code is committed.  So
> it's not a problem to move up to the next version for any reason.  On the
> other hand, if you skip a version, it can be a problem, because someone
> may wonder if they missed some useful information.
>
> julia
>

Thanks for your clear explanation of these details of the workflow,

Fabio

> >
> > Thanks for your help,
> >
> > Fabio
> >
> > > thanks,
> > >
> > > greg k-h
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CAPj211u9MHgtjeZGUPsLxU3HkbJ8cr2EUL0v9HA7LE9-b1uUoA%40mail.gmail.com.
> >
