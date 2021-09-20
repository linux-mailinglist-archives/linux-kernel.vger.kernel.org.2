Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08928412D16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352687AbhIUCyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbhIUC3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:29:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B070C0F3457;
        Mon, 20 Sep 2021 12:26:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t6so65150872edi.9;
        Mon, 20 Sep 2021 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJWnZekTUMSnBRk/CtZe/v9CvFL/Hwr4JrpVx75Cmtk=;
        b=ZdiTJXLL9mgXbyU5Qnw0VxfH6+FlkVxGLpvKOkpbK2L5XLuH1ISSVM2i5YsSzv538d
         Y3zLxEWtL52DZlUT9ehwoPZ9aMiO8iSp5Zlt9m2H9QdyEZ9GvSTTXd1gH8aT1BmtkyZF
         bWNEyJhSpyHwgkLwM9Z0Dnh1wfi1UQCUmPhdAwR6Z0ucyryHZ/2f4IqUNl0QsnJs7jHK
         9c30JmQqxVlas0u3kN0dg0NklDnWDz7IwkWoKBgVT4khJYCCWqwWDsgU9KF/wfCWmmZy
         wVHzUDGDkelDhFf8NRZXfzNN3vgmCtSczIr3bJDAIfDxRWnn2FOK1sO7Xkn8AWvETb4k
         wGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJWnZekTUMSnBRk/CtZe/v9CvFL/Hwr4JrpVx75Cmtk=;
        b=7dhAuV9BIORRaL+bH46kTwOKc053bHpSbLsNKCUc+wrCH/kIzmLtZOLUz5Qi5VbH4/
         fgy7CPZTQcyjUre5qlOLxeGL4MXl6nSQ5fEL3phdsb8i5ew6K9oaFLCZUYJX8HgnZR//
         9g10nu0FIC08V2loNGCz9WEvdXoxjhn/LMCNMJOpotjmcLiYpEck7j2Ck+Wp/0TGbemx
         IU3v3HXE71490MLhP/z0X1TZLF4VNrs6yK4bWAgpYvh25YC6irn2WmSIiL5H0o08SocS
         PV6iUh6krzdWtLpU2vFVUGv6Of6wM69jsiAsgE9648RUBayVSD2VxA5tnfdSK8qmlJeI
         bnBA==
X-Gm-Message-State: AOAM531V5mXQaSBzUL4EKtIlXOEMAj3uVNuTKdgZ7KFlOsuwLERm6Av1
        rLWtJXgLlwB99SQbI8USDOwz9Cd8xm0ZeZDY0vk=
X-Google-Smtp-Source: ABdhPJwdPfnVeY2p6IsWhgrDuynL1Mi9SZtZIeW/NWNfEuNbq4u5cqaYdIMy2elkx0SvapDlMWXEb9a6p2wF4K3n4I8=
X-Received: by 2002:a17:906:e105:: with SMTP id gj5mr29600783ejb.408.1632165979872;
 Mon, 20 Sep 2021 12:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210817041548.1276-1-linux.amoon@gmail.com> <20210817041548.1276-2-linux.amoon@gmail.com>
 <c7f6213b-5ddc-881c-1aea-9cc7b03e6a4f@baylibre.com> <CAFBinCBeNMET2tvH0h6HF3dR+xBb59hifQyaoXigUs3UGkS+KQ@mail.gmail.com>
 <2b07b3de-cee5-c570-8fde-6a4c684122d6@baylibre.com> <CANAwSgRNp8UtU+Yy4smwZ5POTWTU+xN1mrf_cH7Pu9yX5HU=VA@mail.gmail.com>
In-Reply-To: <CANAwSgRNp8UtU+Yy4smwZ5POTWTU+xN1mrf_cH7Pu9yX5HU=VA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 Sep 2021 21:26:08 +0200
Message-ID: <CAFBinCDmNt+aXRE4xFZdegOUs8BqJiTPF3+DQ-buvWWXrQLkdw@mail.gmail.com>
Subject: Re: [PATCHv3 1/6] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Tue, Aug 31, 2021 at 10:48 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> After enabling CONFIG_REGULATOR_DEBUG, with this patch applied
> I still not getting the USB regulator to enable.
> Do you see different output at your end?
I don't have much time for testing and debugging currently but I'll
put it on my TODO-list
Until either of us has found the issue I suggest not merging this patch.


Best regards,
Martin
