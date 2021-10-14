Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6870642E092
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhJNR4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:56:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:12243 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhJNR4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:56:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="228035322"
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="228035322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 10:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="527691585"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga008.fm.intel.com with SMTP; 14 Oct 2021 10:45:33 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 14 Oct 2021 20:45:33 +0300
Date:   Thu, 14 Oct 2021 20:45:33 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ser Olmy <ser.olmy@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWhsvSM5tAvwqprN@intel.com>
References: <YWgYIYXLriayyezv@intel.com>
 <YWg+O1AXrWLO3Sf9@zn.tnic>
 <YWg/5h3OcQKE94Nz@intel.com>
 <YWhCAqDxAuTh1YwE@intel.com>
 <YWhFOJCF1pxIBANv@zn.tnic>
 <YWhG0kv/d/hddf+t@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWhG0kv/d/hddf+t@intel.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 06:03:46PM +0300, Ville Syrj�l� wrote:
> On Thu, Oct 14, 2021 at 04:56:56PM +0200, Borislav Petkov wrote:
> > On Thu, Oct 14, 2021 at 05:43:14PM +0300, Ville Syrj�l� wrote:
> > > Hmm. Actually I just stared at the code a bit more it looks
> > > a bit funny. Was it supposed to do this instead?
> > > 
> > > - fpu->state.fxsave.mxcsr &= ~mxcsr_feature_mask;
> > > + fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;
> > 
> > Whoops, I had it like that in the original patch:
> > 
> > https://lore.kernel.org/all/163354193576.25758.8132624386883258818.tip-bot2@tip-bot2/
> > 
> > I blame tglx. :-)
> > 
> > Does it work if you remove the mask negation "~"?
> 
> The machine is currently preoccupied with other things. Should free up
> in an hour or two. Once it does I'll give this a spin and report back.

That ~ was indeed the problem. With it gone the machine is happy again.

I presume you'll turn this into a real patch?

Tested-by: Ville Syrj�l� <ville.syrjala@linux.intel.com>

-- 
Ville Syrj�l�
Intel
