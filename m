Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D340B3D6F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhG0Goz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhG0Gox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:44:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D24C061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 23:44:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q2so14583041ljq.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Euv6d/VBn7xvedb0PcbV5a82pu9t4491iTmwHLNJp7I=;
        b=RWdMBsMjYyJoxlc/1RTqMFBbaC2BMCSQiiV07WITf1eAPO7CdkgOCGLOi85FCEytyG
         epbIRnbdA64sEVrCWsA+Sjzgms3sc8nhuX1+nYHpHoGfaWREoLPxrN0+0qUFEVo3jBu5
         TJd06PEdQUlVpDDylyAWH/jbeyIPyTIQpdGDd3duk0GK4HkIVbXt5RIZyJRjhTLVSbnF
         XyE4b8SzFvCaCSUkH3TzVyN/Z/yBhQrstGZUxPpjdKZYQWOHZaEB3U1QWc/OgFXL4AL6
         sbdHBNs2OkPvH5NhRlwEwicjEFFQ+GaV6kM+oBVOHqMf1eUehW4WeYqI+mDfDDC/U2ye
         b3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Euv6d/VBn7xvedb0PcbV5a82pu9t4491iTmwHLNJp7I=;
        b=OaT5y/Gk34ZwxFzBp2kV/TIXDDfmeECgW2C/mMI3dPybFSVWScEpmCn6RUOjqNFf3b
         AMieRAZXqSJdSkSVcgFO8o9PhiFALjiDSHYxZDoRveGL3vOV4Zuvmx9Ep1ZLD8OYu+tI
         0R7Swca1NAWDEpUloeU48xEiX4LbtKWmpLL+rey0oEKGPHUY61MPOhcq053KAm9xsf59
         sw2VQUp2kSJYMl/Lk2+LJSI/34D2Xad2MkbPxxP24vTHmZui+FhBZqn02dcrEw0wsf9F
         L1A84twZs0TBJ7ve4WFUNsbXWlt1FM7EGeIIvvC3a9SiHmpxvM1U5b8f6YJy7x+V47+E
         e1Uw==
X-Gm-Message-State: AOAM533qe524W4MQ88DMXNozK2DdeBSIzZDui3wwwU33VoJzp1m7IZ4M
        Joewxa7YoOxfXgERhxhCQn7n8Vnw9IcaYRwaE1VS5g==
X-Google-Smtp-Source: ABdhPJzq0Fsp4qp/oShAU3CX3SOYXu2fOzINrumumJNLnru2/faR/ptZ3+uAR8T9Dzi8Ww6cc7Eyh8Xe5vW2UHcp6Gw=
X-Received: by 2002:a05:651c:906:: with SMTP id e6mr14076066ljq.160.1627368291446;
 Mon, 26 Jul 2021 23:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <045db11f-4a45-7c9b-2664-5b32c2b44943@virtuozzo.com>
In-Reply-To: <045db11f-4a45-7c9b-2664-5b32c2b44943@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Jul 2021 23:44:40 -0700
Message-ID: <CALvZod6YaVBqV_LrqgXO13kBS20uoXdm5EGx2CJfBfPC9yj6Cg@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] memcg: enable accounting for mnt_cache entries
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:33 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> The kernel allocates ~400 bytes of 'strcut mount' for any new mount.

*struct mount*

> Creating a new mount namespace clones most of the parent mounts,
> and this can be repeated many times. Additionally, each mount allocates
> up to PATH_MAX=4096 bytes for mnt->mnt_devname.
>
> It makes sense to account for these allocations to restrict the host's
> memory consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
