Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB503811C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhENUYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:24:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:54603 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbhENUYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:24:04 -0400
IronPort-SDR: Va9ZVF8fijqzHqkFjkT9dbepwe5KLqGKVBbamsKUQJWXhOsS4LcVEQu3VsqL2puurFCtzGijKn
 unxrsRtUni+Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="180508770"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="180508770"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 13:22:52 -0700
IronPort-SDR: tCSdz899VH5JJU8cO3QGNvawjmbQ0pbYXGZeGsr3S5AvmMZR+bisRoQRv/wld6f0/vIusXNZ8V
 QOAcdpp8Li4Q==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431845038"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 13:22:51 -0700
Date:   Fri, 14 May 2021 13:22:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Edgecombe@iweiny-DESK2.sc.intel.com,
        Rick P <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH V6 00/10] PKS: Add Protection Key Supervisor support
Message-ID: <20210514202250.GA1722585@iweiny-DESK2.sc.intel.com>
References: <20210401225833.566238-1-ira.weiny@intel.com>
 <20210416220950.GE1904484@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416220950.GE1904484@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:14:56PM -0700, 'Ira Weiny' wrote:
> On Thu, Apr 01, 2021 at 03:58:23PM -0700, 'Ira Weiny' wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Introduce a new page protection mechanism for supervisor pages, Protection Key
> > Supervisor (PKS).
> 
> Is there any feedback on this series?

Please disregard this series...  (If you have not done so already).

Along with Rick posting his RFC for page table protections[1] he has raised a
concern with me about pkeys being allocated and then reallocated to another
user.  It turns out the code has a bug in this area and the fix is not trivial.

Because the PMEM use case never needed to free its key and even if it did a
small window of access was not a concern this was not tested.

The best solutions involve changing the API therefore this series is going to
need a respin.

Thank you,
Ira

[1] https://lore.kernel.org/lkml/20210505003032.489164-1-rick.p.edgecombe@intel.com/
