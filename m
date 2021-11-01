Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80955441F32
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhKAR26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKAR25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:28:57 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29915C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 10:26:24 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id d204so46394558ybb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMUoTYvwXR+STBD6Thfk9xh2KZRt6xmH8b7PybverA0=;
        b=Nvvy7D7fAQI1VoGPEuH1I3hEajAtrEwoEbny4A6YqMLduutZcj9NJcjES5E5jovTyl
         t6hpIr/AFCICNAoZObkQ8fatEw0kPm8dzNKlI2AYiQhuBFBNknuCmM8Vn8ECBqJ3cckW
         pcRCP67CStOhZZ04q1dMMRBiqwP44yP1r4L0P6O4jhY2Mj+SjVYZrKcRkEmWLE94U0hs
         2B5+ptNMY6rpwc5Sn5wws/eBz595JTiU6NeMJ73GwKjyRZbtRx0S8w+TOJcX9AfIWbZV
         NvB1uPsNRl0I0yLMEjGrM7IEzSPdS+B8LEMOTGgnjh5DhAfhPX7boGtQbnv/BSRiypVa
         vKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMUoTYvwXR+STBD6Thfk9xh2KZRt6xmH8b7PybverA0=;
        b=ASxMp72+Dx5VtkszpcudNQmB9nC5qI5oOEGK6wg0cQEatfWsigRBa/ukFmEwv6qsUL
         dYpueJsqm1CONzN+oy6zI4P6Tuaf6wy6Geidl2ZRxs40Wk9Y7Ze0IQvwedNSUI50+4mg
         iuZufkuHBsgqsLje0blTrwKocFFTdxm1vp14xO00KwaI37nM7GswfR2lyjAw4Dzjc1YT
         xPlZv1EYNnlygS7u6iRCz0Sb2SXMpAHBlQzg8gx8Ibo/I4J81nm8cwB5F46C/oplF7bt
         uZ58+pLCRg2UBKFary7f4edPH8OS7F7BFBfed3SMgctLwtgRhj9Q42j80CoKc06ziN5O
         fbQg==
X-Gm-Message-State: AOAM530cLmWdbIH4BPkXpC1FwqGSckeMM8J4LJ2jCCHt5PVvguZyVdN+
        CxPkLSEIDFEVJ7s6BPWNvGpsAlys8bj8Ae/vPlI8JYpHf24=
X-Google-Smtp-Source: ABdhPJw5lByuLzF/4yOEzrWIfxIP7KxTzo9dA9yrNK3eRzAmPAnt5VI/9m8sWVNWTdchxofKGe/DY77yKpr0uW/MF0M=
X-Received: by 2002:a25:3814:: with SMTP id f20mr10990577yba.117.1635787583294;
 Mon, 01 Nov 2021 10:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 1 Nov 2021 17:25:47 +0000
Message-ID: <CADVatmN--JVRcquqXpkfdvij_SGKL4i8=Hwe1XjXtZmfdszbJA@mail.gmail.com>
Subject: Re: Linux 5.15
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 9:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's been calm, and I have no excuse to add an extra rc, so here we
> are, with v5.15 pushed out, and the merge window starting tomorrow.

My nightly testing tested "5.15.0-8bb7eca972ad" and looked ok with:
x86_64 qemu - https://openqa.qa.codethink.co.uk/tests/320
ppc64 qemu - https://openqa.qa.codethink.co.uk/tests/321
rpi4 - https://openqa.qa.codethink.co.uk/tests/322


-- 
Regards
Sudip
