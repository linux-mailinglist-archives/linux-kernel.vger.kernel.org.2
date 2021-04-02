Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30EB352F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhDBSp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:45:27 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F01C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:45:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r193so3235764ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/OThl2TJ86i+d/Z9onNMKzzml/86evlKk1D8sXUWm3s=;
        b=spoXp4ymwf+FzwwvTbLnfHRGKw2cJp5whg010ZpGpMj7Je/U9GpUX6h6Shj6vEnj2V
         2pp5bM13UMj8HBbM4e2Vp0mulbICA5btgWbxg5n8kuhbvRBwdQ2Sqxcr4EXaXFrFyGCy
         hzWx5OJj9NkNVwIpEQSB2Nmw9EqP5y6PpWTSmkRP0+RAxS5p4DSEeMb/nOfHbuZjXzSn
         aFIusYmUpIEbZM8XuaIqO1SXNamHYjSKcmwZSKPDq9TbxZs8POr5ji4EDRBgo9lLzglR
         q1FL2F4XNE+T4ISBWzkZfA8NAk3Tcm7mFWPxpn/Y6/+fa9GcFZBsUPajvlorufdoNmpS
         VoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/OThl2TJ86i+d/Z9onNMKzzml/86evlKk1D8sXUWm3s=;
        b=EY1lUybvTvuzo/9oZk7X/y9p4AY+BeECVMD1/adEGPns1wy/NOjJP9yz20I8qIZmc+
         8OL1OrAPRbvnFR5Uv/Q6d9120WKyxFn1+dlZlZq+dIYfdzqPfFbOV5FG9b2dLzADZLfO
         7neyOgg5T9V7T0kAhPFNkMvyEQ6731qJDEjRlTbTRGuX+JVVOFWr6KLQxo41NKUMfnkC
         UKW7sIJBIMU2iflxSyfPQOLfKsvwzUIRuVZDxt0NAuZYM6vJUA7M9Zw4waKvoCC4scXS
         M8e3LbqMb93CuFSPgLaTOXKDSFrAGbXk6ECgOaq278nBN3doySqCE+lFe9rp+JH1CBOi
         SNNw==
X-Gm-Message-State: AOAM533RlpuLv0RqEvbzteoxSo17lWB/dlFKHG4viraWEN53hu62wDnh
        tx0QY5FkEY+2HA2/Njc9RqIAmgPX4Z22TA5Ox2A=
X-Google-Smtp-Source: ABdhPJwIz5lMeJXF/ig31xaHINMB9NbZhAF9rqQ90Plamzp40mgR8F+megcIBShLyOw7K3egXeMkAPSODarClDsRkNY=
X-Received: by 2002:a5d:9d13:: with SMTP id j19mr12186378ioj.110.1617389125411;
 Fri, 02 Apr 2021 11:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210211194258.4137998-1-nathan@kernel.org> <161428829728.2305454.15456455443457551559.b4-ty@chromium.org>
 <CA+icZUWdeWSy52bU4cjHau1hn5NiFAozaHgDb=geaaCYOET9+w@mail.gmail.com>
 <202104021125.53164550A@keescook> <20210402183110.zmnuoc74mzil3tml@archlinux-ax161>
In-Reply-To: <20210402183110.zmnuoc74mzil3tml@archlinux-ax161>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 2 Apr 2021 20:44:49 +0200
Message-ID: <CA+icZUXvqF79a=zSOxrshSK3gZHFpPQa=U=MqrK6cnu7Cvmq0A@mail.gmail.com>
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        qemu-devel@nongnu.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 8:31 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Apr 02, 2021 at 11:25:42AM -0700, Kees Cook wrote:
> > On Fri, Apr 02, 2021 at 08:42:07AM +0200, Sedat Dilek wrote:
> > > On Thu, Feb 25, 2021 at 10:25 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Thu, 11 Feb 2021 12:42:58 -0700, Nathan Chancellor wrote:
> > > > > fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> > > > > which violates clang's CFI checking because fw_cfg_showrev()'s second
> > > > > parameter is 'struct attribute', whereas the ->show() member of 'struct
> > > > > kobj_structure' expects the second parameter to be of type 'struct
> > > > > kobj_attribute'.
> > > > >
> > > > > $ cat /sys/firmware/qemu_fw_cfg/rev
> > > > > 3
> > > > >
> > > > > [...]
> > > >
> > > > Applied to kspp/cfi/cleanups, thanks!
> > > >
> > > > [1/1] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
> > > >       https://git.kernel.org/kees/c/f5c4679d6c49
> > > >
> > >
> > > I have queued this up in my custom patchset
> > > (for-5.12/kspp-cfi-cleanups-20210225).
> > >
> > > What is the plan to get this upstream?
> >
> > I haven't sent it to Linus yet -- I was expecting to batch more of these
> > and send them for v5.13. (But if the kvm folks snag it, that's good
> > too.)
>
> I am going to be putting the CFI series through its paces on both arm64
> and x86_64 over the next week or so on several different machines (in
> fact, I am writing up a report right now) so I will probably have some
> more of these as I find them.
>

This was just a friendly ping.

Sami has sent some patches which I reported in the early stage of
clang-cfi (x86-64) through subtree maintainers.
It's up to you Nathan or kvm folks.

Upstreamed patches means to me a RDC-ed custom patchset.

- Sedat -
