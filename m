Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D26D32B718
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357271AbhCCKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhCBXum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:50:42 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DE2C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 15:49:53 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id i11so3750353ood.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 15:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lv6FaWR0xxSCDGyH4driuiSYrxR2/TJyfIIhajWZ/QA=;
        b=AfjGyv6gpXarIl2aQp61RhMDD9VQVVoH7Fu7cn6UODvNKLAjXOKLTCjc2xhgA9+Nwe
         G2AWHUwCFWQl3Wn98qYS2Xn7TH1saGna3cNOiC5M8rmMrNi1rrhNl8cWnyFVlbztFQH5
         HGQhyb1SgeyYR0cW8IZeoo1SJgXddLj8Z6VMWG4Ak7vuJyG0xxaIeBGBNbT+RFXDUWcL
         FuvGmMMn5tgT7gCEbHT4MZTJz3oYzm73mdkHCoh0QHmVFhGTSF+N8ExeSlNCqnYbHMWA
         UHABAQwQrxF7t4eNIcfpjaYhkvkPynXE6CDCS9yRdP2cpSubAVHesGcwSzVEcVj2YSP9
         eqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lv6FaWR0xxSCDGyH4driuiSYrxR2/TJyfIIhajWZ/QA=;
        b=s3T9Bb8vdUmb5kQV3j9yQRNiIXwnQxfdEz5Ab51rP6qsV9jG40JqxRQzXdGprseapL
         85NselckT45UrIGeultjSAzmoah0zCbB6F3e3itS20NGTVBzEVduaWNuAJuvt+nrNmgB
         wxMs4D+IsUtHuisOIU4FPACDqGbwWMRBFC5kPFZqGxIeEj7ljOBeMe5M2y4YNFEKAYUF
         GBbKLPHqglm5/KqRmRdSwgvNJCUQWkHU9bWEYcuDCkanUlPKGLwokoNOkv2/MTLuM64e
         qIMDsXda25uWme4hNSmzDtlGG4oTn6RNL+jfzoHPe+XE+uYeMtNbbrnUpxVGDZFVvcOH
         TmMw==
X-Gm-Message-State: AOAM530YMHNk5x/QvtJoOkx1J6Sj+CEV2kgg2qG+Z0N8z7LrjWWrB7CY
        2v8NBpFJkfBKNGOZCvTGc/cekg==
X-Google-Smtp-Source: ABdhPJzTPGgq+/iqKzkaNKTT6UDe8+wq5IRQKulhhPg0F6EYqfuvTFBxC2W7Tsao2zbmQAC7KhCxow==
X-Received: by 2002:a4a:9b8e:: with SMTP id x14mr18791863ooj.67.1614728992312;
        Tue, 02 Mar 2021 15:49:52 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q4sm4650731otf.67.2021.03.02.15.49.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 02 Mar 2021 15:49:51 -0800 (PST)
Date:   Tue, 2 Mar 2021 15:49:38 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com, Nicholas Piggin <npiggin@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
In-Reply-To: <YD7Ch/8QebzmneCR@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2103021547330.9320@eggly.anvils>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com> <YD4CciUX0/eXFLM0@dhcp22.suse.cz> <alpine.LSU.2.11.2103021157160.8450@eggly.anvils> <YD7Ch/8QebzmneCR@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021, Johannes Weiner wrote:
> On Tue, Mar 02, 2021 at 12:24:41PM -0800, Hugh Dickins wrote:
> > On Tue, 2 Mar 2021, Michal Hocko wrote:
> > > [Cc Johannes for awareness and fixup Nick's email]
> > > 
> > > On Tue 02-03-21 01:34:51, Zhou Guanghui wrote:
> > > > When split page, the memory cgroup info recorded in first page is
> > > > not copied to tail pages. In this case, when the tail pages are
> > > > freed, the uncharge operation is not performed. As a result, the
> > > > usage of this memcg keeps increasing, and the OOM may occur.
> > > > 
> > > > So, the copying of first page's memory cgroup info to tail pages
> > > > is needed when split page.
> > > 
> > > I was not aware that alloc_pages_exact is used for accounted allocations
> > > but git grep told me otherwise so this is not a theoretical one. Both
> > > users (arm64 and s390 kvm) are quite recent AFAICS. split_page is also
> > > used in dma allocator but I got lost in indirection so I have no idea
> > > whether there are any users there.
> > 
> > Yes, it's a bit worrying that such a low-level thing as split_page()
> > can now get caught up in memcg accounting, but I suppose that's okay.
> > 
> > I feel rather strongly that whichever way it is done, THP splitting
> > and split_page() should use the same interface to memcg.
> > 
> > And a look at mem_cgroup_split_huge_fixup() suggests that nowadays
> > there need to be css_get()s too - or better, a css_get_many().
> > 
> > Its #ifdef CONFIG_TRANSPARENT_HUGEPAGE should be removed, rename
> > it mem_cgroup_split_page_fixup(), and take order from caller.
> 
> +1
> 
> There is already a split_page_owner() in both these places as well
> which does a similar thing. Mabye we can match that by calling it
> split_page_memcg() and having it take a nr of pages?

Agreed on both counts :) "fixup" was not an inspiring name.

> 
> > Though I've never much liked that separate pass: would it be
> > better page by page, like this copy_page_memcg() does?  Though
> > mem_cgroup_disabled() and css_getting make that less appealing.
> 
> Agreed on both counts. mem_cgroup_disabled() is a jump label and would
> be okay, IMO, but the refcounting - though it is (usually) per-cpu -
> adds at least two branches and rcu read locking.
