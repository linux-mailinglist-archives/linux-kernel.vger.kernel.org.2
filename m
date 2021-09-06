Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F23401A65
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbhIFLKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbhIFLKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:10:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0BC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 04:09:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so4523192wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Arq1up5bA53xLHQpnJvwo0x1Fb742WDNGFLacyi2NNw=;
        b=sqsd4dIPCJITuPasRtiJ+ze6aVIr8Vb4qU2eVNhGWf85MKDGYCstH46jQu1VuBpsKd
         6bQ5Dp42eh/rxpa2l4Bhx5rbQAGRd2NhhiZ+hzfGLTfQt60s7iddg5yaPHJNQxc4Ln3j
         +PIAo+WX0/WoSSj4F9yKZWGf1w8ZTSa2K8tDlyDWc+wSA72Kr93h0uhSx5dKNycvzCaX
         qPGbQuL3fbV5oIXtnPat3sJA6hBCr5xRlV++Vg+3iKiVFVla775hSwWCt5X/anlm8gu6
         5n7Qo8z70nKG/pA6/Rk0WqamwFMeeTikc8e/RSAUiTtMf8AuW5IEGscxPrjnVQJH16Ev
         0TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Arq1up5bA53xLHQpnJvwo0x1Fb742WDNGFLacyi2NNw=;
        b=ArwVBhTlX1HvWqMGHVYOke9T/cYXAsoWbN1FhN+kZVAeNnh5/eKss9cDceQa/74exy
         w8NpEwyowCQtr0IDuYUm3WEHv2o+aBYkZM5NCHsGLo4mAY2inl0ut6U9Apb01XMBvMjJ
         HF51DiuMHHPDTNIaNn7i/yUfEIOV/fYpPoRmIaTXCluJhjJoz0EQA84WoOewA4rPAY+Q
         UJGzkgr2vaxBS+t6+GDp2JFe2rjmYMMUQHNcuEpwpv01FP3Bh5nGsjz/vvAwGtEXpuZP
         65+DcVblCX0y6NyfHnt+ujdIlGdYnUxgU//8+ynLj71aMCOPEmwBan07+OEwj87MF+PX
         vhTw==
X-Gm-Message-State: AOAM5308PeDV/ZG9FvS6OlShwNTiVaSXz1et5cmXYiISfnUWIyIaMxNy
        N7xnCrdfBzkLVOooZZSHyj0gzg==
X-Google-Smtp-Source: ABdhPJyyhlYuqxiyV6YBKidEilVhA2tJtdXsvYpAarjRG+v0ujsy6bKkyxEbZvFxQrjqUTMd77CJqg==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr10789725wmc.42.1630926571381;
        Mon, 06 Sep 2021 04:09:31 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id d7sm7568540wrs.39.2021.09.06.04.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 04:09:30 -0700 (PDT)
Date:   Mon, 6 Sep 2021 12:09:29 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     ason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: debug: Convert to SPDX identifier
Message-ID: <20210906110929.7jla5xjjlhpoe34m@maple.lan>
References: <20210822022206.221-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822022206.221-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 10:22:06AM +0800, Cai Huoqing wrote:
> use SPDX-License-Identifier instead of a verbose license text
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  kernel/debug/debug_core.c | 5 +----
>  kernel/debug/gdbstub.c    | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index b4aa6bb6b2bd..da06a5553835 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0

Should this be: GPL-2.0-only ?


Daniel.


>  /*
>   * Kernel Debug Core
>   *
> @@ -22,10 +23,6 @@
>   *
>   * Original KGDB stub: David Grothe <dave@gcom.com>,
>   * Tigran Aivazian <tigran@sco.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
>   */
>  
>  #define pr_fmt(fmt) "KGDB: " fmt
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index b6f28fad4307..9d34d2364b5a 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Kernel Debug Core
>   *
> @@ -22,10 +23,6 @@
>   *
>   * Original KGDB stub: David Grothe <dave@gcom.com>,
>   * Tigran Aivazian <tigran@sco.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
>   */
>  
>  #include <linux/kernel.h>
> -- 
> 2.25.1
