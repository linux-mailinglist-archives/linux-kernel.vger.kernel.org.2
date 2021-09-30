Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AEE41DDED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbhI3Psm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbhI3Psl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:48:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B06BC06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:46:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z24so27220500lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2+hq+nxbbXAkaT4qaeWpisMiqGB49qBmA8xSYn2QSI=;
        b=ts/avt3kzHzoGq7Ak5AV5Wxe9QuECdMvB1s1HFzD4+ry82idewTaLUO+lCQuPa4DyT
         +gW4lWvWT46H7IaGSWgIxkI+ddVuNPHD7B4ZwzvfDM6vf/mfP9X4OI6AQuOiSypfGtZB
         h3JFyOa4UBoWcHjaFYDexjo/9CzkqZyngQqJG5pdHE1mbP39PuOkPs0T7cpyNxEjM5Kz
         UNFPvziWlKLKCBEVCTO6UtQGZazE4HPSsfNBQMMIEQoAQH8hu+mCqFP3HcABwh4l4y5v
         WNZ9l1NNn4dCJYMrhtFz6JNdL92AvTTZeVcJ9g+V4XP+NEnb+VXo5HzLlIdET+Ht+L3K
         Cszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2+hq+nxbbXAkaT4qaeWpisMiqGB49qBmA8xSYn2QSI=;
        b=Q6na9r48f5F2LSCrV/lROoTx4PF1JZnJhTAsvYTY3hKjfOT41AXvB8B9yTb20+b1jU
         LLa0iAvEcSGDGEkJiV0w5ivM4/+8WAyRkSEtVQaqDKJcZwxXrC2wWst11Cx71SOLZKM4
         UK4ifhgex1fl8FrxNt+5xEV1kViFNIqXbpUfvyWjRmfLBrKX0v2AMLnrjc6MNSiPPWGf
         ugQSjGIzc7EMil3FzE9F50fQyP95b1OJjqyPVG3sn8FZlky61j3J/aLfggnwfLtnmcsx
         pwrFxRTqhw8qUTH6Xj2xSN5GzevqXkR3gCtSH/dGyvLpvg5vVui43Ivrn/h4vEvuG3SU
         p2bA==
X-Gm-Message-State: AOAM5303kP1ZBa5PBjj2Ura7HF5gr0va4wjXEFS8b/QAeEHKjCkuquuf
        Y4oq/YPPHdkG+TGUW2jmIorlSKLNbelwLAI8Ysxvdg==
X-Google-Smtp-Source: ABdhPJzaDE9QWa7bdhAIHJ94Li3ZZgNfj3d7w6jgx+N0Ze2Whd0t5L9GUlAJne4LsPtEXT2xZD6rwTNo5z3vCOmzq18=
X-Received: by 2002:a05:651c:4d2:: with SMTP id e18mr6742952lji.432.1633016816515;
 Thu, 30 Sep 2021 08:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210929163847.2807812-1-maz@kernel.org> <20210929163847.2807812-11-maz@kernel.org>
 <CACRpkdaXbrmvoQQNRdyv6rJ+dHYAKMN+J_sc-3_c1d6D2dsfbQ@mail.gmail.com> <87fstmtrv2.wl-maz@kernel.org>
In-Reply-To: <87fstmtrv2.wl-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Sep 2021 17:46:45 +0200
Message-ID: <CACRpkdb1JCoTLMH5hExcruJA=XT+KRX=LMvF=rRqzhJUup3-LA@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] arm64: apple: Add pinctrl nodes
To:     Marc Zyngier <maz@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:00 AM Marc Zyngier <maz@kernel.org> wrote:

> > In other discussions it turns out that the driver is abusing these gpio-ranges
> > to find out how many pins are in each pinctrl instance. This is not the
> > idea with gpio-ranges, these can be multiple and map different sets,
> > so we need something like
> >
> > apple,npins = <212>;
> > (+ bindings)
> >
> > or so...
>
> Is it the driver that needs updating? Or the binding?

Both, I guess.

> I don't really
> care about the former, but the latter is more disruptive as it has
> impacts over both u-boot and at least OpenBSD.
>
> How is that solved on other pinctrl blocks? I can't see anyone having
> a similar a similar property.

The Apple pincontroller is unique in having four instances using the
same compatible string (I raised this as an issue too).

Most SoCs has one instance of a pin controller, with one compatible
string and then we also know how many pins it has.

The maintainer seeme unhappy about my suggestion to name
the four pin controllers after function and insist to use the same
compatible for all four, which means they instead need to be
parametrized, which means this parameter has to be added
because ranges should not be used in this way.

I guess the code can survive using the ranges as a fallback at
the cost of some more complex code.

Yours,
Linus Walleij
