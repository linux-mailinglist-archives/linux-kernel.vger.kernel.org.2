Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF827338453
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhCLDWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCLDWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:22:34 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED1DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 19:22:34 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id r20so4932048ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 19:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCIc7dqSdtfRcjLpMj51xq06Wi2OTwxYLeouzZdu4ls=;
        b=MM4wfvArNdN73GuoyTklV4maIs6VrkD57zcs6ThfaiZRuCZTdKDAM6L/uP+vzRIoic
         iDmPSZBen/4rN/eaM99rFXvx1b5Qzty24xAHWN4u2nIqOg/A+lmVP6jpChXsPblRClwq
         mYXzV9aTFX6je8azdoDViZamEkhOVRtYOpTuSy4OEKfL516Wd+SJO9lgx+6otmTcyy4U
         q56OaSRiiu4wOaSdJYCyAZ+25LdB4tmTy79q829cFqkDEqrz6cieaz/XuZ5qbM1eOliA
         R+j/AW954iXCyz5LJ2iF2X8bSr2EBCRaUFXOSHPua0Ek6lL3vvwu2Hw6MPIjsGwSuaGz
         AcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCIc7dqSdtfRcjLpMj51xq06Wi2OTwxYLeouzZdu4ls=;
        b=GNI4M7OyZSQ5lBfusdpr7cmJM0KtIjf+d6qjUUn8uKMr8Kc8T+fGwbQsDUuWwWVdv5
         OG4qrXxCmC48TzNpsloXdszGahhgo/9/MAi+dTqwjGPIkAjF7sZTckBusY7pdZ1VYYfq
         HeBUrSwWpwHMy8WFO5j6gVFcHsdhe5Fb5qXYss/+K0iQj8kIlc8YOTBk0B6J68sk4Tab
         DFeTB2yJsnxbjvRdkIoGHc+cOBsWhytDpkFwYC7GMyl5oC2jUWCgSMJs6zRIKqB6yHoa
         8VQcE0zsA50WOIGbtJp/RDiXj+LfT4txOJOW1lDns9NzXR0cMzwIEEpAZoI+gUNR8BI4
         wkZQ==
X-Gm-Message-State: AOAM533QAqeiJrtrYm7k7UpqRX8w7q5ccXS1OqfhxPrrYtmPbk/PVD81
        NNAQWjXZljJpSC09/0DfSLov8kmgaHr1dwLFexMyHw==
X-Google-Smtp-Source: ABdhPJxPlRl6J49DAV+fDgYTfkYsLWkyswd8hWXDG/3S8bbBYuBPzvn3lU7qV8y3vDLNx2XfFyTI27/FLpZOE2whxSA=
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr1120647ljb.81.1615519352363;
 Thu, 11 Mar 2021 19:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com> <20210309100717.253-3-songmuchun@bytedance.com>
In-Reply-To: <20210309100717.253-3-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 11 Mar 2021 19:22:20 -0800
Message-ID: <CALvZod4vmZztdbjkWT8soRd3P=JXyNJChDTOUP1HaiSQhKoutw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: memcontrol: make page_memcg{_rcu} only
 applicable for non-kmem page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 2:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We want to reuse the obj_cgroup APIs to charge the kmem pages.
> If we do that, we should store an object cgroup pointer to
> page->memcg_data for the kmem pages.
>
> Finally, page->memcg_data can have 3 different meanings.

replace 'can' with 'will'

Other than that I think Roman and Johannes have already given very
good feedback.
