Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9032EC74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 14:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCENrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 08:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhCENrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:47:11 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD3DC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 05:47:10 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id a13so2588259oid.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 05:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SInNMXqsGtA9/hulueI4v7s5Z4FGO7USmnkW6ykDyNk=;
        b=DhVOTTeNEWGP7nvs0N/96ctaUuIi3XAgBRwWEtcDF9LYjBWCG9/iF2Z2IeAfgY9gSk
         EuxxAQT4/gGX6oWuIsL6s1QIwBjSRsL2dc7lgry22R6oLBArIyQwgw2T1gFk3S+cGX+q
         Hx7usAEK/x12IwalJNVxcV6vyfULFvH09nCkI8BKgJ2tE+n1rlu0+POxAoWC/QLasjmI
         LGeYlSTK5JxCH23E0aZKYzbMAlfwLAkH8DVqxUtkJDTwZlLL1f4UaDgFPUbxJtmdX3ao
         m8DaAsVeHxyL9TdQxZTB0Rg+TiMf5JfAQsFOB+islX108CeCvfwMT1fIi6W4EdAyn7hF
         qODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SInNMXqsGtA9/hulueI4v7s5Z4FGO7USmnkW6ykDyNk=;
        b=e/KksqQ2pc8bZSTk+cPMVktZPlpafbgbXApZQcxKCePWOFUN2FzFm0Zf7qVfydtAUV
         /bvbCrWIumspH5x5zWGk/iIwctCKfXyaCftlAfJoVtcfedHquxPllaCxLC3Jb38HI4ow
         q9HwKAQ+3z5y1BYhpn8STH4c/nVEaTiOoWOvYxuz/09CekN7Y6WPB1YH3BUPkdnJ3MnP
         ivkmHCwMWUicT6zGJZ9UfcaLd/Vaw0jYrEv8AExMyaiZlc/34/7ZCdy68GqdICvZ2vjI
         COX80HgLzdZx+C4zmLx/3Oj2gBeg+QYXX7g2viQWBL6aCTq4PmtqViehEVAUOSVFwZZm
         VYjQ==
X-Gm-Message-State: AOAM532DjdnWEMdNaq6a/n/EfOLdIdQxb5Hv8VjMRZnZBGc5hPlKM+B0
        f2MuC5x8PJtf1k0564XmmWzOrMNZDuYODmlucCCS5g==
X-Google-Smtp-Source: ABdhPJzSLALcuCZpE3cEHOvqGJGgFlt2enFY7q4Ev6KGRAIV11AF0b9dUVgfJK1I9YZPXDk6vk12D8KHVvIvf6hKa6U=
X-Received: by 2002:a05:6808:10d3:: with SMTP id s19mr7309520ois.70.1614952029845;
 Fri, 05 Mar 2021 05:47:09 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNPGj4C2rr2FbSD+FC-GnWUvJrtdLyX5TYpJE_Um8CGu1Q@mail.gmail.com>
 <08a96c5d-4ae7-03b4-208f-956226dee6bb@csgroup.eu> <CANpmjNPYEmLtQEu5G=zJLUzOBaGoqNKwLyipDCxvytdKDKb7mg@mail.gmail.com>
 <ad61cb3a-2b4a-3754-5761-832a1dd0c34e@csgroup.eu> <CANpmjNOnVzei7frKcMzMHxaDXh5NvTA-Wpa29C2YC1GUxyKfhQ@mail.gmail.com>
 <f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu> <CANpmjNMn_CUrgeSqBgiKx4+J8a+XcxkaLPWoDMUvUEXk8+-jxg@mail.gmail.com>
 <7270e1cc-bb6b-99ee-0043-08a027b8d83a@csgroup.eu> <YEDXJ5JNkgvDFehc@elver.google.com>
 <874khqry78.fsf@mpe.ellerman.id.au> <YEHiq1ALdPn2crvP@elver.google.com>
 <f6e47f4f-6953-6584-f023-8b9c22d6974e@csgroup.eu> <CANpmjNM9o1s4O4v2T9HUohPdCDJzWcaC5KDrt_7BSVdTUQWagw@mail.gmail.com>
 <87tupprfan.fsf@mpe.ellerman.id.au>
In-Reply-To: <87tupprfan.fsf@mpe.ellerman.id.au>
From:   Marco Elver <elver@google.com>
Date:   Fri, 5 Mar 2021 14:46:58 +0100
Message-ID: <CANpmjNMzY-Jmd9v9MHYqeQ934V91D25vtj85HwJkYuXS2a+4Yg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexander Potapenko <glider@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 at 12:49, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Marco Elver <elver@google.com> writes:
> ...
> >
> > The choice is between:
> >
> > 1. ARCH_FUNC_PREFIX (as a matter of fact, the ARCH_FUNC_PREFIX patch
> > is already in -mm). Perhaps we could optimize it further, by checking
> > ARCH_FUNC_PREFIX in buf, and advancing buf like you propose, but I'm
> > not sure it's worth worrying about.
> >
> > 2. The dynamic solution that I proposed that does not use a hard-coded
> > '.' (or some variation thereof).
> >
> > Please tell me which solution you prefer, 1 or 2 -- I'd like to stop
> > bikeshedding here. If there's a compelling argument for hard-coding
> > the '.' in non-arch code, please clarify, but otherwise I'd like to
> > keep arch-specific things out of generic code.
>
> It's your choice, I was just trying to minimise the size of the wart you
> have to carry in kfence code to deal with it.
>
> The ARCH_FUNC_PREFIX solution is fine by me.

Thank you -- the ARCH_FUNC_PREFIX version is already in -mm, so let's
keep it. It's purely static vs the other options. Should another
debugging tool need something similar we can revisit whether to change
or move it.

Thanks,
-- Marco
