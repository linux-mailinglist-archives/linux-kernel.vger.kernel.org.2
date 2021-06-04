Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E3D39BCA1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhFDQMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:12:35 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:39471 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhFDQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:12:34 -0400
Received: by mail-il1-f180.google.com with SMTP id o9so9342310ilh.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WmER0sPmJ9ixY8p+WTTY2FhzPf3j9TTlXo0+cEHTCt4=;
        b=Ov+FNCp2K9h0Q8TXBjaEWytB7uXrE1SebSmmzumnsUDOHEiaBotZZjQfO8Bm/TevOx
         CV8bJipn1HT0V+yTJZYQB8bFbOo/ZfAkoeUfy+Cq6BQ7tul7GpTY27lcD1nZEBcEpMYG
         Vck9vhmACu03ZIieC9OfbrJbmwxHdEd11+ZvRRlafVYS3KSxA+qzF9dAW6M7mdqOJft8
         QBAOH2x2tiSfgjqCxfgKBW+8J0jW6+0SK2Nqa8CIw0RxDrq7O5eYo2oAUwWT2Yc8MKd8
         ij4EwJ2a4XK0h/FxpbPqBdYM3AKoy5sE4q5p+gYvkxMde6LEGijwnC8dlB7i1grZUfOl
         V/KQ==
X-Gm-Message-State: AOAM530U7uOmy0WozCOYDDnJeIWjzD8rGDufippm4oRLahbTf6J6/UET
        PlJnnKwe8o3mAcDJjMv15bwjF/AIrqw=
X-Google-Smtp-Source: ABdhPJzjiFSZ+MTAsRkaXfWKrteXuc2CVIWEYgOef8GmeTjnECm7PQkB5cw0yvFlGpZcgn6vdIVC4Q==
X-Received: by 2002:a92:cecd:: with SMTP id z13mr4491352ilq.252.1622823047849;
        Fri, 04 Jun 2021 09:10:47 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id c19sm691087ili.62.2021.06.04.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:10:47 -0700 (PDT)
Date:   Fri, 4 Jun 2021 16:10:46 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] percpu: memcg memory accounting rework
Message-ID: <YLpQhuZwuf32avkf@google.com>
References: <20210603010931.1472512-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603010931.1472512-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 02, 2021 at 06:09:28PM -0700, Roman Gushchin wrote:
> This patchset reworks memcg-based accounting of the percpu memory:
> instead of using two types of chunks (memcg-aware and non-memcg-aware)
> it treats all chunks as memcg-aware. An extra memory used for objcg
> arrays will is compensated by a better chunks utilization, so the
> total memory footprint should be the same or smaller.
> 
> First two patches are preparational changes and cleanups on the memcg side.
> The third one is percpu accounting rework.
> 
> v2:
>   - make all chunks memcg-aware instead of on-demand objcg allocation, by Dennis
> 
> v1:
>   https://lkml.org/lkml/2021/5/11/1343
> 
> 
> Roman Gushchin (3):
>   mm, memcg: mark cgroup_memory_nosocket, nokmem and noswap as
>     __ro_after_init
>   mm, memcg: introduce mem_cgroup_kmem_disabled()
>   percpu: rework memcg accounting
> 
>  include/linux/memcontrol.h |   5 ++
>  mm/memcontrol.c            |  11 ++-
>  mm/percpu-internal.h       |  52 +--------------
>  mm/percpu-km.c             |   5 +-
>  mm/percpu-stats.c          |  46 +++++--------
>  mm/percpu-vm.c             |  11 ++-
>  mm/percpu.c                | 133 +++++++++++++++----------------------
>  7 files changed, 88 insertions(+), 175 deletions(-)
> 
> -- 
> 2.31.1
> 

I think I'm pretty happy with this approach. If there is any issue with
the delta of memcg on but kmem accounting off, we can tackle that
separately. I'll need another day or so to review the last patch a
little more carefully though.

Andrew do you mind if I route the first two in my tree too?

Thanks,
Dennis
