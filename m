Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787BF3FCB16
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbhHaP6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:58:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36240 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhHaP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:58:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3805F221CB;
        Tue, 31 Aug 2021 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630425426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6kHgxX95RLos0Aa70DLyOZnKO3e+ri121ddJA4qCzQ=;
        b=jumbj38gN7MJUIRvplpPEztTc5adYZ0rvxNxWfgRFPWAyTbWbmrwCmaUJMQIV/aikQE60I
        kyKtrRFL/FtD0Qv1x5SmB7E5U/HrvlLZzv+Uq6AoESmvTaFCEYCSShNgY08SYhh7611mLC
        Uit4e/6tEBfKxriI15oGEZ/Y53+WHu0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4605A3B9F;
        Tue, 31 Aug 2021 15:57:05 +0000 (UTC)
Date:   Tue, 31 Aug 2021 17:57:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/oom: detect and kill task which has allocation
 forbidden by cpuset limit
Message-ID: <YS5RTiVgydjszmjn@dhcp22.suse.cz>
References: <1630399085-70431-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630399085-70431-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-08-21 16:38:05, Feng Tang wrote:
> There was report that starting an Ubuntu in docker while using cpuset
> to bind it to movlabe nodes (a node only has movable zone, like a node
> for hotplug or a PMEM node in normal usage) will fail due to memory
> allocation failure, and then OOM is involved and many other innocent
> processes got killed. It can be reproduced with command:
> $docker run -it --rm  --cpuset-mems 4 ubuntu:latest bash -c
> "grep Mems_allowed /proc/self/status" (node 4 is a movable node)

Is there any valid usecase to allow cpusets to be configured only to
movable nodes? Wouldn't it be better to simply disallow such a setup?
I do understand that we usually allow people to shoot their feet but
this one has some wider consequences.

> The reason is, in the case, the target cpuset nodes only have movable
> zone, while the creation of an OS in docker sometimes needs to allocate
> memory in non-movable zones (dma/dma32/normal) like GFP_HIGHUSER, and
> the cpuset limit forbids the allocation, then out-of-memory killing is
> involved even when normal nodes and movable nodes both have many free
> memory.
> 
> We've posted patches to LKML trying to make the usage working by
> loosening the check, which is not agreed as the cpuset binding should
> be respected, and should not be bypassed [1]
> 
> But still there is another problem, that when the usage fails as it's an
> mission impossible due to the cpuset limit, the allocating should just
> be killed first, before any other innocent processes get killed.

I do not like this solution TBH. We know that that it is impossible to
satisfy the allocation at the page allocator level so dealing with it at
the OOM killer level is just a bad layering and a lot of wasted cycles
to reach that point. Why cannot we simply fail the allocation if cpusets
filtering leads to an empty zone intersection?
-- 
Michal Hocko
SUSE Labs
