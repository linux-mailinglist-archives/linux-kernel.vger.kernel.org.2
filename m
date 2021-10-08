Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398F542650D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhJHHOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:14:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56402 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJHHOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:14:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ECFAC223D5;
        Fri,  8 Oct 2021 07:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633677136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9JkoUZpACyUfQpOqubca79HEaq3VBgN30ug9B5nuPpY=;
        b=NXd7i7CU+nz4qyVPFPKYz5t696OgTmGX9aCZsWZAX/9WpZQe3qtTbwkjr72JDLPBkxpVo1
        2sc8ArtAiEM6F8uMI5MwqrIiV6j78/xaxaR7ZR5p3/OJmkt32Ow6EItlWMsXamCrA8k90e
        cuwA9/KRcP6TNcmmp/2yggBTEet8rOA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CC92BA3B81;
        Fri,  8 Oct 2021 07:12:16 +0000 (UTC)
Date:   Fri, 8 Oct 2021 09:12:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Support hugetlb charge moving at task migration
Message-ID: <YV/vUIzx6RBPZJ1I@dhcp22.suse.cz>
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
 <YVWVk559nm2xZ98R@dhcp22.suse.cz>
 <e52a85c4-e4b4-b91a-b5b4-4da6c44c5959@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e52a85c4-e4b4-b91a-b5b4-4da6c44c5959@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-10-21 23:39:15, Baolin Wang wrote:
> Hi Michal,
> 
> (Sorry for late reply due to my holidays)
> On 2021/9/30 18:46, Michal Hocko wrote:
> > On Wed 29-09-21 18:19:26, Baolin Wang wrote:
> > > Hi,
> > > 
> > > Now in the hugetlb cgroup, charges associated with a task aren't moved
> > > to the new hugetlb cgroup at task migration, which is odd for hugetlb
> > > cgroup usage.
> > 
> > Could you elaborate some more about the usecase and/or problems you see
> > with the existing semantic?
> 
> The problems is that, it did not check if the tasks can move to the new
> hugetlb cgroup if the new hugetlb cgroup has a limitation, and the hugetlb
> cgroup usage is incorrect when moving tasks among hugetlb cgroups.

Could you be more specific please? What do you mean by cgroup usage is
incorrect? Ideally could you describe your usecase?
 
> > > This patch set adds hugetlb cgroup charge moving when
> > > migrate tasks among cgroups, which are based on the memcg charge moving.
> > 
> > Memcg charge moving has shown some problems over time and hence this is
> > not part of cgroup v2 interface anymore. Even for cgroup v1 this has
> 
> Sorry, I missed this part, could you elaborate on the issues? I can have a
> close look about the problems of memcg charge moving.

The operation is quite expensive. Synchronization with charging is not
trivial. I do not have the full list handy but you can search the
mm mailing list archives for more information.

> > been an opt-in. I do not see anything like that in this patch series.
> > Why should all existing workloads follow a different semantic during
> > task migration now?
> 
> But I think it is reasonable for some cases moving the old charging to the
> new cgroup when task migration. Maybe I can add a new hugetlb cgroup file to
> control if need this or not?

It would be good to describe those use cases and why they really need
this. Because as things stand now, the charge migration is not supported
in cgroup v2 for memory cgroup controller and there are no plans to add
the support so it would be quite unexpected that hugetlb controller
would behave differently. And cgroup v1 is considered legacy and new
features are ususally not added as there is a hope to move users to v2.
-- 
Michal Hocko
SUSE Labs
