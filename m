Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92542396F69
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhFAIuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:50:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:51992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233812AbhFAItu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:49:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622537288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMdwS/ef9ydlcUl/RcqGrwlMAgDRp0m5QB4l1k6zhDc=;
        b=m8ZTX+0EqSAI4Bk7cjO1Ow5K4pvDyxL2+JXo2S2cXntECd5PbJ9KYonmfeNxOnfzRcj7GM
        m6440iCYhq5z3t6VOIubYTIaArgZMFbonS/NoKabP1ef9U0vGa5Yl5kT8DgePUdF8j4KK7
        bC2IZjsvJjIOhOirdW3/LzpyhHUntUs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B291DAEB9;
        Tue,  1 Jun 2021 08:48:08 +0000 (UTC)
Date:   Tue, 1 Jun 2021 10:48:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [v3 PATCH 0/3] mm/mempolicy: some fix and semantics cleanup
Message-ID: <YLX0SFNfXVxcjV2/@dhcp22.suse.cz>
References: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
 <20210531144128.e69aaf2904e83ae170f00f06@linux-foundation.org>
 <20210601005513.GA15828@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601005513.GA15828@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-06-21 08:55:13, Feng Tang wrote:
[...]
> Current memory policy code has some confusing and ambiguous part about
> MPOL_LOCAL policy, as it is handled as a faked MPOL_PREFERRED one, and
> there are many places having to distinguish them. Also the nodemask
> intersection check needs cleanup to be more explicit for OOM use, and
> handle MPOL_INTERLEAVE correctly. This patchset cleans up these and
> unifies the parameter sanity check for mbind() and set_mempolicy().

Looks good to me. I would just add that this cleanup helps to make
further changes easier (notably MPOL_PREFERRED_MANY)

-- 
Michal Hocko
SUSE Labs
