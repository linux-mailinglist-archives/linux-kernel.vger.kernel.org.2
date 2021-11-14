Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728EB44FBC8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 22:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhKNVXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 16:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbhKNVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 16:22:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A2C061204
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:19:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id e3so26337577edu.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLOzaJoltjKDQvEecFuRyMKdXpesuCtjS9ImEoetX68=;
        b=A6imnwSJ5wijhFoiuKjwmqxVd2U5hUIwuDALT577iJiJfKzSv3cYYkDsVT0CmJpHjf
         5Fku9qXEQDUbAYgg+dxRr5Iab7Cnp7PIDhz1EmhL9SVS6htM66mxHHcZasRZYpGwAAYD
         gQ4EfHLNgnsPG4SxZkDwu/bu2O3ew33sMOq1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLOzaJoltjKDQvEecFuRyMKdXpesuCtjS9ImEoetX68=;
        b=IcftUC/pl9V7Zqn4z2+jPaGSXQqC6GD3VL0FZxMx5l5qQIyFs9dqn3eJbtOl/NYLCP
         Xpv/+yOndB0P1KBM7dQSHE4Flspw88aG9Y8DgoQv91B2mUTBjIbKKjXGFho49msznSo8
         JbYO7qloRhs4ecd53WfAiMbUFCPFev9pEUZNwdsT770eTLo1TbX2h6SRMr/e2fOw16Cb
         X6AbhU5aqx0g5tf+lft1qqzi2D/PKej+HUw6hEduiTsUw735kX0S/NFrv2ue0zuKOApl
         xQ0aT0mElsudph13KsQqaS0gt0WFnM+GpHC8kuWf6BeBAbUyVNhhWBn1hQXyGLUs0FHZ
         QTnQ==
X-Gm-Message-State: AOAM533DMjdSb+tdg0w4y9y939ilm2Lzwq1XP/E25Ocz0Un9n6Dz5If7
        doDjYzywsYyKhLwg5i5b+NP0mfHixI4GsPif
X-Google-Smtp-Source: ABdhPJwtm1eOibNeNgRLDh/qcCelJzSnTRm6bhkWaJxdiB/Hb0Ckt+ojZpW3GPEFLQlpbxBB5HjZqA==
X-Received: by 2002:a05:6402:26cb:: with SMTP id x11mr46015216edd.127.1636924781261;
        Sun, 14 Nov 2021 13:19:41 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id d4sm6268495edk.78.2021.11.14.13.19.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 13:19:40 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id i12so11374424wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:19:39 -0800 (PST)
X-Received: by 2002:a7b:c005:: with SMTP id c5mr55506005wmb.155.1636924779662;
 Sun, 14 Nov 2021 13:19:39 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txVydO1fy8sEwVXRZF0zPfWwLYrk-UnGeKhRCEvrW4B7Q@mail.gmail.com>
 <CAHk-=wiZdONN=1Er5eN1bYurrWqhXF7LxQszpPia8hvYUOiZWQ@mail.gmail.com> <CAPM=9tw=NTZ-1NbGupgg42gOA1aFKZ2C6wt++q5BxaocaUbmFA@mail.gmail.com>
In-Reply-To: <CAPM=9tw=NTZ-1NbGupgg42gOA1aFKZ2C6wt++q5BxaocaUbmFA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 13:19:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpPWyH5ff0LE8Mmt6OEiYbD3LwpvpD==FFZfTMTzL2FQ@mail.gmail.com>
Message-ID: <CAHk-=wjpPWyH5ff0LE8Mmt6OEiYbD3LwpvpD==FFZfTMTzL2FQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes + one missed next for 5.16-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 1:00 PM Dave Airlie <airlied@gmail.com> wrote:
>
> i915 will no longer be x86-64 only in theory, since Intel now produces
> PCIe graphics cards using the same hw designs.

Well, at least in my tree, it still has the "depends on X86", along
with several other x86-only things (like "select INTEL_GTT", which is
also x86-only)

So by the time that non-x86 theory becomes reality, hopefully the i915
people will also have figured out how to do the cache flushing
properly.

And hopefully that "do it properly" ends up being simply that the
particular configuration that ends up being portable simply doesn't
need to do it at all and can statically just not build it,
sidestepping the issue entirely.

Fingers crossed.

.. of course, I'm also sure some clueless hardware engineer is still
convinced that non-coherent IO is the way to go for graphics, and that
doing cross-CPU IPIs to write back all caches is somehow still a valid
model. Because some people were still convinced about that not _that_
long ago. Hopefully reality (perhaps in the form of Apple) has caused
people to finally reconsider.

                 Linus
