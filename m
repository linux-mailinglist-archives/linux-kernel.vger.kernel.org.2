Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201073589AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhDHQZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhDHQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:25:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BCDC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:24:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g8so4978136lfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhP7GymXFSKtZlfnt0/yi6SF4MHiLfNobLLfZttkPNg=;
        b=pNP3+nw0beqqrktG7Qie1dyDV4VmIMTq0UwmxM/5Sy5GbRLRfwgh+YWj0pIv0+jMw9
         9WCqIIzsivso6CM/3M1eM/MyxDQaZtoRm3iZj8GpXZGLq6USw578MYrsIwfXNlFIulIW
         +n/4hMXYlP5tphCL1r7xo3d4yFIedzoQ0a+4oFS8tmLcnsC0sIEBa1ZY7vW5CXPGFLzJ
         XiT4U5W3LAeXk/7KXilNkSqdc/gXcnKNG6GNEyGR/lbZJB1QcGjyTjAad7FcLS7ZJMWB
         4RMNOqfrgOqnCQ/w7oNhEe3XoBeJqmHp2rYfhs3bNxY8mlIWL6O4nxCOB7PN7PhBZgbM
         XaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhP7GymXFSKtZlfnt0/yi6SF4MHiLfNobLLfZttkPNg=;
        b=UADFNqD7NFm65luO5TI+SYLVLLGBSGGgndf5snTEQjlcyFesqPNoVmYLozRDFUsj3A
         1o3C6WtFMlfPZYuOvlzcg76o1EabuoV4Kpt2lfaq+r4s2BFEMtANPQLUCSFWJkVFBTfx
         0yNpPsH122cfPXL2QhHBwosHwWhPevyq3d93P9O18nJcKNLfvIdsNYiNRvaJDBmHaqFO
         ssnqLj5JDtjqsz24tLqA6VH6/Mdg3ouKBbv2U4pSPxZ8LvnOOCNBPzZCEYo2ytpF12lP
         9gd1ety9eCyOO0+/vZjgFzbrUjD8omrfLOgkYK+UO/YRobCtk12HTknQw5Jvb0hEpYP5
         +XnQ==
X-Gm-Message-State: AOAM5304EWZCMrG9uqnGSplV1ginmoGvlLV83lflnTqscz7s20DYg52y
        ZFJk1QOmEj2fElxGqdOwm0czGu1gEpbAphP+GJ6zxQ==
X-Google-Smtp-Source: ABdhPJxsgbICoUQRcb1rmHa4XodJWpA+CFTgt6poDqrvLhhm+JBXzDn91yCcJEWT8t2q20D9XXM4smuQa4urJhCK5mA=
X-Received: by 2002:a05:6512:34c7:: with SMTP id w7mr6855594lfr.83.1617899096362;
 Thu, 08 Apr 2021 09:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210408143155.2679744-1-hannes@cmpxchg.org>
In-Reply-To: <20210408143155.2679744-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 8 Apr 2021 09:24:45 -0700
Message-ID: <CALvZod4W+7_EZUmUQLoz-9-C2LeMtqbdvFxK31m4qV6qHOrejQ@mail.gmail.com>
Subject: Re: [PATCH] mm: page_counter: mitigate consequences of a page_counter underflow
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 7:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When the unsigned page_counter underflows, even just by a few pages, a
> cgroup will not be able to run anything afterwards and trigger the OOM
> killer in a loop.
>
> Underflows shouldn't happen, but when they do in practice, we may just
> be off by a small amount that doesn't interfere with the normal
> operation - consequences don't need to be that dire.
>
> Reset the page_counter to 0 upon underflow. We'll issue a warning that
> the accounting will be off and then try to keep limping along.
>
> [ We used to do this with the original res_counter, where it was a
>   more straight-forward correction inside the spinlock section. I
>   didn't carry it forward into the lockless page counters for
>   simplicity, but it turns out this is quite useful in practice. ]
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
