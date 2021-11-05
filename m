Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34E6445DA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhKEB6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhKEB6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:58:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4722BC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:55:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f3so15610834lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQ5rx0ih4ImPc1lQ/4TmMDxVD6bAbyAbRYZrdiz+dqM=;
        b=IxszP5A3m4BSkHIF+6XK27KLraJpaPXPDKK/xS9G6jvRIw5LkesIvUoxQLffwQK1C8
         uUlJdR2eAxmr+zwqs1OUapvIGKsA/roR7TygBWGeGcWLKYMGz1L77jsN6uh43LElBGQ+
         Cj7GAD+Nh2Mkoiu9hQAHrF7qMmVtpOsKv27pH8flr8JIRvxKBw+8crEYS+5EKHenJjfR
         RW65ZOygMfaIyNcUkylcdN45BknAkQa6a3/ExPWyvZcEU32Axn1OBonZBb9XPA+OnWzl
         CP1qyEpT0ayEEy/QjQ9G2k8Cn5x9ttRtSnWx7Lcs5P3eSdVFmXLee/tlsIjLFN9/Ra8p
         fScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQ5rx0ih4ImPc1lQ/4TmMDxVD6bAbyAbRYZrdiz+dqM=;
        b=ED1yBK206KWSnmy3N9XYMMOjMbbwxvtqDj+LZDODM33x+XmGBm0plPx8y4WI27cAdi
         t9XxfnKT/Dp/TBFhaMEoNiDD6nYrFyT9zycYflrnMbEgHcULeqK5rwA0F+VLRGnP45xu
         0sbO7mVKgAS/TVzD24zlj37lFnN9Z1g94JlLpmf/RFV0LM+BZGqCzXK+sXQCjiePXPLR
         AlBMfr+JkOM7AZgOWdwg0pDlpUGw0JNUlIE1cT6+hmJdZwh8FTXDLIzKIgZsWaBUITNR
         nDpuEePCfbUuh6I8jUkCzY55yttXRr7KNxxtuMO3a9cdKy2zF9s/+ibR0BfgUF4f5n8R
         cMZw==
X-Gm-Message-State: AOAM531siw/JBSBwggpA6ERx/UYqLcF0gkKDG7oz3q1tVWI/gjSqqQv6
        nA2gxl3iC5edQ3CaJji3nVETETIK9L5/Azsl+u58Xw==
X-Google-Smtp-Source: ABdhPJxDNQ3NpaQv5bX1NdFnU5Xuxljz59rmlGzJNPgHe5vI0SvIqz2Djc3K4bRYHI/sIf7AP+kOUjIsvTFytbhLdhA=
X-Received: by 2002:ac2:4f02:: with SMTP id k2mr49131299lfr.635.1636077355028;
 Thu, 04 Nov 2021 18:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211105005955.107419-1-osk@google.com> <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
 <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
In-Reply-To: <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
From:   Oskar Senft <osk@google.com>
Date:   Thu, 4 Nov 2021 21:55:39 -0400
Message-ID: <CABoTLcRyc0B5HXSzEusPKWOwO+BG6GfSmmv0miDd6Y4rRCYTiw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To answer my own question and as a reminder for myself ...

> > I applied this and tried comple testing, and got this warning:
> >
> >   DTC     arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb
> > ../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:217.4-14: Warning
> > (reg_format): /ahb/apb/bus@1e78a000/i2c-bus@40/nct7802@28/channel@0:reg:
> > property has invalid length (4 bytes) (#address-cells == 2,
> > #size-cells == 1)
> Is there an easy way for me to see these types of warnings? Or should
> they really come out as errors?

Yes, there is:

1) Copy the .config from the OpenBMC build directory:
cp ~/src/openbmc/build/s7106/tmp/work/s7106-openbmc-linux-gnueabi/linux-aspeed/5.15+gitAUTOINC+da6376d789-r0/linux-s7106-standard-build/.config
.

2) Run
ARCH="arm" make aspeed-bmc-tyan-s7106.dtb


Oskar.
