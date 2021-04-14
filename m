Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9793735F473
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351093AbhDNNCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:02:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:52572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345934AbhDNNCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:02:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618405315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WK2tglOodrWcHX/sWIFzGgFANwYLOhHY9/+WgOzzF7I=;
        b=kPNlVeT3TOhJTXtx1tmHbTs2rzMWQYKHxZybvqPagHlWlCwPmBccMfD6uQo/jUjZGyKp7o
        yImTJv13aIsF0+sCNJYP6uqNzuHoIr8YcElZhrSWvxGNLVlPMurWICdGqYyB+ZsTHSUGXk
        blMP2QsrHwsnRMe/OQqG6oHVQ4XYTcA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CADEDAFAB;
        Wed, 14 Apr 2021 13:01:55 +0000 (UTC)
Date:   Wed, 14 Apr 2021 15:01:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 07/13] mm/mempolicy: handle MPOL_PREFERRED_MANY like
 BIND
Message-ID: <YHbnwyITOehcVn0S@dhcp22.suse.cz>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-8-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615952410-36895-8-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 11:40:04, Feng Tang wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Begin the real plumbing for handling this new policy. Now that the
> internal representation for preferred nodes and bound nodes is the same,
> and we can envision what multiple preferred nodes will behave like,
> there are obvious places where we can simply reuse the bind behavior.
> 
> In v1 of this series, the moral equivalent was:
> "mm: Finish handling MPOL_PREFERRED_MANY". Like that, this attempts to
> implement the easiest spots for the new policy. Unlike that, this just
> reuses BIND.

No, this is a bug step back. I think we really want to treat this as
PREFERRED. It doesn't have much to do with the BIND semantic at all.
At this stage there should be 2 things remaining - syscalls plumbing and
2 pass allocation request (optimistic preferred nodes restricted and
fallback to all nodes).
-- 
Michal Hocko
SUSE Labs
