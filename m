Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB5361032
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDOQbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:31:18 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38273C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:30:55 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x11so25758444qkp.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLlUIJ56vn2FytCBhcVr6jOxxhXwMhN3GRBRjO1H938=;
        b=fJ+aTApDvICnAaOoe1KfP5BBtl0Rh1YFuKCLL5fGye5h6BA0p3BoOr8tTI9XEesNsV
         Fp/CKLarivIoqyF5ZKVGf5AMSoeIOp66zzfcxUNrTzVNyrnUoSr9VH4mZpxedYlhvA1o
         SquyxUpSwHzg2Em16wV4jROqCqmxsoDLVVWWoepjSmIPOmXFHqjO70eGS6cNXVP0JtWO
         MFs47w22p+QY7XIGIz617jBPaokG4aLVhDxox4ykRQYSCt58SfNDJS+PEpYO1zmYnY36
         mf1OqSf/833V1NxqpSMwUK8l82gxWSAStXHi1qBk/jSGj3U4MNmM5xnMJzjm1/XGyyKr
         OQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLlUIJ56vn2FytCBhcVr6jOxxhXwMhN3GRBRjO1H938=;
        b=TifbNrmJivHRx0QtMLI9sp/KUZbX43UZiTECksXdsiHV6DqgAS6CK6imNh75uoORDb
         Mn3IYZyVpiRMFVeChe35JU+iwPohWtSyhkx3WkRiLbuN5/oER9N+feUgs/tXRq3KBFHZ
         HjIe2aW5WaDtudlHg6+G9IDUV6Zn4ltV6Omd9sjBbTocwGa0FOpTWMyObFrhy1qF4wBt
         Yfx7lghPBFvkkzvu/xlNo9bhyS8EShOVeCHKv5kNqmE07Jb5cPGJaO+aWNgKCgzWuf8X
         YBc2K6yRmJDmYEJJkhkgjWpaGCmtpFweTYGnt/jUVIj0MFh4p2O3OgqOiSg7VEh5SNmW
         fSVA==
X-Gm-Message-State: AOAM533niJQhG21QG4lnqMyxKuFDLtZNKZ9af1ZsgJil/LMgkcbQhk3X
        rjMescuMp1y7Weumgq2tZyQCP2z2uyqgKQ==
X-Google-Smtp-Source: ABdhPJxMzkOoK6xcP8+cj7pzrX9sBiOxKb/AGdZZ5o26GJsZBEwYbb6mn2mCUVuHnuuatjx7/2RBoA==
X-Received: by 2002:a37:b704:: with SMTP id h4mr4378052qkf.177.1618504254457;
        Thu, 15 Apr 2021 09:30:54 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h23sm2064825qtr.21.2021.04.15.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:30:53 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:30:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 2/5] mm/memcg: Introduce
 obj_cgroup_uncharge_mod_state()
Message-ID: <YHhqPYcajI9JgXk/@cmpxchg.org>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-3-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:24PM -0400, Waiman Long wrote:
> In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
> is followed by mod_objcg_state()/mod_memcg_state(). Each of these
> function call goes through a separate irq_save/irq_restore cycle. That
> is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
> that combines them with a single irq_save/irq_restore cycle.
>
> @@ -3292,6 +3296,25 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>  	refill_obj_stock(objcg, size);
>  }
>  
> +void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
> +				   struct pglist_data *pgdat, int idx)

The optimization makes sense.

But please don't combine independent operations like this into a
single function. It makes for an unclear parameter list, it's a pain
in the behind to change the constituent operations later on, and it
has a habit of attracting more random bools over time. E.g. what if
the caller already has irqs disabled? What if it KNOWS that irqs are
enabled and it could use local_irq_disable() instead of save?

Just provide an __obj_cgroup_uncharge() that assumes irqs are
disabled, combine with the existing __mod_memcg_lruvec_state(), and
bubble the irq handling up to those callsites which know better.
