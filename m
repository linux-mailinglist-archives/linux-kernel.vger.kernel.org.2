Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE33162A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhBJJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:47:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:37756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhBJJpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:45:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA84CAE53;
        Wed, 10 Feb 2021 09:45:01 +0000 (UTC)
Date:   Wed, 10 Feb 2021 10:44:58 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, rientjes@google.com, cl@linux.com,
        alex.shi@linux.alibaba.com, dwagner@suse.de, tobin@kernel.org,
        akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
Subject: Re: [RFC][PATCH 02/13] mm/vmscan: move RECLAIM* bits to uapi header
Message-ID: <20210210094457.GB27173@linux>
References: <20210126003411.2AC51464@viggo.jf.intel.com>
 <20210126003415.1171FE94@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126003415.1171FE94@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:34:15PM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> It is currently not obvious that the RECLAIM_* bits are part of the
> uapi since they are defined in vmscan.c.  Move them to a uapi header
> to make it obvious.
> 
> This should have no functional impact.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Daniel Wagner <dwagner@suse.de>
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
