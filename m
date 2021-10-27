Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9874E43C934
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241748AbhJ0MI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhJ0MIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:08:25 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B66C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:06:00 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y10so2116121qkp.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoE64TdDHE/gTi4i1OPzPbdXPkSP+qVI54kwUIQ+eMk=;
        b=IL0EkEfTynBQCNxlnvNvzTzem+gKVqgjCVzXu6qnPdM6ZilL8MkGt4o4Ddpv7trMUc
         7ZhV1rgfVCaEBB/5+qfyGBTO9WtyfLu+qE2oHhSfi035eexUaoGgs20Ixveg9dENzZiH
         dx8ziwaUOl437AW0D+yLzqZL7iEEfJT4JbQEeMJmW3XuMOCKuJOksag2Uj5pH/nThtLy
         LR2IpXLI29hR+NZIOIJyOw5C+nH3L1e9QehG2CgerWvmKUmn2CanVHKyHvaq/ppvzB8Q
         sJq5aEjEuwSoAeMxleegWgF5aC1Lgs/h56TgGX8rMI+haT5XglBr9Jbi07SCygJN0W6+
         1cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoE64TdDHE/gTi4i1OPzPbdXPkSP+qVI54kwUIQ+eMk=;
        b=0zxUgfAjUcois5FeaV5Lb7o2pdseKqPIVrBIx/2um2LHXVTyRbGd7oQW625twzQ1Nr
         Fn6jM+4fi2WARYhrui8ocuGnMAPrcIZNdJIMeB3MkYLdB/HISIM+NAdYIJTYlWbPmazc
         DltegjYxP/p7Oz1yZ7uiM1hefiWBMxzu9gfxG+ze5Mg5FKBnN5sCdE5LcTfIrpWp2NH2
         x3dzT8hEgtqfu/GGbnN4UXtCTmxjkyKcqZ7Nir7jes1DydSTC6Hle2zRYvl8JBlBQRuE
         Y1tkYXdkdAwha8EdtXj9co1VxvtfXLZsCjo8eutHBwXlmBDrxlZWKrFS1m66l1L/wGoO
         O2lg==
X-Gm-Message-State: AOAM530lg6we31EJeBJAbZR2hkh19OKBMNZ7JVKncdGAHGYsO8XcVltG
        huLZgpcvVWfrC0NmU4rnKCs2n689tBI4axhY1to=
X-Google-Smtp-Source: ABdhPJyhqfwnEgb39Ng1knA6fOpJFQOuh8egGkFLxlZkWZXZUn+IfcHlyFrRUSJ0dOT/K19Gv+5XOteNZnsroLbUHy4=
X-Received: by 2002:a37:8e44:: with SMTP id q65mr23327968qkd.372.1635336351853;
 Wed, 27 Oct 2021 05:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com>
 <YXj9w+8Bwlkz5PRy@dhcp22.suse.cz> <CAGWkznHVHVBrQEiO32p2uX_5BDUMc1fE64KuV34WJfpwC_23Pw@mail.gmail.com>
 <YXkNJjD4axYlmqQ5@dhcp22.suse.cz> <CAGWkznHrZ=Y3kG5j5aYdTV2294QGrQbM6251zcdGphzCGUP6dw@mail.gmail.com>
 <YXk9a3X62vNTyvGE@dhcp22.suse.cz>
In-Reply-To: <YXk9a3X62vNTyvGE@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 27 Oct 2021 20:05:30 +0800
Message-ID: <CAGWkznEZhPxgb_K2vcfyhnGufPMaX3ksxbJvQSurwkNtLKRTGg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: have kswapd only reclaiming use min protection on memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 7:52 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 27-10-21 17:19:56, Zhaoyang Huang wrote:
> > On Wed, Oct 27, 2021 at 4:26 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 27-10-21 15:46:19, Zhaoyang Huang wrote:
> > > > On Wed, Oct 27, 2021 at 3:20 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Wed 27-10-21 15:01:50, Huangzhaoyang wrote:
> > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > >
> > > > > > For the kswapd only reclaiming, there is no chance to try again on
> > > > > > this group while direct reclaim has. fix it by judging gfp flag.
> > > > >
> > > > > There is no problem description (same as in your last submissions. Have
> > > > > you looked at the patch submission documentation as recommended
> > > > > previously?).
> > > > >
> > > > > Also this patch doesn't make any sense. Both direct reclaim and kswapd
> > > > > use a gfp mask which contains __GFP_DIRECT_RECLAIM (see balance_pgdat
> > > > > for the kswapd part)..
> > > > ok, but how does the reclaiming try with memcg's min protection on the
> > > > alloc without __GFP_DIRECT_RECLAIM?
> > >
> > > I do not follow. There is no need to protect memcg if the allocation
> > > request doesn't have __GFP_DIRECT_RECLAIM because that would fail the
> > > charge if a hard limit is reached, see try_charge_memcg and
> > > gfpflags_allow_blocking check.
> > >
> > > Background reclaim, on the other hand never breaches reclaim protection.
> > >
> > > What is the actual problem you want to solve?
> > Imagine there is an allocation with gfp_mask & ~GFP_DIRECT_RECLAIM and
> > all processes are under cgroups. Kswapd is the only hope here which
> > however has a low efficiency of get_scan_count. I would like to have
> > kswapd work as direct reclaim in 2nd round which will have
> > protection=memory.min.
>
> Do you have an example where this would be a practical problem? Atomic
> allocations should be rather rare.
Please find below for the search result of '~__GFP_DIRECT_RECLAIM'
which shows some drivers and net prefer to behave like that.
Furthermore, the allocations are always together with high order.

block/bio.c:464: gfp_mask &= ~__GFP_DIRECT_RECLAIM;
drivers/vhost/net.c:668: pfrag->page = alloc_pages((gfp &
~__GFP_DIRECT_RECLAIM) |
drivers/net/ethernet/mellanox/mlx4/icm.c:184: mask &= ~__GFP_DIRECT_RECLAIM;
fs/erofs/zdata.c:243: gfp_t gfp = (mapping_gfp_mask(mc) &
~__GFP_DIRECT_RECLAIM) |
fs/fscache/page.c:138: gfp &= ~__GFP_DIRECT_RECLAIM;
fs/fscache/cookie.c:187: INIT_RADIX_TREE(&cookie->stores, GFP_NOFS &
~__GFP_DIRECT_RECLAIM);
fs/btrfs/disk-io.c:2928: INIT_RADIX_TREE(&fs_info->reada_tree,
GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
fs/btrfs/volumes.c:6868: INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS &
~__GFP_DIRECT_RECLAIM);
fs/btrfs/volumes.c:6869: INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS
& ~__GFP_DIRECT_RECLAIM);
kernel/cgroup/cgroup.c:325: ret = idr_alloc(idr, ptr, start, end,
gfp_mask & ~__GFP_DIRECT_RECLAIM);
mm/mempool.c:389: gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
mm/hugetlb.c:2165: gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
mm/mempolicy.c:2061: preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
mm/memcontrol.c:5452: ret = try_charge(mc.to, GFP_KERNEL &
~__GFP_DIRECT_RECLAIM, count);
net/core/sock.c:2623: pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
net/core/skbuff.c:6084: page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
net/netlink/af_netlink.c:1302: (allocation & ~__GFP_DIRECT_RECLAIM) |
net/netlink/af_netlink.c:2259: (GFP_KERNEL & ~__GFP_DIRECT_RECLAIM) |

>
> --
> Michal Hocko
> SUSE Labs
