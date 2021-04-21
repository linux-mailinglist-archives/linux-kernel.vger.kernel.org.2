Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE33366EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbhDUPR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243482AbhDUPR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:17:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF0F86144D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619018215;
        bh=Io4iMaIv8N0MLHnovQIdaYCwJRnECXTA7HVW6nEGycI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AUIRYh3Hh0DmQUpL9X9ftiSoyf1YBXUWzQq6smCgHWX/HCA3e1CiuFQZD/XllaEtX
         P6YO4KSQxiPrzUA1BcorsNe/UGKdU+cBjHmOwDp4CtVeYd00DaocvyLbjwS3rv+QXw
         5ngeI6+9SVvUgtOCeqSf2bAr4QYAfnZnql4iJsaTOqKWUJMtoyB2xsARtbmTasAn6W
         lQsZc1/PNmD7dcVhLGU12WyMTbnHX0Lkkn9O5Tt0h5wgf+9AXCRQMy5M0Ly6efLi0s
         W2e8uOQ56BBKU23btkm1mi+Y4SmLQ2aQnr41EaemnyJXR/nryCauwDOVS+x+5qPB/W
         E1Osu39+8jQPw==
Received: by mail-wm1-f48.google.com with SMTP id k128so22397847wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:16:55 -0700 (PDT)
X-Gm-Message-State: AOAM532QtskVoW00ROjLhAAB96DIrR2V0Yu3H33PdAB4Qz2EdLkVYzMw
        M8fo4KEbIe75BB00MimrtTUtwn4QnsrHDiHfYgU=
X-Google-Smtp-Source: ABdhPJwpsQcQaN0Z5hLp1BdqaVahJiiUW53lSURYUNoyATOvO4JILh7FXAd93qiicNh0FXoFkj+o4kTP/0HfdMc9TFQ=
X-Received: by 2002:a7b:c344:: with SMTP id l4mr7069862wmj.120.1619018214348;
 Wed, 21 Apr 2021 08:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210421135433.3505561-1-arnd@kernel.org> <20210421145302.GA36124@sirena.org.uk>
In-Reply-To: <20210421145302.GA36124@sirena.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Apr 2021 17:16:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3FoAEAQYoccqMNJ-TbScnen6Mm5y+2vE5ZPOjsag8tMg@mail.gmail.com>
Message-ID: <CAK8P3a3FoAEAQYoccqMNJ-TbScnen6Mm5y+2vE5ZPOjsag8tMg@mail.gmail.com>
Subject: Re: [PATCH] regulator: bd71815: select CONFIG_ROHM_REGULATOR
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Fritz <chf.fritz@googlemail.com>,
        Axel Lin <axel.lin@ingics.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 4:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Apr 21, 2021 at 03:54:27PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The newly added driver is missing a dependency as shown by this
> > randconfig build failure:
>
> This doesn't apply against current code, please check and resend.

It seems that the patch causing the build failure (5a8a64d9a38b)
is in Lee's mfd tree instead, with the description "Immutable branch
between MFD, Clock, GPIO, Regulator and RTC due for the v5.13
merge window".

There is also a commit with a related description in the regulator
tree as commit aaa8c4e05e32 ("Merge series "Support ROHM
BD71815 PMIC" from Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>:")
but this one only contains two commits (fb8fee9efdc and e3baacf542)
from the series in Lee's tree.

It looks like something went wrong in the coordination between the
trees, but I'm not quite sure what.

      Arnd
