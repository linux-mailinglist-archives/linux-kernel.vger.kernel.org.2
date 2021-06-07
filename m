Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D203A39D6CB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFGIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:12:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGIMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:12:01 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 718971FDA5;
        Mon,  7 Jun 2021 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623053409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NN/NQnziwslkNFgyu/32WXF9fOyovwCDi+PNXgUNu+8=;
        b=DXNBwOjaAJXb/et+FP2EkmFlLJ6EWr11ds9F+xm21tjXLCntBQY0iNj4JNIv/fc3GN543+
        DBigiMyXSnUX2htWnojyJ+7F1e0RDM/WkT0cD91/aygQ61Sp3bUvXmUlWTXrXURWOR94N1
        tIpVceBRpPj0O92s2GJMynnugHh4iyY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D1DECA3B8F;
        Mon,  7 Jun 2021 08:10:08 +0000 (UTC)
Date:   Mon, 7 Jun 2021 10:10:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [mm/mempolicy]  7463fff037: ltp.mbind01.fail
Message-ID: <YL3UYOGIz1HoqGd1@dhcp22.suse.cz>
References: <1622560492-1294-3-git-send-email-feng.tang@intel.com>
 <20210607074815.GC16270@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607074815.GC16270@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-06-21 15:48:15, kernel test robot wrote:
> mbind01.c:169: TINFO: case MPOL_PREFERRED (no target)
> mbind01.c:188: TFAIL: Wrong policy: 1, expected: 4

AFAIU this points to
static void test_none(unsigned int i, char *p)
{
        struct test_case *tc = &tcase[i];

        TEST(mbind(p, MEM_LENGTH, tc->policy, NULL, 0, tc->flags));
}

So it calls MPOL_PREFERRED with NULL parameter and the test has failed
because the kernel returns MPOL_LOCAL instead of MPOL_PREFERRED. Strictly
speaking this is breaking user interface but I am wondering whether this
really matter or is completely unexpected.  The manual page explicitly
talks about this case
"
	If the nodemask and maxnode arguments specify the empty set, then
	the memory is allocated on the node of the CPU that triggered the
	allocation.
"

I would be inclined to keep this inconsistency and see whether anybody
actually complains and have a relevant use for this behavior. The
cleanup which makes the code easier to maintain and less error prone
doesn't really deserve to get ditched just because of this IMHO.
-- 
Michal Hocko
SUSE Labs
