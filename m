Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFCD379831
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhEJUQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhEJUQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:16:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F7AC061574;
        Mon, 10 May 2021 13:15:46 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s22so14121269pgk.6;
        Mon, 10 May 2021 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+p9XfQZN9xRLgB1v8BKeqEGzYiPvUKqgY5NPOFg08/g=;
        b=sCN/upVCTo8HwsQkCNZHSTnnnqjeVDCSqcBmfqtY8K135locm6HipbNHWugeevKnu/
         yrLFaa+caBNyMOx9aU/vu/7chsuz0SGqOdBpjznAcMeI9D4FD9CkemRNXrkZMSvndbBb
         B70ePynTRa+bPr6KYcbGg25T5gPY633v66ecPgTNs8w7P5UhwpHxh0gq0Kb6kdXNQvAo
         CBvd7xmVJyWG87Gd8j7DYs89ygX3H9yL3guPAmRArqvRxhFo9BXc5pz18AHtWY0Eyapg
         oipdPX/wFQd96EiymSHYXO/rQFJBL1uB/fyNqymEfcRKjmHhHb6jOgy9MPpQOK6st9/v
         iKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+p9XfQZN9xRLgB1v8BKeqEGzYiPvUKqgY5NPOFg08/g=;
        b=Qlgxsl3RglbMtfSQXELg0fYRiczk0Pv7gakB7wXzyUH/uO1GiheDlGYHDoAyExjzPx
         0AYsUUgMLTnfUQnao/zgBVS0YetMeQ7dqf0zPWqycBuwZrDTz7RsKcRAMUv8qwjgFjlc
         64llsQg56PB3l/DZv9cCVd9B11WcbfaJYGCzvO5KBq+U7WgCHjEx+M9sTj5+sLdCeC5v
         WT5Cboe+FE0lyGqYQOx2dViOISBwYWgB2oZBkJjaKCKAK9BVUBPmrJgNdz7RHukslWV3
         DCgjez066iEq+MZT8XQsVIjTNLAblLSgNT7PpVT1CRZBVr5KupOWp+wmWTUCorFDIRcB
         Gfdw==
X-Gm-Message-State: AOAM532+hqGzYSseQhMZits0EXO5uRYbEtlg1nLxSoL+KL368Bs79bec
        vEtZUSLDkJNQ0wjCA0VEdFualTBLUY9hDFMqSME=
X-Google-Smtp-Source: ABdhPJyhmuiLlb5avsxYTZCc5YVZalAQw8AdHZRDj9gvkDLOBNQGJ+07d4yuOwkzbH2RSJHdW4gZwQ2pr/pYDElYfBc=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr26145345pfb.7.1620677745573; Mon, 10
 May 2021 13:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <a22cf56239512f52ae5927f226e79d890d7a1240.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
 <202105110116.2KVffy45-lkp@intel.com>
In-Reply-To: <202105110116.2KVffy45-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 May 2021 23:15:29 +0300
Message-ID: <CAHp75VfS4=X9mW9oM+ySQeq-bd+btxD7c9gjSZCztvkvJTpbXQ@mail.gmail.com>
Subject: Re: [PATCH v9 05/10] regulator: IRQ based event/error notification helpers
To:     kernel test robot <lkp@intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mark Brown <broonie@kernel.org>,
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

On Mon, May 10, 2021 at 8:35 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Matti,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on 6efb943b8616ec53a5e444193dccf1af9ad627b5]
>
> url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/Extend-regulator-notification-support/20210510-203125
> base:   6efb943b8616ec53a5e444193dccf1af9ad627b5
> config: x86_64-randconfig-a015-20210510 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 492173d42b32cb91d5d0d72d5ed84fcab80d059a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/904edb46fa37ac86bc1e7a1629141e037f45ebed
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Matti-Vaittinen/Extend-regulator-notification-support/20210510-203125
>         git checkout 904edb46fa37ac86bc1e7a1629141e037f45ebed
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> drivers/regulator/irq_helpers.c:244:4: error: implicit declaration of function 'pr_dbg' [-Werror,-Wimplicit-function-declaration]
>                            pr_dbg("Sending regulator notification EVT 0x%lx\r\n",
>                            ^
>    1 error generated.

I believe it has to be pr_debug()

-- 
With Best Regards,
Andy Shevchenko
