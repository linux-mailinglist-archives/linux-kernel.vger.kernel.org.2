Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8236B9F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhDZTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbhDZTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:24:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E96BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:24:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so8957898lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1+fehePF1LQa+ETT3QS1bc9x/S6CdwPnRCT51uHUm4=;
        b=Iap4Uo88x+wPaxUmMexmQyhYyjf2sL25rylbPddEu+U/hlOmwkIefEtnY9a0lTsa+d
         DUbgh7t+lOXHdq4VYz0VlwX3lCFYFB9Lm27pp+hlnNM+4iymjU+rWrmDC8hvTSBH4Wv2
         1CkyEz7xj5NMP4EM/vwkZawFtnVeCrcaL9+ByUY9j70Rdaig1pbM0LyMSpkkbYp1A5lL
         /mXaVwXO48K5isxqZhn8/7TsMvkeR+0Z9j4PvHF3GxA75g9scTENPeaggakn1ZRNx/nR
         0GyKQl7X5aA60jsuye9ISomU28l0tO06+F4UFDCPU2V4zz1wWjvJKdL91tRtAT+Rq/2l
         vsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1+fehePF1LQa+ETT3QS1bc9x/S6CdwPnRCT51uHUm4=;
        b=RnS9gh3MErJByLUg/0TbPiNDo3IzCLqHEyhLn+ZBhynIRKAJSJeVCdmhDvLnCFfj21
         SlbnMS6GFYlaYeCogA/ogeX3zBWX7hAfXkS3dDG1eVBjcTGGy420YN1I4Pm07gYaaObx
         gs5azVrIGwOylPkHxvUe58CwO8jeeMlT9L8QjRk6gj6LpSZHexbSIkVkOf6qa/moxJ+D
         Tq4FbQCI2DQauwRSen/TzHT+F/ZDRxcteZKsr3ngPtMO7v8JSkyn6MpGr4pKaQ1RX2N7
         kBdi4KPTqKh2bmu1dynRUFTuzsv4L/KJj22JwpwInMQ192hHr2tXn/RPYNnUVYNHIA7u
         bsGg==
X-Gm-Message-State: AOAM531jlkkKzlbp78RoBT9vxnKm2RKnv+JYBy435Sz/587koiwMvy0V
        m5qbrV8Y8yGFImweohSPKSeLduL6d4ag80ILT1yEsA==
X-Google-Smtp-Source: ABdhPJwJX5X5pWKlvL6trEZIBhuyZeAVdXfLQCF7xC4WYagqNL7GOVc6hyzsmKqZsbWi0D4AiImpjViPhwh2JFpcLIw=
X-Received: by 2002:a05:6512:2037:: with SMTP id s23mr13515499lfs.358.1619465053738;
 Mon, 26 Apr 2021 12:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210420192907.30880-1-longman@redhat.com> <20210420192907.30880-4-longman@redhat.com>
In-Reply-To: <20210420192907.30880-4-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Apr 2021 12:24:02 -0700
Message-ID: <CALvZod7_NtptXi=1QdfgyobL-bw72xGeZ9Sm3pn1pxtZ9crTow@mail.gmail.com>
Subject: Re: [PATCH-next v5 3/4] mm/memcg: Improve refill_obj_stock() performance
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 12:30 PM Waiman Long <longman@redhat.com> wrote:
>
> There are two issues with the current refill_obj_stock() code. First of
> all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
> atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
> and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
> be used again which leads to another call to drain_obj_stock() and
> obj_cgroup_get() as well as atomically retrieve the available byte from
> obj_cgroup. That is costly. Instead, we should just uncharge the excess
> pages, reduce the stock bytes and be done with it. The drain_obj_stock()
> function should only be called when obj_cgroup changes.
>
> Secondly, when charging an object of size not less than a page in
> obj_cgroup_charge(), it is possible that the remaining bytes to be
> refilled to the stock will overflow a page and cause refill_obj_stock()
> to uncharge 1 page. To avoid the additional uncharge in this case,
> a new overfill flag is added to refill_obj_stock() which will be set
> when called from obj_cgroup_charge().
>
> A multithreaded kmalloc+kfree microbenchmark on a 2-socket 48-core
> 96-thread x86-64 system with 96 testing threads were run.  Before this
> patch, the total number of kilo kmalloc+kfree operations done for a 4k
> large object by all the testing threads per second were 4,304 kops/s
> (cgroup v1) and 8,478 kops/s (cgroup v2). After applying this patch, the
> number were 4,731 (cgroup v1) and 418,142 (cgroup v2) respectively. This
> represents a performance improvement of 1.10X (cgroup v1) and 49.3X
> (cgroup v2).
>
> Signed-off-by: Waiman Long <longman@redhat.com>

After incorporating Roman's suggestion, you can add:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
