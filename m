Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E9937498D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhEEUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhEEUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:40:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D648C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:39:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c3so4499247lfs.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vLE3pRIE7DJyqWPEwNMu12YoYQF5DlZNk2exGmPNTg=;
        b=reGxAsDmGcDNeDbtupo1tbWXa6T9XrjZqX3xyHKEQtoI1PKUnAMqbp4g8ZsJ/CLTb5
         49+eRQ6l2rhVksKqKYfARh9s6gTXQQY3zw5x5PktHltVzCFFrT8fD6E9tQ1w6fqoUHLQ
         9VeKmoIRKKa5X8sZVI6cywPDotAAF54/q4y4zxIr+EU5A91PYBnNL9QQ5K/VNQhbm8Wv
         35TmQ+AJVmjxZiEsJyt0bfVgsoI65T3kYwAHHPmXB9KdNsE+AFrsUBWtqTArNWUuvVqj
         t52WBgYsk9My43JMjwehdnmbZ3xJO/xvBAUyJo/YYJWoJXOQu/xwY6qrLYyCDvDt0TXX
         Vssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vLE3pRIE7DJyqWPEwNMu12YoYQF5DlZNk2exGmPNTg=;
        b=p+G0sIpc2kM5c+VS9CgnlhWGdALLRKMS65QgfTb4m42auIxKH1ob3Qk/ad6MNbiLCW
         mtWK2WDciS2McCB4RJI8oIy2HVIcQVFfsBJj2RUzLg9HFhxnatIpKSyqnw2fs+1q/nFp
         aFrKANJbUJI6QeJblTlPhH5khr2GqRKR8IzV3NS9nNOqPDIkmvyaL5cKpJyVUyU6JgWV
         mD9viFMD6Co6q8RMj1ydxzMX/V9fuQ/3bhI9OhGfLFHYuUrdvAqm4q1onTjyS32rb0QH
         Mu0YQCUoDVpv2YiosE9nGV/69g0RLvH0fGWsNZJK2xYJxZK2ao/Eg4o61Rls8fPfppJh
         8Mxg==
X-Gm-Message-State: AOAM531zcqRoyMq83U5i1xLLCCADWJfOGiho34tJKhgtFN21mtqHjTse
        Be2syqekhy2bi6o8oeS+ML2P8sfJYPVLz/myzDESfg==
X-Google-Smtp-Source: ABdhPJwyjIJjTM32S0Z6f0x0NjAwi/xcgU0hmTHM9xcAkdHxxrQLvzP7kWQl3Yxthm0XYBQaRaD9jnVAMVmt3TnFO9o=
X-Received: by 2002:ac2:5b1b:: with SMTP id v27mr417118lfn.549.1620247174619;
 Wed, 05 May 2021 13:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210505200610.13943-1-longman@redhat.com> <20210505200610.13943-4-longman@redhat.com>
In-Reply-To: <20210505200610.13943-4-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 May 2021 13:39:23 -0700
Message-ID: <CALvZod7MnE2WiyxqCpou4+wXmr_dMz3iHf-NnJ5tVZRfyH9Xcw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: memcg/slab: Disable cache merging for
 KMALLOC_NORMAL caches
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 1:06 PM Waiman Long <longman@redhat.com> wrote:
>
> The KMALLOC_NORMAL (kmalloc-<n>) caches are for unaccounted objects only
> when CONFIG_MEMCG_KMEM is enabled. To make sure that this condition
> remains true, we will have to prevent KMALOC_NORMAL caches to merge
> with other kmem caches. This is now done by setting its refcount to -1
> right after its creation.
>
> Suggested-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
