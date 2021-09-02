Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65D83FEC7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhIBKyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:54:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhIBKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:54:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C37C225EE;
        Thu,  2 Sep 2021 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630579988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2r0EybgPnEtDMpsAL/9zs/IAxrhOXjue5RbUFNnGOQs=;
        b=sjD13cj9yFHAcnznFYrXc+XNRQ/egzDqqPtTdSniUvxrsqWYjvn3tJnj/CNQlN9Z/Dav+e
        sJs2kXYkLf9yV3PMe5833fp2YmKrTeyJuLR5tzNHN/OwbLwIr3bjh66k9BTRlwF5EDLSWp
        /BW0UtCuyOmqnreyG7Uk5ggRcKxJOvg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DE7C013424;
        Thu,  2 Sep 2021 10:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ajV1NROtMGE+bAAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Thu, 02 Sep 2021 10:53:07 +0000
Date:   Thu, 2 Sep 2021 12:53:06 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <20210902105306.GC17119@blackbody.suse.cz>
References: <20210817164737.GA23342@blackbody.suse.cz>
 <20210818023004.GA17956@shbuild999.sh.intel.com>
 <YSzwWIeapkzNElwV@blackbook>
 <20210831063036.GA46357@shbuild999.sh.intel.com>
 <20210831092304.GA17119@blackbody.suse.cz>
 <20210901045032.GA21937@shbuild999.sh.intel.com>
 <877dg0wcrr.fsf@linux.intel.com>
 <20210902013558.GA97410@shbuild999.sh.intel.com>
 <e8d087a4-a286-3561-66ef-1e9cfb38605f@linux.intel.com>
 <20210902034628.GA76472@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902034628.GA76472@shbuild999.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, Sep 02, 2021 at 11:46:28AM +0800, Feng Tang <feng.tang@intel.com> wrote:
> > Narrowing it down to a single prefetcher seems good enough to me. The
> > behavior of the prefetchers is fairly complicated and hard to predict, so I
> > doubt you'll ever get a 100% step by step explanation.
 
My layman explanation with the available information is that the
prefetcher somehow behaves as if it marked the offending cacheline as
modified (even though reading only) therefore slowing down the remote reader.


On Thu, Sep 02, 2021 at 09:35:58AM +0800, Feng Tang <feng.tang@intel.com> wrote:
> @@ -139,10 +139,21 @@ struct cgroup_subsys_state {
>       /* PI: the cgroup that this css is attached to */
>       struct cgroup *cgroup;
>
> +     struct cgroup_subsys_state *parent;
> +
>       /* PI: the cgroup subsystem that this css is attached to */
>       struct cgroup_subsys *ss;

Hm, an interesting move; be mindful of commit b8b1a2e5eca6 ("cgroup:
move cgroup_subsys_state parent field for cache locality"). It might be
a regression for systems with cpuacct root css present. (That is likely
a big amount nowadays, that may be the reason why you don't see full
recovery?  For future, we may at least guard cpuacct_charge() with
cgroup_subsys_enabled() static branch.)

> [snip]
> Yes, I'm afriad so, given that the policy/algorithm used by perfetcher
> keeps changing from generation to generation.

Exactly. I'm afraid of relayouting the structure with each new
generation. A robust solution is putting all frequently accessed members
into individual cache-lines + separating them with one more cache line? :-/


Michal
