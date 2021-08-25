Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E83F7E60
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhHYWXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhHYWW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:22:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71118C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:22:13 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w4so1255306ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBo/yuwYCnpEEKpqJMVcO5vlkbx1VJXFEaT8Qj6ZnyE=;
        b=d1LVjQOWL5uGIClma6igO2ILkdPSiZGbS3OfVt5O+19W6dtMYCP69aNVf6rY029EEi
         7se6tCBiFiTLKbNYIdN/l37NGXSq0e9M0Ky+rcUAPbocaFhyk8sZM5RYIFE/NmbDPzyw
         ZaY9FXpbUpNlfnPOoQnMGFmwVhyURWYzB5BIbenSbvoSHyxT1aDqt6yAHLjClxtt3iua
         QTi5DPd0gUdnjxi/LUdWYsoWilaffIgIqC4eT2p9fC82gH8lbLkvY2OTyzgTgKOvz5Fp
         N9H7WqT2rm5PdJqV5wehDJFI+uQ1vpkOMvkNjPwjj+vpsC2mzJHiuqnalEO5ucK7jHlK
         Ojmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBo/yuwYCnpEEKpqJMVcO5vlkbx1VJXFEaT8Qj6ZnyE=;
        b=uBu06YYi1lqrlVzqwwtZQ7EEck4dcoEi5FYHOoaHatJ9uKVfcgYeXI4f5AQTQYYw/N
         uvS4fmBQ/bAZeDg7MUybE/CuoQN0XTpM8QH93YclGhzCZY6gxnGW5bNOj9O9unAwKr4N
         /+L/Me6apPQR+13yEO+i59Guz59XXsU4YLNGvcUL+S2SWl4eObZPlFcpnLws6U8hefv3
         0lEAZaRJ/8yO2BBqczk43jbY/2/tR4m0Y4toKh869qzBmLS5uT4LCJqudX3VtmOGkGtN
         aalOtYWDIm9DpqtsG7CT4G0PubTWEcZNdbO0a+JZmUWgtCEEMojB+qmmlPMOYrrjUe/e
         9vnw==
X-Gm-Message-State: AOAM5309YuyxH/uU5GDOZDy6z8GF2ghd9eYlt/AvebJTtQNpkT2pTyH5
        kYQUuJDEDW7rMzlgzd6+EDt9FPKf5PFTQ7gpZ+MZUFu31DUsVA==
X-Google-Smtp-Source: ABdhPJy/FAkLw45hLQ1lPa7pFEUDGn94AeA8zZrnS96FF45pmqBhYsblUz1EHdZjJBDMh7EHFt46FJNZu9kaSCyFICI=
X-Received: by 2002:a2e:a367:: with SMTP id i7mr383718ljn.244.1629930131530;
 Wed, 25 Aug 2021 15:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210822021542.2-1-caihuoqing@baidu.com>
In-Reply-To: <20210822021542.2-1-caihuoqing@baidu.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 15:22:00 -0700
Message-ID: <CAKwvOd=VaVqUg_JJyWNz+69d91gpTphKMVF_YatspZdT1D2yzA@mail.gmail.com>
Subject: Re: [PATCH] gcov: clang: Remove repeated verbose license text
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     oberpar@linux.ibm.com, nathan@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 7:16 PM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> remove it because SPDX-License-Identifier is already used

Sure.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  kernel/gcov/clang.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index cbb0bed958ab..b97a922b36b7 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c
> @@ -3,16 +3,6 @@
>   * Copyright (C) 2019 Google, Inc.
>   * modified from kernel/gcov/gcc_4_7.c
>   *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - *
>   * LLVM uses profiling data that's deliberately similar to GCC, but has a
>   * very different way of exporting that data.  LLVM calls llvm_gcov_init() once
>   * per module, and provides a couple of callbacks that we can use to ask for
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
