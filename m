Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A89130BD57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhBBLoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:44:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:48386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhBBLnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:43:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4CE6AD37;
        Tue,  2 Feb 2021 11:43:05 +0000 (UTC)
Date:   Tue, 2 Feb 2021 12:43:03 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC][PATCH 05/13] mm/numa: automatically generate node
 migration order
Message-ID: <20210202114302.GB12139@linux>
References: <20210126003411.2AC51464@viggo.jf.intel.com>
 <20210126003421.45897BF4@viggo.jf.intel.com>
 <CAHbLzkoB98YY0amBWTGcDPStcy1c35CC8D5MPMbVxzRKqVA0Cg@mail.gmail.com>
 <317d4c23-76a7-b653-87a4-bab642fa1717@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317d4c23-76a7-b653-87a4-bab642fa1717@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 11:13:14AM -0800, Dave Hansen wrote:
> Sure.  Were you thinking of a code comment, or enhanced changelog?
> 
> Let's say there's a system with two sockets each with the same three
> classes of memory: fast, medium and slow.  Each memory class is placed
> in its own NUMA node and the CPUs are attached to the fast memory.  That
> leaves 6 NUMA nodes (0-5):
> 
> 	Socket A: 0, 1, 2
> 	Socket B: 3, 4, 5
> 
> The migration path for this configuration path would start on the nodes
> with the processors and fast memory, progress through medium and end
> with the slow memory:
> 
> 	0 -> 1 -> 2 -> stop
> 	3 -> 4 -> 5 -> stop
> 
> This is represented in the node_demotion[] like this:
> 
> 	{  1, // Node 0 migrates to 1
> 	   2, // Node 1 migrates to 2
> 	  -1, // Node 2 does not migrate
> 	   4, // Node 3 migrates to 1
> 	   5, // Node 4 migrates to 2
> 	  -1} // Node 5 does not migrate
> 
> Is that what you were thinking of?

I would not mind to have the above explanation in a comment somewhere
in the code.


-- 
Oscar Salvador
SUSE L3
