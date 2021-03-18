Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACBE340952
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhCRPx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhCRPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:53:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE2C061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:53:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a198so5352771lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pq/eBnxufGHS03GB6g8W63yjQMuRCa5QlbRp3PwKUEw=;
        b=bgdV4hZplv+94CUHWEbu9IHkjeAlUPO8LEb5m90TFIXf2m9HsOiO9yTkUsNDIdAL/2
         rBZTdVoEZ257H5o2v1HojtAp7qwdrf7q6Ii2ntKX7WkOrgSD01JG2StigU5YHcWoqSJZ
         bTXqHezszXCYygdvLZ/D4lwuJVAa88DpyGrABJ/xN9LlrHbBIre4dBG8nHgZCCo7PWaS
         YykPvxidGKJ7WFvtyyCMDgKpOdLSC7cUPueTA3LN63sNMlGVX/MIeRRWbisyCFlEdCpG
         VXqLfvbBzVRVVJY9HgvpGs9mCleH1KBcPG9F1+PKCOZB9CKurbXljzRWCaGovWH1biG9
         +hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pq/eBnxufGHS03GB6g8W63yjQMuRCa5QlbRp3PwKUEw=;
        b=LeE09qqFhB9Nrj+KEvldqzd2QAqDIirzyuLHmwJVqpwzpNVSuewffD3E95/mdO5aoq
         OaHmp0jN4uMqHsyZNUy2+c2ohonOeP2mhT3PVFCdbZhzCWr/JT2qMXtw+X2IhxwHV9pi
         S1FOjHwyWd2ixina8TGjXeuUoUuLBs2XcVlftGwcX5qr2iFWj7JrXYVKji2FRm0PPDwQ
         nDYOkOmfWw+O4FoH/iDn+kbdjkllMAHf8zk+RERVh6BOHmrsZOW934KBFLFNqI1eXytX
         tS/X0vi/EKIVQQ21a0dE39G83J1r2szSkJVpmJcaGGpp/KESXYKalbHg+o5pHq0Aje2C
         78rg==
X-Gm-Message-State: AOAM533ZLiB7If/3GGk5ObJxU8o0eliFtbksOYBMGyoNQnWoa3HGrRG/
        xB85d2lXOxa1L9932y23dDfQ/1VDBmIsoCGNBGdiPg==
X-Google-Smtp-Source: ABdhPJxEgWeS33XZh839tg6ABZ5gTUZAm8ikQzXDtakEINgKM9uy1FMacx7hcnhzqgiPX7UJktfr+qQJhl78XhvdRtk=
X-Received: by 2002:a19:3804:: with SMTP id f4mr5990396lfa.117.1616082825932;
 Thu, 18 Mar 2021 08:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210316153655.500806-1-schatzberg.dan@gmail.com> <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
In-Reply-To: <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Mar 2021 08:53:32 -0700
Message-ID: <CALvZod6tvrZ_sj=BnM4baQepexwvOPREx3qe5ZJrmqftrqwBEA@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 3:30 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/16/21 9:36 AM, Dan Schatzberg wrote:
> > No major changes, just rebasing and resubmitting
>
> Applied for 5.13, thanks.
>

I have requested a couple of changes in the patch series. Can this
applied series still be changed or new patches are required?
