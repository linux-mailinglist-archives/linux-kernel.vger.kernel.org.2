Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F433556C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243275AbhDFOjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:39:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:56334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239220AbhDFOjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:39:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617719971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gS9jCgSahAIGFQk7iYdYYP7eMAC4KzLikaNfz8sceyk=;
        b=HBxD5VgCgiTqyzWzCDWj1rPP7yrKtwwI3GctubUobBynv2nNUwptN5/9RFIpobMSSrU+g+
        or+snQX5xw7HcGmRtKNLWSXHvrFmEIFHaVUoRP63AVWV++ewuzzPlcdCtYobRi1mEe8izp
        OkTIMwlXiMls62hoD9Nu7aIUwqGCbC0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24DE9B1C3;
        Tue,  6 Apr 2021 14:39:31 +0000 (UTC)
Date:   Tue, 6 Apr 2021 16:39:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Neil Sun <neilsun@yunify.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: drop_slab_node with task's memcg
Message-ID: <YGxyojApNhi5DjFc@dhcp22.suse.cz>
References: <1617359934-7812-1-git-send-email-neilsun@yunify.com>
 <YGwMD3DOymOFJ7O5@dhcp22.suse.cz>
 <4dba277d-e497-5c34-0e68-fd2283585de2@yunify.com>
 <YGxIVDXw7wtBytIg@dhcp22.suse.cz>
 <d21f3b10-0c39-211f-dc45-e81c8da5dd9d@yunify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21f3b10-0c39-211f-dc45-e81c8da5dd9d@yunify.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-04-21 22:34:02, Neil Sun wrote:
> 
> 
> On 2021/4/6 19:39, Michal Hocko wrote:
> > On Tue 06-04-21 19:30:22, Neil Sun wrote:
> > > On 2021/4/6 15:21, Michal Hocko wrote:
> > > > 
> > > > You are changing semantic of the existing user interface. This knob has
> > > > never been memcg aware and it is supposed to have a global impact. I do
> > > > not think we can simply change that without some users being surprised
> > > > or even breaking them.
> > > 
> > > Yes, do you think add new interface to sysfs is a good way? such as
> > > /sys/fs/cgroup/memory/lxc/i-vbe1u8o7/memory.kmem.drop_caches
> > 
> > There were other attempts to add a memcg specific alternative to
> > drop_caches. A lack of a strong usecase has been a reason that no such
> > attempt has been merged until now. drop_caches is a problematic
> > interface because it is really coarse and people have learned to (ab)use
> > it to workaround problem rather than fix them properly.
> > 
> > What is your usecase?
> > 
> 
> We have some lxc containers running on the server, when mysqld running
> backup jobs in the container, page cache will grow up and eat up all unused
> memory in the container, then some new jobs come, we can see that tasks are
> busy on allocing memory with reclaiming, so we want to drop page cache after
> mysql backup job for individual container, it will speed up allocing memory
> when new jobs come.
> 
> This patch only drop slab cache but not page cache, this can be the
> first step if people really need this interface.

Have you considered using high limit for the pro-active memory reclaim?
It really seems odd to drop a certain category of memory without aging
information we already do have. I do understand the start time overhead
concern but it seems to be a much better approach to drop old objects
rather than hammer a very specific type of memory.
-- 
Michal Hocko
SUSE Labs
