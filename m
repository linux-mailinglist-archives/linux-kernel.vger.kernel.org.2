Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61521361096
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhDOQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhDOQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:58:19 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5607C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:57:55 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i11so6505350qvu.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8CoVbt6IzeLUC5q7IpdX1He4bycqg82PFofNsjY3nlo=;
        b=dz805Z+hx47wOwNMrHi3cTS4DU3UR/WoK/LOkLO4wjGFRvU0R2UR/LM1Jr5qmO+UfX
         Xj8eZgLigKlOmHDihOrF/lge4KjH4S1MbzQ1M0phjbomNKF4n6kf/MMrGg1Ou+v4T6oN
         hKy0W1m35ceAeVYDrHWoHULB41E5JJZzzI3D2kUw76zXNtQ3bamQFVNjksr5O8mNKpMf
         4W4khLTCWvVPTlyDZi5xBNYSSFRlRicGN+SQevM04Aa6pNLQ7jNhYYrcky177RipPj2F
         3TdlR6C9GSq2z9Q4NoV8m/FUwzOffvwttLpLK7cohfEQM759tvqvn+nzZANak8XsuIDd
         EQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8CoVbt6IzeLUC5q7IpdX1He4bycqg82PFofNsjY3nlo=;
        b=TCwrgJDc2+r55z0Qa5va9Nee+VB5++MW9L9dTJPOc2rIQEZnJ0JRlPBYGpkkqK7sTZ
         mesYnbp7NEJWPQW/VdkRMlEuUHI9NevFWyh9AVjBUCfMRAz8OSrwcErJlem6ptxpg/DK
         nq5OE22SlZMKcbNqYeaSxbJD6wankfMNmzgLnjA0I3w/HAbrta51y/kt1BGLXxW/Nj4r
         tK1NiYOl2TCHCrR2AjxbTNWB1RNMkWltD+x/U8d7jhGgwHQ/wRQDw9vMxlJqNpQX8EQ5
         TrQeSw+EL3MKKy77yxEQFE5IrA+6Izy9wF4I+bV9rPk2MBjtiIAdaU3ksAM6FJJTuxd2
         EvRQ==
X-Gm-Message-State: AOAM530N8Uu1XkpB5NMGkfSfjhiD3hsuryFcKZFnq4PJc10W8G+slz/r
        3Mn46pl3uBuI84l7UwQFwO5cOQ==
X-Google-Smtp-Source: ABdhPJwrkekqqLUelsmYQNbOIN/gwIAcnSZuH7n7IbRPMrei060BZIN2tzys9aDf7QbjTGMb0PIRKQ==
X-Received: by 2002:a05:6214:ca4:: with SMTP id s4mr4142968qvs.44.1618505874966;
        Thu, 15 Apr 2021 09:57:54 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id a202sm2402124qkc.13.2021.04.15.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:57:54 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:57:53 -0400
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
Subject: Re: [PATCH v3 4/5] mm/memcg: Separate out object stock data into its
 own struct
Message-ID: <YHhwkaas2PLfgtjj@cmpxchg.org>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-5-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:26PM -0400, Waiman Long wrote:
> The object stock data stored in struct memcg_stock_pcp are independent
> of the other page based data stored there. Separating them out into
> their own struct to highlight the independency.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)

It's almost twice more code, and IMO not any clearer. Plus it adds
some warts: int dummy[0], redundant naming in stock->obj.cached_objcg,
this_cpu_ptr() doesn't really need a wrapper etc.
