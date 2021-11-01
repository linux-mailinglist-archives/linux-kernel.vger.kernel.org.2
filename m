Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF3B441541
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhKAI04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:26:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42750 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKAI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:26:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 725F3212C7;
        Mon,  1 Nov 2021 08:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635755061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v73T2I+R3+XsQ58nd63iTWxJazBHCqhFl5kE+JfgSvQ=;
        b=A8EZzgOTU7ycVXKyf1uY2ceQpnEEle1vwKlTLBIeuVE0dJ3psGUqmEaO4GHbNbQu1zn4jh
        59QgOci0x9LLjVjt0YTxnLvyr2Q8nbeQ3ZZFHIAaSOuriKp6jy6GM5XhdYUUjNT0YweNz9
        8bOs2GEKr+OhWZN8xtRHEGe5ADNfDec=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E80A8A3B83;
        Mon,  1 Nov 2021 08:24:19 +0000 (UTC)
Date:   Mon, 1 Nov 2021 09:24:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yongqiang Liu <liuyongqiang13@huawei.com>
Cc:     rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>
Subject: Re: [QUESTION] oom killed the key system process triggered by a bad
 process alloc memory with MAP_LOCKED
Message-ID: <YX+kMpr/fvmMW7hy@dhcp22.suse.cz>
References: <cc85a520-804c-35cc-c7d7-b9999c0671fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc85a520-804c-35cc-c7d7-b9999c0671fe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon 01-11-21 16:05:50, Yongqiang Liu wrote:
[...]
> And we found that when the oom_reaper is done but the memory is still high:
> 
> [   45.115685] Out of memory: Killed process 2553 (oom) total-vm:953404kB,
> anon-rss:947748kB, file-rss:388kB, shmem-rss:0kB, UID:0 pgtables:1896kB
> oom_score_adj:1000
> [   45.115739] oom_reaper: reaped process 2553 (oom), now anon-rss:947708kB,
> file-rss:0kB, shmem-rss:0kB
> 
> This is because the bad proccess which recieved SIGKILL is unlocking the mem
> to exit which needs more time. And the next oom is triggered to kill the
> other system process.

Yes, this is a known limitation of the oom_reaper based OOM killing.
__oom_reap_task_mm has to skip over mlocked memory areas because
munlocking requires some locking (or at least that was the case when the
oom reaper was introduced) and the primary purpose of the oom_reaper is
to guarantee a forward progress.

Addressing that limitation would require the munlock operation to not
depend on any locking. I am not sure how much work that would be with
the current code. Until now this was not a high priority because
processes with a high mlock limit should be really trusted with their
memory consumption so they shouldn't be really the primary oom killer
target.

Are you seeing this problem happening with a real workload or is this
only triggered with some artificial tests? E.g. LTP oom tests are known
to trigger this situation but they do not represent any real workload.
-- 
Michal Hocko
SUSE Labs
