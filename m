Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C994C313DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhBHSpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:45:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:32724 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234147AbhBHQs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:48:26 -0500
IronPort-SDR: uLm5SqUfPZeOMgAYg6u3OmU4OSTlLMbnSd1JB6H+3s+1wIQzBzLtVoRxkurOwNNnqXbzd/a1iq
 VwdDBPA/2X5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168865857"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="168865857"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:46:40 -0800
IronPort-SDR: 0tH8vZ2UDyXUCeWra8Y96TDBdMxjR8G87LfAVI2Q1A7MD5uAf6Y1yA03Dp9YVvseRVpM7J9ttu
 hyLgSbZIH7BQ==
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="435687940"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:46:40 -0800
Date:   Mon, 8 Feb 2021 08:46:39 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <20210208164639.GB365765@tassilo.jf.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YCEQiDNSHTGBXBcj@hirez.programming.kicks-ass.net>
 <20210208162301.GA365765@tassilo.jf.intel.com>
 <YCFnwnzgHXNGKW+M@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCFnwnzgHXNGKW+M@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > So what happens if NMI happens here, and triggers a nested #VE ?
> > 
> > Yes that's a gap. We should probably bail out and reexecute the original
> > instruction. The VE handler would need to set a flag for that.
> > 
> > Or alternatively the NMI always gets the VE information and puts
> > it on some internal stack, but that would seem clunkier.
> 
> The same is possible with MCE and #DB I imagine.

I don't think there are currently any plans to inject #MC into TDX guests. It's
doubtful this could be done securely.

#DB is trickier because it will happen every time, so simply reexecuting
won't work. I guess it would need the ve info stack, or some care in kprobes/kernel
debugger that it cannot happen. I think I would prefer the later.

-Andi

