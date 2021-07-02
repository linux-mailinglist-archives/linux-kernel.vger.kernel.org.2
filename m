Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC83BA4E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhGBVCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhGBVCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:02:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6625C061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 14:00:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y4so10123499pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oOQvjNwUs6iGdF4qU2K20XA2rSMaHeKg3ys4j3WcHnc=;
        b=hYM4Px7OvwbK9XsUFZfo1RxGbzj90AUFJXgJwyByTUvzILGgndzmwMbIeL8chJCL/1
         jnLgsfXFcJORybUzJlR8Ts4om5iI3vfYCOOaOGhcbqNDqPf5G9HIQDmb575aYR+2mMcB
         UHULog5A9xsnm2hD6O+LvitJflAiWtuUlsSp8b1zC1z+F+GtjwFOkmoxUpEr7qnFab+S
         K4eS+ZSOYZqUI8WwZwd1Xylpf6Tsx1ULc6iiDVbo5T58XZunv+/TzmElGmJCmEBO3KQ4
         9Mgj+VUVg1GWSmLadoePcZyVGiDpn3Gx6gFsQyDn3LxMUHibgihro9oW4eb8GFKbtJ+X
         rfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOQvjNwUs6iGdF4qU2K20XA2rSMaHeKg3ys4j3WcHnc=;
        b=KZkK1STLUpnHl2SeNnvKniNpd1qB/THGRP37XFHWjY8wrnvnAUpmtNAi2FY/13T89c
         6CpugcGsGncfXuvWp1vMrHJWXD1Q4FHSjzYs1dcWcFZj839OpnvM6fOV3Xa6Kn9RQtKy
         nSsUdKFuiCsrz6yT4JCjvL8QJIRI7zQJ6LBEVc2lhNQu41ri54ErUaivvxaMdlQZ14nu
         XgK7rE2Nhyp3ELxDOQpIQgezmbEdycdxzEjcr/ekbNfVOIJzETC1mFb+EiSsUaikl7Ej
         GwO5r1oEBu1IuiZa+GNHW6vTOMALJZ2jGH8sye+yT+gFEzCUWkc1NoEiKfs2mrMqpj5U
         LRfQ==
X-Gm-Message-State: AOAM532xfHYJ2FdlG2YX+veiT83fN2Y8rlwHYx+MXMUt6zRTd5CeIj7o
        u/EXgerx+WY+XIejPVGGZzHJRg==
X-Google-Smtp-Source: ABdhPJwX6MC0pslJVSWjiHUEQMYnxqyk6w0QgIpJI+wow/rFNf/BdwqJWoRkWhXswPubyBwBxdmobA==
X-Received: by 2002:a62:7950:0:b029:30f:cffa:a25e with SMTP id u77-20020a6279500000b029030fcffaa25emr1324959pfc.50.1625259614259;
        Fri, 02 Jul 2021 14:00:14 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:f236:257f:88f9:445e])
        by smtp.gmail.com with ESMTPSA id 11sm4742618pge.7.2021.07.02.14.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:00:13 -0700 (PDT)
Date:   Fri, 2 Jul 2021 14:00:10 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Michael Walle <michael@walle.cc>, g@x1
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
Message-ID: <20210702210010.GB1035183@x1>
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

I looked more at the example.  Do you have a suggestion of how to handle
different types of interrupts?  

This gpio controller can handle level triggered and edge triggered.
Edge triggered can be positve, negative or both. Level trigger can be
high or low.

Thanks,
Drew
