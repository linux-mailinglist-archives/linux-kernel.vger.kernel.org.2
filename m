Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E2644D8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhKKPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:09:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:25393 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbhKKPJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:09:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="256630674"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="256630674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 07:06:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="670268040"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 07:06:16 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 11 Nov 2021 17:06:14 +0200
Date:   Thu, 11 Nov 2021 17:06:14 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YY0xZjjGjNq+kUXi@lahna>
References: <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna>
 <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna>
 <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <YY0UCHtf8SAvGHTY@lahna>
 <CAD2FfiF=7H7RuAdrSrrr57JF6YG=pb5jw2QMgBDQsAEwgasYLw@mail.gmail.com>
 <YY0b01g+z3lkO4w2@lahna>
 <CAArk9MOxZaK2WqsuPR4GbgdxSnUBqgO1KZ8OT=+siksYq+2PxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAArk9MOxZaK2WqsuPR4GbgdxSnUBqgO1KZ8OT=+siksYq+2PxQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 11, 2021 at 11:42:52AM -0300, Mauro Lima wrote:
> > > > Having said that the hardware sequencer used in the recent CPUs should
> > > > be much safer in that sense.
> > >
> > > FWIW, I'd be fine if we had RO access for HWSEQ flash access only. If
> > > I understood correctly that's what Mauro proposed (with a patch) and
> > > instead was told that it was being rewritten as a mtd driver
> > > completion time unknown.
> >
> > I think Mauro proposed something different, basically exposing RO parts
> > of the driver only.
> 
> My patch was intended to move the read functionality of the spi chip
> to be able to compile the driver with just that and then remove the
> dangerous tag. So we can use that functionality to read the flash, I'm
> missing what is different from the things being discussed here sorry.

I'm hinting that we could make this "non-DANGEROUS" for hardware
sequencer parts of the driver. Basically moving only the software
sequencer bits as DANGEROUS or something like that. The hardware
sequencer is much more safer because it does not allow to run random
opcodes.

In case someone is unfamiliar with this, the Intel SPI hardware
exposes two interfaces through the same controller. One that is called
software sequencer and there is a register of "allowed" opcodes that
software can use as it wishes. This register can be locked down but is
not always. The second interface is the hardware sequencer that only
exposes higher level commands like read, write and so on and internally
then executes whatever opcode the controller got from the chip
"supported opcodes table" (SFDP).  The recent Intel hardware, all
big-cores, only provide hardware sequencer and the software one is not
even available.

Regardless of all this the driver needs to be converted from MTD to SPI
(SPI MEM) before we can add any features. I'm planning to send v4 of
that series next week.
