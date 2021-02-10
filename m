Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE96C316300
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhBJJ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:58:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:55074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhBJJzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:55:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50187AD57;
        Wed, 10 Feb 2021 09:54:40 +0000 (UTC)
Date:   Wed, 10 Feb 2021 10:54:37 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, cl@linux.com, alex.shi@linux.alibaba.com,
        tobin@kernel.org, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw, dwagner@suse.de
Subject: Re: [RFC][PATCH 03/13] mm/vmscan: replace implicit RECLAIM_ZONE
 checks with explicit checks
Message-ID: <20210210095437.GC27173@linux>
References: <20210126003411.2AC51464@viggo.jf.intel.com>
 <20210126003417.72B4BCFB@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126003417.72B4BCFB@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:34:17PM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> RECLAIM_ZONE was assumed to be unused because it was never explicitly
> used in the kernel.  However, there were a number of places where it
> was checked implicitly by checking 'node_reclaim_mode' for a zero
> value.
> 
> These zero checks are not great because it is not obvious what a zero
> mode *means* in the code.  Replace them with a helper which makes it
> more obvious: node_reclaim_enabled().
> 
> This helper also provides a handy place to explicitly check the
> RECLAIM_ZONE bit itself.  Check it explicitly there to make it more
> obvious where the bit can affect behavior.
> 
> This should have no functional impact.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: "Tobin C. Harding" <tobin@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: osalvador <osalvador@suse.de>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
