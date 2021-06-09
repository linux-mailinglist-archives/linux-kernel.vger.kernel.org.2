Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D733A0EDA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbhFIIpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:45:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:8593 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237688AbhFIIpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:45:09 -0400
IronPort-SDR: NgVs+Z1BfIkKZ3wWwe+slS4w+0mNNJcnzuJ+rePFKkLCLmrRuXlncPDcoJ7oEvhlii+W90Hcun
 UZQXzqtYL/TA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="226398368"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="226398368"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 01:43:14 -0700
IronPort-SDR: a10/iHx3Ez8a/S442LEMxFO5RbR1PTaU9GqPQBchSXLASM2BWXGVXaMtJTZFK8YJVpq6psqUJY
 UuJNDjwMXYWQ==
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="448211587"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 01:43:11 -0700
Date:   Wed, 9 Jun 2021 16:59:38 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oliver Glitta <glittao@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [mm/slub]  ad36bafb3b:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
Message-ID: <20210609085938.GD15555@xsang-OptiPlex-9020>
References: <20210516144152.GA25903@xsang-OptiPlex-9020>
 <20210518170700.0ffdcaeb55cf64607120d5be@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518170700.0ffdcaeb55cf64607120d5be@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Andrew,

On Tue, May 18, 2021 at 05:07:00PM -0700, Andrew Morton wrote:
> On Sun, 16 May 2021 22:41:52 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597 ("mm/slub: use stackdepot to save stack trace in objects")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> 
> I expect
> https://lkml.kernel.org/r/20210516195150.26740-1-vbabka@suse.cz will
> fix this?
> 

we tested the patch, and it can fix the issue. thanks
