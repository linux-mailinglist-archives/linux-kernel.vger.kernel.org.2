Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271AC44E64D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhKLM2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhKLM2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:28:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D34C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 04:25:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d5so15226985wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 04:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jxbpx2H3WV70W11knwtz4SsFOIycJ83XdinFOIGLbg=;
        b=7sBBmdg7iNg4lhSrq6TwIk22IOawCpW74X0fdA6GMmaeMteYbLZvWgPBFEmWxwtlAg
         7feSwM/27hQF/7QHHHKrysPa9h+76hYw+ivaaK7OaR31RDW+DogMX9BZrV2gR9Y1OReO
         cCrpKnZxKAJsWgEu0J2N4JWGoEom/wg9fpMUwpFqV8XzqfR/JD8ZZw35WjOTcTgB8TpD
         0YJOt8JpgsXgEqKI8rQIpWRPX/paylKKMCpEJIvXZIZpUvsxPyxWNo9C6u7bkoYp+tD3
         4yEhYwIiMOhr6unBafFjD8QmQOpKolUovTXtuEDli9KXjyRHXlnzh56o05tGMxxI2TXa
         GRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jxbpx2H3WV70W11knwtz4SsFOIycJ83XdinFOIGLbg=;
        b=VQ2DULQgpjXIA0INRntZAU/BMVEQQsVhTNQPBsMGZKzROBWHD6XWmqIM+Bukw4tb80
         dOMtsoXDQ2ljnDVWub/1bm1+5G/758sgX6Zxo9WWa5VKrpnE9iHc8m5AbQ7hnC+XBz/Y
         AMVagND08FWoYGXaE2i/4Xy1vXAEudOzmM+ib2StuzKq31Co0nghNivvn+S5JeIqpInW
         Oei+RsvgSSFmzWXSzAto7/r96Sg5+XkKkO0r18ByUQ7AzK/tTwpute3r2U/3yruXKMsO
         iX4EApvDgo3WJx1xySuFg1uXwV0pPmPfVFPSpen7CSzsRQ2C3rzdS9HMIoVMS7A6QFm4
         NJSQ==
X-Gm-Message-State: AOAM532oop+L5//R7FnY0BWgcGjZsv7rTAsSRGK2PTPzck6Zu/Jo/qa7
        prdith7z5dMq0ej0Q2MiSLywIlyvvsNKs/IuZQjZ4g==
X-Google-Smtp-Source: ABdhPJxGwBaTby1dDG962TGIuuVNOB5oseBDZiuDCzRq2veW4kClqmVcaMgGSqyCkPg0BoPDNOT8xWv2nI72uBqZlpU=
X-Received: by 2002:a5d:464c:: with SMTP id j12mr17966057wrs.150.1636719925025;
 Fri, 12 Nov 2021 04:25:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75Vcp=hC1oL5FBQDDFe8EBxWB9Po4FKNS9ZGtD3q-yQPtAw@mail.gmail.com>
 <CAHifhD6p9qSm5dv1spz+oPRhRkBZeQspHNEphE49fODacm-S6g@mail.gmail.com>
 <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com>
 <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com>
 <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com>
 <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com>
 <CAHp75VckB0RA6zoLRQ2UOcQRgMEf6sNxDGfpsNVr+92eArhD=Q@mail.gmail.com>
 <CAD2FfiH9OcKyUo6xjTfSENrEKF=4kZiGU4rT0FriK6KgKYSzyw@mail.gmail.com>
 <YY4PHacrS4czhEx3@kroah.com> <CAD2FfiFTsj63NJTKjOhHU0FZ53uHCnG9SDdfqkj3cGcH=vos=A@mail.gmail.com>
 <YY5FX/sQZSkBh2vz@kroah.com>
In-Reply-To: <YY5FX/sQZSkBh2vz@kroah.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Fri, 12 Nov 2021 13:25:13 +0100
Message-ID: <CAHifhD462b-H0LGm=i-KH8tQc=Dtbk6me0qS9fBQWtiK_Lg4qg@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr., 12. Nov. 2021 um 11:43 Uhr schrieb Greg KH <gregkh@linuxfoundation.org>:
>
> On Fri, Nov 12, 2021 at 10:09:14AM +0000, Richard Hughes wrote:
> > On Fri, 12 Nov 2021 at 06:52, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > Why don't we just export these areas to userspace and let the decoding
> > > of them happen there?
> >
> > Unless I'm missing something, the patch from Hans-Gert does just that:
> > exposing the IFD BIOS partition that encloses the various EFI file
> > volumes.
>
> But it is not tied into the EFI subsystem at all, binding only to those
> resources.  It does not do anything with any efi symbol or access
> control.
>
> Again, that's my primary complaint here, the driver HAS to be able to
> tell the kernel what resource it wants to bind to and control, right now
> it just "assumes" that it can have access to a chunk of memory without
> any notification or checks at all, which will cause problems on systems
> that do not follow that assumption.
>
> So while you all are arguing over oddities, the main complaint here of
> "this driver is not ok as-is" seems to keep being ignored for some odd
> reason.

No, no, at least I am not ignoring it. I am aware of that and I was
planning to fix the broken parts since the start of the discussion.
Sorry for the miscommunication here.

>
> I'm going to just ignore this thread now and wait for a new patch to
> review.

That's the plan and I'd be happy if we don't have to discuss it
further right now.

>
> thanks,
>
> greg k-h

Hans-Gert
