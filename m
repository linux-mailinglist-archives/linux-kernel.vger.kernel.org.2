Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741464136C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhIUP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhIUP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:57:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F38C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:56:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u18so7358702lfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dRRvOoGnmIrwwlsxrjhXDNUq+Kqf2aFZjcm4Fpvb7k=;
        b=XjT8euJ1tczso29kfHXmNCJHZRMAS1oX71/URiU3zEEb64+9uDWgmIwauvqNThaKd2
         LY6KbMerapB+rxaOPqzMXMMoo13WjSu99La0jzgxrbYC3oRmbVXsvwOc2eDBkPiST4AE
         Vx9Y2HZ3utTbU1zwoIfIwYQ+f72e96CJ5i+98x8/LpRPLGQrfmZd5Vg/WlsDPIFtkbA9
         8kAuY8odwAUT+MFeuVlE9RbB11tnFs90USfJY66NmOhc7dplcF6vSuI2yrSdO9+9lu+L
         9I6tocdkqJ7EcfnoXSqvvJfk2mQ/2gDyYNoFBYC30GH0lx/hspNQtok0n2XFWFxX4J1d
         IWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dRRvOoGnmIrwwlsxrjhXDNUq+Kqf2aFZjcm4Fpvb7k=;
        b=tSaQZ8ogUlhJT1ACCSb+/5sfF+APFg61fK/mDC2Ae5BSM/sdpgazT81GB884cQep/o
         OF37753GNUs4G0raCuI/uCdI+LxASKW+oQJxMBGAi1qRWskwNI5bn2ugRGqV3IzcnHcf
         nvs2ct/ystCMXJVHPWauLe47VI3UVYihpNne5txemNXpe2FgsKUrP3ZmrLy+GjHaFrF9
         RX1FrUEILrKkmygdDN9z5H0Vw5cByz4PNdUR2CIUsDWSA6Xyjp9/wnZIUGe91VmJ1xPI
         i8Fkh48V74veU56ahxgpjGp8RUcdMtd7o5gFOFkClRniv4WB2aDta+ThZiiXzwWBvNS9
         y/uw==
X-Gm-Message-State: AOAM532aAF/jsGX1bSzhj/cV6DS+lUllXLYu4NrwH0KHnllWZjJng2tm
        IMrMDEDj0eNVVNOhh74DSGeQDU1yzfa+5P38O5+iyw==
X-Google-Smtp-Source: ABdhPJwFv538xdJK2HBZc2Lz0Yc451rwEukRVrSDiTltXNyPlcvQxBCy+cpnqY1P/Xjdy+Z5BZBlkAZXIBjSs9HGGEU=
X-Received: by 2002:a05:6512:10cb:: with SMTP id k11mr13874613lfg.72.1632239775245;
 Tue, 21 Sep 2021 08:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <1631860648-31774-1-git-send-email-rnayak@codeaurora.org>
 <YUfZbsf3MX1aQJ2+@builder.lan> <d2f28d34-99b3-30f8-8504-bc819946876f@codeaurora.org>
In-Reply-To: <d2f28d34-99b3-30f8-8504-bc819946876f@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Sep 2021 17:56:04 +0200
Message-ID: <CACRpkdaJm_UbJu=kXGOFs76MiAiTkqToEpOnf1Pk-by4FsCcgQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Add egpio feature support
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:39 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> On 9/20/2021 6:14 AM, Bjorn Andersson wrote:

> > It seems reasonable that this would be another pinmux state for these
> > pins, rather than just flipping them all in one or the other direction.
>
> hmm, I don't understand. This is not a pinmux state, its a switch to decide
> the ownership.
> These egpio pins have regulator mux functions, some for apps, some for the
> island processor, they might not always be used as gpios.

The pinmux API is for muliplexing a pin between owners, and that
is what is going on is it not?

If the bit(s) select different processors that is changing the owner
and creating a usage matrix, e.g.

TLMM_GPIO
ISLAND_GPIO
TLMM_I2C
ISLAND_I2C
etc etc

They become different muxing states nevertheless. How to encode them,
such as (a) bitfields in the enums, (b) more cells in the device tree or
(c) ... that is another question.

Shoehorning it into pinconf is not the answer IMO.

Yours,
Linus Walleij
