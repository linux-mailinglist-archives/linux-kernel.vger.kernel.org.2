Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E13E836B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhHJTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:09:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:42937 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhHJTJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:09:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="194562192"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="194562192"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 12:08:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="460504963"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2021 12:08:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3F085F9; Tue, 10 Aug 2021 22:08:36 +0300 (EEST)
Date:   Tue, 10 Aug 2021 22:08:36 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] efi/x86: Implement support for unaccepted memory
Message-ID: <20210810190836.cffj4fjqenuunwsd@black.fi.intel.com>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-3-kirill.shutemov@linux.intel.com>
 <07c2770e-1171-24ab-9403-91b306b5b1a4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c2770e-1171-24ab-9403-91b306b5b1a4@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 11:30:42AM -0700, Dave Hansen wrote:
> On 8/9/21 11:26 PM, Kirill A. Shutemov wrote:
> > +config UNACCEPTED_MEMORY
> > +	bool
> > +	depends on EFI_STUB
> > +	help
> > +	   Some Virtual Machine platforms, such as Intel TDX, introduce
> > +	   the concept of memory acceptance, requiring memory to be accepted
> > +	   before it can be used by the guest. This protects against a class of
> > +	   attacks by the virtual machine platform.
> > +
> > +	   This option adds support for unaccepted memory and makes such memory
> > +	   usable by kernel.
> 
> Do we really need a full-blown user-visible option here?  If we, for
> instance, just did:
> 
> config UNACCEPTED_MEMORY
> 	bool
> 	depends on EFI_STUB
> 
> it could be 'select'ed from the TDX Kconfig and no users would ever be
> bothered with it.  Would a user *ever* turn this on if they don't have
> TDX (or equivalent)?

But it's already not user selectable. Note that there's no prompt next to
the "bool". The "help" section is just for documentation. I think it can
be useful.

-- 
 Kirill A. Shutemov
