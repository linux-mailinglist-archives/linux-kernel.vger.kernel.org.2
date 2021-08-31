Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2213FC4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbhHaJYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:24:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48986 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbhHaJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:23:59 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35D952218C;
        Tue, 31 Aug 2021 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630401783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KEjheK3h00K+lY9OU2qNX5OkzKIkBPjT18RnPLeOtvw=;
        b=XsYZ+3djmOGV2B64OFpTbqfeJfg3PWodIWAcKOYMjjrWtHXl07rKXOWzcZISSP9ILtEmZr
        JN3ha3QJ/oMAxygs6zbKFpnDFf6sIjPe9zKOJSMdvN5cUQrPQ9Ar9l/SZXDFUgea5VGUK0
        XbTzBy+PNAOBsEysYVJ+LzeFEYB8w74=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0983C139A3;
        Tue, 31 Aug 2021 09:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id T8ubAff0LWH9awAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Tue, 31 Aug 2021 09:23:03 +0000
Date:   Tue, 31 Aug 2021 11:23:04 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andi.kleen@intel.com, kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
Message-ID: <20210831092304.GA17119@blackbody.suse.cz>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com>
 <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org>
 <20210817024500.GC72770@shbuild999.sh.intel.com>
 <20210817164737.GA23342@blackbody.suse.cz>
 <20210818023004.GA17956@shbuild999.sh.intel.com>
 <YSzwWIeapkzNElwV@blackbook>
 <20210831063036.GA46357@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831063036.GA46357@shbuild999.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 02:30:36PM +0800, Feng Tang <feng.tang@intel.com> wrote:
> Yes, I tried many re-arrangement of the members of cgroup_subsys_state,
> and even close members of memcg, but there were no obvious changes.
> What can recover the regresion is adding 128 bytes padding in the css,
> no matter at the start, end or in the middle.

Do you mean the padding added outside the .cgroup--.refcnt members area
also restores the benchmark results? (Or you refer to paddings that move
.cgroup and .refcnt across a cacheline border ?) I'm asking to be sure
we have correct understanding of what members are contended (what's the
frequent writer).

Thanks,
Michal
