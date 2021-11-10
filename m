Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170F544C2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhKJOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhKJOUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:20:45 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EEFC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:17:57 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id o17so2230442qtk.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OI7XzQR/AItkA9UXractExmowE/uf8KHxKzx9i9f84E=;
        b=W9sj3aA3V6wCJyzZa5Z/r0Rjs+GTdf1AeXM8lXWs1ItRDO7+/hHWiyfr1RghfNFD52
         2ZObYc1/Ev5HuxwoRne4mRAn4wb1QH9I3ysUrEpYnc4eEB46JeKLOWZiqgrE6DjK3Zon
         nefZrsy1IaVWEAdg46Qadpl7KhTIOSgEExbsa5Bv6mapZ3XZa/2p93DF5c3Gsx8MkJ0Q
         hnpRJPUjyvMHgc3TVNkmsE4VYufI35RUt0Fe9/75Gf/6hwjUpuUUISCYC2OC8coiza+4
         AqiKpoWOhrDQ+lFAZVlC3XJLuxgpu8Lj0e4+M0hzxv+/JGEELvzEe9dICC/UVJ59F1tv
         oA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OI7XzQR/AItkA9UXractExmowE/uf8KHxKzx9i9f84E=;
        b=exLPm+x0nMq66waK//3bYbImLw2NxQ142ln/h53lNJHq5+qfc1hzLXyn7QzdbcmLQI
         CuyOBSBx2lRjMHkzIi62TwhPNZLxmy+YdmEti8vMtBQlpZBPnhI4Ul6ai4E7ESSsoCJ1
         ExEcg7Z/ABQ/ZCTq6szhUS5IWXjr/fMh/upfTAQ/vpgEeuPBRcI5ygzDNNBk5I2S4uYH
         4cu+WOHyzVT+qmMnc6mFY9NIVwsh9GdQkCELRvuT98oaXFJu+wXuFmgf5ynvl4MEMFCt
         sZ6scfJhJcAv2rM/1rOaV9jwBQaendZnGS+X/2x4D+XVIRh781YCk9qbqzNt2r/uhyIY
         ZuXA==
X-Gm-Message-State: AOAM532kWHcehBmvyY0tzb8mRS22TQJtI1oiAGHfP9T/il137fCILyUn
        LNC2m9TV5OpYzHURsyRZ56nBtN23/6EfyX/trH8=
X-Google-Smtp-Source: ABdhPJxnGDnmgr5sER3lQwxPP3RchgmqIpmO8+XRu1a/kMfJ/rVkx3ikP0WJhcQdaTZjD0Ij4VJiHbgg/GlFZVmAL4M=
X-Received: by 2002:ac8:7e83:: with SMTP id w3mr6986536qtj.160.1636553876858;
 Wed, 10 Nov 2021 06:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20211104145713.4419-1-laoar.shao@gmail.com> <20211104145713.4419-3-laoar.shao@gmail.com>
 <87a6iitu3r.mognet@arm.com> <CALOAHbAHQ0UBn2GqRNWQwH32UPOuFo0b550oi6WCKr8+wFgdsw@mail.gmail.com>
 <87tuglsj0l.mognet@arm.com>
In-Reply-To: <87tuglsj0l.mognet@arm.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 10 Nov 2021 22:17:20 +0800
Message-ID: <CALOAHbDkeOC0LWpSTmn-vXiftxqFatPFwfuFqzU6i86Z8xoFbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] sched/fair: Introduce cfs_migration
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 6:47 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 06/11/21 15:40, Yafang Shao wrote:
> > It seems we'd better take the patch[1] I sent several weeks back.
> >
> > [1]. https://lore.kernel.org/lkml/20210615121551.31138-1-laoar.shao@gmail.com/
> >
>
> As Peter stated in that thread, this only reduces the race window and
> doesn't eliminate it. The FIFO-1 smpboot idea is still a good one IMO.
>

Of course.
I will think about how to avoid the migration happening in the smpboot
thread_fn.

-- 
Thanks
Yafang
