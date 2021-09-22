Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478C2414609
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhIVKUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbhIVKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:19:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E1FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:18:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b65so7462771qkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2E8A06MDifxzY74TxCZz6NPFVVCyFO4WZRfZRmmLzu4=;
        b=mVjg0hti0O+7Jf7d9MrOg2mdnI/WeMF2OC1QbNtyiHC2X2u/EUmHPjOXQOSzdPLY9G
         t7PpdsQU1BCJuQsIHCkpGZi6YH1q7KlNojarfCmLFWUmLJqdoRrDjcRCqAa53rnEhYZ/
         LQPOTMURnTAwWArsoywyr0ghJhPQITvUQWHNNCSVR06w7YJY6Yr2Yg7VYBOpyu4itfM3
         ThJQdmVNeBj6Lg8wfYFyGhjXD8yUdMg9oiv3CHYF4vxkI9ALkZJvzoxvmw4zfqepHOmv
         wuf8gYbbpWlr6quJW+L39fwY7JBH/PcMMD6gizkZwd8ph67R3pHyhLI/jH/wjw4ucu8K
         Aplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2E8A06MDifxzY74TxCZz6NPFVVCyFO4WZRfZRmmLzu4=;
        b=Ex84QchX1xFoLfE1DoWLsIPiQeRf7+nbM5w4/wguJ6mpCTUlzQZUsL0aB+82Fc5oMe
         6SaQA60yyC8fKAVjhAjDb6vo5bizLWLUOd7c9T4S67IS+wp4JoEQTxFJk56Vz10Jn47x
         qWtxDJWDMdL8EqKHwCihDa5i4xv+iS0wCrAWfDKQc6rpIiQz5PNSryf75mrMrZKL0XSE
         fx6JTPZiBO8YNasB4X8b+1YJBYRSjQqs0omoUiRCaZrINcNSLEgVDM+7acO+GR07u3SR
         LEPeAi4S9sdzVweKaAXaudEcd1DJHI5Xs6FdLDn9U6anHn7R2xd6s4HkM0hUzpug5sd2
         T+EA==
X-Gm-Message-State: AOAM531kIQmvLXH+r80Z8R8VliUzuD9CgmDLewlpOoVGhKBx4p0iGl9U
        4PMS/czaWbttdaNfEKtbJzhZBCMwJin0Rvabxdk+Qw==
X-Google-Smtp-Source: ABdhPJyvYd88V/kcmUiBbM0BNpGmvm5k22k/8QnEOX/4Ny3ltI+viPiMs5gztxALXhhhiwcemlzEwx05kKrtyZIHT94=
X-Received: by 2002:a25:dd46:: with SMTP id u67mr44558799ybg.295.1632305896044;
 Wed, 22 Sep 2021 03:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210818081018.2620544-1-piyush.mehta@xilinx.com>
 <20210818081018.2620544-4-piyush.mehta@xilinx.com> <CAMpxmJUvPg3LvT1EJa-ZecXMWpR82EQMr8vhTjBpO3_6iiGecQ@mail.gmail.com>
 <2286343a-e061-d5bb-b266-6f657cba63e2@xilinx.com>
In-Reply-To: <2286343a-e061-d5bb-b266-6f657cba63e2@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 12:18:05 +0200
Message-ID: <CAMpxmJVUTy5iOoTuDTY8-7z-brLJwkv_a82tU47ZXsJjM_Vp1A@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] gpio: modepin: Add driver support for modepin GPIO controller
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Piyush Mehta <piyush.mehta@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, Zou Wei <zou_wei@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        wendy.liang@xilinx.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Rob Herring <robh+dt@kernel.org>, rajan.vaja@xilinx.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        git <git@xilinx.com>, Srinivas Goud <sgoud@xilinx.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 10:14 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Hi Bart,
>
> On 8/23/21 10:02 AM, Bartosz Golaszewski wrote:
> > On Wed, Aug 18, 2021 at 10:11 AM Piyush Mehta <piyush.mehta@xilinx.com> wrote:
> >>
> >> This patch adds driver support for the zynqmp modepin GPIO controller.
> >> GPIO modepin driver set and get the value and status of the PS_MODE pin,
> >> based on device-tree pin configuration. These four mode pins are
> >> configurable as input/output. The mode pin has a control register, which
> >> have lower four-bits [0:3] are configurable as input/output, next four-bits
> >> can be used for reading the data  as input[4:7], and next setting the
> >> output pin state output[8:11].
> >>
> >> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> >> Acked-by: Michal Simek <michal.simek@xilinx.com>
> >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >
> > Which tree should this go through?
>
> I would prefer to go this via gpio tree.
>
> Thanks,
> Michal

Sure, just make sure to get an Ack from Rob Herring on the DT bindings.

Bart
