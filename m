Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343DE3DB5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhG3JPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhG3JPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:15:22 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E8AC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:15:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f18so16546074lfu.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6CWB3KykagPZ7odVSHKVhg71bMUe7ee2Rfq81or/sI=;
        b=m79A2839S42cY7qYEN0XcMKzZjX4H0tCTceoG5vAByFET28jaJEmrcQgyVgclJTMxw
         f8VCHLE2wYvoRKisPVLpkyMPvhlA07Uxf145O51JKZPXnoTxAQ776ae2uHrs0hah8s6P
         3yNaSQL5UZSC1apk75SjRlkEcYLOPgEgeDa+wfcCp9+ysok+Ya/DfeA1ah4TyRNAffho
         A4JjX4ajtNW8QpmDZOuP+yyaikddNt1cCq3oe4dvxuI+rsVb1aJjlXjjBgHxzlpzbBUE
         rRz37C76RewNHWMEE2vTf4uPuArS5mpgReq1ZpQFIhhkdJEoXxp2YLB33EZC7qYfU5EQ
         /RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6CWB3KykagPZ7odVSHKVhg71bMUe7ee2Rfq81or/sI=;
        b=IQqNcCCNTpmC8tvaXcNg8XOmDq9nLxx+0hI8Vfv5+Wh7AoQ84MkX4+Jh4RPpBG2w9a
         ixIkm/F4buTlKJ+wsvU59ay3Wp1ey9abqqNR8IdMSUMzovgUvkKhc3pY+hrO8DKX0zE+
         a2vy5m1/4ZZKDimVJpARFYHUwD+kR0+5zwUlOoyVYComXUkvpAP36ZL/Tp3A1tVa6/l/
         sRy3gwfWRgtSnj3oV+Q2aZDTg9UFkPaFXy4cf1k1//qqqabs+6KYfzMXz+NCh1bgPrck
         jE+GVS9YSdmjCVysrTpfLCXLsqy/pDgwbomXXyzrK/CCws9OWllQLG/+9sFHkOupFxFK
         utAA==
X-Gm-Message-State: AOAM533Q1d4DKnGC04Z2Sgn6Z5Ni8/5EgqFAVsUGOxRYRBF6Pb3afvhv
        EjEyU9oO5LUTzMf+ikbzWqhx58+BcLFlumNjzMf2Bg==
X-Google-Smtp-Source: ABdhPJxxvAEFkVBCIWP4SJUT0bMXR30c2srAUgbdroOKs1TrecoN5MnBqbJEa4pZNa6bcX7Uoyto7wN2teGP6SL93AY=
X-Received: by 2002:a05:6512:3696:: with SMTP id d22mr1215496lfs.586.1627636511952;
 Fri, 30 Jul 2021 02:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210716162724.26047-1-lakshmi.sowjanya.d@intel.com> <20210716162724.26047-2-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210716162724.26047-2-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 11:15:01 +0200
Message-ID: <CACRpkdZJaoQEJsAqrrAxWcpgx6J0OGoc_CkP0kUdNe-RPkRvqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Keembay pinctrl driver
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 6:27 PM <lakshmi.sowjanya.d@intel.com> wrote:

> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> Add Device Tree bindings documentation for Intel Keem Bay
> SoC's pin controller.
> Add entry for INTEL Keem Bay pinctrl driver in MAINTAINERS file
>
> Acked-by: Mark Gross <mgross@linux.intel.com>
> Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> Co-developed-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
(...)
> +  interrupts:
> +    description:
> +      Specifies the interrupt lines to be used by the controller.
> +    maxItems: 8

Write here that each interrupt is shared by up to 4 GPIO lines.

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
