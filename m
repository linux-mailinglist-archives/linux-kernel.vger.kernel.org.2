Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB62244D85C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhKKOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbhKKOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:36:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DE3C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:33:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so10101951wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ja+uZ/098TjANxx6nNWMaIY7Dtj1bPhX+Sb1SEHf/Xo=;
        b=1tkzBNyit1lHlwLMhV8wO6Trj9HbVtfFvWLfYVSnLNz6nXqyAMIp9RsOjYIFl3d2DC
         tm4rr8+ITlvF42xmdKZZV3Sy16aQU2b9uM5UGQ2z1ClhMhu+DIoDVGspTGiIbz+zFP/k
         w2ntKmQFmRDpV+HqJkIIp6lmV0cwcSfX0D2UdwwaeezhvftVmeDzOi6ilmTiu44bXuv7
         H//Cfv1ChlsjJmkO/bnTQwtNDAdw+ibEx3JNboblEaOZX/bRohCat2b/5VjXCm6Hlgu1
         5TZPRLaIiwryxVXXq+pfL9KK2HLWLqNw+E3u4cXLth3/RGR7IhauqSyYdCwxgNkLDybq
         8o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ja+uZ/098TjANxx6nNWMaIY7Dtj1bPhX+Sb1SEHf/Xo=;
        b=2zbDuHZcOFK8RnP/AOEnCMR1r6XbMHwyHYXWn2PMH47edHae4YsZ1c5vStixvcciVu
         I1FT5zNXklCwgfdVIlibvz0M+PstwOmFMDzsWlaT4XG5LX79D/Qyrb/3c7M7ekBfmzcM
         VsnkkeFGWlbvZ85YAIGcIzpQ0c2je6fP5t7wHWIc/4XFUWDt/HetVkP37hT9XMjXhbbD
         Gk9zq8k9WRY00B+l/rqAGOqf+snpN8GtfcXLvWdMEy7ErKjU/mjtIIpjs/gi5gP5XC41
         CVSyTUWo788ysiJ6rdwC66fYLrE9Tn0TeI3xmfcu93n1fwyAXWPjXtp6CnorslGqlIZn
         ejbA==
X-Gm-Message-State: AOAM530+bqTu34ecqDtxAil/19XQqGNrDao73T28iIVc9LjypTCh4vQv
        gP2G0fuUbRBH4s2sAIX/BDp58rMFyPVGnB20Vqe3bw==
X-Google-Smtp-Source: ABdhPJyHKnKU2yO/043Tx5WStHAw2sXQcCYHF5i9tDrEJvv+DcWtsumYvTGAM1y+bagXbaOScmpSgccmxmw1wgGPQwc=
X-Received: by 2002:a5d:464c:: with SMTP id j12mr9302472wrs.150.1636641197026;
 Thu, 11 Nov 2021 06:33:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna> <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna> <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <CAHp75Vcp=hC1oL5FBQDDFe8EBxWB9Po4FKNS9ZGtD3q-yQPtAw@mail.gmail.com>
 <CAHifhD6p9qSm5dv1spz+oPRhRkBZeQspHNEphE49fODacm-S6g@mail.gmail.com> <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com>
In-Reply-To: <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Thu, 11 Nov 2021 15:33:05 +0100
Message-ID: <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 11. Nov. 2021 um 14:55 Uhr schrieb Andy Shevchenko
<andy.shevchenko@gmail.com>:
>
> On Thu, Nov 11, 2021 at 2:56 PM Hans-Gert Dahmen
> <hans-gert.dahmen@immu.ne> wrote:
> >
> > Am Do., 11. Nov. 2021 um 13:46 Uhr schrieb Andy Shevchenko
> > <andy.shevchenko@gmail.com>:
> > >
> > > On Thu, Nov 11, 2021 at 1:46 PM Richard Hughes <hughsient@gmail.com> wrote:
> > > > On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > > it's always going to work on x64 -- if the system firmware isn't available at that offset then the platform just isn't going to boot.
> > >
> > > Well, it's _usual_ case, but in general the assumption is simply
> > > incorrect. Btw, have you checked it on Coreboot enabled platforms?
> > > What about bare metal configurations where the bootloader provides
> > > services to the OS?
> >
> > No it is always the case. I suggest you go read your own Intel specs
> > and datasheets
>
> Point me out, please, chapters in SDM (I never really read it in full,
> it's kinda 10x Bible size). What x86 expects is 16 bytes at the end of
> 1Mb physical address space that the CPU runs at first.

So you do not know what you are talking about, am I correct? Starting
from 386 the first instruction is executed at 0xFFFFFFF0h. What you
are referring to is the 8086 reset vector and that was like 40 years
ago.

Please refer to SDM volume 3A, chapter 9, section 9.1.4 "First
Instruction Executed", paragraph two. Just watch out for the hex
number train starting with FFFFF... then you will find it. This is
what requires the memory range to be mapped. Modern Intel CPUs require
larger portions, because of the ACM loading and XuCode and whatnot.
Please refer to the email [1] from me linked below where I reference
all PCH datasheets of the x64 era to prove that 16MB are mapped
hard-wired. Note that the range cannot be turned off and will read
back 0xFF's if the PCH registers are configured to not be backed by
the actual SPI flash contents.

[1] https://lkml.org/lkml/2021/6/24/379

>
> > before spreading further FUD. I have experienced u-root
> > and coreboot developers sitting right next to me in my office and they
> > were among the ones suggesting my patch. This is just laughable,
> > please stop it Andy.
>
> Yeah, zillion people can't ever make a mistake... I see.
>
> --
> With Best Regards,
> Andy Shevchenko

Hans-Gert
