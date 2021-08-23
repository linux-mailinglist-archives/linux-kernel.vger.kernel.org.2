Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535EE3F536D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhHWWjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhHWWi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:38:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A2C061760
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:38:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id m17so4007851plc.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ls4wTzpAa/UZnJAhPpmUr+INHPkSHtnofBYbCYCTzyk=;
        b=fAcusxJ6XKUL8t7FXM1y3WtR17cVaFSBv7ku7U1H3elmNv9mQmLf6UW+xn+5ctZtct
         LLwdMyxTJPA+0X6O/ZuCscYfTqMVjM8zXDx2wuH/HcvRgq+rkEwSfFblL5CifR8j2xut
         4Bg3g94NsO0U6DrrC9ygqqxqNtcuIcOHjCjrqSqMxbmy5iSm+UfHvYBMy3e8D3VXe92X
         aUOc66Hk6Z9/SfCMiG8Cmln+D6I+JB9AVELDFmJD48B6K0oedQEJm/X9w4ABK44K3Md/
         PpzHooRdNOisKiG66aeV8YdACBimlwIOFTY8JtMRjmphYFafQ4oiVZqmNqqXQ5FGVZhY
         hOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ls4wTzpAa/UZnJAhPpmUr+INHPkSHtnofBYbCYCTzyk=;
        b=jjQlkvzm/h6wb+S+eRAY2BmrcqZtYc226GJJHLykpStPal5yD73bvBfHgyKpDdFVSq
         lIp5c+Z+K9w+KqMUlRIBpxxHwZmZn3dVBXZjyl6KxYICL6Cy/Lf6iO2zEZjNP6CKBe5r
         WvzmhNOhzcd7+uz/28xJ7vXJ4DuzysEAjB0/el/zkRSwkQYjXPqUw8u+c0v/AT/SvBTF
         w+C+6aBQM0Be/93W20AEJ+VbqTN39/F2ii+Vrs+MFQYA8a0MKBNpiCmWgBmhcEczzKGt
         Un9MpuEMtyeg+UTT0n1zitiC9QOAG3eYhvHogBXbrfr7THb4qj80TqmyQPkbvFs5p8w6
         4yfQ==
X-Gm-Message-State: AOAM531Yi3D2CDeXPnGycoBGYZaaBMLXC6AcillP0o7PgT4VS4u0Gk9v
        vR03RUvQ3WHdTmmBMOO6HDkRs822rztaOORnm2F3+g==
X-Google-Smtp-Source: ABdhPJx6KS3qbCu+cw6fRdySrJxukemk3ty6zIhIK0NSv6weZRL1AxHAmZk/2EyQBzJr1LpCBCypoUgZm+FjB0UPj/4=
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr831589pjq.217.1629758292730;
 Mon, 23 Aug 2021 15:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210823081820.9724-1-straube.linux@gmail.com>
 <CAA=Fs0=6=ueb53iNhyjSE5B8CdQvrpijgihAaN9YVwdDgNGiFA@mail.gmail.com> <cb8d08f7-c27c-d6f3-1128-4047350d6871@gmail.com>
In-Reply-To: <cb8d08f7-c27c-d6f3-1128-4047350d6871@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 23:38:01 +0100
Message-ID: <CAA=Fs0=46RNFVBphJb+yj8KRKsMfePRu21bAB+puTntSF7ayFA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove ip.h header file
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 at 23:32, Michael Straube <straube.linux@gmail.com> wrote:
>
> On 8/24/21 12:21 AM, Phillip Potter wrote:
> > On Mon, 23 Aug 2021 at 09:19, Michael Straube <straube.linux@gmail.com> wrote:
> >>
> >> The struct ip_options declared in ip.h is only unsed in the optlength
> >> macro which is also defined in ip.h. All other definitions/declarations
> >> in ip.h are duplicated from <include/uapi/linux/ip.h>. Remove the ip.h
> >> header file and its includes.
> >>
> >> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> >> ---
>
> >
> > Dear Michael,
> >
> > Thanks for the patch. Sorry, but it seems to conflict with your
> > earlier patch titled: "[PATCH] staging: r8188eu: remove if_ether.h
> > header file". They apply fine individually, but not together - can you
> > confirm this is the case for you as well and not just me?
> >
> > Regards,
> > Phil
> >
>
> Hi Phillip,
>
> yes I can confirm, sorry about that. I will rework and send both patches
> in a series. Thank you for testing and pointing out this conflict.
>
> best regards,
> Michael

No apology necessary, and thanks again for the patches.

Regards,
Phil
