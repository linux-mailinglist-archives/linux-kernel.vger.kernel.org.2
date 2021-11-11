Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF144D508
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhKKKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:35:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:54889 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhKKKfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:35:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="296327252"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="296327252"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 02:33:02 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="492493741"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 02:32:59 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 11 Nov 2021 12:32:56 +0200
Date:   Thu, 11 Nov 2021 12:32:56 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     Mauro Lima <mauro.lima@eclypsium.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Richard Hughes <hughsient@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YYzxWPIWFAV04LRU@lahna>
References: <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna>
 <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 11, 2021 at 09:59:32AM +0100, Hans-Gert Dahmen wrote:
> > I think we discussed this previously already but in any case, instead of
> > removing the tag from the "main" driver, we can make certain "safe"
> > parts of the driver available without that tag. That would allow you to
> > read the things the controller exposes and allow distros safely include
> > the driver too. By "safe" parts, I mean the information available
> > through the SPI flash controller without actually sending commands to
> > the flash chip. I think this is the information everybody (on this
> > thread at least) is interested in. Unless I'm mistaken - I did not check
> 
> Yes you are mistaken. My patch is about safely reading the BIOS/UEFI
> binary on every past and future x86_64 system. There are tools out
> there that use the interface my patch uses and they can not work any
> longer when /dev/mem is locked down with SecureBoot enabled. The
> tools, like fwupd, should work out-of-the-box on the typical
> distribution. During this discussion we were told that my patch is not
> welcome and that we have to work with you to achieve the same. So I'm
> curious to hear how that can be done.

OK, I see from your patch that it uses the direct mapped read-only
region to read this data.

Do we know what information exactly fwupd needs? I mean exposing all of
this might not be good idea from security perspective (but I'm not an
expert). However, we can perhaps expose some of it through intel-spi,
and make that work so that distros can enable it safely. My concern of
removing the DANGEROUS tag is that we end up bricking yet another Lenovo
laptop by accident. Avoiding that would give me more peace of mind :)
