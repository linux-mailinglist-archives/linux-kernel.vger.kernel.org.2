Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A33597EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhDIIcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:32:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhDIIbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:31:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A6FDAEFE;
        Fri,  9 Apr 2021 08:31:35 +0000 (UTC)
Date:   Fri, 9 Apr 2021 10:31:32 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Wei Xu <weixugc@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shy828301@gmail.com,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>, ying.huang@intel.com,
        Dan Williams <dan.j.williams@intel.com>, david@redhat.com
Subject: Re: [PATCH 07/10] mm/vmscan: add helper for querying ability to age
 anonymous pages
Message-ID: <20210409083132.GB31366@linux>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183229.B2360AEA@viggo.jf.intel.com>
 <CAAPL-u-OgmT+R=txfO_rFaYLKC0UZ5xEmFOY3spVHEmk_r4iSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAPL-u-OgmT+R=txfO_rFaYLKC0UZ5xEmFOY3spVHEmk_r4iSQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:40:13AM -0700, Wei Xu wrote:
> anon_should_be_aged() doesn't really need "lruvec".  It essentially
> answers whether the pages of the given node can be swapped or demoted.
> So it would be clearer and less confusing if anon_should_be_aged()
> takes "pgdat" instead of "lruvec" as the argument.  The call to
> mem_cgroup_lruvec(NULL, pgdat) in age_active_anon() can then be removed
> as well.

I tend to agree with this, and I would go one step further with the naming.
For me, taking into account the nature of the function that tells us whether
we have any means to age those pages, a better fit would be something like
anon_can_be_aged(). IIUC, the "should age" part would be inactive_is_low().


-- 
Oscar Salvador
SUSE L3
