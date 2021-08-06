Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117563E2FA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbhHFTEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbhHFTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:04:33 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 12:04:16 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u10so13451983oiw.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 12:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZT01TgKF7XEqpoPOtmHqdd4Je83vC9seFylZrpeVCdA=;
        b=FuYNCKMVlDxEyxLAFTn6GTmFGUClvbPOEIqm19dmqWKjyvX23E7TB2UtaN7dunkEy2
         rR0BdBfVPQWaBEn9jOBdSTEigT6DWPwlVfMJyMfK1H/9RzqLdgxNZTU9/E9aBRWHag3D
         xjb1rVQgTKVqCkqhqQwA3A5XlEj209kuKcyhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZT01TgKF7XEqpoPOtmHqdd4Je83vC9seFylZrpeVCdA=;
        b=iCeKPm2MNwnjAyUEePpvkbEMiLvCCzhmLOe+nLb1V8TyUDq/7OhHxR5i9CHbnXHq15
         OqBbWQ24dDPA4uFT/x210JOx3Ma0yrA+EjmpzKv2bOICtwNM6OrANX6q+DsUFH+eVQui
         QR1nBpWXvbtXIsDAwpxI2+T0yXViIvepkQdJvHW0VGCQFw0pp8+1ISYcAEvqIHaGXVzA
         z7gK5gGHjfBCDm5VPRI9dkh+f+UKrkxMKkYryvOdlleHgh3QE3zmnEbeI0YMoLToIl13
         kDCKguKgZbqMl8S9PlCV6UXtBO+X1Ca914Molwu9XJhrCDPMs4klHeMlKts5gF7yspZ1
         L4xg==
X-Gm-Message-State: AOAM531HgaaS0Phu79TO/+sZmWALJoPUNeVlmkkI1wPFFCv4Fk773JWr
        jkWyXpKN/7VR85WscXHz0w1TERGGj5FaNGDoJt+z7w==
X-Google-Smtp-Source: ABdhPJxTe7LFcmOjLVVGjEdWd9gISgLJkJ0MFlfg8DYRX8l5ebEcO6EsoWzJ3WCmYSU6KmFJS0sFVjcQ33W6I8Ibr8Y=
X-Received: by 2002:a05:6808:3b2:: with SMTP id n18mr6045462oie.14.1628276655861;
 Fri, 06 Aug 2021 12:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twko1gCNTB3CPf7CAQqWFayMj=1fa3ZoEwwviDFhF48kQ@mail.gmail.com>
 <CAHk-=wgYq=EpNmDPNVxnBX+HpjNcQg50DSjuxZuK0UbZjh-pnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgYq=EpNmDPNVxnBX+HpjNcQg50DSjuxZuK0UbZjh-pnQ@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 6 Aug 2021 21:04:04 +0200
Message-ID: <CAKMK7uEnPn=Tuc7bV-=Nr7gbk+uP9L0xH+HDL2+D4PewMmq6Cg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.14-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 8:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This might possibly have been fixed already by the previous drm pull,
> but I wanted to report it anyway, just in case.
>
> It happened after an uptime of over a week, so it might not be trivial
> to reproduce.
>
> It's a NULL pointer dereference in dc_stream_retain() with the code being
>
>         lock xadd %eax,0x390(%rdi) <-- trapping instruction
>
> and that's just the
>
>         kref_get(&stream->refcount);
>
> with a NULL 'stream' argument.
>
>   Call Trace:
>    dc_resource_state_copy_construct+0x13f/0x190 [amdgpu]
>    amdgpu_dm_atomic_commit_tail+0xd5/0x1540 [amdgpu]
>    commit_tail+0x97/0x180 [drm_kms_helper]
>    process_one_work+0x1df/0x3a0
>
> the oops is followed by a stream of
>
>   [drm:amdgpu_dm_atomic_check [amdgpu]] *ERROR* [CRTC:55:crtc-1]
> hw_done or flip_done timed out
>
> and the machine was not usable afterwards.

Hm that part is a bit disappointing because the atomic modeset commit
helpers are designed to recover from this (assuming we didn't fry the
hw). But amdgpu does these waits in amdgpu_dm_atomic_check() which is
decidedly not great (you're not supposed to block on hw or a previous
in that atomic_check ever, because it can be called by userspace in a
TEST_ONLY mode to figure out whether a desired config would work), and
then returns that error to userspace, which is worse.

I guess that's another area where the integration between what atomic
modeset expects and the DC backend provides is suboptimal. I think the
data structures we managed to fuse together fairly ok, but the
check/commit flow and semantics are a bit a struggle.

Anyway this was just an aside, I guess given the bug the driver
wouldn't have recovered anyway.
-Daniel

> lspci says this is a
>
>  49:00.0 VGA compatible controller [0300]:
>    Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
>    [Radeon RX 470/480/570/570X/580/580X/590]
>    [1002:67df] (rev e7) (prog-if 00 [VGA controller])
>
> Full oops in the attachment, but I think the above is all the really
> salient details.
>
>                    Linus



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
