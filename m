Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534FB33E2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 01:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCQAac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:30:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:61621 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhCQAaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:30:15 -0400
IronPort-SDR: qSB9Hi5s96XoX4ewzQJif4PhrgsiDqrAExHPkGopHQ6EYH8VXBeY3J7pIo5a9vKsGe4YfdD+OE
 qHLwHERkfZXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="168629941"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="168629941"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 17:30:14 -0700
IronPort-SDR: iU74D+PnG+FCfDSM1Id5HlD81J/lHNM6AIKW/6A5oEv2Kknv+2oa9aDpBfAvZMqP9Jglnpnyue
 yTciKHwQxRNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602026427"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 17:30:12 -0700
Date:   Wed, 17 Mar 2021 08:30:11 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/x86/kcpuid: Add AMD leaf 0x8000001E
Message-ID: <20210317003011.GD49151@shbuild999.sh.intel.com>
References: <20210315125901.30315-1-bp@alien8.de>
 <20210315125901.30315-2-bp@alien8.de>
 <20210316074223.GC49151@shbuild999.sh.intel.com>
 <20210316142825.GB18003@zn.tnic>
 <YFDlLHsE7AhOgkDi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFDlLHsE7AhOgkDi@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris and Sean,

On Tue, Mar 16, 2021 at 10:04:44AM -0700, Sean Christopherson wrote:
> On Tue, Mar 16, 2021, Borislav Petkov wrote:
> > On Tue, Mar 16, 2021 at 03:42:23PM +0800, Feng Tang wrote:
> > > Also I'm wondering for some basic leaf and extended leaf which
> > > may has different definition for different vendors, do we need
> > > to seprate the csv to a general one and vendor specific ones.
> > 
> > Do you know of such?

No. When I read the patch, I googled some doc for the registers definition
which I found different from Intel's manual.

> > 
> > Because AFAIK vendors own, more or less, each range. Like, Intel owns
> > the base range and AMD the extended so there should be no conflicts
> > actually...
> 
> There are no known conflicts, and all sorts of things would break horribly if
> any CPU vendor (or hypervsior) were careless enough to redefine a CPUID bit.

Great to know these sharing policy between vendors, which will save many
troubles for us :)

Also I just took a look at code of cpuid, which has some functions like
	print_leafX_vendorA
	print_leafX_vendorB
	print_leafX_vendorC
but as you mentioned, I didn't find obvious overlaps of specific bits.

Thanks,
Feng
