Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D91631B23D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBNTfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:35:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:53951 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhBNTfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:35:08 -0500
IronPort-SDR: O9MjSacBhjWCgLheiIbex1RVbMh2ZZmKyzfMbHuZ7FsoQb69tWnDcH7WBb3L4S0B+YV5JvDnTl
 pmIa0sQMwqnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="161736102"
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="scan'208";a="161736102"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2021 11:33:22 -0800
IronPort-SDR: V2grEBjIPBMLQfK0YatjbkaTnDA5f3Ijs8X5sKxsnCJ6c3Kkf0XqQ0YrVNYTefrvBZKIwoq8D/
 uOxLM2jO5kSg==
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="scan'208";a="376990409"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2021 11:33:22 -0800
Date:   Sun, 14 Feb 2021 11:33:20 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <20210214193320.GH365765@tassilo.jf.intel.com>
References: <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
 <YCbfyde9jl7ti0Oz@google.com>
 <8c23bbfd-e371-a7cf-7f77-ec744181547b@intel.com>
 <YCbm/umiGUS7UuVb@google.com>
 <514734d9-d8be-03ee-417e-4d0ad2f56276@intel.com>
 <YCbq+UEMIsE0NIWI@google.com>
 <7d0b08c4-5ae7-f914-e217-767a9fae7b78@intel.com>
 <YCb0/Dg28uI7TRD/@google.com>
 <CALCETrUnOVvC4d8c_Z=5ZDefAo+0t6-9hadttOjTypJykN6_3A@mail.gmail.com>
 <caa0b029-038c-cb59-6a69-70c84922fc6f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa0b029-038c-cb59-6a69-70c84922fc6f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 01:48:36PM -0800, Dave Hansen wrote:
> On 2/12/21 1:47 PM, Andy Lutomirski wrote:
> >> What about adding a property to the TD, e.g. via a flag set during TD creation,
> >> that controls whether unaccepted accesses cause #VE or are, for all intents and
> >> purposes, fatal?  That would allow Linux to pursue treating EPT #VEs for private
> >> GPAs as fatal, but would give us a safety and not prevent others from utilizing
> >> #VEs.
> > That seems reasonable.
> 
> Ditto.
> 
> We first need to double check to see if the docs are right, though.

I confirmed with the TDX module owners that #VE can only happen for:
- unaccepted pages
- instructions like MSR access or CPUID
- specific instructions that are no in the syscall gap

Also if there are future asynchronous #VEs they would only happen
with IF=1, which would also protect the gap.

So no need to make #VE an IST.

-Andi

