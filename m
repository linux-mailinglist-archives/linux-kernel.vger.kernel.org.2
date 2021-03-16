Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE88D33D4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhCPNcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:32:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235081AbhCPNb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:31:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615901516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8svTfIyJTaVROFKYlQfsMsGIUrlyGzzyIqCVIWqxArY=;
        b=ENhZ/Ea0rqxCFArUQgZIJwni2mFnvIFyqXxY2vAiR07jDO6jM2vVlJqMoem6bhiplcbIcd
        tHwk+LNFOwjW1CsUGqrNJJF0cZE0WJWeQPKpIRFI0ybDj1bCHawyrRaWRMHPqzgD6ULoEX
        i1UgogLMyr4N6Ko2sJWcuhq788XIIsc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A892AD74;
        Tue, 16 Mar 2021 13:31:56 +0000 (UTC)
Date:   Tue, 16 Mar 2021 14:31:53 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [mm] f3344adf38: fxmark.hdd_btrfs_DWAL_63_bufferedio.works/sec
 -52.4% regression
Message-ID: <YFCzSYIgCn9YAXf/@dhcp22.suse.cz>
References: <20210315062808.GA837@xsang-OptiPlex-9020>
 <CAHk-=wi1KcOZo4JeRDgJCU0gB5v16q6GJsFtF365MSfM8hH3zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1KcOZo4JeRDgJCU0gB5v16q6GJsFtF365MSfM8hH3zA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-03-21 13:42:50, Linus Torvalds wrote:
> If somebody can actually figure out what happened there, that would be
> good, but for now it goes into my "archived as a random outlier"
> folder.

This is not something new. We have seen reports like that in the past
already. In many cases there was no apparent reason except for potential
code alignment: e.g. http://lkml.kernel.org/r/20200409135029.GA2072@xsang-OptiPlex-9020
There were some other memcg related which didn't really show any
increase in cache misses or similar. I cannot find those in my notes
right now. There were others like https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
with analysis http://lkml.kernel.org/r/20201125062445.GA51005@shbuild999.sh.intel.com
which actually pointed to something legit actually.

For this particular report I do not see any real relation to the patch
either.
-- 
Michal Hocko
SUSE Labs
