Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E73D821F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhG0Vv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhG0Vv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:51:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0348C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:51:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d18so26980lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LklRqbXMTEN/3IOARnfGCTnT/yEZVFwCJFDMkmvyYVo=;
        b=AbNu22X3Nmx8X2h+2ik7T5v6bU+CsbYIGQapGfDjCY/3r1jS9dwjHMGAsireZtJIzA
         W6vzg/MECVRzb0M3CzcIvMUeqvE7OFHKjzUu9Vc8EciMK4M22Lalr1SoxpUWAdaS0jas
         trp6Y9wm5/8rQ99XmOCezferLz9rqJpSR4qHfjYjK/VTc3I7BOoBPi0fzC9EwTD/nYHV
         8dAu/luh9QT3BGhD0+VcybrhasaOcPPohqRydoP5y/Vo5wWXp7PD1EhvztG+D5sonifC
         yAelkaCCnK3W8KrUX9cPBHBrruaxk+BOade7OJ7ssi7N40oIgkFN4GjiGFhdx1Vp7uI1
         EVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LklRqbXMTEN/3IOARnfGCTnT/yEZVFwCJFDMkmvyYVo=;
        b=h0aeczAIVnaOJlGhQGhvcaCjbn9apcNSDsZBE8gc7CQnhv1GS33XD1WZ45NyZHdgMf
         NNTmOkjr362sTBPJUO7zZ9rHm905lRISTtW/3V2GpTNSqLdmtWPvDAgaCBWfA/rfV1Wt
         GUuKX6rTIesDrBKTwCl08M1o1bzXROeyvZyGGtwUbpbEgtLFFtKgKfZ4FfZ28as2uQfZ
         nwx8ITtF6pXQ7IjDxBkR0efAyy/iGt1xAv3r8E2knQqZZoyATgZqTZND8yNbRCZS+VkV
         eSgpBMCRLKOT28PpRSplLoKBrzt+JEg8U6zBvhtL22/yU0gS4LjPNINIZx8OqYArzyjG
         igXA==
X-Gm-Message-State: AOAM533VtLossuOyVqsCHYjBd4tAz8lfSZdye2zB8u16tP+3BuiGLlw+
        tY9b/M5sXh9qDG7sokFaQ4uyHT1VNCGofsNZjk/ugg==
X-Google-Smtp-Source: ABdhPJyiTzH35Mq19nPcHN5BCC0dltSH+g1FJkcA9lyijpawno1XuHgUeOU54nM7g+YaoRlnu+709wB8lfa9Tl7tdvs=
X-Received: by 2002:a19:771c:: with SMTP id s28mr17640254lfc.358.1627422714605;
 Tue, 27 Jul 2021 14:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <5525bcbf-533e-da27-79b7-158686c64e13@virtuozzo.com>
In-Reply-To: <5525bcbf-533e-da27-79b7-158686c64e13@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 14:51:43 -0700
Message-ID: <CALvZod5tfepT51EgUVX_Xq=2UykpGehNE5K3+K12OCwymi=-vQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] memcg: enable accounting for new namesapces and
 struct nsproxy
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Serge Hallyn <serge@hallyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:33 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Container admin can create new namespaces and force kernel to allocate
> up to several pages of memory for the namespaces and its associated
> structures.
> Net and uts namespaces have enabled accounting for such allocations.
> It makes sense to account for rest ones to restrict the host's memory
> consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
