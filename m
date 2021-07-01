Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7123B97AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhGAUgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbhGAUgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:36:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3315DC061764
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 13:33:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d1so4341189plg.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OJw8rDzzQy3DhiLUvJQW+Qdo9Q9Meb8jwgwdAgUtwaA=;
        b=tjNf5cxiic1IPqklXIFZcopMA88yLPj7nHk9KKLZZCgnA0o/97EhJzWO3mqfHkg89j
         kAvRHnAzxJSzeRsj/R1Zs/iQhGksf/npipynnWtszL2uJSpvaki4kcXwIWo7jKepEU9z
         AkvXC7nruuQI0yxo9nu0Zsq5lpZMHPR9eIKAo33JCgWztrDpK9LqDUDZxTKHqX79Et+0
         tOVNAqJxr7h0M31yRL/TyIChS9QJCX8yhqqE2EuHgPEvtzYiYLIRGE2d9f5vgNazBLv+
         /UJF+LPAjXVH2hfPv2RyTYowAdt+Bpf0XiS2sEUhUqR5QCAmXajtoo8vcnACnaYC80CW
         iRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OJw8rDzzQy3DhiLUvJQW+Qdo9Q9Meb8jwgwdAgUtwaA=;
        b=PD4YZwJkgXVB89GMZKstQnXaYXR6Cox4DUm8rqh1LuqlemLKaA9DecXf/urZ6R7voT
         01pVEPloPxFe+AyHKfEXDh1cBIen0q8Fvk1H64HlWLU03yfdK8DjPPj48iND+FtjKLRw
         g3aEEhcVbl+cFA9ofKOUDDLyVIWSnjHfJw1pS7U6uzj4JTeopMRTNqX+RtBpCA/+fTB0
         mIEXGT65X3Wn8skBL1Zknu0xAdF3XeF71SLwSOwKpWwQXCxrCt3BEuEq7w9+RjRKAEXU
         /H5DtW9MRb0/9NCVuDz/LhQcVbyPhdb1qSk9Xh2vM9l+tHaFwa1B7p3rKq3EzZ8MgQYu
         AUcw==
X-Gm-Message-State: AOAM533lhUU650CIFNYEhcYnQ72vN4KnDkQ0tjnhA/Aho9ih9JJ8uE4Z
        q9RT5vlN3STSgKsRkz703GsTMA==
X-Google-Smtp-Source: ABdhPJxg+Za0ZEhKlCUXAe3lsXSkyHKiJcX76VwoRNv8bPZ+omjAiffeUdkx0JcSCtpRpL5AW22CoA==
X-Received: by 2002:a17:902:c086:b029:129:3680:32f0 with SMTP id j6-20020a170902c086b0290129368032f0mr1419861pld.47.1625171616680;
        Thu, 01 Jul 2021 13:33:36 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:8fd:ccc0:a9a:cf98])
        by smtp.gmail.com with ESMTPSA id d3sm501203pjo.31.2021.07.01.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:33:35 -0700 (PDT)
Date:   Thu, 1 Jul 2021 13:33:33 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
        Huan Feng <huan.feng@starfivetech.com>
Subject: Re: [RFC PATH 2/2] gpio: starfive-jh7100: Add StarFive JH7100 GPIO
 driver
Message-ID: <20210701203333.GA963857@x1>
References: <20210701002037.912625-1-drew@beagleboard.org>
 <20210701002037.912625-3-drew@beagleboard.org>
 <8c59105d32a9936f8806501ecd20e044@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c59105d32a9936f8806501ecd20e044@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 08:39:40AM +0200, Michael Walle wrote:
> Hi Drew,
> 
> Am 2021-07-01 02:20, schrieb Drew Fustini:
> > Add GPIO driver for the StarFive JH7100 SoC [1] used on the
> > BeagleV Starlight JH7100 board [2].
> > 
> > [1] https://github.com/starfive-tech/beaglev_doc/
> > [2] https://github.com/beagleboard/beaglev-starlight
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> > Signed-off-by: Drew Fustini <drew@beagleboard.org>
> 
> Could this driver use GPIO_REGMAP and REGMAP_IRQ? See
> drivers/gpio/gpio-sl28cpld.c for an example.
> 
> -michael

Thank you for the suggestion.  I am not familiar with GPIO_REGMAP and
REGMAP_IRQ so I will read about it.  Is the advantage is that is helps
to reduce code duplication by using an abstraction?

I did notice that the gpio-sifive.c driver used regmap_update_bits() and
regmap_write().

I suppose that is better than writel_relaxed() and iowrite32() which
this RFC driver does?

thanks,
drew
