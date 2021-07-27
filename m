Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52ED3D7896
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhG0Ofm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:35:42 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:36655 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231466AbhG0Ofl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:35:41 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 43787CAEC8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 15:35:40 +0100 (IST)
Received: (qmail 9215 invoked from network); 27 Jul 2021 14:35:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Jul 2021 14:35:40 -0000
Date:   Tue, 27 Jul 2021 15:35:38 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm/page_alloc]  44042b4498:
 WARNING:possible_recursive_locking_detected
Message-ID: <20210727143538.GB3809@techsingularity.net>
References: <20210727143136.GA27400@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210727143136.GA27400@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:31:36PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 44042b4498728f4376e84bae1ac8016d146d850b ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 

Does this warning happen after 187ad460b841 ("mm/page_alloc: avoid page
allocator recursion with pagesets.lock held")? I ask because I see the
stack_depot_save in the warning.

-- 
Mel Gorman
SUSE Labs
