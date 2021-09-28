Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4130641A44B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 02:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbhI1AtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 20:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238236AbhI1AtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:49:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31C28611C0;
        Tue, 28 Sep 2021 00:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632790043;
        bh=XQMXYqgv1DilxuDhTVnlqoDru7v0POHEvK/WxsTQwlE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dzq1JA+OQze0EoDBpuzE2SrFyQr8Ta6E+ZmgxapKntxbUaQ35hK2efdHIcCaaEgSB
         o0OKBJ+1NN8joCiAYPR4Mbi4AlinkYrNCYNQNHkRHRY/ZjFpQSPF2dv7cTyc/42Et8
         c4utfcZoXQyfZGrheqLs6uF5MiZrKWLqoKSNvasc=
Date:   Mon, 27 Sep 2021 17:47:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH -V2] mm/migrate: fix CPUHP state to update node demotion
 order
Message-Id: <20210927174722.6ca9bc6a63bb50da7754bdaf@linux-foundation.org>
In-Reply-To: <20210927081100.475075-1-ying.huang@intel.com>
References: <20210927081100.475075-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 16:11:00 +0800 Huang Ying <ying.huang@intel.com> wrote:

> The node demotion order needs to be updated during CPU hotplug.
> Because whether a NUMA node has CPU may influence the demotion order.
> The update function should be called during CPU online/offline after
> the node_states[N_CPU] has been updated.  That is done in
> CPUHP_AP_ONLINE_DYN during CPU online and in CPUHP_MM_VMSTAT_DEAD
> during CPU offline.  But in commit 884a6e5d1f93 ("mm/migrate: update
> node demotion order on hotplug events"), the function to update node
> demotion order is called in CPUHP_AP_ONLINE_DYN during CPU
> online/offline.  This doesn't satisfy the order requirement.

What are the user-visible runtime effects of this error?

>  So in
> this patch, we added CPUHP_AP_MM_DEMOTION_ONLINE and
> CPUHP_MM_DEMOTION_DEAD to be called after CPUHP_AP_ONLINE_DYN and
> CPUHP_MM_VMSTAT_DEAD during CPU online and offline, and register the
> update function on them.
> 
> Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Keith Busch <kbusch@kernel.org>
> 

