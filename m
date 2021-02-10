Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B2B3167B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhBJNPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:15:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:33352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhBJNPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:15:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612962889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MiX2gkzarTK0h+lISZ1n2kae0qwJVwGheDzNtJatgj4=;
        b=oGTLpdlTv9kpK7PGKvpr+uzOynnvsduvfrSgh/g1amIqnkadq/SgrIDv6zZ95TA907qy0F
        DexjlY/nfJEG67SjG26HNg8S7ApCGw62B43HlBlmUEGVPrem+EXc7MU6NWejTdLP0mUn3H
        65fbIwFlTG/wO25sBtvT0Epxttd7ycU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8332AC97;
        Wed, 10 Feb 2021 13:14:48 +0000 (UTC)
Date:   Wed, 10 Feb 2021 14:14:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     zhou xianrong <xianrong_zhou@163.com>
Cc:     iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        rostedt@goodmis.org, mingo@redhat.com, vbabka@suse.cz,
        rientjes@google.com, willy@linux.intel.com,
        pankaj.gupta.linux@gmail.com, bhe@redhat.com, ying.huang@intel.com,
        minchan@kernel.org, ruxian.feng@transsion.com,
        kai.cheng@transsion.com, zhao.xu@transsion.com,
        yunfeng.lan@transsion.com, zhouxianrong@tom.com,
        zhou xianrong <xianrong.zhou@transsion.com>
Subject: Re: [PATCH] kswapd: no need reclaim cma pages triggered by unmovable
 allocation
Message-ID: <YCPcRj/e9NdQIV9S@dhcp22.suse.cz>
References: <20210209082313.21969-1-xianrong_zhou@163.com>
 <YCJUnWLlcSGoR1sT@dhcp22.suse.cz>
 <bc294334-eec3-f755-cb51-0e302e82809b@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc294334-eec3-f755-cb51-0e302e82809b@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-02-21 12:07:57, zhou xianrong wrote:
> 
> On 2021/2/9 下午5:23, Michal Hocko wrote:
> > On Tue 09-02-21 16:23:13, zhou wrote:
> > > From: zhou xianrong <xianrong.zhou@transsion.com>
> > > 
> > > For purpose of better migration cma pages are allocated after
> > > failure movalbe allocations and are used normally for file pages
> > > or anonymous pages.
> > > 
> > > In reclaim path so many cma pages if configurated are reclaimed
> > > from lru lists in kswapd mainly or direct reclaim triggered by
> > > unmovable or reclaimable allocations. But these cma pages can not
> > > be used by original unmovable or reclaimable allocations. So the
> > > reclaim are unnecessary.
> > > 
> > > In a same system if the cma pages were configurated to large then
> > > more failture unmovable (vmalloc etc.) or reclaimable (slab etc.)
> > > allocations are arised and then more kswapd rounds are triggered
> > > and then more cma pages are reclaimed.
> > Could you be more specific? Do you have any numbers and an example
> > configuration when this is visible?
> It should be implicit.

Right but the scale of the problem is an important part of _any_ patch
justification.
-- 
Michal Hocko
SUSE Labs
