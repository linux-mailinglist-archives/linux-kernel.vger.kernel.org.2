Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76A34120E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhCSBXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhCSBWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:22:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3CEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:22:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n138so7517378lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CW4McI8JkV+pieEAOjNv+vlbnY5aNnNxkeeFzG0tW8w=;
        b=cDeKZHVFxabXMfipkJOP7Ibt7u7HVzssV//KJmna76gp11QpclpUxew/DscSIAVeT/
         ILTnAIjHt4zXkV5rdRyMkftIzQhnm6/f4Fc1g/eFn3KcKwKdUaLvvXlCK9S6uSyQMJuy
         z8rnpEi1ijjr2S0a5dAwX48+eC9eYYzuuKyUyW8TWRdIdYlNVAScpyqUbBB+tzRz0DXp
         fwYpz0a0GpiFPVbBulejetQGfE9enAm6Qp3Az8rG1NCuJX/H5eajWjAZ3zEYkgbu4dGW
         9z/ugj21ayFY1WgcWWhE9uw/ZP7lLMCb5UU9bvxnwru5IsOfv/1HtFzPEOaDcXXy7cUf
         fuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW4McI8JkV+pieEAOjNv+vlbnY5aNnNxkeeFzG0tW8w=;
        b=qly3HP+Hwnbc0HZJ9cmVPXBZuXJkyxsVJ3NTeX0sIG4jjxwD1IhXC8OcaACWEVhW+r
         t74MQP+H6PDqJ1pKw6NHsG2v84zrK5kvQTRpUjsu0E+cKlTVE7rFaYiqH0JXZ69FocjZ
         rsOCCnGStIkNCEnjPW+adSB/hyj/5K8n8RhWEWvK3xisiZ1uxGpof0Zhu6Aofarndm8v
         ktw8szcrzFpDrFf3+vx56T5afRIZI6KH/Y9rkzm/IeESJQnrBjs8h0doyty0GQtftUpr
         8p4PTxsM3meXBvlZldFEjz0y/BIoz8P+ja+Z9znMqFAFvMXvE0iO1LqHU75SPXdy1fcQ
         iYTA==
X-Gm-Message-State: AOAM533w9XKJrVtf6Dm6753W0PQbkRl0n+L/Yn1n7nkhdb9a8OUna2Y1
        nmZWccZWC0EX1r71cko+1hO5q6JCrbMAtS54OvMRQnBIFk0=
X-Google-Smtp-Source: ABdhPJyeKUzfk7qJwdmTpIOVyFefL4jP2HUWSjTzyZpGRUmli8dFZV88KSSE8oBfMULFwo4SPWZ4Um/djOyrGlRodTE=
X-Received: by 2002:a19:ee19:: with SMTP id g25mr6696142lfb.83.1616116970201;
 Thu, 18 Mar 2021 18:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210318110658.60892-1-songmuchun@bytedance.com> <20210318110658.60892-4-songmuchun@bytedance.com>
In-Reply-To: <20210318110658.60892-4-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Mar 2021 18:22:39 -0700
Message-ID: <CALvZod7d-6UH+6CTWyH44W8YuzsC3TyaHwdtQSs9a+65hJr2UQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] mm: memcontrol: change ug->dummy_page only if
 memcg changed
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

On Thu, Mar 18, 2021 at 4:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Just like assignment to ug->memcg, we only need to update ug->dummy_page
> if memcg changed. So move it to there. This is a very small optimization.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
