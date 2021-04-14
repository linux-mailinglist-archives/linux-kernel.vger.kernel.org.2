Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A403F35F15D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhDNKQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:16:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhDNKQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:16:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618395342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6wKF//P88U/M+zDwsZ3xJTgPUSQgjspEx6v7dGglkw=;
        b=XixLXnku8keACsrXdywnzaLMPxitUWW1MLzpGkLuHry2mV4ONud24MzYd5uB9jGT5g4crA
        PLg3P0NDpplSNVmjWSGBluS2VEspTZBk8K8hs5ue6yPgvuJJBehN6DpNUPg0MMq1ZDZRd9
        WWWPyYawUhyJQ5vKR5Ep41hOxAMG+X0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3DA79AF4F;
        Wed, 14 Apr 2021 10:15:42 +0000 (UTC)
Date:   Wed, 14 Apr 2021 12:15:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [External] Re: [PATCH 2/7] mm: memcontrol: bail out early when
 !mm in get_mem_cgroup_from_mm
Message-ID: <YHbAzL9ls6EBsB3L@dhcp22.suse.cz>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-3-songmuchun@bytedance.com>
 <YHa00lx7ACWcS1/h@dhcp22.suse.cz>
 <CAMZfGtVpUW1=Zvys7J=gW1xqkuUVLuPYcQbwJoe=TEkBa6qqQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVpUW1=Zvys7J=gW1xqkuUVLuPYcQbwJoe=TEkBa6qqQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-04-21 18:04:35, Muchun Song wrote:
> On Wed, Apr 14, 2021 at 5:24 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 13-04-21 14:51:48, Muchun Song wrote:
> > > When mm is NULL, we do not need to hold rcu lock and call css_tryget for
> > > the root memcg. And we also do not need to check !mm in every loop of
> > > while. So bail out early when !mm.
> >
> > mem_cgroup_charge and other callers unconditionally drop the reference
> > so how come this does not underflow reference count?
> 
> For the root memcg, the CSS_NO_REF flag is set, so css_get
> and css_put do not get or put reference.

Ohh, right you are. I must have forgot about that special case. I am
pretty sure I (and likely few more) will stumble over that in the future
again. A small comment explaining that the reference can be safely
ignore would be helpful.

Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

-- 
Michal Hocko
SUSE Labs
