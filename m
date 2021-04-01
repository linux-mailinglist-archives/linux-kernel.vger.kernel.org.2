Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3A350DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 06:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhDAEZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 00:25:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:14565 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhDAEYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 00:24:39 -0400
IronPort-SDR: Be5rAwfZzng45LHYaeKZmViLYFkxWv+tm3lzh0C5gZTis3f986tMwXpRasdzsuJP4GxTJ0AW2Q
 q2/erPYDG71w==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="277335108"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="277335108"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 21:24:38 -0700
IronPort-SDR: TSo3nltnwRKujxL/XTvtnwrikFqTHFy42I2GykZpMQSBoqvSwAL/DhlNsBVvc0VzrzCVBSU5uw
 MmlwARbBX6sg==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="439061545"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 21:24:37 -0700
Date:   Wed, 31 Mar 2021 21:24:36 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <20210401042436.GJ1285835@tassilo.jf.intel.com>
References: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
 <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YGTvSvr2T2v3t3XA@google.com>
 <5d961c25-3dee-4a5d-4bba-a97d157a5a49@intel.com>
 <YGTyWUQbxVZeeko+@google.com>
 <d8078f5d-735c-2b0f-98eb-663be2118762@intel.com>
 <ef49222a-8ffc-dacc-4f21-3bd1ef13a2ac@linux.intel.com>
 <b175f08d-2930-158d-8543-fe6a7f6aaf12@intel.com>
 <20210401032827.GI1285835@tassilo.jf.intel.com>
 <92688a68-f4b8-9518-424b-7d967c4c728a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92688a68-f4b8-9518-424b-7d967c4c728a@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 08:46:18PM -0700, Dave Hansen wrote:
> On 3/31/21 8:28 PM, Andi Kleen wrote:
> >> The hardware (and VMMs and SEAM) have ways of telling the guest kernel
> >> what is supported: CPUID.  If it screws up, and the guest gets an
> >> unexpected #VE, so be it.
> > The main reason for disabling stuff is actually that we don't need
> > to harden it. All these things are potential attack paths.
> 
> Wait, MWAIT is an attack path?  If it were an attack path, wouldn't it

No MWAIT is not, but lots of other things that can be controlled by the
host are. And that will be a motivation to disable things.

> >> We don't have all kinds of crazy handling in the kernel's #UD handler
> >> just in case a CPU mis-enumerates a feature and we get a #UD.  We have
> >> to trust the underlying hardware to be sane.  If it isn't, we die a
> >> horrible death as fast as possible.  Why should TDX be any different?
> > That's what the original patch did -- no unnecessary checks -- but reviewers
> > keep asking for the extra checks, so Sathya added more. We have the not
> > unusual problem here that reviewers don't agree among themselves.
> 
> Getting consensus is a pain in the neck, eh?

Tt seems more like a circular argument currently.
> 
> It's too bad all the reviewers in the community aren't like all of the
> engineers at big companies where everyone always agrees. :)

I would propose to go back to the original patch without all the extra
checks. I think that's what you're arguing too. IIRC the person
who originally requested extra checks was Andy, if he's ok with 
that too we can do it, so that you guys can finally move on
to the other patches that actually do more than just trivial things.

-Andi
