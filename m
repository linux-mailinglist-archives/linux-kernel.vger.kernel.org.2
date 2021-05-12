Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D51737BE35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhELNar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:30:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:29:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so34943917ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2Xm0zvt+awRTlmfOBDWYmZKbcrwWg30pJhiDIwcPTA=;
        b=urBYN7ecbgtyQef30Glwk8bNUDY42SI4LloNazJn8gqCtA2H7kJ1C6oQWM6Gb6FGEh
         LPrcNpnRg7o30MxHMXob72hOOWZBQ4sjp18v7g/quUUksFlP/0Tzef31SrQiRzp2SWXp
         Qny2CVZ0EpbrY6z4BFTjElB9EYUueEeNCBXd+btD5wJYlp7vyyo4lY5hwUbfjj7jaBT+
         hZL9SZdSgVjBHho5XdD6r1V34qY4+l4JcKOkiassPaD7DLn3Hl4JSWFgnJ5hbwR5koCj
         L53ukQvIPuSYRGQ3sbMjYxKGKPIspFA+FqM+oD62Kl1ccyPXzotOlBIW4pCM5qAtDH0L
         B1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2Xm0zvt+awRTlmfOBDWYmZKbcrwWg30pJhiDIwcPTA=;
        b=OE0QlQY32LShuIyZkIdt0w/OEj7n35+tIZlg+9p+Cz9gt56HoOr3HTskjP50HWa437
         nSGSNohUKQ6ezPOh1juN4g8jcF+nOqxX0jMnLQXKuNbcoXQQ/IYRVMfpQScVuB4S5ok9
         j/jaQ4et2iebnHyuWkuVl5fbtfkYyW4iyk0Kb/Am+/+oDkRqWP0Oj/tFycfQ7Ye358Kc
         bQDDITpX0vTgfaZRlVwWF3U5N1S/O1tDf8moIjY7c10zm5r93SCLPugMSQX/CAeybax0
         RXWkMC41e+L+Bwh68tnRxyb7v41IZAOxiCPr1BEY6/9BiRQBtpQHNCZTcJgva1t6E2rc
         GHPA==
X-Gm-Message-State: AOAM533Q7LZINB9RVNQPednaWqluznvi4pzehGk0G/9yo2D1XGEsduAn
        fVxKthPZx4LW8o25lRMxhsSw9ADJxykIw0AlZogrng==
X-Google-Smtp-Source: ABdhPJzJND28/5zCNEuN6yQt6amOBLo1vpCnc/DKTzTtz3QIsjgaSayxUHgqB1W155wwKouhuYsoCV8wPo3/2Qb8U6s=
X-Received: by 2002:a17:906:82d4:: with SMTP id a20mr37693177ejy.14.1620826171029;
 Wed, 12 May 2021 06:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210510063602.505829-1-jay.xu@rock-chips.com> <CAAEAJfALROYg5awL88Uux0yXyMxBthbFjRgJCyhvu4hWioSO2w@mail.gmail.com>
In-Reply-To: <CAAEAJfALROYg5awL88Uux0yXyMxBthbFjRgJCyhvu4hWioSO2w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 12 May 2021 15:29:20 +0200
Message-ID: <CAMRc=MfqzrjxZBbnmpqjgR6KP6O7zr5xTwTq26oqhwu39kaLHw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] gpio-rockchip driver
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Geis <pgwipeout@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 12:16 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> Hi Jianqun,
>
> Thanks a lot for the patch, and for pushing this work forward.
>
> On Mon, 10 May 2021 at 03:36, Jianqun Xu <jay.xu@rock-chips.com> wrote:
> >
> > Separate gpio driver from pinctrl driver, and support v2 controller.
> >
>
> Usually, we expect to see a changelog here, with some information
> about the changes from in v2, v3, etc. Also, note that only the cover
> letter says "v4", and the individual patches are missing that. You can
> use git-format-patch --subject-prefix="PATCH v4", and then all the patches
> will get the same prefix.
>
> However, the last patchset I can find in lore.kernel.org (or my
> mailbox) is a v2:
>
> https://lore.kernel.org/linux-gpio/20210411133030.1663936-1-pgwipeout@gmail.com/
>
> .. which was sent by Peter Geis (so you should have Cced him).
>
> These are just some friendly tips on the submission process,
> for you to keep in mind,  you don't really need to resend the
> series or do anything else.
>
> Also, I added Bartosz the GPIO maintainer in Cc.
>

Thanks. Jianqun: please resend the series so that I get it in my inbox.

Bart
