Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0173FB493
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhH3LaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhH3LaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:30:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E2BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:29:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so9747063pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqz5NELXeyXyp6JpPQd/OjDjt2DKtvOMjx6kruuCx0U=;
        b=vemQ+M29g3W8l7Ms0dA5tdUsZMmMMUz5xQ78hj5neVTjzh7LdDdcHqhwYL65wUvA3p
         ms0KClM36IS7D9/aOY0uIesNNYA3o8Mc/1XOo+cO4MAR2s5b/Bty9ttCLzJitQ7bXx5R
         Z8JXTqx3hCvmNsGzmQuqBvc0HJqlJPSsbpKdU7dZo614XUvePnOh2pTc2DGQx78ES9j2
         XqDvFtR/8+1OIGK4tv+/Dt9rnRtxl7zZIMXb3PyHT+wSQHoA60ZmUQKLYqcRHZ5l8e5v
         lMq4BX3ChnMyw1ehHxzl/O6/HicuflzkDoaOxd4UwK0oVdEcmc1kRnb8HOS1MRMuj5ov
         VdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqz5NELXeyXyp6JpPQd/OjDjt2DKtvOMjx6kruuCx0U=;
        b=TsLqDJK1gkAmwbwbpwv1u2HTw5I7pFVs0jBxKQYIXdHcTLs9yeNxaAKsSj+yFrQzNh
         PgyRa9A3p7pdPUMCY4VEh6DgnorDas8BDiqRNtttQWIHbg4aGrPMzsP6c3oD5wltssiC
         9Pq54AcJdyvzGprbAhRZ9SSGcc6bdvBwutxXoSIgqltP52wbvnO94mXNmPWkWN/M6rRB
         vTwpCOoa2NKDmkk+5xsYMGOtOPHppS1ILx2aXnVCzR4XnGXU6oNH0ZGV+3uS9hVR8UAa
         +c64X2KHKrb2wAD6SHRIp5nRhavk1mRYxT2q3VFvCbCDaihhmOu1XLxJgv505ebspq8a
         VEmg==
X-Gm-Message-State: AOAM533CTEs2MLeMDNJqCt77Hu3ltQvXozDrDlMhmgwXaaICLxvfSsJh
        IxbsBKSztO4mnqN4GFR8heIc0/Xo6/IMfvdlRBlrFjkVXIk=
X-Google-Smtp-Source: ABdhPJwv67QcjUs+Lct3zm+Ohne+rUgiv0X7xu19JETF45uQyHDzA583wT5Z15PzPoT3ybf8SqYyQHCz5d0W1XnejnU=
X-Received: by 2002:a17:90a:d78d:: with SMTP id z13mr25086866pju.228.1630322955507;
 Mon, 30 Aug 2021 04:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
 <CAHp75Ve_zQctbiOkJbeL6T=5FOukGbL99kcgpLdL3Zf8DfFdDA@mail.gmail.com>
In-Reply-To: <CAHp75Ve_zQctbiOkJbeL6T=5FOukGbL99kcgpLdL3Zf8DfFdDA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Aug 2021 14:28:39 +0300
Message-ID: <CAHp75VeSOMu+xvgv81BVc8R4U9MPB=50hgQHTULyTUKO6+Rh9A@mail.gmail.com>
Subject: Re: Linux 5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 12:39 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Aug 30, 2021 at 1:20 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:

> Haven't investigated so far, but all 32-bit builds for x86 on Debian unstable
> gcc (Debian 10.2.1-6) 10.2.1 20210110
> fail for me with
> FATAL: modpost: section header offset=11258999068426292 in file
> 'vmlinux.o' is bigger than filesize=509598908
>
> (hex value is 28000000000034)
>
> Replacing
> #if KERNEL_ELFCLASS == ELFCLASS32
> with
> #if 1
>
> in scripts/mod/modpost.h fixes it to me.
>
> As said, I haven't done any work to find the root cause, so JFYI.
>
> P.S. Yes, I did a completely clean build and tried different kernel
> configurations including just default i386_defconfig in the release,
> the same error. x86_64 builds are good.

Okay, I think I found it. I have had ccache with a quite bit pile of
cache files in between, After cleaning it it seems everything went
fine.

Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko
