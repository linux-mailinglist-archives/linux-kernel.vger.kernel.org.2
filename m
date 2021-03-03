Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4B32BCA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377915AbhCCOab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842963AbhCCKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:09 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C75C0698E2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:24:54 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p186so23809723ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlxeqDLui4YIX/OHi7qYVIzSW877dMsjl/oW0nGbxr8=;
        b=EKe3D+8/PZd2Ys+eUG7dyHPeS9nF9J0DwTHbXufUVvf/c/DAFoKoR2uIa2wxf2gvOs
         Iaw9mQFwbWTmPBOdsKVavrKmIq8+YlI4UQxfkt0OqJRGodp0vdvsjvsTLk/d7TQkxwBT
         qF0ghhUY45wKrLdkOee3+M53tSKIncDB2MvYxFC5wHVFwF5vJT/ADY7i7D+VsfTB8ET9
         yz806ii6HlsFf8HIepDfSsVugP27mm2g8aRNwAGNgntDdRlim3aybhKf2ZIdf9MKSGnb
         5vXqpjEU0hqikQj4595pLbGztShkqFWNozZxTDQ09urCYN9d32fPHpwBiD1fZ3ZIpQPz
         Airg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlxeqDLui4YIX/OHi7qYVIzSW877dMsjl/oW0nGbxr8=;
        b=ioWhS49Rbw2k4szhlabmSAVvivCLQFSeiQ61+4Kio3+AnUkD89Vrj05NVMpPpD9hxw
         Q2Z+6ZUX60/SRzdpASX59P2CsJezFU5lGtG+wfAhmSL4dcnqxmMzBG/LpqLF35SlXwPV
         rKI+Op53eJ+gwa5RWgP7ge4Npg0HHDY0iiVMaOE/KahPy1eMdpf9CEPAY4Kfb8wiRtzp
         XRaJbXFA6axjI6ZTm0Mp/6mtEgdfN3o75iVNWzzyPo2izyPuufJWhfUP/zoIt5va9a60
         uBTP7/ljTab2iADCTqIuO3LZeVyZAMSs8GXt1s8D7yNHwGmpPqWWWYnql5J3wQO3PbcJ
         XQGw==
X-Gm-Message-State: AOAM531RjzSb3koHRGLzCk1vtVpD44ko54Oa3sxkFApKPl1HJPHwOPaL
        8hhrs2E64MrarQHQJcUwZTXE7yjjFqLw0UIhNR74hg==
X-Google-Smtp-Source: ABdhPJxDhlwvDHh2ueUCUXGNtxH32QmSZuQ4/Fj8d64FWXWkDEabIEG3KntXg7pq9IXIZqKWvBFgPYrDSmUUZO+u7wc=
X-Received: by 2002:a25:dd43:: with SMTP id u64mr2786208ybg.96.1614763493934;
 Wed, 03 Mar 2021 01:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com> <CAMuHMdU4rJaMFUS8ukUgqYjTGY41Pa3iQQpKiK8qJA6YnDJDkw@mail.gmail.com>
In-Reply-To: <CAMuHMdU4rJaMFUS8ukUgqYjTGY41Pa3iQQpKiK8qJA6YnDJDkw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Mar 2021 01:24:18 -0800
Message-ID: <CAGETcx8F+cC5wrSRb8qzLyHfxUNtyOoy6-m+YbxRgp09k9fp9Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 1:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Tue, Mar 2, 2021 at 10:11 PM Saravana Kannan <saravanak@google.com> wrote:
> > This series fixes the last few remaining issues reported when fw_devlink=on
> > by default.
>
> [...]
>
> Thanks for your series!
>
> > Geert/Marek,
> >
> > As far as I know, there shouldn't have any more issues you reported that
> > are still left unfixed after this series. Please correct me if I'm wrong or
> > if you find new issues.
>
> While this fixes the core support, there may still be driver fixes left
> that were not developed in time for the v5.12-rc1 merge window.
> Personally, I'm aware of "soc: renesas: rmobile-sysc: Mark fwnode
> when PM domain is added", which I have queued for v5.13[1].
> There may be other fixes for other platforms.

Right, I intended this series for 5.13. Is that what you are trying to say too?

-Saravana


>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/commit/?h=renesas-drivers-for-v5.13&id=fb13bbd6c90ee4fb983c0e9a341bd2832a3857cf
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
