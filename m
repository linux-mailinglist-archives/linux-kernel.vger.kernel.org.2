Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164403EC3F3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 18:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhHNQzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 12:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhHNQzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:55:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A9C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 09:54:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d17so15859182plr.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JY7pPLjj/B269stty41QL9NGb4G8n6jLdrZkp/18n68=;
        b=HKoDnzK0/PrmlfEIpY60lBk7/fCES5ZNmTZiiQD/fUX/D9mqkjvjksQDpy0KkWV4gg
         bqUZ7fsovYzQy9y65XdOOiG4w4r5L6sYeIwpd85VG8kGxCD2k0ZrZXWEJ4pmieo/CBIf
         w3Tn/Kku7fmE92HIiTQ1HkLVlwmDZv0QAvglMXZCvYYJJ9S/T3Ffi25aRc7amG4ZKl6p
         UnRSAolSO3XtG6fWXGRxmDoo3J3m0um/2JbZHC8deegQUvAtl+s2HaJr+4JFu8zJQA7S
         F++mX4sy3eZumvK32/gFoaUrRy9HA3suLsckvak8kYVvDwj49GNZgr66ixFxp5hMutXX
         Q3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JY7pPLjj/B269stty41QL9NGb4G8n6jLdrZkp/18n68=;
        b=Jz7QM7LZhNDgACOPGEsKATAKRhOKDRKJZwESN2/Il17HuJchBa0Ei68iLLLuzyV+0u
         vKklqwnyqHpfZN5FvJkqkTDvk5JA9xQ+gRhx/Vyge99ZEbNLNvrqDgpZ674N4IzmxYaT
         3Vp7bwVyYnO2S1ucnDq9WOv4RaC7M4fhD0VhFrx/OSHLbnBiwnUNBiUjbfKdxG/UgNeF
         6Ut0O+3jQBXpuj3hYONJfLZZeenOi+zlaeGNQSFXQcsLS1i5u4A4NAGrMTD5Yy7Y+B4M
         RjD/GRARk1DuRpJivGUr5pWGjA8XaizlBQOgGKhcPH2aYBuTHz4jmLGwnDDh8krtjVCM
         6bOg==
X-Gm-Message-State: AOAM532q7SC3S5Ctmr11FaC2Asj/0yRRTfROI7ecoxbw+m4lyTDcXXXg
        Ba5VIOv126sSgRUJJwY6OJKxj47OlEDb4Me0U/G/Eg==
X-Google-Smtp-Source: ABdhPJyzauVMKmxIEgzrH7QoiUYrH5ZkZG4IbF0CAJAigPhwmxnF9WDkC7hooa6ju2/StjBttBQaQGBEQUn44Dv3AUI=
X-Received: by 2002:a62:88c8:0:b029:3a3:94e9:8ab0 with SMTP id
 l191-20020a6288c80000b02903a394e98ab0mr7914007pfd.2.1628960091691; Sat, 14
 Aug 2021 09:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210811201450.31366-1-martin@kaiser.cx> <20210812061759.GW22532@kadam>
 <20210813100536.xkjzfq5pstbhdwru@viti.kaiser.cx> <2555683.U4YhqVPOqN@localhost.localdomain>
In-Reply-To: <2555683.U4YhqVPOqN@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 14 Aug 2021 17:54:40 +0100
Message-ID: <CAA=Fs0kyzRjR1b_QfseyKE4mAp4W-Bxa97esf5QDoUFiOhA-zQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] staging: r8188eu: (trivial) remove a duplicate debug print
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 at 13:42, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Friday, August 13, 2021 12:05:36 PM CEST Martin Kaiser wrote:
> > Hi Dan and Phil,
> >
> > Thus wrote Dan Carpenter (dan.carpenter@oracle.com):
> > > Please think of the subject and the commit message as two different
> > > things.  Often it's people reviewing on email will only read one or the
> >
> > > other.  In other words just restate the subject:
> > OK, I'll keep that in mind for further patches.
> >
> > > > Dear Martin,
> > > >
> > > > Just my personal opinion, but I'd be inclined to strip out all DBG_88E
> > > > calls totally. If there are necessary functions being called such as
> > > > device_may_wakeup() we can always just keep this part and remove the
> > > > macro call (not checked this function out myself yet). Thanks.
> >
> > I'd agree with you, Phil. Most DBG_88E prints don't say anything useful.
> >
> > This comment from Greg made me drop the DBG_88E removal for now
> >
> > https://lore.kernel.org/linux-staging/20210803201511.29000-1-martin@kaiser.cx/T/#m05d82a
> > 0ca8ed36180ebdc987114b4d892445c52d
> >
> Hi Martin,
>
> I think you misunderstood what Greg was trying to convey with the above-
> mentioned message.
>
> Well, he doesn't like to feed developers with little spoons :-)
>
> I'm pretty sure that, by "Why not use the proper debugging calls instead of
> just deleting them?", he meant you should research, understand, and use the
> proper APIs for printing debug messages.
>
> Please check out pr_debug(), dev_dbg(), netdev_dbg(). Use them appropriately,
> according to the subsystem you're working in and to the different types of
> arguments they take.
>
> Thanks,
>
> Fabio
> >
> > A compromise would be to remove only those DBG_88E prints which are
> > really not helpful.
> >
> > Best regards,
> > Martin
>
>
>
>

The problem I see is that this driver is so littered with unnecessary
macro calls, how do we decide which ones to keep? In my mind, the
better option is to remove them all and then come up with some new
ones in the vein of netdev_dbg() and friends. I could be wrong of
course :-) I tried going down the route of keeping/converting some to
proper calls such as netdev_dbg() and the issue is a lot of the calls
don't have an obvious value anyway.

Regards,
Phil
