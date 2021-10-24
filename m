Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932E0438C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 01:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhJXXTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 19:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhJXXTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 19:19:10 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F6C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 16:16:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d13so4924802ljg.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7c8mDt5oU6grN/T27nlrN9m6S6mPoCForSkLbFys4hQ=;
        b=qm7X+j5P9wG5YV6anbu6txrHkdOtZrGzk1C5p/otJ90cVX2ViknRy63w2NST+aK1KR
         hkoVJSSE3lZuf0IZNeFIa9IPBtST8cTG0ssSFn8w9HJxBH1ovF4L4LKUgzMNMhIcVI5N
         xjyPA2x2ZyLJO48lKunCAsA1/4dlkCPMgmr33Ca4OvKlrQhE1Q80eSmJiMl44JB1OcES
         ePDBF+TAIkwyohEzFmh9rhkHXh3zOWpLjt0ngdsPfCJqolFqoaEbXJAGg2tw4s6BVj3m
         LIhEyxrkGLPhWF6Z7eTbNFsG+PT3F8nO9H+KqXGqKYn80qN11u4xRFnklv1rcGffqZQg
         vMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7c8mDt5oU6grN/T27nlrN9m6S6mPoCForSkLbFys4hQ=;
        b=xJeROu3IhVjQtV7FVs593IjbrhHQgbatAyTv0VmlFQto4NdMTS7I4bF+/JR5j0nICR
         JKiYf8qbpM1+kMA0FeRY1ChgnltL9K1ozHNtWZT+cLl4XPY35UOrTeNOiVFIkXx6sKRo
         wls7cQ6cCbGHR5gVdWEghc8DwPb8gJqm7EXs/rz/fTItj9haDSFDYUjtPCwsy3rOX+6h
         /I04PpA/7e1i7LJLnvbCrk+X74DvdMy4ZWrB+RNDlU1KqTVDVPHl3HMkjD3UvGWg0UBm
         OoHP4bjVmL/frxaxb6uK6UqFvtXtxkVT31r/4bcBx0luXtg/YleqYJDAfDoajFklXP4q
         SUKg==
X-Gm-Message-State: AOAM532SOfrmYH1nN7uCzPtZSPBG0ZDQSRmXSeoQKrnx1lEzxOXyLB4W
        KKcmyILsyn+v2Vc/Kv2Vs+/rXAMYHXC0agAMvDk7Ig==
X-Google-Smtp-Source: ABdhPJzK8HuLWgNka0Gsm1lpjg1VBs6Cv75aRPFmVlFmVh5ohfE5x4WnvPYnpbTcdht3SFLyy7pXW+rG7G6BNzLvJfo=
X-Received: by 2002:a2e:98c5:: with SMTP id s5mr15404100ljj.432.1635117407175;
 Sun, 24 Oct 2021 16:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211013143810.2101838-1-arnd@kernel.org> <CAL_Jsq+WqboHoqHN-c5KAWPzMZm3dgExWr8RT7+-5bzwSA5BUQ@mail.gmail.com>
 <CAK8P3a1SreOdJ=jMvRYhwyWhTdEOBMzW+AFX2bRztRStrDWVLw@mail.gmail.com> <CAL_JsqLyLOK=1HwirRmA+FwyfZckzodqT08Qy_KZz3-WPN6Zsw@mail.gmail.com>
In-Reply-To: <CAL_JsqLyLOK=1HwirRmA+FwyfZckzodqT08Qy_KZz3-WPN6Zsw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Oct 2021 01:16:35 +0200
Message-ID: <CACRpkdYe_f_iS9Qu5D63bSfH8+sFU2eHrbqTgiECo53s0VL3jQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: versatile: remove leading 0 on unit address
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Liviu Dudau <liviu.dudau@arm.com>, SoC Team <soc@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 11:10 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Oct 21, 2021 at 3:49 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Thu, Oct 14, 2021 at 2:53 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > On Wed, Oct 13, 2021 at 9:38 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > Please apply these instead:
> > > https://lore.kernel.org/all/20210913192816.1225025-7-robh@kernel.org/
> > > https://lore.kernel.org/all/20210913192816.1225025-8-robh@kernel.org/
>
> Linus?

I don't recognize these patches, no idea why I have missed them :(

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Arnd, please feel free to go ahead and apply these.

Yours,
Linus Walleij
