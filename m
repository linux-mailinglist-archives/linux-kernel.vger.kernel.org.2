Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752E93CA340
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhGOQz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhGOQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:55:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B458FC06175F;
        Thu, 15 Jul 2021 09:52:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j9so6029927pfc.5;
        Thu, 15 Jul 2021 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mUlg+XLAlWs2OpGsm7v1Fxu/dScyzw5iATM/EAu2yA=;
        b=Usx8MphYIkqlfCMOPrXG6SMy8C3xTpgMSgFEPeWJ6KRIWjauV5XzBe6Bs2gVK+jcn2
         jQ5mq6lx18Q14GQpc7DuCL6zEeyy0u7DNix1bdscl+GSRS38NkGhd+8BxktMTbBcqaPI
         My0xt93eB9/MRbSwiGorYyuOJa0FXGHikM8MZIV9+za6QrORyrR++BuxY5pSIgU0EuH+
         wgM44M4LEfn4DAr/72Xyk/C55oZHZSKRVaFdv6NFRoqIWvmp9EfRm8xEHDl4TfMsi21s
         NzXtoIARIWcRZW79iX53qHbE5AncBusdCdeNMtGJ7z/CwfX7cSlB8AhysekFiwcEMM/E
         W3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mUlg+XLAlWs2OpGsm7v1Fxu/dScyzw5iATM/EAu2yA=;
        b=SWScJh0x60pI36NH6XSXviI/xtvUU/kWu+P9VGSawB6ynrLJ6W68kU6n7DScYEuF+q
         P8yal12AWg+juFmW4qZuPZ9mRQX2ZFUNjEha3gwXanOVLEcZ9bP1xQa09xm2uQVg8OG/
         LtbiLWIkMmPPv+NeBbiYdy32Oopv+XhOxsXBaX8VhBH5dNGUkOq50P6CcQCvp4Eh8Cbe
         vP1tJU9IOGpfs2q398NiWqaEJ+1IGabqjIGKY4BU8f00NvSWVuFpmLBtZxUD7t1X7/ST
         3GQp5Tzf2RW+m/16qydtfKeCCm57YKlD3htnTFNhJLA9dSqO8wcxC8kbZYmin0BmBznd
         qFow==
X-Gm-Message-State: AOAM532Dj2gD2wH5NHsCvXQZZV7seCiaUKcJvfwPfyHduSZ0vAhNCU9G
        14p0dfY6yA8JHzAsGGlHCLPbzn9n/hDy/SP2foQ=
X-Google-Smtp-Source: ABdhPJxbxh9MntYcaLyvO5NKj1X9Jd024SE3i4PphFkTofHotG9CHRDsLmrs+8TpoEP0WCtgUHxu9XuSS2x3Z/nMqZg=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr5462920pfh.73.1626367951167; Thu, 15
 Jul 2021 09:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com> <202107152356.7gQSC0vc-lkp@intel.com>
In-Reply-To: <202107152356.7gQSC0vc-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jul 2021 19:51:51 +0300
Message-ID: <CAHp75VcxP6QSoATProqjqJ_kmjXr4FfjijohCyumrw_gmj904w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] clk: fractional-divider: Export approximation algo
 to the CCF users
To:     kernel test robot <lkp@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kbuild-all@lists.01.org,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 7:49 PM kernel test robot <lkp@intel.com> wrote:
> I love your patch! Yet something to improve:

Definitely!

> All errors (new ones prefixed by >>):
>
> >> drivers/clk/rockchip/clk.c:27:10: fatal error: clk-fractional-divider.h: No such file or directory
>       27 | #include "clk-fractional-divider.h"
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.

Indeed. No idea how to compile-test this on x86.
Let me see what I can do to avoid other issues.


-- 
With Best Regards,
Andy Shevchenko
