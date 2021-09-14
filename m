Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797440A575
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhINEeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhINEeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:34:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF149C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:32:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id i28so21294411ljm.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fu4lIl+FKgt34SvsZzswMOLfBBmVaqouMxJqzvs5GUE=;
        b=Wz8/qbTPuO2gFsebTp8dF07QwNkcGKHJMIVgEfNxylqPVZk6OBBEkaVAdxFl12egu7
         l97RUWL/RGR8c934GwssB4/036sjsHpT9g0uqhwaOqSjYuXOsqG1yftRdoOu/8BIc9cl
         6voG47yQxfvp9VzEVI9Iif5Icr86qsK7yGWbgCOsrBwFx2Jr+WK4n9+Syk4/kwti/G0V
         nM5qOvg8C/2cJB40l7jsLaIeAnGw2ZFv+dElbWu8D9BO2Gt6R30tVUrztrdx7+U1Yux6
         xFN2S8CNPAjBD2AY+FHArieeB3XWjHrOCCqrKRk/SSiCyDCnoxoBZeRQWTVCBTZLYVi8
         dT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fu4lIl+FKgt34SvsZzswMOLfBBmVaqouMxJqzvs5GUE=;
        b=FAuDRg7XZOWlLCo9alGcJHPliltstvMPeG34XLZakgDckNCDCrwUAzZ/VSipTAjc51
         1aWKJFFV42UQDyN7TpgEirkqfuEAnYVMy5AhPgVQGNpkuOfsC1fPsdyrfMULXYl2XKqg
         n9RsVijM7uJoT489dMV/xDDse2Byw/M/3RRyXxU7Y0z7/4NXU1p//i1U+HqIi1qtRIcg
         7CFyvn9ZtUJuC3a+MUU85mbPIRbxujaWacDNEH2UwQsgFrstVw6hfHnAywj3BYy8sox/
         xkGVpCXWRiY0q6Xy5azWo06Qv/KR61PGhcyplT4QlvWN+DUhrp1Dd3B8+6wEP6zny3mX
         09nw==
X-Gm-Message-State: AOAM531yKl2w4hEBTPiG2ignilDP6wegFcsHnsXiWTkcv3KOOMbC7gGH
        s92QUS9vRD4YDb3W+Av4CzvY5UPR9tepkJVx8FCMCw==
X-Google-Smtp-Source: ABdhPJwwcJw34ryViJqWfeTSyIDbwy7I214F0qpdX1884+9sk07rIdBTGzjoVqFpSHQdDuRtvjz6KAek0X0vVU2EMsY=
X-Received: by 2002:a05:651c:113b:: with SMTP id e27mr13609792ljo.6.1631593956911;
 Mon, 13 Sep 2021 21:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com> <YT8NrsaztWNDpKXk@dhcp22.suse.cz>
In-Reply-To: <YT8NrsaztWNDpKXk@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Sep 2021 21:32:25 -0700
Message-ID: <CALvZod7Y4pC4XvqVp+tJ==CnS5Ay8YPqrxeUzA8tMLu+0U3hjQ@mail.gmail.com>
Subject: Re: [PATCH] ipc: remove memcg accounting for sops objects in do_semtimedop()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:37 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> > However Shakeel Butt pointed that there are much more popular objects
> > with the same life time and similar memory consumption, the accounting
> > of which was decided to be rejected for performance reasons.
>
> Is there any measurable performance impact in this particular case?
>

I don't think there was any regression report or any performance
evaluation. Linus raised the concern on the potential performance
impact. I suggested to backoff for this allocation for now and revisit
again once we have improved the memcg accounting for kernel memory.
