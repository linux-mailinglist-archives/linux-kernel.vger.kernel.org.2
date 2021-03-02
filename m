Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ACF32A149
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576932AbhCBFfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242190AbhCBDni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:43:38 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C4AC0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:43:40 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id r25so21180133ljk.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3B0Sx20A1r9upf4Kb0C/kpU0MZoTOmOraXVoNYgXq+0=;
        b=vhnQXwzEG4fSKT+nNG8JUDOp8WuwtYyM9Vz5u8UuMP5J6E6kOng7zABNCZkGIvqO/Z
         lF4txvkAhYVRIOspQwJRhpV/pfvlYUWQ8uOzwdf7klS7QjLw4GNL+ZBCxj7jb1kaXaWW
         2EVpdc+nUpLUFYKejU4N1/NkqXpsK+iNO2iUhOD5PzWkGPjRXlFH5Vq9hI5nweviVxJ0
         NpiRLjezGtQ6dFxliVjEln5wPhPJNrZsZ1EAFlEqOtxnHA3L0FT4PBwuk8yR82LJKP06
         vMlaRaiuezL4cMfKgC2gSDIA/EiixC0Hmd9+1A8bYAQyOZYqpDyERlYiqDTLSGk7L7Vd
         2HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3B0Sx20A1r9upf4Kb0C/kpU0MZoTOmOraXVoNYgXq+0=;
        b=d7Np2TcWsN/EOtVYBncew8gHra0dYRwhhZsffFI01J9io+bH7ZxD9o6iWo2mshvIcK
         LjlD6kT/IAAms4lfJcCrd7hY3UzgZS3T6MYwtViw5hQevzrPMEzZcFGhgeoBf5LMTHT/
         EkyPq3H3z437qfz64YcXP2cPjmMyPZ7eO4RikQ2sgsBDzhDwy1xR7dhqzDU2EDRfrYRV
         u3+Y+ywWZk0x6KT9FGaAPfxfmJs6Jqb9sDlY6D6RIoq155FC1qmJcGT8LN1PdNOPiuM1
         uWoDe7qGjWKKJ8rGsOaVr3GsERLbH9PKWFFIGPvhS14zEhxG396xjRZnl03IJEu4+yI8
         vElw==
X-Gm-Message-State: AOAM531bsOiRktupf1yHJQKI3F2OaJtGa2f+FG9OgkwJ6U9crikUwgn9
        qJRzVITsDIr8JShJTRoKXFIctAaOOYt197X4qFrWXQ==
X-Google-Smtp-Source: ABdhPJyC5KTWWfJMUVQrljO6hX8iwyh7wkZlnr5yI6GC2wySp0634pLrU6si7GQKQAf9+DCrxQr24mvnkUGVPNVCw6o=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr9224356ljc.0.1614656619239;
 Mon, 01 Mar 2021 19:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20210301062227.59292-1-songmuchun@bytedance.com>
 <20210301062227.59292-5-songmuchun@bytedance.com> <YD2RuPzikjPnI82h@carbon.dhcp.thefacebook.com>
In-Reply-To: <YD2RuPzikjPnI82h@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 1 Mar 2021 19:43:27 -0800
Message-ID: <CALvZod4rWvMJdnbfMm4SGtj0WyqDzvH8RY9G32y=NLNCZqJ2Gg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: memcontrol: move remote memcg charging APIs to CONFIG_MEMCG_KMEM
To:     Roman Gushchin <guro@fb.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, esyr@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 5:16 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Mar 01, 2021 at 02:22:26PM +0800, Muchun Song wrote:
> > The remote memcg charing APIs is a mechanism to charge kernel memory
> > to a given memcg. So we can move the infrastructure to the scope of
> > the CONFIG_MEMCG_KMEM.
>
> This is not a good idea, because there is nothing kmem-specific
> in the idea of remote charging, and we definitely will see cases
> when user memory is charged to the process different from the current.
>

Indeed and which remind me: what happened to the "Charge loop device
i/o to issuing cgroup" series? That series was doing remote charging
for user pages.
