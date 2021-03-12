Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E69338459
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhCLD0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhCLD0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:26:44 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500EFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 19:26:44 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 18so43363605lff.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 19:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERXTmDvOuzBoCJ5riCOMOTJGtMFLgVqrDbOyFkQIKZU=;
        b=uhDaAHWNhpGodMLTIvN6LLx6pBhfH5Zb9oWCNThrJfA0oF1j/GfZJUJpbCXkeR2am2
         1G/QJF7dC1izF5DhNn4vSvNM03Tl1DNt3EXw2JihNbCKmk2uQ6JrFy2AvFpbYHBH57kd
         35DVw0c5ZmdUZjgpckrDA4sxUiAm5/IjTNcJyT6Luw/YII5Mxf6fUO4T2W2sNEo28UY6
         OJ4Hvtt3gvX6tZQCYDvVTVq4a8juiXXSxbn/3AtBZW406WiV+AFe5rWFJUTeDTtTfLuT
         +Un5pyNWE34YALBPoSWXuOp3E+KyFsjNFG1ZfPyswpi94NGtF7C0Xi+1r7F94PsMr+Jt
         1ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERXTmDvOuzBoCJ5riCOMOTJGtMFLgVqrDbOyFkQIKZU=;
        b=gHdvCoOTKwjQMzDdSarYiJm8+cp+DYzjz1MIcRp8dBvtxsJJI5FCVtKz8Vn4+qT4OO
         DHI0DtOneTCjxrc1A7a0qIxamVqxh88ZPBHPOQNtVivpiMhiTRaSTff1tX610KJmdTdV
         0AAYeJqarhAOafTGd72Brx5nFoCs7UdVnAuA7FgXZmnvHWC/mCpripzmKnZbZpksLEoJ
         o3kP/pmOKEmCK+lvrvVDckLVlgmTV3SHzh+k+X5rLMUWKPQ02wV2PcUfEGPHi1lV/srz
         WIG82/6DjhbfbFJCQUtQUCGvSeXRYOtmk7wFP2Gw74eS/xIWZX5zRMRXg1GzB0HCPCop
         d8oA==
X-Gm-Message-State: AOAM533sdH5up9ZthZneqQZRe7qokNYVE0lGVS7Hk3w91Qtm31ImyFxr
        EGmj1+dxFA/+TBQEfJqth9eZRivOE8xpCQ6Digt4sA==
X-Google-Smtp-Source: ABdhPJxpTifUkJNXNU9AokKWA5VD1wIJvHOn2mEnoq/3b/62z2REb1NnWu2zsZgq+M9fXbTURLREY7ZnF/pug/izHpc=
X-Received: by 2002:a05:6512:39c9:: with SMTP id k9mr3942270lfu.432.1615519602400;
 Thu, 11 Mar 2021 19:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com> <20210309100717.253-5-songmuchun@bytedance.com>
In-Reply-To: <20210309100717.253-5-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 11 Mar 2021 19:26:30 -0800
Message-ID: <CALvZod7CmOMedrv1RMO=ryEagf9yanoWA6o0RXZ0xhPhiE0JrA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: memcontrol: move PageMemcgKmem to the scope of CONFIG_MEMCG_KMEM
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
> The page only can be marked as kmem when CONFIG_MEMCG_KMEM is enabled.
> So move PageMemcgKmem() to the scope of the CONFIG_MEMCG_KMEM.
>
> As a bonus, on !CONFIG_MEMCG_KMEM build some code can be compiled out.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
