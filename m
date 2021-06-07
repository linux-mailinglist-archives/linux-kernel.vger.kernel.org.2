Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D539E801
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhFGUFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:05:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40684 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhFGUFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:05:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0E9CF1FD2A;
        Mon,  7 Jun 2021 20:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623096238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrkIY/B3u9V9j7jp5dtI5Sis6+M3bzV1qGVo/FUf4gY=;
        b=cI5dTWt07tQFVnLRABp9qkLhF3RbFC95PIXMtFhnq3Vqg+yYlME2U0RWkvWjOxdwBoEFkh
        ICXg1QD7APxdnIw7OR4SWRG4rBp96+tjPpgstu/lMfjTUq+33Y21i6E3vpMYgg2JWWah6+
        C8vqUsFoe59XbAv8EU6/oOH3Pj6GyLo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C5EB6A3BDC;
        Mon,  7 Jun 2021 20:03:57 +0000 (UTC)
Date:   Mon, 7 Jun 2021 22:03:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <llong@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
References: <20210607163103.632681-1-atomlin@redhat.com>
 <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-06-21 21:36:47, Michal Hocko wrote:
> On Mon 07-06-21 15:18:38, Waiman Long wrote:
[...]
> > A partial OOM report below:
> 
> Do you happen to have the full report?
> 
> > [ 8221.433608] memory: usage 21280kB, limit 204800kB, failcnt 49116
> >   :
> > [ 8227.239769] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents  oom_score_adj name
> > [ 8227.242495] [1611298]     0 1611298    35869      635 167936        0         -1000 conmon
> > [ 8227.242518] [1702509]     0 1702509    35869      701 176128        0         -1000 conmon
> > [ 8227.242522] [1703345] 1001050000 1703294   183440        0 2125824        0           999 node
> > [ 8227.242706] Out of memory and no killable processes...
> > [ 8227.242731] node invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=999

Btw it is surprising to not see _GFP_ACCOUNT here.
-- 
Michal Hocko
SUSE Labs
