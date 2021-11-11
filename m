Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4DD44D724
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhKKNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhKKNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:25:28 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECA9C061766;
        Thu, 11 Nov 2021 05:22:39 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u25so9215843ljo.12;
        Thu, 11 Nov 2021 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXEbn8H7pxAKlYWqlmB2yKeJ4B1lwBLiYpPWtH/0aJI=;
        b=EdEsfI1iXJWPqQ1Z53pJXoWngi2Kag6xy1HTYr77msFRYWrWkXwm33wI92W5mJqk/K
         3d/amHMdnF0cKoGD6UJEnNXi1q20O56PFyiP1sa6tKCMHmtQnuSYRQEVjHbiSIYD6qpI
         Umtwx9A436RENm+mIMnXCS7EN2egubDTGWOT+aNrcdgDqKyUeZ49VJ13LHC27Gaj2WGF
         WLzRgM0cLQI3GU2uWmVohpeKeq9/3Od74HOxdtJjU4xwrNNQE+H0yf7yMaoQwO50TwXh
         VJ73e4uvZ5ynCVfEFa9eo7W8NNnuPX//iFx+yn3CXpen52lksw874x8ptDtuk0agO75n
         AF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXEbn8H7pxAKlYWqlmB2yKeJ4B1lwBLiYpPWtH/0aJI=;
        b=J5kJ/T9gplJtcrS5VycD8P7CuVd2Skg9BGfRhIQRMuaxtmY9q3b0F167HSlkyW3xVi
         S+nIoXNJDpJS6rmXzwjJ35PZfwuBwgBcRAvKgCg2W/cmIxgd+JgR29Croca+ramqKTKO
         wyuzf3e6GntMcwH7PRgptp5Y62JohMIs2IDVZsNY6p/M38JC8DFdTmdLprH949c1SB8R
         nzN59z98J0zs1zRzKhLHYOUnZuP+LZFLLW69NoJDuEc7H1ixTLat+gO3RhRF/YVEUynf
         YOL5XId1W8FEl3R2JUB4oQPttOhxcq1kbV9CwObIwYZ6VMRy/JkveVU9Yq5Dd9U3XWWL
         mg9A==
X-Gm-Message-State: AOAM530RrHLXPTWfimqy63hJ2vlAh52lvZ7UNUvsAS2VXIkVW8UtP4X+
        PwVZ+VILD63JbmzgHu6eaWqB68ZyphM4lG6oCDA=
X-Google-Smtp-Source: ABdhPJyIt/3NhcQZH+TXhAsoszHNHs0Iyoyr/rzDe7ITzB6qVWV2BcovQ4R/k4tRIufDmBto0yLr30bt5xEoaLl4+XI=
X-Received: by 2002:a2e:a607:: with SMTP id v7mr6882559ljp.35.1636636957329;
 Thu, 11 Nov 2021 05:22:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna> <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna> <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <YY0UCHtf8SAvGHTY@lahna>
In-Reply-To: <YY0UCHtf8SAvGHTY@lahna>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Thu, 11 Nov 2021 13:22:25 +0000
Message-ID: <CAD2FfiF=7H7RuAdrSrrr57JF6YG=pb5jw2QMgBDQsAEwgasYLw@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Thu, 11 Nov 2021 at 13:01, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> I'm not sure I understand why the platform security needs to be turned off?

Sorry to be unclear, I meant we had to turn off Secure Boot (and thus
also kernel lockdown) so that we could use /dev/mem to verify that
OEMs have set up the IFD, BLE, BIOSWP etc correctly. You'd be
surprised just how many vendors don't read the specifications
correctly and get this wrong. We also need port IO to use the
intel-spi driver so we can parse the BIOS contents from userspace,
which you can't obviously do when SB is turned off. The eSPI
controller is hidden on some hardware now, and we need to play games
to make it visible again.

> I think exposing /dev/mem opens another can of worms that we want to
> avoid.

Ohh it's not all of /dev/mem, it's just the 16MB BIOS region that has
to be mapped at that address for the hardware to boot.

> Don't we already expose some of the EFI stuff under /sys/firmware?

Yes, some information, but not the file volumes themselves. I don't
think the kernel wants to be in the game of supporting every nested
container and compression format that EFI supports. It's also the
wrong layer to expose platform attributes like BLE, but that's an
orthogonal thing to the patch Hans-Gert is proposing.

> I just don't want to
> spend yet another Christmas holiday trying to fix angry peoples laptops :(

Completely understood, I don't think any of us want that.

> Having said that the hardware sequencer used in the recent CPUs should
> be much safer in that sense.

FWIW, I'd be fine if we had RO access for HWSEQ flash access only. If
I understood correctly that's what Mauro proposed (with a patch) and
instead was told that it was being rewritten as a mtd driver
completion time unknown.

Richard.
