Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498CC326B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 02:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhB0Bcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 20:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhB0Bce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 20:32:34 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C28C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 17:31:54 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id n19so2612988ooj.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7/mS4JlhW7SeQffZJqsZzshwjd7P2X3tlrkAYmIL+wI=;
        b=aC08uKlZHTNs2CPHxzjC/fUCCCnh0DnACmBgKfTwnQWKsP13bg/Ux/c5smAnxatYjd
         YVgxutv5NXfmHDvo8VUeIa8hk76n/DbEiefDaH/xHVa/2gytf4In8gdjIBp20uV+kKUM
         Fg3ZCBAYmsyYlVYE8b2449cYjxZbZHQG4lKPdMuhFqD8JzoVviW+TNrNMg25LViceLy3
         miwJXGZ4gSAmP8W0CQUzyG8H3uj9Hbi8qynjg7IyDOagw1vt+pW8fmtrE+7R43QmrJhV
         UesR7zDi0FXTFI93FrfrtqdFsKqwNoL9KhSztPlxMjSOtTwJccp/Cx+YRmCJDxkQgdAs
         Xrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7/mS4JlhW7SeQffZJqsZzshwjd7P2X3tlrkAYmIL+wI=;
        b=VeqV+J22/LHtvUVZGyJVU3dHJ5X53KaeU4CdlnYjpS8hfCXRcmTJgyA4sepREFoTWm
         6BLa/TVDUT/tUZ0BR1TTwI5O0G0c9g1jWO1V5bXAMoXJuWb2EcscO6XTD0M2fUkhXSR5
         ujAp+v56MkBfiKgFBB5UgsEfQffQQhpyNIC5xYDal81GexcVkHvjiugaVOmwbiaMmfP+
         alnnmlAd7FETnCRCGrYB0daonB6itpmVEDdUtl8K7fOu1srmJ/kvQNOywAT85nULn0VG
         ZLQBKuIm0Rg7RLqmM3VLE1ce+SoTXbtF3AMKGnzff+dJbDESLv02csEKe97AHjIUEfA4
         xMLw==
X-Gm-Message-State: AOAM532d9Y7aeDQj/zCfaG6NZ9tI0rou2LgnkBSevdaQkXqffmMybtlP
        sSgjN8v84KdxGd16isFfGNWdog==
X-Google-Smtp-Source: ABdhPJyvhv/bKfUpc4n2LJZcAl+AtKZVYKLT9TvA2xpjnk/YwPdCP5dcHoK0dpVpt1hDiOCXn2blZA==
X-Received: by 2002:a4a:ab8d:: with SMTP id m13mr4484432oon.57.1614389513542;
        Fri, 26 Feb 2021 17:31:53 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 88sm2089884oto.3.2021.02.26.17.31.52
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 26 Feb 2021 17:31:53 -0800 (PST)
Date:   Fri, 26 Feb 2021 17:31:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Palmer Dabbelt <palmer@dabbelt.com>, atishp@atishpatra.org,
        peterz@infradead.org, srikar@linux.vnet.ibm.com,
        valentin.schneider@arm.com, vbabka@suse.cz, mpe@ellerman.id.au,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 1/2] mm: Guard a use of node_reclaim_distance with
 CONFIFG_NUMA
In-Reply-To: <20210226123716.6bc2a463e0ee9d1770c7966b@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2102261724370.15322@eggly.anvils>
References: <20210226201721.510177-1-palmer@dabbelt.com> <20210226123716.6bc2a463e0ee9d1770c7966b@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021, Andrew Morton wrote:
> On Fri, 26 Feb 2021 12:17:20 -0800 Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > From: Palmer Dabbelt <palmerdabbelt@google.com>
> > 
> > This is only useful under CONFIG_NUMA.  IIUC skipping the check is the
> > right thing to do here, as without CONFIG_NUMA there will never be any
> > large node distances on non-NUMA systems.
> > 
> > I expected this to manifest as a link failure under (!CONFIG_NUMA &&
> > CONFIG_TRANSPARENT_HUGE_PAGES), but I'm not actually seeing that.  I
> > think the reference is just getting pruned before it's checked, but I
> > didn't get that from reading the code so I'm worried I'm missing
> > something.
> > 
> > Either way, this is necessary to guard the definition of
> > node_reclaim_distance with CONFIG_NUMA.
> > 
> > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >  mm/khugepaged.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index a7d6cb912b05..b1bf191c3a54 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -819,8 +819,10 @@ static bool khugepaged_scan_abort(int nid)
> >  	for (i = 0; i < MAX_NUMNODES; i++) {
> >  		if (!khugepaged_node_load[i])
> >  			continue;
> > +#ifdef CONFIG_NUMA
> >  		if (node_distance(nid, i) > node_reclaim_distance)
> >  			return true;
> > +#endif
> >  	}
> >  	return false;
> >  }
> 
> This makes the entire loop a no-op.  Perhaps Kirill can help take a
> look at removing unnecessary code in khugepaged.c when CONFIG_NUMA=n?

First lines of khugepaged_scan_abort() say
	if (!node_reclaim_mode)
		return false;

And include/linux/swap.h says
#ifdef CONFIG_NUMA
extern int node_reclaim_mode;
extern int sysctl_min_unmapped_ratio;
extern int sysctl_min_slab_ratio;
#else
#define node_reclaim_mode 0
#endif

So, no need for an #ifdef CONFIG_NUMA inside khugepaged_scan_abort().

Hugh
