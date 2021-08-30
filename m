Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213FE3FB88C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhH3OwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:52:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50938 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhH3OwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:52:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 449DC21F52;
        Mon, 30 Aug 2021 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630335066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CX58qVN4Ck12zG3v77O1vQ3yL2HFd/HJt1tB50SwN+o=;
        b=o7bqxEr0KexNclilyLNchGDyvyLnJo73QmlRVCHSxxDSw1DEDBOTKoGQ4ujOQds2OwYNUZ
        Iep6AMtMZEg06eW52hNkevpGXojzaoiG5qFaVh59zY0pnSBl/VL3P6sSvYfnc5rQIJtA71
        Z8tR7j9bBmffl8Ftelmflp/4FUU/MhA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE5F413B68;
        Mon, 30 Aug 2021 14:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GSMrMVnwLGFzPgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 30 Aug 2021 14:51:05 +0000
Date:   Mon, 30 Aug 2021 16:51:04 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        andi.kleen@intel.com
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
Message-ID: <YSzwWIeapkzNElwV@blackbook>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com>
 <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org>
 <20210817024500.GC72770@shbuild999.sh.intel.com>
 <20210817164737.GA23342@blackbody.suse.cz>
 <20210818023004.GA17956@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210818023004.GA17956@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Feng.

On Wed, Aug 18, 2021 at 10:30:04AM +0800, Feng Tang <feng.tang@intel.com> wrote:
> As Shakeel also mentioned, this 0day's vm-scalability doesn't involve
> any explicit mem_cgroup configurations.

If it all happens inside root memcg, there should be no accesses to the
0x10 offset since the root memcg is excluded from refcounting. (Unless
the modified cacheline is a μarch artifact. Actually, for the lack of
other ideas, I was thinking about similar cause even for non-root memcgs
since the percpu refcounting is implemented via a segment register.)

Is this still relevant? (You refer to it as 0day's vm-scalability
issue.)

By some rough estimates there could be ~10 cgroup_subsys_sets per 10 MiB
of workload, so the 128B padding gives 1e-4 relative overhead (but
presumably less in most cases). I also think it acceptable (size-wise).

Out of curiosity, have you measured impact of reshuffling the refcnt
member into the middle of the cgroup_subsys_state (keeping it distant
both from .cgroup and .parent)?

Thanks,
Michal
