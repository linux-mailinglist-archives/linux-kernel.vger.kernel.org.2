Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9CB42D872
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhJNLqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:46:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:27262 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231236AbhJNLqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:46:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="313858117"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="313858117"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 04:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="626772293"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga001.fm.intel.com with SMTP; 14 Oct 2021 04:44:34 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 14 Oct 2021 14:44:33 +0300
Date:   Thu, 14 Oct 2021 14:44:33 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking out
 of reserved MXCSR bits")
Message-ID: <YWgYIYXLriayyezv@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a 32bit installation here that stopped working. Bisected it
to commit d298b03506d3 ("x86/fpu: Restore the masking out of reserved
MXCSR bits").

dhcpcd was the first thing I notice being affected on account of
network not coming up, and after trying to look at it with gdb also
gdb turned out to be broken.

strace of dhcpcd shows a SIGFPE getting delivered, after which it gets
stuck (seem to be sitting in poll but not responding to even ^C).
And gdb seems to be stuck in a perpetual SIGFPE loop and won't even
get to the prompt.

The crucial bit here seems to be that most of the software is built
with -mfpmath=sse. After rebuilding dhcpcd without that it started
to work on the broken kernel. Rebuilding gdb didn't help so I whatever
SSE usage is causing the issue is presumably happening in a library.
Had to do the rebuilds on a working kernel as well because otherwise
the build itself would die to a SIGFPE somewhere.

Tested the same disk on on both a 64bit capable Pentium D
and a 32bit only Pentium 4 just to rule out the specific CPU.
Busted on both.

-- 
Ville Syrjälä
Intel
