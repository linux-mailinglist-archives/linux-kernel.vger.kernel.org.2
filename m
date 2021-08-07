Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F188C3E36FB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 21:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhHGTdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 15:33:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:62637 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhHGTdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 15:33:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10069"; a="201697252"
X-IronPort-AV: E=Sophos;i="5.84,303,1620716400"; 
   d="scan'208";a="201697252"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 12:32:59 -0700
X-IronPort-AV: E=Sophos;i="5.84,303,1620716400"; 
   d="scan'208";a="524453650"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 12:32:59 -0700
Date:   Sat, 7 Aug 2021 12:32:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 14/18] memremap_pages: Add memremap.pks_fault_mode
Message-ID: <20210807193259.GD3169279@iweiny-DESK2.sc.intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-15-ira.weiny@intel.com>
 <2bbd7ce2-8d16-8724-5505-96a4731c3c45@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bbd7ce2-8d16-8724-5505-96a4731c3c45@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:57:31PM -0700, Randy Dunlap wrote:
> On 8/3/21 9:32 PM, ira.weiny@intel.com wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index bdb22006f713..7902fce7f1da 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4081,6 +4081,20 @@
> >   	pirq=		[SMP,APIC] Manual mp-table setup
> >   			See Documentation/x86/i386/IO-APIC.rst.
> > +	memremap.pks_fault_mode=	[X86] Control the behavior of page map
> > +			protection violations.  Violations may not be an actual
> > +			use of the memory but simply an attempt to map it in an
> > +			incompatible way.
> > +			(depends on CONFIG_DEVMAP_ACCESS_PROTECTION
> 
> Missing closing ')' above.

Fixed.  Thank you!
Ira

> 
> > +
> > +			Format: { relaxed | strict }
> > +
> > +			relaxed - Print a warning, disable the protection and
> > +				  continue execution.
> > +			strict - Stop kernel execution via BUG_ON or fault
> > +
> > +			default: relaxed
> > +
> 
> 
> -- 
> ~Randy
> 
> 
