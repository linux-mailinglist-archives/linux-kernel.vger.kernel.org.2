Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674B244D6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhKKNDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:03:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:53930 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232513AbhKKNDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:03:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="230367278"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="230367278"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 05:01:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="452690470"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 05:00:59 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 11 Nov 2021 15:00:56 +0200
Date:   Thu, 11 Nov 2021 15:00:56 +0200
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
Message-ID: <YY0UCHtf8SAvGHTY@lahna>
References: <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna>
 <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna>
 <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 11:46:39AM +0000, Richard Hughes wrote:
> On Thu, 11 Nov 2021 at 10:33, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > OK, I see from your patch that it uses the direct mapped read-only
> > region to read this data.
> 
> Sorry for the delay in replying here. What I like about Hans-Gert's
> patch is that it's always going to work on x64 -- if the system
> firmware isn't available at that offset then the platform just isn't
> going to boot. It's super simple, and means we can read out the hugely
> complex UEFI blob without asking the user to turn off kernel lockdown
> and secure boot so we can run the security verification tools. At the
> moment we're in this strange situation where we ask the user to
> cripple their platform security to run the platform security tools.

I'm not sure I understand why the platform security needs to be turned
off? Sorry if that was already mentioned somewhere in the thread, I did
not read all of them throughly.

> > Do we know what information exactly fwupd needs? I mean exposing all of
> > this might not be good idea from security perspective (but I'm not an
> > expert).
> 
> Ideally, fwupd needs the entire IFD partition which contains all the
> EFI File Volumes. We already parse these when the user is booting
> without secure boot using the Intel SPI controller and doing *evil*
> hacks to make the PCI device visible. The reason we want to parse the
> BIOS can be explained pretty easily; at startup we look at the TPM
> PCRs and we know very quickly and easily if the system firmware event
> has changed. If the checksum changed, then the firmware was modified
> in some way. However, saying to the user that "checksum changed" isn't
> useful at all. What we want to do is say something like "an EFI binary
> called RootKitz.efi was added" or "the AmiTcgPlatformPeiAfterMem.efi
> binary changed" and actually report what was done. At the moment we
> can do this, but not if /dev/mem cannot be used.

I think exposing /dev/mem opens another can of worms that we want to
avoid.

Is there anything preventing to add a sane interface from say the
intel-spi driver (can be something else too) that exposes the minimal
set you need? That can be in the mainline kernel and is secure (and
safe) enough that distros (and users) can enable it?

Don't we already expose some of the EFI stuff under /sys/firmware?

> > However, we can perhaps expose some of it through intel-spi,
> > and make that work so that distros can enable it safely.
> 
> I think, if we're being honest, that Intel has no plans to make
> intel-spi available as a RO interface of any sort. There's some sort
> of hardware errata or misdesign that nobody can mention that makes the
> RO access unsafe. I think it's probably more than missing arbitration.

No that's not the reason. The real reason I'm concerned (as the author
and maintainer of that thing) is that last time the driver was
accidentally enabled in Ubuntu (around 2019) there was a driver bug
(which was fixed already but it was not yet in the Ubuntu kernel) that
turned some Lenovo based systems' BIOSes to read-only. It has nothing to
do with my employer or hardware errata/misdesign. I just don't want to
spend yet another Christmas holiday trying to fix angry peoples laptops :(

Having said that the hardware sequencer used in the recent CPUs should
be much safer in that sense. It should not allow things like this to
happen (the affected systems used software based sequencer).
