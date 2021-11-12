Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512ED44EDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhKLUTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhKLUTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:19:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A47C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:16:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t18so22877543edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ln4RXyBHR8doDkTvzPRGiuinGe7jyzb0IrpoLwi8jaI=;
        b=NI9uAcinaqpmJx5ILSYb8lXr26e0VJqphVU5LVvNQTyPCe/3VDYqvtuqe+/DyAePMH
         CQZD+o3avI3ug403ryG6GwE0OgouZXhed9c2/svOy5d3J0x/doML+D3z48oU2DmlaBAJ
         L9bpQDojkBXy1zxmyGS4uEKJR7MtcKtD5/luM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ln4RXyBHR8doDkTvzPRGiuinGe7jyzb0IrpoLwi8jaI=;
        b=1jVXbSsxmuAK4EYf//CluUGktKGyVeYroW13CXXYxL8jDli8dGACmucVTG4vmnNuTc
         W2S3iGy2G6UFC16UAEs5aY/0sRPBAyPNxa0SIPNdQtyCkoD+lPx3Bp0inix99tUPKizi
         xYcHAfyOhE6hNyhw4fSlUad2M9DXGqJ8WTWtW8cYqU5kYA+JG7uVhL1VYplIntol/Iw9
         QZ6yee60jWI6o5TZczcaevRn/mHspR1ZzNu31JYqYk30kQhdhITWZQLFr4vkeLfiHq78
         ItSUgTH4u42kAqJIfjeZdx17n3lrJvJ5pG6h1gB0mhjZRh4vVti63UQRGmVY3GiW36Wd
         aO7w==
X-Gm-Message-State: AOAM532eZBMfvR6sosZdGOTspoU47a3iZscl9jKRsN2HV4fvsCpq8In8
        OotOtHR681Rxy4Ww+7BmPRD3YmWLo5fuQo0fl8g=
X-Google-Smtp-Source: ABdhPJzGePBzcvx01b5GsGLi1NWmTk0X0iBq/a+2dffZExMvvs5VN5lMYOcZpkUIlJ/ayHRsPdrzpw==
X-Received: by 2002:a50:d74e:: with SMTP id i14mr3847171edj.243.1636748196994;
        Fri, 12 Nov 2021 12:16:36 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id h7sm3386962edt.37.2021.11.12.12.16.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 12:16:36 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id o29so8736169wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:16:36 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr37406491wmq.26.1636748195924;
 Fri, 12 Nov 2021 12:16:35 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txVydO1fy8sEwVXRZF0zPfWwLYrk-UnGeKhRCEvrW4B7Q@mail.gmail.com>
In-Reply-To: <CAPM=9txVydO1fy8sEwVXRZF0zPfWwLYrk-UnGeKhRCEvrW4B7Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 12:16:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZdONN=1Er5eN1bYurrWqhXF7LxQszpPia8hvYUOiZWQ@mail.gmail.com>
Message-ID: <CAHk-=wiZdONN=1Er5eN1bYurrWqhXF7LxQszpPia8hvYUOiZWQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes + one missed next for 5.16-rc1
To:     Dave Airlie <airlied@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 7:25 PM Dave Airlie <airlied@gmail.com> wrote:
>
> I missed a drm-misc-next pull for the main pull last week. It wasn't
> that major and isn't the bulk of this at all. This has a bunch of
> fixes all over, a lot for amdgpu and i915.

Ugh.

The i915 conflict was trivial, but made me aware of that absolutely
disgusting "wbinvd_on_all_cpus()" hack.

And that thing is much too ugly to survive. I made my merge resolution
remove that disgusting thing.

That driver is x86-only anyway, so it all seemed completely bogus in
the first place.

And if there is some actual non-x86 work in progress for i915, then
that wbinvd_on_all_cpus() needs to be replaced with something proper
and architecture-neutral anyway, most definitely involving a name
change, and almost certainly also involving a range for the cache
writeback.

Because that "create broken macro on other architectures" thing is
*NOT* acceptable.

And I sincerely hope to the gods that no cache-incoherent i915 mess
ever makes it out of the x86 world. Incoherent IO was always a
historical mistake and should never ever happen again, so we should
not spread that horrific pattern around.

                Linus
