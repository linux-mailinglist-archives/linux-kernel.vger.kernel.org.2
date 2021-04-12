Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A9A35D0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245231AbhDLTXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 15:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbhDLTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 15:23:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A651C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 12:22:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f17so16165593lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gd0dxflCaTKXdqbWxXEfT6HOfWboYzChFATjj4IIxDU=;
        b=KwSeQQinUU7zyo5Fv1JGk2xgxPkBqPeRGTDM5KlhEpSwkX/XmivjIkm0LJEPxZGVHO
         joO7arIl3VlPnxUWo8T2MkV9me/LsH/H2Z6sLalkVByWBszJ4jkA5pLzF8FjA5Andgiv
         wkmj7PcKXxQh2CnzxWgubF//q5lAaW/Zo4ebzkt3I4G3UaSLWfv+gGeURTDeuRncPMcn
         3O7ViH/4/EWgaF0jz37FDL3lPDL5xQoguc1AfxXdRdHrUTgFccWzvfnWPfVu0lcPhkFo
         31sxVTQkxdGuRuoQXfXncTjoCebtKW24RXa5qGmyOvST1FPonNKJA5Im+CL2FTRcImrM
         GZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gd0dxflCaTKXdqbWxXEfT6HOfWboYzChFATjj4IIxDU=;
        b=NKbMFIfTrZ5F9H3MecHF7K7D90bB+D7wQbufYv5UrqlqBp0MWAmCOMpoLCO3yHXP0B
         WUfmxVsD//tG8FnCZabtABp7vlO4QyESed7GPyH1ho+0FLiX24YVnpfSLPE4XL1Iqcqd
         VxW3i/K7elp9JIyXHAxdA/QqWTtgQcHyulknqOR0oW8iD/IIiRqJvKFsUK0o0yW2o+fH
         gAJt/oi8QS0xkNG8z0lUQJew0DxxpJy95X7vwXaZBVxmuHYYvy8hFB8ZyWIConvzWda2
         ij6Ia9cWDVpr2aS4rNCxlNK81ZJ2QEvPR64JgycTtOu/gHiFkLe0JR1JEpUGCBiXU1Rp
         ekFQ==
X-Gm-Message-State: AOAM532g/iORcRLFEA0lRjhty8jmBoPC+pZ2Gdv+A46CFQ8UeF7B5ccK
        E2GhtENVOmGejEnQRS2YBfyYIdSq1v8ZUh+nbda/cA==
X-Google-Smtp-Source: ABdhPJyroaK2RiYclmz6pzbGm8fFY4sD5rXEsikqbQYegIq/wuxdQyXAuN6/b1qwvpMONbNLZwNchnmwL6/Vg/OeeBY=
X-Received: by 2002:a05:6512:3703:: with SMTP id z3mr19675008lfr.358.1618255366497;
 Mon, 12 Apr 2021 12:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210409231842.8840-1-longman@redhat.com> <20210409231842.8840-2-longman@redhat.com>
In-Reply-To: <20210409231842.8840-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 12:22:35 -0700
Message-ID: <CALvZod4MSrvSBJv3Kd2VC42BxQFNRhPaeM8AbCXXbkGOTfjRig@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/memcg: Pass both memcg and lruvec to mod_memcg_lruvec_state()
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
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 4:19 PM Waiman Long <longman@redhat.com> wrote:
>
> The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
> available. So both of them are now passed to mod_memcg_lruvec_state()
> and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
> updated to allow either of the two parameters to be set to null. This
> makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
> is null.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Similar to Roman's suggestion: instead of what this patch is doing the
'why' would be better in the changelog.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
