Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0333402758
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244858AbhIGKqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbhIGKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:46:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC2BC061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 03:45:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x5so7494554qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhJTn/hYmD9Wk3Ae1y0kn3j81X+g5ZZ10vUF/xazIJ0=;
        b=lGWSQvA4q3lNRL8NxvzZkggZekV90yLNpLGzQ3WZtKJKa12VFsuHGWkDD9YFXYpKPU
         t60GKaLauaqjjF1mchyvTS6X70zagNDbd8ZPfX/wR5lMEgBv7xW+rnrStGF4QZggwXL0
         o0hBBlWo4s4RJPPSUbZs+KLkcuc/YEu1PRsbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhJTn/hYmD9Wk3Ae1y0kn3j81X+g5ZZ10vUF/xazIJ0=;
        b=j/DAPAx+/L9ri7L2Fg3D4x6uEXCE51KlJzPCOr8S/+D2z+uQZaMrewKLlZBKeOLQQp
         abyn6+9THiSDI1pGwHC6gcbkbqtz4gOtzIhFq+Pa2h6+Nb/yGtVgcb5elBXmzC+uX4Ol
         LBTfVT4kPpa06n4KWYGFz5G+eAusNnhZ5CdqWx1Lv2lnBM5OFUMyqYZNwziF6C+qnC5m
         k2HzhSGB9iy6urLu+RZ2yCosfGZf6R0+QT3v6VRpv3T8EQrHBNZC3R+4LuaOjyGF63TF
         dM/w/dWZrVjsfTqqVcNZ0n8yZQAGNm24LiMNoZQHS4ehfAe0+oDWo1yuFSn9JTNusiL3
         bWNQ==
X-Gm-Message-State: AOAM530AQUVKnw10gjj1hBvTlWdL02AZM1JrDYoDGeeXlB99S+RPm2Vn
        fZajAf/Ub9oA38gOSuZ2mV6WLOXO40TlBzc1Wf/m9g==
X-Google-Smtp-Source: ABdhPJxAgNq+TRPEt3Cc5NVfj7Yl2Sws5mLyFkpsR2QyyZYdf3nDHAvpwel14NrDd4c6vt339tAGgqtHFhYk/Bv3tBQ=
X-Received: by 2002:ac8:7f45:: with SMTP id g5mr14317578qtk.93.1631011515901;
 Tue, 07 Sep 2021 03:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210907102722.47543-1-bert@biot.com> <20210907102722.47543-5-bert@biot.com>
In-Reply-To: <20210907102722.47543-5-bert@biot.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 7 Sep 2021 19:48:02 +0900
Message-ID: <CAFr9PXmCKPfdHnHU7=ALh=j2SDf71ibd8kEnLTK6aPN1vmQVdg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ARM: Add basic support for Airoha EN7523 SoC
To:     Bert Vermeulen <bert@biot.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Crispin <john@phrozen.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bert,

On Tue, 7 Sept 2021 at 19:30, Bert Vermeulen <bert@biot.com> wrote:
>
> From: John Crispin <john@phrozen.org>
>
> EN7523 is an armv7 based silicon used inside broadband access type devices
> such as xPON and xDSL. It shares various silicon blocks with MediaTek
> silicon such as the MT7622.

This is a Cortex A53 isn't it? So it's ARMv8. I thought the issue is
that it's actually a 64bit system but you only have a 32bit
bootloader, firmware etc?

Off-topic but related:  Another MediaTek spin off, SigmaStar, seems to
have done exactly the same thing. Cortex A53 chip running as a 32bit
system to avoid having to fix their software. I'm interested to see if
this makes it into arm or arm64. :)

Cheers,

Daniel
