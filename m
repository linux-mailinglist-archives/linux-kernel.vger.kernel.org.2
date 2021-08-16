Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69CB3EDF68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhHPVkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhHPVky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:40:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E31C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:40:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id bu14so7179620qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bkCxSCHWMZ7ifVAWn9uE3NNPnVIWsd+yoguxxgSyT/E=;
        b=u9xM2180d8bEqgcdH0G2Xr+fDBmIT7hGm3KseFJJnnrFClI3gzRsnk0fHeUzP4sN3D
         qwBxpkaoqzewGlVA8yzwRz9J0tu73Gkpg7YG/KGC66C8vD8FPHuzFLZ9qIiT4ZvGSoCA
         JETZ+RieSp6YzUXkgW4pO9VzXo8OoZJkYVaswkSb5Tr8rK/HyoTiNjPvodajYYUBj828
         ZYLfdWYgOsUcRrNOvb1w/H1cvWXyScg2uTnCFPr2ZunCmWBEzZd9sFxgYwS37BEqc3+d
         vOzlbNJdXUNNFYe7D25YrYzcEsPYVN+oih0m+4A/6Rq/YrgF3WEW9zG/Kl3/Z1/SisO3
         8wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bkCxSCHWMZ7ifVAWn9uE3NNPnVIWsd+yoguxxgSyT/E=;
        b=A8y4P8o+4zY/9XNnrlekbeYctiFyaAQhDL5pkAMz1HWq9DXXesNTrT4zlxW+/n9039
         oY7jGLTeRgyO6YzXKHTBqTsMZpdE0NrT2jNqo4NuA/82nUdrIQy6E/4Hls1A0FRd0aiy
         dI6+hbnbb0rP1Tn9kJ315rsBcbtq7hNECxxlkrKSKidH46+o3g7F/xzAS0pOqo+m5fpL
         pVfz7S+BwNtUEmnkvDHFt/B+gxmjo0wjWE5onrb42kxvLZ999zQzyocb833PIHTwZZs5
         iZwuCVHDNw4hCMsgOB4ncCXzpcyz6700alvJuvFO08P0uMoz0NSsFGb+H+2SbEmmdDa/
         qY0w==
X-Gm-Message-State: AOAM53102/b02bmm8Xgm1XC8CVENyzno5h/+yrzR5DJYoKLbNXjm3HN+
        XNGY8OpSGp82QRdvj2ydqLgNnw==
X-Google-Smtp-Source: ABdhPJzLawvDQJ+cO7x4VrTkNWchJxTEALcGBSnmBvzEXpnYcZaDInUkbWdziD+TWA1j5iLVjj+OQg==
X-Received: by 2002:a05:6214:500b:: with SMTP id jo11mr188804qvb.52.1629150021171;
        Mon, 16 Aug 2021 14:40:21 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id k21sm69138qkh.110.2021.08.16.14.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 14:40:20 -0700 (PDT)
Date:   Mon, 16 Aug 2021 17:41:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Koutn?? <mkoutny@suse.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
Message-ID: <YRrbpRsvdDoom9iG@cmpxchg.org>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com>
 <20210816032855.GB72770@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210816032855.GB72770@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 11:28:55AM +0800, Feng Tang wrote:
> On Thu, Aug 12, 2021 at 11:19:10AM +0800, Feng Tang wrote:
> > On Tue, Aug 10, 2021 at 07:59:53PM -1000, Linus Torvalds wrote:
> [SNIP]
> 
> > And seems there is some cache false sharing when accessing mem_cgroup
> > member: 'struct cgroup_subsys_state', from the offset (0x0 and 0x10 here)
> > and the calling sites, the cache false sharing could happen between:
> > 
> >     cgroup_rstat_updated (read memcg->css.cgroup, offset 0x0)
> > and 
> >     get_mem_cgroup_from_mm
> > 	css_tryget(&memcg->css) (read/write memcg->css.refcnt, offset 0x10)
> > 
> > (This could be wrong as many of the functions are inlined, and the
> > exact calling site isn't shown)

Thanks for digging more into this.

The offset 0x0 access is new in the page instantiation path with the
bisected patch, so that part makes sense. The new sequence is this:

	shmem_add_to_page_cache()
	  mem_cgroup_charge()
	    get_mem_cgroup_from_mm()
	      css_tryget()			# touches memcg->css.refcnt
	  xas_store()
	  __mod_lruvec_page_state()
	    __mod_lruvec_state()
	      __mod_memcg_lruvec_state()
	        __mod_memcg_state()
	          __this_cpu_add()
	          cgroup_rstat_updated()	# touches memcg->css.cgroup

whereas before, __mod_memcg_state() would just do stuff inside memcg.

However, css.refcnt is a percpu-refcount. We should see a read-only
lookup of the base pointer inside this cacheline, with the write
occuring in percpu memory elsewhere. Even if it were in atomic/shared
mode, which it shouldn't be for the root cgroup, the shared atomic_t
is also located in an auxiliary allocation and shouldn't overlap with
the cgroup pointer in any way.

The css itself is embedded inside struct mem_cgroup, which does see
modifications. But the closest of those is 3 cachelines down (struct
page_counter memory), so that doesn't make sense, either.

Does this theory require writes? Because I don't actually see any (hot
ones, anyway) inside struct cgroup_subsys_state for this workload.

> > And to verify this, we did a test by adding padding between
> > memcg->css.cgroup and memcg->css.refcnt to push them into 2
> > different cache lines, and the performance are partly restored:
> > 
> > dc26532aed0ab25c 2d146aa3aa842d7f5065802556b 73371bf27a8a8ea68df2fbf456b 
> > ---------------- --------------------------- --------------------------- 
> >   65523232 ±  4%     -40.8%   38817332 ±  5%     -19.6%   52701654 ±  3%  vm-scalability.throughput
> >
> > We are still checking more, and will update if there is new data. 
> 
> Seems this is the second case to hit 'adjacent cacheline prefetch",
> the first time we saw it is also related with mem_cgroup
> https://lore.kernel.org/lkml/20201125062445.GA51005@shbuild999.sh.intel.com/
> 
> In previous debug patch, the 'css.cgroup' and 'css.refcnt' is
> separated to 2 cache lines, which are still adjacent (2N and 2N+1)
> cachelines. And with more padding (add 128 bytes padding in between),
> the performance is restored, and even better (test run 3 times):
> 
> dc26532aed0ab25c 2d146aa3aa842d7f5065802556b 2e34d6daf5fbab0fb286dcdb3bc 
> ---------------- --------------------------- --------------------------- 
>   65523232 ±  4%     -40.8%   38817332 ±  5%     +23.4%   80862243 ±  3%  vm-scalability.throughput
> 
> The debug patch is:
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -142,6 +142,8 @@ struct cgroup_subsys_state {
>  	/* PI: the cgroup subsystem that this css is attached to */
>  	struct cgroup_subsys *ss;
>  
> +	unsigned long pad[16];
> +
>  	/* reference count - access via css_[try]get() and css_put() */
>  	struct percpu_ref refcnt;

We aren't particularly space-constrained in this structure, so padding
should generally be acceptable here.
