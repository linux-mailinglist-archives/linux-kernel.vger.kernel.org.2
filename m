Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7C37983A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhEJUVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:21:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D06C061574;
        Mon, 10 May 2021 13:20:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so30026pjz.0;
        Mon, 10 May 2021 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cA/DdZqH+qZ+PTKZmFPD/rztPZWvGEHa5WV/C8rLOQ=;
        b=Nknx1W3qgZmEYdA7Mll0SVkCRRs9gwIK6UP6dkkDg9hH4qqwKHBylqMsw4aP8SMwZK
         Rt2+NFqhZmqjyGTGnC5cTfPfqQnGfCE9nGDXYsur9fNwiQa6W4piV8g1MGwXyanp+IDp
         dKITGGXs8+zBRYJn9ML90gPQLWhbLgpVziRev4r0UjSGNAghsdFfZ/SNGEfUxf+yJqLV
         +ajHf3JA24Amu7XYFN7gTR6C/ks9tr2B7wJOSPd2pkk4V11TM61GTWLQ7b1KoLmIgLGP
         d/dhJHDGvwHA2QS3yNXYaoQ5FiCtssKuMfV7bXrLMuMvx/3GE16uemLz2qKqknRcIJKq
         SCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cA/DdZqH+qZ+PTKZmFPD/rztPZWvGEHa5WV/C8rLOQ=;
        b=Ehjr6FdlDCsiC56tUOmJjUXxqyhlnemq/QVnBqjDj53KlS/iTUSDGQAeYW7RUROxTe
         J+rEvhRMbacx6iaIq58r6dw4qrdspO361kWskcIZ5m3ti4chWxJ/x2HeXTXmcPKzl5ei
         9JbXhFIttblR3DJoArtVYmy90zCaKBhE0JYp2I6qKMAAPV+6+nty8EEqoQEvc4tqg6tw
         IL0LQP8DCt5FcWzjsomqNy9vVt67ocKIqf8ZN8mF/JuG+N8rBqVRO6o6iLT0D/wjUhYu
         W3tpRc6M7I2ZFVoCiZzL0nBabZIIWiRaPRtN01FfJPCjsBOFXgeDaNX157qk+U5UmkrD
         Odwg==
X-Gm-Message-State: AOAM533NID66sgkXjhn1bJEXnlvI+I38WkJSOOeeqaKPK2CEnuYpM+8i
        8zXbyIzNaeZU0KG1Zqf/AvGYceU+2K50FRLaUgc=
X-Google-Smtp-Source: ABdhPJwfFrr2vhwfSc2PKYItY8Cl9Uu15yI9i7sgdFH53/GBEfcr140YJMH8XThQ6zb6ntUeu3qQ1UgWxS56tjwg1fI=
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr1009572pjv.129.1620678033371;
 Mon, 10 May 2021 13:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <a22cf56239512f52ae5927f226e79d890d7a1240.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
 <202105110342.Oembupaq-lkp@intel.com>
In-Reply-To: <202105110342.Oembupaq-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 May 2021 23:20:17 +0300
Message-ID: <CAHp75Vfw+5R-qN+iGC4hYSbL6phOoSZ7nuNsyroQPODxEmMaNA@mail.gmail.com>
Subject: Re: [PATCH v9 05/10] regulator: IRQ based event/error notification helpers
To:     kernel test robot <lkp@intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        kbuild-all@lists.01.org, Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:46 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Matti,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on 6efb943b8616ec53a5e444193dccf1af9ad627b5]
>
> url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/Extend-regulator-notification-support/20210510-203125
> base:   6efb943b8616ec53a5e444193dccf1af9ad627b5
> config: i386-randconfig-s002-20210510 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://github.com/0day-ci/linux/commit/904edb46fa37ac86bc1e7a1629141e037f45ebed
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Matti-Vaittinen/Extend-regulator-notification-support/20210510-203125
>         git checkout 904edb46fa37ac86bc1e7a1629141e037f45ebed
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/kernel.h:12,
>                     from arch/x86/include/asm/percpu.h:27,
>                     from arch/x86/include/asm/current.h:6,
>                     from include/linux/sched.h:12,
>                     from include/linux/ratelimit.h:6,
>                     from include/linux/dev_printk.h:16,
>                     from include/linux/device.h:15,
>                     from drivers/regulator/irq_helpers.c:10:
>    drivers/regulator/irq_helpers.c: In function 'regulator_notifier_isr':
>    include/linux/bitops.h:35:2: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
>       35 |  for ((bit) = find_first_bit((addr), (size));  \
>          |  ^~~
>    drivers/regulator/irq_helpers.c:242:3: note: in expansion of macro 'for_each_set_bit'
>      242 |   for_each_set_bit(j, &stat->notifs, BITS_PER_TYPE(stat->notifs))
>          |   ^~~~~~~~~~~~~~~~
>    drivers/regulator/irq_helpers.c:244:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'


Seems like missed {}

Matti, there is a serious question: how had you tested this...
(besides obvious compilation error)
Perhaps you have to fix your process somewhere to avoid missing important steps?

-- 
With Best Regards,
Andy Shevchenko
