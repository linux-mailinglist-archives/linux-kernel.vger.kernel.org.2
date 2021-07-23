Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB93C3D38CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhGWJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhGWJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:54:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AD7C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:34:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l17so1148454ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swGcTNpA98MU/vBFxvZLl9qo7SscXLpjeJm2hi9sy7I=;
        b=fcmHRd/Vsw/hxY/nlM1A5Q8ziml1XikfWihkC5N1/rqK3UXsBVjF13+j+c7VGdeAQ9
         qnmcozaQc22tvuwglbyJJyZ9TTUBlx7eXU0lZmBTQYHWSoYfjP5BHpCFitc9zQRmC55p
         isNdKSUBA0ESGnN85ENYb9mTxeUj3P7D50Sl+4LOCBbVILanTs00UnboMm2JMpfBvu0D
         Ur5a8DtDJY8z3ZE45eZpY1i0KLptXbB9fhGORaXLXQPN16ZJQopTILB9fE0x4SshyobT
         xCp+aBrBT0mxNeq3C+aEed/s5DS6ouCdToZrKj9H9YNiUNjQC726eWclZRuco3DkqYgh
         KYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swGcTNpA98MU/vBFxvZLl9qo7SscXLpjeJm2hi9sy7I=;
        b=bulj5h39Lt7S6FccL8Nw8R7c55EQru1gN91q7IBz8Byj8hXUCC7cVBN7ddArDF0wsz
         V4kRqXyPet8GCzsPoIE/nDYw+xk8IYHrbEG5DOXOkOJgSYNMLH1OkaOEhFYKmyGd2o0Y
         ebh3ZvuApeXKTj3LJ+bCNUHa0ouD/nn0bCOl1uM01rKJxq29rxYO64pbLe4oPY9GykOL
         zaYfeMP4IRXWh/VHQsKkg992hDRawKrfbQhnw8oFWKNx8DcCH4AeE8pQBooJs6I2KcV1
         GXNCVhqtqYeQF+Hf34HgSecqWvCj9a9MT2+gaASmAWv9QnCjNvu7KP7TLnPqnssg5BBG
         h7Ng==
X-Gm-Message-State: AOAM530A744l0Rz9c9MirHEyrLsro26xREueJuABW+X5syIK2WXkS0Hx
        3sx0o4hcx3zVmyBEvRsFRjZX2GnEuliZrXtiWsk2nA==
X-Google-Smtp-Source: ABdhPJzCFJwi0QtxItn9n9d22Y44wmE7wx/d8aLLz8VyvFA97du4CxRRxIrfYiQRUruKvqLhoVIWcU1xYaulvbb2KbI=
X-Received: by 2002:a05:651c:169a:: with SMTP id bd26mr2912069ljb.368.1627036478284;
 Fri, 23 Jul 2021 03:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210618205533.1527384-1-clabbe@baylibre.com>
In-Reply-To: <20210618205533.1527384-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 12:34:27 +0200
Message-ID: <CACRpkdZNeJLsOhAOqD9TPsPuHDjK4ec-SUAVrLXvVOkcGd1S-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ARM: gemini: add two more board
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:55 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> I have two boards with a SL3516 SoC. Both are NAS box.
>
> Changes since v1:
> - ssi1328 use now redboot-fis partitions
> - added pinctrl as asked by Linus Walleij
>
> Corentin Labbe (5):
>   ARM: dts: gemini: add labels for USB, IDE, flash and ethernet
>   dt-bindings: add vendor prefix for edimax
>   dt-bindings: add vendor prefix for ssi
>   ARM: gemini: add device tree for edimax NS2502
>   ARM: gemini: add device tree for ssi1328

Thanks Corentin!

All patches applied for v5.15, I saw that the NS2502 does
not make use of the redboot FIS partition table but that's
no big deal, you can send a separate patch to fix that
when you can test it.

Yours,
Linus Walleij
