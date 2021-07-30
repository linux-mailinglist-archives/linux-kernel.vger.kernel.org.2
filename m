Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA03DB81F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbhG3L6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbhG3L6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:58:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D06AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 04:58:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y34so17399538lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUMiykQNfMbAmHAwrv+rEI/bGM+ClnUap5p0JH7cDWk=;
        b=nOEuMX16PEbcv7Ku8Wq0OOJf4JaQLloyxnXX69y4ciEH+9JpQLa5sHl8FFzp6P+HZN
         A3TPw0IuNgRaZBkIBzQUZSVSAUhQtNi/3TR98vof2uhGG45DmUck1crDb0YJ1jPjO1rQ
         BAdKrrooSGJhQRwqoWTg6r/dM6D2V43cVZdH5WQAMTVgj6gyp9iAj8RMflYWtJ+InJfx
         oeOarek4Cip/AJVkDOOfFxfUteS6BH1V17sl7k/G1qR6RgusjFS7P2A7538buW5i0twT
         3lyBoozMlsRPrBYb9rBoPox7Or6Yi5dwoxKO1x/2PnOH3xYFitQBJ9fbvcJ0/5+MMvXg
         JJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUMiykQNfMbAmHAwrv+rEI/bGM+ClnUap5p0JH7cDWk=;
        b=ECIESUM47xS+XW0Fcg61M2JNIC44VB7zmIdw506a12ZpJ2JKo29IMbuaJfKbm6m2MS
         h4nQLe/HjLMYjL3b4KNGkx+6Nl30I24QPAZiY0wu4d3BaojuAiSm97Sub3UFLpQPQq+L
         2HW86JbcHVAVltRNyYAF2vs9k2BqlFBA3j+fRi8gdDO7Y7Df13oC62/D3/Sf24MbPoTQ
         UTis4e9rZha6z8/PpFYuSx0qT8I68cUopHAjlRBpq5YyQkzb2TQdv0BYxqj/yp1Q6JEL
         263+v/MiEsd8JRsU4DZ5NZh9YhaY1+0uVHMIxNmZ2cUAHJgb41irQh8eaLKtZ8AyHigo
         LCUw==
X-Gm-Message-State: AOAM533hIJYskqTd/D/tVQHwn3HM/kbrJU2cQXTIuRo4V4Z/l322pXGn
        H80Rwy93mqvWWUPxhK8oNNJdoM93Li+b1tABdbXohw==
X-Google-Smtp-Source: ABdhPJwEx3oEbRgthFsX8r5lKXXApepAFs4jKYkBuxT5GrK36PWVmz/RO1TegRk5uc5YVBYD9kcProL40+fEW37UOkI=
X-Received: by 2002:ac2:4c4c:: with SMTP id o12mr1587755lfk.157.1627646310474;
 Fri, 30 Jul 2021 04:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210716162724.26047-1-lakshmi.sowjanya.d@intel.com>
 <20210716162724.26047-2-lakshmi.sowjanya.d@intel.com> <CACRpkdZdK38iwwCQKqUQ1Xbd-5kf8NFjAxT8pvq+e7jT+wiThA@mail.gmail.com>
 <YQPis1mVrVNwplKY@smile.fi.intel.com>
In-Reply-To: <YQPis1mVrVNwplKY@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 13:58:19 +0200
Message-ID: <CACRpkdb+N_FFqZpk9fsECM5q+T9UPzZoCpKzDX5T5f5F_QuWtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Keembay pinctrl driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 1:30 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Jul 30, 2021 at 11:05:43AM +0200, Linus Walleij wrote:
> > Since this is one of those "Intel but Arm" things I don't know how
> > Andy feels about picking up the patch to his Intel pinctrl tree
> > (I think we discussed it in the past) so I need to know how to handle
> > this. It'd be great if Andy queues "all Intel stuff" but I don't want
> > to force unfamiliar stuff on him either.
> >
> > Andy? Do you pick this (when finished) or should I?
>
> I think it's for you. Mika and I are about Intel pin controllers on x86.

OK I'll deal with it, I do have some experience with some
other funny Intel-Arm silicon like XScale IXP4xx etc.

Yours,
Linus Walleij
