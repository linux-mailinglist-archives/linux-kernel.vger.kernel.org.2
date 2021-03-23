Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58E5345B98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhCWKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhCWKCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:02:30 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A1C061574;
        Tue, 23 Mar 2021 03:02:30 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x189so2381228ybg.5;
        Tue, 23 Mar 2021 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qp/jj3l6ivGZ4OXCocertOe4BVJnz1tKssW/YzmGbTA=;
        b=gJuXXYMuBphx+t5hfk93Y7sfNFPYwhbjIw3T8P7KTZv5AR9YQ4Y0OOiEXzTlu3oo57
         crZ2GYH2sClMfNM12fQOVFB4DcyXeyCzGpZ9fit7gX4nYw1de8CsJ55YlLUb56WzSUwy
         TIAfMPbTFDWkuuBaQTTfwEzsr8GkFTEzeQQEpHWJTrjgqAtAgAo5o/UjcIcMhv9s4lGV
         MsdeVqUEza/b/LRrElL1NtVHI7ChbPkgtMXdtoJNDKSRQsFPCBgCOOz50hQhOVDd7R30
         6rh77lFlSCkHHoCnzIj3FwHAXgBj1N3xpoOGwB25mXsFh+wq85GheT3NMuG9IpPVaNfx
         UnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qp/jj3l6ivGZ4OXCocertOe4BVJnz1tKssW/YzmGbTA=;
        b=e1A1Q2TBkbtDWQmE7X5Z7u3kkGLrxcmw3YxVas+rfPylkQDP0VuFoow1yBF1kp6yX4
         cTBmax9nH5NDg2uewGFkWuXqxyB0XvJjOu/DhclANA/LzU1GWHwVLSA4c5dxGelNFs2F
         KXZXDnLRsRh5BRtK0CyXDg4RsmnO0iWPnLx+J7dkRtipsfUfXZt3dvTLg8tUIaDq/zJi
         QyQIKKDV/8KFTYnAwaixtCa2TuShht6XPTkfIFHGQ7ult0B8jIjHCJ5ogyl7/uYECMDF
         xs3HsAkbNR2YsojWt0Tz5zWIj9Yr7T79ac5+tSfzHKBMA5V87yZonKh5QXSJzr5uDuHI
         SH8g==
X-Gm-Message-State: AOAM5335OhsOgkvU+ojRHEQqOlKVUjPHEjiVImOPcAuYLZ0VZtm2QBZx
        y5DUyjfkECUK8kqhff6kT/o0zwPsZVtgOMCXPFI=
X-Google-Smtp-Source: ABdhPJylVauAaSy0QdnuaN0wsPp5eKvLs3gWNjOyhWw54JITI4zXzthk13t3k6s1NdoyOmuw9hraEbpQt1uXgHEBJaQ=
X-Received: by 2002:a25:6e02:: with SMTP id j2mr4055149ybc.247.1616493750049;
 Tue, 23 Mar 2021 03:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210323032624.1039422-1-mpe@ellerman.id.au>
In-Reply-To: <20210323032624.1039422-1-mpe@ellerman.id.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 23 Mar 2021 11:02:19 +0100
Message-ID: <CANiq72n-tMww2U+eQ=iHOh5u1JQgjM0b1E3XQ9jpWMfpdQ5+=g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Rust for Linux for ppc64le
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     rust-for-linux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, Mar 23, 2021 at 4:27 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi all,
>
> Here's a first attempt at getting the kernel Rust support building on powerpc.

Thanks a *lot*! It is great to have more architectures rolling.

> It's powerpc64le only for now, as that's what I can easily test given the
> distros I have installed. Though powerpc and powerpc64 are also Tier 2 platforms

Even if it is just 64-bit, it is very good to have it!

> so in theory should work. Supporting those would require something more
> complicated than just pointing rustc at arch/$(ARCH)/rust/target.json.

Yeah, the arch/$(ARCH)/rust/target.json dance is a placeholder -- I
need to figure out how to do that more cleanly, likely generating them
on the fly.

> This is based on 832575d934a2 from the Rust-for-Linux tree. Anything newer gives
> me errors about symbol name lengths. I figured I'd send this anyway, as it seems
> like those errors are probably not powerpc specific.

Sure, feel free to send things even if they don't work completely.

I will take a look at the symbol name lengths -- I increased that
limit to 512 and added support for 2-byte lengths in the tables, but
perhaps something is missing. If I manage to make it work, I can add
ppc64le to our CI! :-)

> Michael Ellerman (4):
>   rust: Export symbols in initialized data section
>   rust: Add powerpc64 as a 64-bit target_arch in c_types.rs
>   powerpc/rust: Add target.json for ppc64le
>   rust: Enable for ppc64le

Regarding the development process: at least until the RFC we are
working with the usual GitHub PR workflow (for several reasons: having
a quick CI setup, getting new Rust developers on-board, having a list
of "issues", cross-reference with the Rust repo, etc.).

I can take patches from the list, of course, but since we are pre-RFC,
do you mind if they get rebased etc. through there?

Thanks again!

Cheers,
Miguel
