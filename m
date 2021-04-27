Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9436CA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbhD0RLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:11:40 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:41832 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbhD0RLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:11:38 -0400
Received: by mail-ua1-f48.google.com with SMTP id x22so698019uav.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpGZFjzRW/p3RHl0B+aF4dHbQd+A5fGdxZYu9M6J2yA=;
        b=TAKB0jf1fV+Sd5vy4YnnFqn/VjoAsO+z6gE+97nvzZITUTbRkF6hN0haDzr7X6wqix
         hDL163zG+wS5soaPsF6ADgAT9h9wNUo9Gj6wTdd3atBYn5SlQmOOFIsPI37JRrfnlq2p
         GOMXq/cMDUa3olnE3gRPKdQMwt9kB7aDAJCIBvBKPk32p/0HOYpf28NLtto94m0D7siT
         UlFs9sJie3pTGjHJlasW6OAc//EeL+mvCPN0b8G2GsLhwnC0CJ3xEUI8i9LgbBn8Q7ks
         LIHOIPmvyqATk2ty0D4M4XkdeaqJ5V6wFUn+Blc/hnRAbj5rfdv1ZXI31GA1O68Nosap
         yV+A==
X-Gm-Message-State: AOAM533nrKGMqnOPFIRhxou35ElZYi8Z34wRZ/rACw0/61B16dfZyihL
        UkgwqnTxHtNl4zJRkEortyOp5uUc0/kbERyvmwY=
X-Google-Smtp-Source: ABdhPJxmYZvWw4iFRCiICLEtgluxP0y711XlnbtT9zNpkC2keBJqt8AuoHXaew9t26dhAksBszaB4vQOXxuV+PASdmQ=
X-Received: by 2002:a9f:262c:: with SMTP id 41mr18657209uag.4.1619543453199;
 Tue, 27 Apr 2021 10:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com> <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com> <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin> <20210427151042.j7hku7pxqz56uyt6@bogus>
 <0887ce92-e9d8-47ec-0077-4c1f2fd46f87@gmail.com> <20210427163913.svx2w2mxo4w3is32@bogus>
 <1e4b602d-5ed8-19a3-2cd1-b3fe27e7ff8d@gmail.com>
In-Reply-To: <1e4b602d-5ed8-19a3-2cd1-b3fe27e7ff8d@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Apr 2021 19:10:41 +0200
Message-ID: <CAMuHMdWHRb0+BS=s0OU_JBMtEuc4=tFkrZhb=3Wjm2AUxL-ryQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by default""
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, Apr 27, 2021 at 6:50 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 4/27/2021 9:39 AM, Sudeep Holla wrote:
> > On Tue, Apr 27, 2021 at 09:24:55AM -0700, Florian Fainelli wrote:
> >
> > [...]
> >
> >> This is a self inflicted problem that we have in that the bootloader
> >> provides a Device Tree to the kernel which is massaged in different ways
> >> and intends to stay backwards compatible as much as possible. And indeed
> >> after removing the 'mboxes' property gets us going with fw_devlink=on.
> >>
> >
> > I assume the bootloader checks the presence of SMC support and modifies
> > the DT node accordingly. Can't it remove the mbox properties as it make
> > no sense with SMC compatible ? However ...
>
> The bootloader has always assumed the SMC support was there from the day
> we introduced it because it was. What changed is the way we advertised
> to Linux that support. We used to have a custom mailbox driver that
> would be pretty much what the ARM SMC transport eventually came to be.
>
> Since we still support earlier kernels that were deployed with the old
> mailbox we cannot arbitrarily break that setup, especially as our
> customers tend to be slow in picking up new kernel versions, fortunately
> before they get to 5.13 we can mandate a new bootloader that may not be
> compatible with their 4.1 kernel anymore, or at least not without some
> backporting of the ARM SMC transport, that's all fair IMHO.
>
> >>> 2. IIUC, the fw_devlink might use information from DT to establish the
> >>>    dependency and having mailbox information in this context may be
> >>>    considered wrong as there is no dependency if it is using SMC.
> >>
> >> Right, unfortunately, short of having some special casing for SCMI and
> >> checking that if we have both an "arm,smc-id" and "mboxes" phandle we
> >> should prefer the former, there is not probably much that can be done
> >> here. Do we want to do that?
> >
> > I *think* we could do that in the SCMI drivers, but:
> > 1. I am not sure if that helps fw_devlinks if they are deriving the info
> >    purely based on DT
> > 2. I am also afraid that someone might come up with exactly opposite
> >    requirement that let us prefer mailbox over SMC as they would use
> >    SMC only if h/w lacks proper mailbox support. I fear that we will get
> >    into rabbit hole trying to do something like that.
>
> That is true, and to get to the SCMI driver, even the base protocol you
> must have been probed, so we have a nice chicken and egg problem. I
> highly appreciate your time understanding the context and trying to find
> a solution it is pretty clear that we must fix our FDT now.

Alternatively, you can have a quirk in the kernel that removes the
phandle from the FDT during early boot.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
