Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EE03FE28A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbhIASwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244423AbhIASwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:52:43 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8D8C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 11:51:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so971812otf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpMrHx2xrjALxDo2+qnSwUhR97fWUA7NiL67FnzoBbs=;
        b=e0RtJHV/x1N7itMnl6FhNdz+AWN7rEUsOba8pGEb/GUQf8QzzGBLO/6NdlnDBtHOAL
         mZTXK4KBBNp4du3di0UJDTtOGr2LkdET0W2eonjElLZhYtR3s4XT2F0/509vgq3dZUv/
         xpMndW6JBu3Uc/gxHrcFHsach9TXFR+W7WmwlaUBqId3hsBiXeqjSdJRjZwLBiBaApA3
         8AhN3BCUrjIgmcYriMpojx7fTh1kFKpSTudSN3SXNFsLwl50DSbqomsVHQ691wcTRzJz
         I0nEDJsrLfT7YBpSxVVmncx9NZdGd5+tKZVl2SuQ1G0r115AYm+uPOfDPTbFz8CNitj1
         1yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpMrHx2xrjALxDo2+qnSwUhR97fWUA7NiL67FnzoBbs=;
        b=qbwxQ8EnWkOMNdlt7m5OhTLPWKO52hTpYNFiWiJuhBd6nwZt4lTDaqOXr/BWUEhDjW
         6AAGe6BLrAVsg/h23bUf7jm6gh4GUW0u84angdx0608mjmR+KdinRjO+uOI+oARr3wd2
         K+joxnsGhc57C1kGu8x1QxODie1d7aU3Gyi0PIHgf2LkLnmkwRRWXPhViudRB4EabgPP
         Sdbv6sgSlSWX6EczDK4oQS3MIu0Hjkgyst4ZqaYtvV5kVWkKtGfv8MfDK1IQDK0cnWIe
         OazmUk7YKANO45dx6Tau+eUOydsMYTon5b5V8EfDvQAhwNItOnDqwnOvvczMV9wxjEkl
         vPKA==
X-Gm-Message-State: AOAM533YTLx3nGrpFb0UEgflXb21V8B0PVa8IfQDMJR4Y3MXSKLSiQ3Q
        /5OSIKnCT5zcb/ofYhlytoX6nQH4J+0X97OaPRD83wjk
X-Google-Smtp-Source: ABdhPJw8t4vsqP/7Q9PflPtjlczDwGn9Ca+aw7OmDyIMY4azGHA/6DyJI9o6HDQ2fy8EvZf613m/TDLq3FE8zD/9Jl0=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr765105otp.23.1630522305399;
 Wed, 01 Sep 2021 11:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txeN-qCRJvYV552zdo2H9iVy1ruVrq=YdZBP5Dmpc3Jmg@mail.gmail.com>
 <CAHk-=whP_v5nrK9B5vefnZS6Xz3-vZDFxUvSmW8W82hhNh67sA@mail.gmail.com> <CAHk-=wiyPpwYLBXTdXi0DyMFhTKsTstmqU-LLjgD5fNxUnB_WA@mail.gmail.com>
In-Reply-To: <CAHk-=wiyPpwYLBXTdXi0DyMFhTKsTstmqU-LLjgD5fNxUnB_WA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Sep 2021 14:51:33 -0400
Message-ID: <CADnq5_N9GgDuAdLmYED19Mx2z=5fhc1JCPj5_icFMZ-U1bO-Sg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        John Clements <john.clements@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 2:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 1, 2021 at 10:57 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > No worries. I enjoyed seeing the AMD code-names in the conflicts, they
> > are using positively kernel-level naming.
>
> Oh, I spoke too soon.
>
> The conflict in amdgpu_ras_eeprom.c is trivial to fix up, but the
> *code* is garbage.
>
> It does this (from commit 14fb496a84f1: "drm/amdgpu: set RAS EEPROM
> address from VBIOS"):
>
>         ...
>         control->i2c_address = 0;
>
>         if (amdgpu_atomfirmware_ras_rom_addr(adev,
> (uint8_t*)&control->i2c_address))
>         {
>                 if (control->i2c_address == 0xA0)
>                         control->i2c_address = 0;
>         ...
>
> and honestly, that just hurts to look at. It's completely wrong, even
> if it happens to work on a little-endian machine.
>
> Yes, yes, BE is irrelevant, and doubly so for an AMD GPU driver, but still.
>
> It's assigning a 8-bit value to a 32-bit entity by doing a pointer
> cast on the address, and then mixing things up by using/assigning to
> that same field.
>
> That's just *wrong* and nasty.
>
> Oh, the resolution would be easy - just take that broken code as-is -
> but I can't actually make myself do that.
>
> So I fixed it up to not be that incredibly ugly garbage.
>
> Please holler if I did something wrong.

Fix looks good.  Thanks,

Alex
