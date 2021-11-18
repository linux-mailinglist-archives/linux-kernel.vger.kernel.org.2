Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B274455CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhKRNa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:30:56 -0500
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:54955 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229766AbhKRNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:30:56 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 291FCBAB41
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:27:55 +0000 (GMT)
Received: (qmail 29759 invoked from network); 18 Nov 2021 13:27:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Nov 2021 13:27:54 -0000
Date:   Thu, 18 Nov 2021 13:27:53 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <20211118132753.GB3366@techsingularity.net>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
 <YZYbXC/ycmif8WIE@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YZYbXC/ycmif8WIE@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:22:36AM +0100, Michal Hocko wrote:
> [Cc Mel]
> 

I think this patch should be ok. There are few direct users of __GFP_HIGH
and some of them are borderline silly (e.g. mm/shmem.c specifying
__GFP_HIGH|__GFP_NOMEMALLOC) while others just look questionable (
drivers/md/raid10.c seems to assume __GFP_HIGH guarantees allocation
success). Xen appears to be the worst abuser of __GFP_HIGH.

-- 
Mel Gorman
SUSE Labs
