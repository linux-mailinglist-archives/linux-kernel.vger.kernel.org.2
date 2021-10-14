Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7A42DBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhJNOgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:36:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:54348 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhJNOgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:36:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227970933"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="227970933"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 07:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="481278966"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga007.jf.intel.com with SMTP; 14 Oct 2021 07:34:15 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 14 Oct 2021 17:34:14 +0300
Date:   Thu, 14 Oct 2021 17:34:14 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWg/5h3OcQKE94Nz@intel.com>
References: <YWgYIYXLriayyezv@intel.com>
 <YWg+O1AXrWLO3Sf9@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWg+O1AXrWLO3Sf9@zn.tnic>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 04:27:07PM +0200, Borislav Petkov wrote:
> On Thu, Oct 14, 2021 at 02:44:33PM +0300, Ville Syrjälä wrote:
> > I have a 32bit installation here that stopped working. Bisected it
> > to commit d298b03506d3 ("x86/fpu: Restore the masking out of reserved
> > MXCSR bits").
> 
> Lemme make sure I understand this correctly: this patch is bad and with
> it reverted it works?

Yes.

>
> Because before this patch, the restoring would be a more restrictive
> than before and this patch reverts the code to the old behavior for
> invalid MXCSR bits.
> 
> > Tested the same disk on on both a 64bit capable Pentium D
> > and a 32bit only Pentium 4 just to rule out the specific CPU.
> > Busted on both.
> 
> So that's a purely 32-bit installation and a 32-bit kernel and you've
> booted it on two different machines?

Yes.

-- 
Ville Syrjälä
Intel
