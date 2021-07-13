Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519953C72B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 16:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhGMPCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:02:34 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:33485 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236842AbhGMPCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:02:33 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id D671F1D00
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 15:59:42 +0100 (IST)
Received: (qmail 3732 invoked from network); 13 Jul 2021 14:59:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Jul 2021 14:59:42 -0000
Date:   Tue, 13 Jul 2021 15:59:41 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm/page_alloc]  dbbee9d5cd:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <20210713145941.GG3809@techsingularity.net>
References: <20210713144057.GB28943@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210713144057.GB28943@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 10:40:57PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: dbbee9d5cd83f9d0a29639e260516907ceb2ac3d ("mm/page_alloc: convert per-cpu list protection to local_lock")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 

Thanks, this will ultimately be fixed by https://lore.kernel.org/r/20210713135625.7615-1-mgorman@techsingularity.net

-- 
Mel Gorman
SUSE Labs
