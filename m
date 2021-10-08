Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC6426A4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbhJHL5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:57:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54210 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbhJHL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:57:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2C0DC21987;
        Fri,  8 Oct 2021 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633694127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZQJ68UJF1UZJy1bavpd29rgK/K1ZJathwtfYweveOqM=;
        b=Z6t2/6psmMNzgiKhQKcUfE8OReafFdlssMrUFTy5W23oQMGG/J33ny0iJvBefQVz/tVk8I
        RYmoWZ+8M2Aiz0kyave7HeKVnHAdjhfR/0U0uxXq6VPhZnCsYnvZ1OhkJqARe8Bql7cA4S
        ID5vNM8Qhzta/3XrAzC8capcBahVN8k=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 106DEA3B84;
        Fri,  8 Oct 2021 11:55:26 +0000 (UTC)
Date:   Fri, 8 Oct 2021 13:55:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Support hugetlb charge moving at task migration
Message-ID: <YWAxqxvXBvjZrWsO@dhcp22.suse.cz>
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
 <YVWVk559nm2xZ98R@dhcp22.suse.cz>
 <e52a85c4-e4b4-b91a-b5b4-4da6c44c5959@linux.alibaba.com>
 <YV/vUIzx6RBPZJ1I@dhcp22.suse.cz>
 <d20cbaa5-d510-2039-4a3c-1f1cc8acd2d1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20cbaa5-d510-2039-4a3c-1f1cc8acd2d1@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-10-21 17:17:12, Baolin Wang wrote:
> 
> 
> On 2021/10/8 15:12, Michal Hocko wrote:
> > On Thu 07-10-21 23:39:15, Baolin Wang wrote:
> > > Hi Michal,
> > > 
> > > (Sorry for late reply due to my holidays)
> > > On 2021/9/30 18:46, Michal Hocko wrote:
> > > > On Wed 29-09-21 18:19:26, Baolin Wang wrote:
> > > > > Hi,
> > > > > 
> > > > > Now in the hugetlb cgroup, charges associated with a task aren't moved
> > > > > to the new hugetlb cgroup at task migration, which is odd for hugetlb
> > > > > cgroup usage.
> > > > 
> > > > Could you elaborate some more about the usecase and/or problems you see
> > > > with the existing semantic?
> > > 
> > > The problems is that, it did not check if the tasks can move to the new
> > > hugetlb cgroup if the new hugetlb cgroup has a limitation, and the hugetlb
> > > cgroup usage is incorrect when moving tasks among hugetlb cgroups.
> > 
> > Could you be more specific please? What do you mean by cgroup usage is
> > incorrect? Ideally could you describe your usecase?
> 
> Sorry for confusing, what I mean is, when tasks from one hugetlb cgroup are
> migrated to a new hugetlb cgroup, the new hugetlb cgroup's hugetlb page
> usage is not increased accordingly.

Which is a perferctly reasonable behavior as the memory has been
consumed from the original cgroup and it will be freed there as well.
Migrating to a new cgroup doesn't imply all the resources to be migrated
as well.

> The issue I found is just from my
> testing for the hugetlb cgroup, and I think this is not resonable if we've
> already set a hugetlb limitation for a cgroup, but we always ignore it when
> tasks migration among hugetlb cgroups.

I would like to learn more about why you consider this unreasonable.
This will likely depend on the reason why you want/need to migrate task.
If you want to move a task to completely new resource domain (read a
completely different cgroup subtree) then I can imagine you want to
leave all the resources but this will have problems with other resource
controllers - e.g. memory cgroup v2 which doesn't allow charge migration
either.
-- 
Michal Hocko
SUSE Labs
