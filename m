Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FAC44E224
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhKLHCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 02:02:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:5889 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhKLHCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 02:02:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="232929784"
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800"; 
   d="scan'208";a="232929784"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 22:59:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800"; 
   d="scan'208";a="534692367"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 22:59:50 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 12 Nov 2021 08:59:47 +0200
Date:   Fri, 12 Nov 2021 08:59:47 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     Mauro Lima <mauro.lima@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YY4Q46XogSDHgcsY@lahna>
References: <YYy7QZGKeEEfI1mH@lahna>
 <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna>
 <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <YY0UCHtf8SAvGHTY@lahna>
 <CAD2FfiF=7H7RuAdrSrrr57JF6YG=pb5jw2QMgBDQsAEwgasYLw@mail.gmail.com>
 <YY0b01g+z3lkO4w2@lahna>
 <CAArk9MOxZaK2WqsuPR4GbgdxSnUBqgO1KZ8OT=+siksYq+2PxQ@mail.gmail.com>
 <YY0xZjjGjNq+kUXi@lahna>
 <CAHifhD6+BB+4LHq1CE3ZBVhnG-V0U=3H51mjfh44dx11kMCUfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHifhD6+BB+4LHq1CE3ZBVhnG-V0U=3H51mjfh44dx11kMCUfg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 11, 2021 at 04:16:14PM +0100, Hans-Gert Dahmen wrote:
> > In case someone is unfamiliar with this, the Intel SPI hardware
> > exposes two interfaces through the same controller. One that is called
> > software sequencer and there is a register of "allowed" opcodes that
> > software can use as it wishes. This register can be locked down but is
> > not always. The second interface is the hardware sequencer that only
> > exposes higher level commands like read, write and so on and internally
> > then executes whatever opcode the controller got from the chip
> > "supported opcodes table" (SFDP).  The recent Intel hardware, all
> > big-cores, only provide hardware sequencer and the software one is not
> > even available.
> 
> I am familiar with this and I do totally agree. I believe HW
> sequencing is available since sandy-bridge from 2011, so it will
> suffice for modern platforms. Honestly me and my developer friends
> never understood why this driver needs to still focus on SW sequencing
> altogether, it seems like a (possibly buggy) relic that just slows
> down the vital parts.

Just to clarify the software sequencer was used in "recent" Atoms
(Baytrail, Braswell and I think its successor too). After Broxton I
think it all is now hardware sequencer only. AFAIK those are still used
in embedded world so we should keep the support in the driver but that
support can be put under the "DANGEROUS" KConfig option.
