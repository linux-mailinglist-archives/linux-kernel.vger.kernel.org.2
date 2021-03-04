Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C29032D047
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbhCDJ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:59:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:51902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238179AbhCDJ70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:59:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614851920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+Vq6O5olw4xwzFFe299bnHsHIPKz6DwZZTvQIM7UXI=;
        b=dcjhF6ZddsuBWbaL5ro/UgiOqUChdTPrHDEPRNSD/qq8sZjhOZwUIkeEBeZMk7djvS9ObH
        aib6thLKpuC6Y6PzdEASMjpkPsT0aUW3I2ZMFtrFuCXUI4aICBVXd4gKPEenYNekdBanWE
        0Jmp9iPZoPErJCKO2BQ9yko9dFVybVA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D56CAD74;
        Thu,  4 Mar 2021 09:58:40 +0000 (UTC)
Date:   Thu, 4 Mar 2021 10:58:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com
Subject: Re: possible deadlock in sk_clone_lock
Message-ID: <YECvT4QOitK954Ne@dhcp22.suse.cz>
References: <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
 <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
 <YD0jLTciK0M7P+Hc@dhcp22.suse.cz>
 <122e8c5d-60b8-52d9-c6a1-00cd61b2e1b6@oracle.com>
 <YD4I+VPr3UNt063H@dhcp22.suse.cz>
 <CALvZod7XHbjfoGGVH=h17u8-FruMaiPMWxXJz5JBmeJkNHBqNQ@mail.gmail.com>
 <YD5L1K3EWVWh1ULr@dhcp22.suse.cz>
 <06edda9a-dce9-accd-11a3-97f6d5243ed1@oracle.com>
 <YD9CzzypRyUPT0Jh@dhcp22.suse.cz>
 <20210303175945.GE2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303175945.GE2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-03-21 09:59:45, Paul E. McKenney wrote:
> On Wed, Mar 03, 2021 at 09:03:27AM +0100, Michal Hocko wrote:
[...]
> > Paul what is the current plan with in_atomic to be usable for !PREEMPT
> > configurations?
> 
> Ah, thank you for the reminder!  I have rebased that series on top of
> v5.12-rc1 on -rcu branch tglx-pc.2021.03.03a.
> 
> The current state is that Linus is not convinced that this change is
> worthwhile given that only RCU and printk() want it.  (BPF would use
> it if it were available, but is willing to live without it, at least in
> the short term.)
> 
> But maybe Linus will be convinced given your additional use case.
> Here is hoping!

Yes, hugetlb freeing path would benefit from this. You can reference
this lockdep report (http://lkml.kernel.org/r/000000000000f1c03b05bc43aadc@google.com)
with an additional argument that making hugetlb_lock irq safe is a
larger undertaking and we will need something reasonably backportable
for older kernels as well.
-- 
Michal Hocko
SUSE Labs
