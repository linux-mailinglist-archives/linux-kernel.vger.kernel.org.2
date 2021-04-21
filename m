Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FBB367286
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245195AbhDUS33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbhDUS31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:29:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9E4C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 11:28:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r128so41256385lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3pKNRpAYonIhJIPLG+pbIg/iVXk4BkHo5q1/p/dOgo=;
        b=AAoUTPD7oBRut/ALdKm+tPO6jlrcqGZAJSsoMj8iGEp6Zg/YqD6yGfx1Yxi3bpHRcC
         6siZpF6fb7tuWkT2EQdMnCumN2CMDnOPzmvpYcF5S431ORvspnkulpHEa/t3mERwZHmG
         7n3krkLX85vE9LhJodHreS7aSegTTQ/WxNpSKGKsxY71e1fntE2ffpomx7mY2GomwzyC
         Fn/HKakuhmUzJhMig93Y0mlLSeVwDWqQW1R2IcjuZ2uEzJLnTN1ZOJ46woQnyDOezz0w
         8orZmdhMXW7tHjrcFjkfhhtVhtnhc4W9irW2IzCsysbkc4u1Eo89TJanvCB8v4SRoloM
         rKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3pKNRpAYonIhJIPLG+pbIg/iVXk4BkHo5q1/p/dOgo=;
        b=d52O6hxGJLz0EyVNmmtJ0pzDuh+9sqa1P6IcmJdXvQh542xjeeKSCSxEUufaHBVxOh
         i5KwF/dSBB/3WBhUdHJDKpClo2Hw3WTKn9QpyRo5pSab1+MY0tUD/iJNqK26QX41Ielh
         LgZ+Qbmj6cKRbjenXoehGIzZST2rcO/TwvPxOEOpRbeQGLmEfVhS046hMBn7RBi+znDB
         PkLHw/iefUAw1l29w5NCVrfswazrg7RTEWoxxAeD9IDpN0YiOI9wW1Hd+ladTNihZDgT
         cwn48Cg3ZdFZ0xc66Ph7uBtU/rIkVHU1kZ9lLP/7yVFqpGV0reVU385bxwDqRWyq2Iky
         Kgtg==
X-Gm-Message-State: AOAM531N4vn+ruLFqyJEIsm3yH++gAT63t7sNAW3dN76/aGiBogsS0wp
        VxJtySUODLnaFim+eTpsfkr2WTJTFEB80vnGE/3nyQ==
X-Google-Smtp-Source: ABdhPJzVdK3x9cI06saU3B0MCD9Pb2S2GZP3vYXK2GIGysuECny5jZsN839PKrxjU0hUrtB8WK7Aox+R8wCADc2Sqdg=
X-Received: by 2002:ac2:58ee:: with SMTP id v14mr19969129lfo.83.1619029730879;
 Wed, 21 Apr 2021 11:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <699e51ba-825d-b243-8205-4d8cff478a66@sony.com>
In-Reply-To: <699e51ba-825d-b243-8205-4d8cff478a66@sony.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 21 Apr 2021 11:28:38 -0700
Message-ID: <CALvZod7AEjzWa6AR4Ym1jpfzT32hmepxvci6hXvNJTEQvcQqEw@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:06 AM peter enderborg
<peter.enderborg@sony.com> wrote:
>
> On 4/20/21 3:44 AM, Shakeel Butt wrote:
[...]
>
> I think this is the wrong way to go.

Which one? Are you talking about the kernel one? We already talked out
of that. To decide to OOM, we need to look at a very diverse set of
metrics and it seems like that would be very hard to do flexibly
inside the kernel.

>
> I sent a patch for android lowmemorykiller some years ago.
>
> http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2017-February/100319.html
>
> It has been improved since than, so it can act handle oom callbacks, it can act on vmpressure and psi
> and as a shrinker. The patches has not been ported to resent kernels though.
>
> I don't think vmpressure and psi is that relevant now. (They are what userspace act on)  But the basic idea is to have a priority queue
> within the kernel. It need pick up new processes and dying process.  And then it has a order, and that
> is set with oom adj values by activity manager in android.  I see this model can be reused for
> something that is between a standard oom and userspace.  Instead of vmpressure and psi
> a watchdog might be a better way.  If userspace (in android the activity manager or lmkd) does not kick the watchdog,
> the watchdog bite the task according to the priority and kills it.  This priority list does not have to be a list generated
> within kernel. But it has the advantage that you inherent parents properties.  We use a rb-tree for that.
>
> All that is missing is the watchdog.
>

Actually no. It is missing the flexibility to monitor metrics which a
user care and based on which they decide to trigger oom-kill. Not sure
how will watchdog replace psi/vmpressure? Userspace keeps petting the
watchdog does not mean that system is not suffering.

In addition oom priorities change dynamically and changing it in your
system seems very hard. Cgroup awareness is missing too.

Anyways, there are already widely deployed userspace oom-killer
solutions (lmkd, oomd). I am aiming to further improve the
reliability.
