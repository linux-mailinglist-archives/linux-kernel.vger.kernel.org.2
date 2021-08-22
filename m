Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2003F403B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 17:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhHVPKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhHVPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 11:10:39 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD3C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 08:09:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e7so14194992pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOgOYoU/WJQDwpDThJRPMILCnbZWWqtiYHz7s6Kk7mc=;
        b=Wpqh136HlhTcg+2T1nVxZ607SGpMeb2Ip34pDKsYx2gHU5C1RA7RUx1n6umM75Wvu+
         UAWwRWcBfYtarC7wPE8htsYVlFCjC6bsCOkVBDZYl//9kamCfZQcKnI9K2sCvZ4JYW2n
         A2NhAF3FMHW30uUFWDi24XV4nJWseQR9erNf1Uzsv6U4OWreY41kusi8l3zAwjKwvYCB
         /tY4sdKmOkHtiQuuMC2wh7g8locaXwC6SJHFfeiy3QjByHuK3NzpwMmH14q7ZMiLRPaE
         zUnSGBr/nQRNHpdw/AnAW54y8i/AtJCJqxvB4WJI50XmYEbfZNFQ8Kn1WAsDYYtrlmAe
         7wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOgOYoU/WJQDwpDThJRPMILCnbZWWqtiYHz7s6Kk7mc=;
        b=c6ue068dXVWXBGn8FrhnY/ApIMsKtBlxENIoxcETcqEQfvSUMOtg/2KRBFM5bge3qw
         PnJqoi8Av954bvDBm7POJeDy0p/qcLX3ENA4z/mawvi35ed78E3TsPWSf9Ju10Jz+Bhs
         2nAjgZyViLbbj3yUpYo18GzNasVXeqX8YUiZgHJjLL1uPj/rAGevcv+x5MuxGIIVahM8
         4KVDfS9Iv1aY4NRbPhMp+ueoInJGpFGmfNtK1ynOal4UxQjblMngcx6QiSg/o/9Cuv0P
         ivEjb3HqLaxyt3VHynDyW+wpbMajRBLjYVHRfHcEJJ9Wt9HdxMz7pgv6yq0Fr78bOWzJ
         0ZXw==
X-Gm-Message-State: AOAM530UxfoFA3FAC4JRL1EztM5S3/Xz38pdQIMAruYGocEMVKmVazIq
        lBNV8Rjb2VNUnTraOQdm6qzoVm9Ec7UBjSn5H/AvnA==
X-Google-Smtp-Source: ABdhPJx0M1X24GznjRzWwRakyQly5Svp5D4WEOPA7CfMn501vymtkwDC6XGxKiXqI0F+A4Bf3gUCb/vl3pjczQHYSUw=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr28172377pgo.208.1629644997993;
 Sun, 22 Aug 2021 08:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <1897566.d8lQ4HMSh1@localhost.localdomain> <YSJE6aoH96kh777R@kroah.com>
 <2099975.VbY6Rib6K3@localhost.localdomain>
In-Reply-To: <2099975.VbY6Rib6K3@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sun, 22 Aug 2021 16:09:47 +0100
Message-ID: <CAA=Fs0n9pJSRuC=LQ1WsSziaup8XsSax8cQAySb8jMHBQa4X0A@mail.gmail.com>
Subject: Re: TODO list for staging/r8188eu
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 at 14:50, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Sunday, August 22, 2021 2:36:57 PM CEST Greg Kroah-Hartman wrote:
> > On Sun, Aug 22, 2021 at 09:41:20AM +0200, Fabio M. De Francesco wrote:
> > > Dear Larry, Philip,
> > >
> > > >From what I understand how the development process works, drivers in
> staging
> > >
> > > should have a to-do list in the TODO file. Please read https://
> www.kernel.org/
> > > doc/html/latest/process/2.Process.html?highlight=todo#staging-trees.
> > >
> > > Could you (as the maintainers of the r8188eu driver) please compile and
> > > provide the above mentioned list?
> >
> > Why don't you provide an initial list for people to work off of if you
> > feel it is needed here?
> >
> > thanks,
> >
> > greg k-h
>
> Unfortunately I'm not able to tell what is needed to do to have a driver
> improved so that it can be moved off staging. This work should be better
> addressed by someone who is much more experienced.
>
> For example, I read from other drivers TODO lists that cfg80211 and lib80211
> are required but I don't know what they are.
>
> Regards,
>
> Fabio
>
>
>

Dear Fabio,

I believe Larry is working on hooking up CFG80211 again (he mentioned
going quite for a few days to work on it). As for other stuff that
needs doing, a few things come to mind:

* Removal of dead code (whether or not this includes the
debugging/printing macros is a matter of opinion, I would say yes
personally) such as unusued functions, struct fields, etc.
* Correction of code styling in the kernel (e.g. there is a lot of camel case).
* Use of in-kernel functionality and removal of unnecessary wrappers
where possible.
* Removal of the HAL layer and migration of its functionality into the
driver as a whole - this is an important one I would argue.

There is likely to be lots of other items not on that list, but that
would seem to be the basis of a TODO list if we need one?

Regards,
Phil
