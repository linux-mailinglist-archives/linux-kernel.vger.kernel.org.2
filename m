Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C170635FD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhDNV6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:58:04 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35614 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhDNV55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:57:57 -0400
Received: by mail-ed1-f52.google.com with SMTP id x4so25556937edd.2;
        Wed, 14 Apr 2021 14:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJDYdY4y4ttJ0VfwvoAkuVaHu7q9owyfa4h9zmvYo7o=;
        b=q+hmMs4eMJFI5pwsDAwQSh3ScEFJY2u7EHaGC0NLzB0wrYcC8fdS9zQCTs9svhhcIz
         vDMHtLpCwb4AzM5HAG9eXpNJwdLKZHtsjThu23+dsPzX32AwGjGLFEafHb/ulVR4U1LG
         fgbPG8SDH6pfYu8jNIQhKgY+oSNjnSqcPVRW0fKBh0Lc6PjSNAyX85DjCKwRRnakHr59
         LTASD1gtGmaIODUhBDPx3v/+ocPUN/BAPHERW6N1wsu0GiTBaTRz5K3J8A4oYiw85viD
         +vE4t9UWA8urI8c7+Z2JYOi3hnOthuDemC9OHM7mNFItgfur0mWBBxRfrcU/Oqme9pIW
         0Elw==
X-Gm-Message-State: AOAM5301XrlZ6K45jz01tEp+9KJyVTtcMMUG0RvbkWrcRZTmq6AugKpc
        /QHETIiCFeWkUyLYtqs7tZEfdVyCtI3Bnmm7P1E=
X-Google-Smtp-Source: ABdhPJyRHJNyKlkQDom9OOnmZTGMNVEwavqkKgxZuNdqoWF+Vp+ZkGIssTUZCIgt1sAvVglIqXIcleuM7N5f/qMk1K4=
X-Received: by 2002:a05:6402:2208:: with SMTP id cq8mr394377edb.122.1618437453589;
 Wed, 14 Apr 2021 14:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <20210413034346.GA22861@1wt.eu> <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic>
In-Reply-To: <20210414095804.GB10709@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 14 Apr 2021 17:57:22 -0400
Message-ID: <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Borislav Petkov <bp@alien8.de>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 5:58 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 13, 2021 at 03:51:50PM -0400, Len Brown wrote:
> > AMX does the type of matrix multiplication that AI algorithms use. In
> > the unlikely event that you or one of the libraries you call are doing
> > the same, then you will be very happy with AMX. Otherwise, you'll
> > probably not use it.
>
> Which sounds to me like AMX is something which should not be enabled
> automatically but explicitly requested. I don't see the majority of the
> processes on the majority of the Linux machines out there doing AI with
> AMX - at least not anytime soon. If it becomes ubiquitous later, we can
> make it automatic then.

I'm pretty sure that the "it isn't my use case of interest, so it
doesn't matter"
line of reasoning has long been established as -EINVAL ;-)
