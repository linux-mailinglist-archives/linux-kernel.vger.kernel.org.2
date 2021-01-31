Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78A2309EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhAaUKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhAaTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:46:11 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649F3C0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:39:05 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f19so16954664ljn.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/prez2NnS5ONN2JEGbaH8ZceOC33z6jLmIIRaywDxM0=;
        b=GZl8pdXmgI/+/bvVFugC4BXdlZNhjQK1C34M0NtdchE5n0o7I5hcnwnXr2sLd4qklc
         zzMCCS2S5tJkhQp8gY8jhOSb21ViCHJMKQY/GVBvQCOCOvS0PBueqgs+DbGeREUyJKhR
         A6k5bcLDkfoPkcjuq9U5tXsGVwGC0jdpRYTCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/prez2NnS5ONN2JEGbaH8ZceOC33z6jLmIIRaywDxM0=;
        b=otgcfFFjYCG/l14jD4/iKlUXuvEYNZFGYW6sfcSjB66UqDqqorkfTPZLUGiZH0wL41
         k62+JWp3hnBJ48eKFwAB9ouw2rx0JB5Va1oiPljRnFvb0ivQkrp0gn4y0jWsX/xGtqY4
         Z1qBBEt/VZWRWJtEMhaL+/bpfWhayrvqauonxBvMa8jjh89/V7pi2kl3P1YFC8gtSQ8v
         yY11GsmbX4a4m6eptFRo1FEmHAWrz3DBMUUYsT/oTiGMZEVAENlLrUl1rDPl8dfG60XX
         QT0k5UxheV9ABnaoxNzes2jwIILveO5zHHDNLN3d6nHsxxSlmGhkpA2L2UNoERYiDgrd
         SVKQ==
X-Gm-Message-State: AOAM531T8cYy5PXSo0KRcIvvkYyzjVwqMQMhgsy+xr3x2QdErwMOuqkZ
        7siOAfPJC5G+17WlDyki/V+HKZBE4ek5Sg==
X-Google-Smtp-Source: ABdhPJzZioC2Kz9Y7hkZRKIYauuHHpPz7QEWKtffIBtPalrEpwEMCe69bifgmas32c8em1OP21XIcQ==
X-Received: by 2002:a2e:700e:: with SMTP id l14mr8122494ljc.182.1612121943724;
        Sun, 31 Jan 2021 11:39:03 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id y18sm2726570lfe.29.2021.01.31.11.39.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:39:03 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id f19so16954616ljn.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:39:02 -0800 (PST)
X-Received: by 2002:a2e:860f:: with SMTP id a15mr8349039lji.411.1612121942529;
 Sun, 31 Jan 2021 11:39:02 -0800 (PST)
MIME-Version: 1.0
References: <87lfc9cnuw.fsf@mpe.ellerman.id.au>
In-Reply-To: <87lfc9cnuw.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 11:38:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPfxVm0F8Eb0Wba_kCy9hzM6Go-qgOgP6Tf6SKhf-P9w@mail.gmail.com>
Message-ID: <CAHk-=wjPfxVm0F8Eb0Wba_kCy9hzM6Go-qgOgP6Tf6SKhf-P9w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-6 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nick Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 4:06 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Please pull another powerpc fix for 5.11:

Manual pr-tracker-bot says thanks,

           Linus
