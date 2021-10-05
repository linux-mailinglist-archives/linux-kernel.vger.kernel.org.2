Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A618422089
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhJEIVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:21:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39556 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhJEIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:20:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2572320276;
        Tue,  5 Oct 2021 08:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633421938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kkPDXffrrJ+hj7t8fdYRdLuRd1zqhh+uit59I6+zuoM=;
        b=j8NDRxJ5tqFyz6PckdXxjEmdjgQSuuHv1Vhf+J7fvDHFwVQu7AmAiAwE47plmurmc1/yB7
        tph+J2NyWngjqn9vNYfIAt1co58Fv8yNRGVGnXue2V419KdJj5QTdAaubOoNy3nGof4b/x
        /ruIav9hZkG+FcbF9Z8ld2Ysw5qJRik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633421938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kkPDXffrrJ+hj7t8fdYRdLuRd1zqhh+uit59I6+zuoM=;
        b=GoXZZVJF36FEhHhfewQa06c6c7bNpd95M8rymNq84YyLrgOr3tAKbPc/fR2BjjmnU3SBFo
        T51zwZZ74qoMZNAw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B2FCFA3B81;
        Tue,  5 Oct 2021 08:18:57 +0000 (UTC)
Date:   Tue, 5 Oct 2021 09:18:56 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, riel@redhat.com
Subject: Re: [PATCH 1/4] sched/numa: Replace hard-coded number by a define in
 numa_task_group()
Message-ID: <20211005081855.GK3891@suse.de>
References: <20211004105706.3669-1-bharata@amd.com>
 <20211004105706.3669-2-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211004105706.3669-2-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:27:03PM +0530, Bharata B Rao wrote:
> While allocating group fault stats, task_numa_group()
> is using a hard coded number 4. Replace this by
> NR_NUMA_HINT_FAULT_STATS.
> 
> No functionality change in this commit.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
