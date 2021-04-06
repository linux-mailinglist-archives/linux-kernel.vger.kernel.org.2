Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E312C355276
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243208AbhDFLjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:39:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242018AbhDFLjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:39:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617709141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YW0n/W3dPLfWTBXzJ8PJ0h6vYshGydcVQrV/PiOxuQ=;
        b=RJauROFiVBGV5bknbZbs+Q1gjmqpP0ViVeKyVvWq/asdxT65nzdVEUQDAGBhg52lcZmhWk
        iJr15TDRFaRtw5fpDqY6aIktpbDmw4H3LaYtzE9iIAY0riB/IuYqNGoNSxvvPy+M+42whi
        iJH9W8tDZ0EoJ8TEPDTpIymOwI94uRw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D63B4B154;
        Tue,  6 Apr 2021 11:39:00 +0000 (UTC)
Date:   Tue, 6 Apr 2021 13:39:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Neil Sun <neilsun@yunify.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: drop_slab_node with task's memcg
Message-ID: <YGxIVDXw7wtBytIg@dhcp22.suse.cz>
References: <1617359934-7812-1-git-send-email-neilsun@yunify.com>
 <YGwMD3DOymOFJ7O5@dhcp22.suse.cz>
 <4dba277d-e497-5c34-0e68-fd2283585de2@yunify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dba277d-e497-5c34-0e68-fd2283585de2@yunify.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-04-21 19:30:22, Neil Sun wrote:
> On 2021/4/6 15:21, Michal Hocko wrote:
> > 
> > You are changing semantic of the existing user interface. This knob has
> > never been memcg aware and it is supposed to have a global impact. I do
> > not think we can simply change that without some users being surprised
> > or even breaking them.
> 
> Yes, do you think add new interface to sysfs is a good way? such as
> /sys/fs/cgroup/memory/lxc/i-vbe1u8o7/memory.kmem.drop_caches

There were other attempts to add a memcg specific alternative to
drop_caches. A lack of a strong usecase has been a reason that no such
attempt has been merged until now. drop_caches is a problematic
interface because it is really coarse and people have learned to (ab)use
it to workaround problem rather than fix them properly.

What is your usecase?
-- 
Michal Hocko
SUSE Labs
