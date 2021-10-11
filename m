Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09053428BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhJKLZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:25:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52492 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbhJKLZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:25:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 51AD31FE9C;
        Mon, 11 Oct 2021 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633951384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xw+IlCOw0VN11+4gbW0CcFkV8zMbAYmFEqOL5u+s6vo=;
        b=oek9t6K1RiKpfTX6tBopWgwd3n6/EwyBZJnKr6ToCyP5ri0SKHrqxbbaWEEwFJ3nrq+mOD
        NTkafHAmMEmGnugMTQVjryBJQWTNC4rlvnR1DdoZVTnpZ//kMXfRWGKaMmPmVeDMOOpVU4
        JbsCJY/PLvR9mf8eRghX1hU+TEswqwo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C86B3A3B83;
        Mon, 11 Oct 2021 11:23:03 +0000 (UTC)
Date:   Mon, 11 Oct 2021 13:23:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     ultrachin@163.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, brookxu.cn@gmail.com,
        chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit time
Message-ID: <YWQelNijZQ7PuYSa@dhcp22.suse.cz>
References: <20211008063933.331989-1-ultrachin@163.com>
 <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
 <YWQDqtnA5FXk7xan@dhcp22.suse.cz>
 <278a6cda-3095-5e27-e136-2765f73bc67d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278a6cda-3095-5e27-e136-2765f73bc67d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-10-21 11:40:12, David Hildenbrand wrote:
> On 11.10.21 11:28, Michal Hocko wrote:
> > On Fri 08-10-21 10:17:50, David Hildenbrand wrote:
> > > On 08.10.21 08:39, ultrachin@163.com wrote:
> > > > From: chen xiaoguang <xiaoggchen@tencent.com>
> > > > 
> > > > The exit time is long when program allocated big memory and
> > > > the most time consuming part is free memory which takes 99.9%
> > > > of the total exit time. By using async free we can save 25% of
> > > > exit time.
> > > > 
> > > > Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
> > > > Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
> > > > Signed-off-by: lu yihui <yihuilu@tencent.com>
> > > 
> > > I recently discussed with Claudio if it would be possible to tear down the
> > > process MM deferred, because for some use cases (secure/encrypted
> > > virtualization, very large mmaps) tearing down the page tables is already
> > > the much more expensive operation.
> > > 
> > > There is mmdrop_async(), and I wondered if one could reuse that concept when
> > > tearing down a process -- I didn't look into feasibility, however, so it's
> > > just some very rough idea.
> > 
> > This is not a new problem. Large process tear down can take ages. The
> > primary road block has been accounting. This lot of work has to be
> > accounted to the proper domain (e.g. cpu cgroup).
> 
> In general, yes. For some setups where admins don't care about that
> accounting (e.g., enabled via some magic toggle for large VMs), I guess this
> accounting isn't the major roadblock, correct?

Right, I would be careful about magic toggles though. Besides there are
ways to achive this in the userspace. We used to have a request to help
paralleling process exit from a DB vendor and Vlastimil has come up with
a clone(CLONE_VM) and madvise(DONT_NEED) from several threads as a
"workaround". This would work properly from the accounting POV.
Admittedly a bit of an involved approach though.
-- 
Michal Hocko
SUSE Labs
