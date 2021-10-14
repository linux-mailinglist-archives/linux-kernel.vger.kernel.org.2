Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0842E195
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhJNStD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:49:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:40741 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhJNStC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:49:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="251204208"
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="251204208"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 11:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="525174652"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga001.jf.intel.com with SMTP; 14 Oct 2021 11:46:51 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 14 Oct 2021 21:46:50 +0300
Date:   Thu, 14 Oct 2021 21:46:50 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWh7GgCgdtwRj3GU@intel.com>
References: <YWgYIYXLriayyezv@intel.com>
 <YWg+O1AXrWLO3Sf9@zn.tnic>
 <YWg/5h3OcQKE94Nz@intel.com>
 <YWhCAqDxAuTh1YwE@intel.com>
 <YWhFOJCF1pxIBANv@zn.tnic>
 <YWhG0kv/d/hddf+t@intel.com>
 <YWhsvSM5tAvwqprN@intel.com>
 <YWhwdDI5ECoMZQzU@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWhwdDI5ECoMZQzU@zn.tnic>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 08:01:24PM +0200, Borislav Petkov wrote:
> On Thu, Oct 14, 2021 at 08:45:33PM +0300, Ville Syrjälä wrote:
> > That ~ was indeed the problem. With it gone the machine is happy again.
> > 
> > I presume you'll turn this into a real patch?
> 
> Actually, you found it and you should be the one to write it and do the
> honors. Unless you don't want to - then I can do it.

I figured you can write a reasonably succinct commit message, instead
of having me ramble on incoherently. ATM I don't even know what mxcsr
is or why clobbering it would cause floating point exceptions with
sse specifically.

But I can certainly ramble, if you prefer that.

> 
> If you do, pls add 
> 
> Ser Olmy <ser.olmy@protonmail.com>
> 
> to Cc so that he can test your patch. I *think* it should work for him
> too but I don't know anything anymore. :-)
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Ville Syrjälä
Intel
