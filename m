Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6BA354DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbhDFHWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:22:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240089AbhDFHWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:22:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617693712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NaYy0uWjn0czkuwfMwjR10jkixk+b1OEP4FSJKarE1w=;
        b=MNy/qD2vSam5wmc2g3CJoNcqtIq/nerZnfEURI68VwMgPi6w4o27wdnsCAoQ44FdWE88T1
        CF9XZmIsDWftPUnopfkSfL7lMD5yVmfZBkEU6qX89FYNVuPnkxHC3V9h3djqING0Xh7orQ
        m9Bmqn4lFIn4wF7A2HzHXr/P0nDzP+8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6AAFB090;
        Tue,  6 Apr 2021 07:21:52 +0000 (UTC)
Date:   Tue, 6 Apr 2021 09:21:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Neil Sun <neilsun@yunify.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: drop_slab_node with task's memcg
Message-ID: <YGwMD3DOymOFJ7O5@dhcp22.suse.cz>
References: <1617359934-7812-1-git-send-email-neilsun@yunify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617359934-7812-1-git-send-email-neilsun@yunify.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-04-21 18:38:54, Neil Sun wrote:
> This patch makes shrink_slab() with task's memcg in drop_slab_node(),
> so we can free reclaimable slab objects belongs to memcg /lxc/i-vbe1u8o7
> with following command:

You are changing semantic of the existing user interface. This knob has
never been memcg aware and it is supposed to have a global impact. I do
not think we can simply change that without some users being surprised
or even breaking them.

> cgexec -g memory:/lxc/i-vbe1u8o7 sysctl vm.drop_caches=2
> 
> Test with following steps:
> 
> root@i-yl0pwrt8:~# free -h
>               total        used        free      shared  buff/cache   available
> Mem:           62Gi       265Mi        62Gi       1.0Mi       290Mi        61Gi
> Swap:          31Gi          0B        31Gi
> root@i-yl0pwrt8:~# (cd /tmp && /root/generate_slab_cache)
> root@i-yl0pwrt8:~# free -h
>               total        used        free      shared  buff/cache   available
> Mem:           62Gi       266Mi        60Gi       1.0Mi       2.2Gi        61Gi
> Swap:          31Gi          0B        31Gi
> root@i-yl0pwrt8:~# cgcreate -g memory:/lxc/i-vbe1u8o7
> root@i-yl0pwrt8:~# cgexec -g memory:/lxc/i-vbe1u8o7 /root/generate_slab_cache
> root@i-yl0pwrt8:~# free -h
>               total        used        free      shared  buff/cache   available
> Mem:           62Gi       267Mi        58Gi       1.0Mi       4.1Gi        61Gi
> Swap:          31Gi          0B        31Gi
> root@i-yl0pwrt8:~# cgexec -g memory:/lxc/i-vbe1u8o7 sysctl vm.drop_caches=2
> vm.drop_caches = 2
> root@i-yl0pwrt8:~# free -h
>               total        used        free      shared  buff/cache   available
> Mem:           62Gi       268Mi        60Gi       1.0Mi       2.2Gi        61Gi
> Swap:          31Gi          0B        31Gi
> root@i-yl0pwrt8:~# sysctl vm.drop_caches=2
> vm.drop_caches = 2
> root@i-yl0pwrt8:~# free -h
>               total        used        free      shared  buff/cache   available
> Mem:           62Gi       267Mi        62Gi       1.0Mi       290Mi        61Gi
> Swap:          31Gi          0B        31Gi
> 
> Signed-off-by: Neil Sun <neilsun@yunify.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 562e87cb..81d770a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -702,7 +702,7 @@ void drop_slab_node(int nid)
>  			return;
>  
>  		freed = 0;
> -		memcg = mem_cgroup_iter(NULL, NULL, NULL);
> +		memcg = mem_cgroup_from_task(current);
>  		do {
>  			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
>  		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
