Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0D744D748
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhKKNhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:37:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:56219 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232930AbhKKNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:37:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="293733918"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="293733918"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 05:34:16 -0800
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492544105"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 05:34:13 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 11 Nov 2021 15:34:11 +0200
Date:   Thu, 11 Nov 2021 15:34:11 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YY0b01g+z3lkO4w2@lahna>
References: <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna>
 <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna>
 <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <YY0UCHtf8SAvGHTY@lahna>
 <CAD2FfiF=7H7RuAdrSrrr57JF6YG=pb5jw2QMgBDQsAEwgasYLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiF=7H7RuAdrSrrr57JF6YG=pb5jw2QMgBDQsAEwgasYLw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 01:22:25PM +0000, Richard Hughes wrote:
> On Thu, 11 Nov 2021 at 13:01, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > I'm not sure I understand why the platform security needs to be turned off?
> 
> Sorry to be unclear, I meant we had to turn off Secure Boot (and thus
> also kernel lockdown) so that we could use /dev/mem to verify that
> OEMs have set up the IFD, BLE, BIOSWP etc correctly. You'd be
> surprised just how many vendors don't read the specifications
> correctly and get this wrong. We also need port IO to use the
> intel-spi driver so we can parse the BIOS contents from userspace,
> which you can't obviously do when SB is turned off. The eSPI
> controller is hidden on some hardware now, and we need to play games
> to make it visible again.

Okay, thanks for explaining.

> > I think exposing /dev/mem opens another can of worms that we want to
> > avoid.
> 
> Ohh it's not all of /dev/mem, it's just the 16MB BIOS region that has
> to be mapped at that address for the hardware to boot.

I see.

> > Don't we already expose some of the EFI stuff under /sys/firmware?
> 
> Yes, some information, but not the file volumes themselves. I don't
> think the kernel wants to be in the game of supporting every nested
> container and compression format that EFI supports. It's also the
> wrong layer to expose platform attributes like BLE, but that's an
> orthogonal thing to the patch Hans-Gert is proposing.
> 
> > I just don't want to
> > spend yet another Christmas holiday trying to fix angry peoples laptops :(
> 
> Completely understood, I don't think any of us want that.
> 
> > Having said that the hardware sequencer used in the recent CPUs should
> > be much safer in that sense.
> 
> FWIW, I'd be fine if we had RO access for HWSEQ flash access only. If
> I understood correctly that's what Mauro proposed (with a patch) and
> instead was told that it was being rewritten as a mtd driver
> completion time unknown.

I think Mauro proposed something different, basically exposing RO parts
of the driver only.

The intel-spi driver is being moved from MTD to SPI because the MTD
SPI-NOR maintainers (not me) said that it needs to be done before we can
add any new feature to the driver. That includes also Mauro's patch.

I have v4 of the conversion patch series done already but since it is a
middle of the merge window I'm holding it until v5.16-rc1 is released
(next sunday). I can CC you too and I suppose Hans and Mauro (who else,
let me know). Once the MTD maintainers are happy we can progress adding
features what fwupd needs there too (and the features we, Intel, want to
add there).
