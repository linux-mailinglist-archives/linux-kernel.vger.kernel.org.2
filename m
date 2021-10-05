Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF663422093
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhJEIX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:23:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49916 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhJEIXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:23:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E90B223F3;
        Tue,  5 Oct 2021 08:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633422093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSgWfHBoq0JDEOFQ2LHMyzXTFy3fM71N3IgwYhLccE4=;
        b=uvIywHtmliwkl2XzXJvi+3jQa74Ll6+r28e32vA6pKFBmS7HAF5gIMyPtFPXMbQKXsaBp5
        EfMCMPvWTSKIYs7ouJ5TW3afmYzmpv4vk7uJtyEZWn6jgDhV53S0MzihXZyS53YwAOylRq
        NYyO9JKQF09cyoq30rRgEytmsfmlh2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633422093;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSgWfHBoq0JDEOFQ2LHMyzXTFy3fM71N3IgwYhLccE4=;
        b=tqUsTt8e9JBhZdDzbUo0vGY07DDfyo6OjYvr5tXVBDnuziX1ujGMMmEebhB8ehoQIDlYhM
        8I0fDcvt7CIOQbCQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D74E5A3B81;
        Tue,  5 Oct 2021 08:21:32 +0000 (UTC)
Date:   Tue, 5 Oct 2021 09:21:31 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, riel@redhat.com
Subject: Re: [PATCH 2/4] sched/numa: Remove the redundant member
 numa_group::fault_cpus
Message-ID: <20211005082131.GL3891@suse.de>
References: <20211004105706.3669-1-bharata@amd.com>
 <20211004105706.3669-3-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211004105706.3669-3-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:27:04PM +0530, Bharata B Rao wrote:
> numa_group::fault_cpus is actually a pointer to the region
> in numa_group::faults[] where NUMA_CPU stats are located.
> 
> Remove this redundant member and use numa_group::faults[NUMA_CPU]
> directly like it is done for similar per-process numa fault stats.
> 
> There is no functionality change due to this commit.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
