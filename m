Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47317379B02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhEKAC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:02:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:52014 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhEKAC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:02:28 -0400
IronPort-SDR: GTGBq8W6Q3tm8sHBAQk1QoNecyS+HiDUgwNvbPucZ3Qs0zj8C6p0OtvthJhyaKi0Pyw84AGpk4
 kOZVgJhkOFQw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186759309"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="186759309"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:01:21 -0700
IronPort-SDR: oh4FgzYiaaOGS7G9qIZSYq4KtAUUReMP+pUWhvBkN9Ruili04khdTwQpBmgmKqkhLTv3UgX3Zb
 NFrUm1YKYQRw==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="468540381"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:01:20 -0700
Date:   Mon, 10 May 2021 17:01:19 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
Message-ID: <20210511000119.GV4032392@tassilo.jf.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
 <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com>
 <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 04:34:34PM -0700, Dan Williams wrote:
> > > Outside the boot decompression code isn't this branch of the "ifdef
> > > BOOT_COMPRESSED_MISC_H"  handled by #VE? I also don't see any usage of
> > > __{in,out}() in this patch.
> >
> > I thought it was all alternative after decompression, so the #VE code
> > shouldn't be called. We still have it for some reason though.
> 
> Right, I'm struggling to understand where these spurious in/out
> instructions are coming from that are not replaced by the
> alternative's code?

There should be nothing in the main tree at least.

> Shouldn't those be dropped on the floor and warned
> about rather than handled? 

It might be related to eventually handling them in ring 3, but
I believe we disallow that currently too and it's not all that useful
anyways.  So yes it could be forbidden.

> I.e. shouldn't port-io instruction escapes
> that would cause #VE be precluded at build-time?

You mean in objtool? That would seem like overkill for a more theoretical
problem.

> > There used to be SAVE_ALL/SAVE_REGS, but they have been all removed in
> > some past refactorings.
> 
> Not a huge deal, but at a minimum it seems a generic construct that
> deserves to be declared centrally rather than tdx-guest-port-io local.

Yes I agree. We should just bring SAVE_ALL/SAVE_REGS back.

-Andi
