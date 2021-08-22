Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A163F4036
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhHVPFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhHVPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 11:05:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EAAC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 08:04:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k24so14193491pgh.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXD+5VHMd7QYSc+oqJ848WpTg1hq4vUp/oR/6I5ToGU=;
        b=x52fkWOGcLRNhnA+tJucUVoRxBPE5kYI8BkWvF3EUHx16W+RwVmOy9d5siJCYgODaE
         gK4b/EYgtZIZjbSVgi8qEXivS/+MPHyJaleBuSmESCoBepcVTcL9j2oS7glQJRF/ex6V
         qlUnM1qU2SYNO6I9plDJ9cbQ3iyIF84b3Bm1GLpFjM3c58EfhEgWdtnDgNMo0YfmEjGE
         ZHSPxEJxNKqvJH6COm3CKUB/q0sNDJ2JXhqvwnq5ldEZCuUfoP3YFi41weQhR/z8GkiB
         plN0bnWPhjdYjSi/nbkTJcuxWgl7uzOgefbZvVEsEtHoZlrB4ZTK7VUdfWFeoB/Ogxb9
         1HBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXD+5VHMd7QYSc+oqJ848WpTg1hq4vUp/oR/6I5ToGU=;
        b=btKmmdfkr0Mvmac1t3Om1nckDiYiX86PjKyVNaO0vuxBbaquC4ae7PUK0ILCO+WX+u
         VKxpiV2kRa8LdJJmh1jzTO3EpoujDkccIEGiGlME0jMGzh9xoQpD0QorkO2eFJY6v79X
         DKP9Mj3uUaXi33EqQQpdidS6LEn1r0cPt5tfzt3DY6uPP6pNja/kpGq0HXWRTIBpmJQI
         3ilJgX/usYwnu4MHn2m21dOUqn2Q2XFv3mhQSkgdGQJPR50go4/xS7AU5g5UaVr+A2T5
         qBmNedb85hozJ3PpYcQTGOqTh0ucMsrT+/nAP6E/2x/aYYqcddc3sRN/CmWq84fs4XSn
         cI6g==
X-Gm-Message-State: AOAM533OesfRYXmgdsYzXh9kSopN6BHKEEMWyJU9rAgNa7mCDxbteU4l
        X/vb6lqohJ/VH3Kasx4oMBfqEQe8jHEP+oeI81IKFA==
X-Google-Smtp-Source: ABdhPJxCUmnER9SMqeJTiJf+ZZBEIi/Kje9o2YIMoY40horcjPweWC+bjLHPfi3/QNgS8kxZoSeePrdh8pRlWpaKGtg=
X-Received: by 2002:a63:d910:: with SMTP id r16mr27752915pgg.318.1629644669117;
 Sun, 22 Aug 2021 08:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629479152.git.paskripkin@gmail.com> <435eea22-da31-1ebc-840c-ee9e42b27265@gmail.com>
 <YSJFhmTs74PUyo8b@kroah.com> <2244219.zNr1yEsLHP@localhost.localdomain>
In-Reply-To: <2244219.zNr1yEsLHP@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sun, 22 Aug 2021 16:04:18 +0100
Message-ID: <CAA=Fs0=Ffo=Lk3HRSuewPLwYscN6zvpuJskmxsh6k1UR1kWpog@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Kaiser <martin@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 at 14:21, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Sunday, August 22, 2021 2:39:34 PM CEST Greg KH wrote:
> > On Sun, Aug 22, 2021 at 03:10:56PM +0300, Pavel Skripkin wrote:
> > > On 8/22/21 1:59 PM, Fabio M. De Francesco wrote:
> > > > On Sunday, August 22, 2021 12:09:29 PM CEST Pavel Skripkin wrote:
> [...]
> > > > So, it's up to the callers to test if (!_rtw_read*()) and then act
> > > > accordingly. If they get 0 they should know how to handle the errors.
> > >
> > > Yes, but _rtw_read*() == 0 indicates 2 states:
> > >     1. Error on transfer side
> > >     2. Actual register value is 0
> >
> > That's not a good design, it should be fixed.  Note there is the new
> > usb_control_msg_recv() function which should probably be used instead
> > here, to prevent this problem from happening.
>
> I think that no functions should return 0 for signaling FAILURE. If I'm not
> wrong, the kernel quite always prefers to return 0 on SUCCESS and <0 on
> FAILURE. Why don't you just fix this?
>
> > > > In summation. if anything should be changed, it is the code of the
> callers of
> > > > _rtw_read*() if you find out they they don't properly handle the
> returning
> > > > values of this function. You should find every place where _rtw_read*()
> are
> > > > called and figure out if the returns are properly checked and handled;
> if not,
> > > > make some change only there.
> > > >
> > > > Larry, Philip, where are you? Am I missing something?
> >
> > Relax, there is no need to get jumpy, people do not have to respond
> > instantly to emails here.  Especially when it is not their job to do so.
>
> I should have placed a big smile at the end of the phrase. I was just kidding
> while trying to get their attention. I know there is no hurry and that no one
> has any obligation of this kind. Again, just kidding :)
>
> Thanks,
>
> Fabio
>
> > greg k-h
>
>
>
>

Dear Fabio,

I can't speak for anyone else, but I will reply to as many e-mails as
I'm able - there is no need to try and get my attention, you shall
have it by default, as and when I am able to give it :-)

As V2 has been sent out by Pavel, I will try and take a look soon.

Regards,
Phil
