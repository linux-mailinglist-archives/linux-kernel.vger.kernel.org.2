Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88998401DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbhIFQC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhIFQCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:02:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5AEC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:01:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so10499407wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nZNOqvCTllmH6p8FAtp7O1mUgKdNYQZBUnztmCg4OwE=;
        b=v/6l0XFYJQC+iOp7T7uOf3fRXDoq//OlVQ9PirVbU43FMAvxGsJIneO6Oc9sErnrsu
         2gk+K3wGmzC/a7xD2OMmk0fxx2JfPhgJ4062tbdxUSm/xGkFP2w5FSrs4YulyeRvh5kk
         x945HLLLnOJgBdJbYVjisDsM/FmL/twybQhnBJ406Keqr1vk4JdeCWbGWSmTU0DF6TQv
         IrpoyXtlXHTBQgAB3P9fIguGVuA3YXSBYg2EzOi/vr1miN/O94qVQKQM9sI7bVuyiIh8
         mV6lcENy/4aKO2E87BVnUHzTRm4Ier9ca3usjSH95uP7NGEE3h/HVbZIG1iAGelEL/Fm
         VgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nZNOqvCTllmH6p8FAtp7O1mUgKdNYQZBUnztmCg4OwE=;
        b=M+cBLcDk4K2Nypary1GbJvEUprfPdGKIRltOvhy0m5dGsnTly6o5lfZYMy0vc1+xHD
         68+B2tGu1YiAb9WitpBQ5jIqP/2LMG6CrPLKeM3GPuPfPFcAhWwGqndRcNlMgMNu+6RL
         nSGSZNnSXOmYtKzBc90LTcaCL1onMcXeTBPKfwuVPAxGpJ+CvyXyeKn1YBE0NvXSYEr2
         tgLJqD0a4hjKJEL243odbg39GqKUTiwrZhXuxUBHrarhLEDFNl3olakjowrUpjZZvPDV
         Jre853qRRAURgZ41xMSgRZgRT466pPW+9TScmIGsov4zh4WinfJSWNHouqVC+eLSMj81
         ZshQ==
X-Gm-Message-State: AOAM5322hQJu6TNKlv6ggVakiU/ecoT7PNBOtEYePomr3yiTKCt7d0rm
        4Bh+FwNwL6bxGwxX/lUPQvdxX76lQrznu8vZ
X-Google-Smtp-Source: ABdhPJw/qs9dqmozAk/iSNP5480wvgNQbMemh1yjemJvklEwIvZFR/RhSUAubyMYxpkP5FxVu3qKZg==
X-Received: by 2002:adf:f889:: with SMTP id u9mr14697038wrp.67.1630944079371;
        Mon, 06 Sep 2021 09:01:19 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id u9sm8349588wrm.70.2021.09.06.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:01:18 -0700 (PDT)
Date:   Mon, 6 Sep 2021 17:01:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     ason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Kgdb-bugreport] [PATCH v2] kernel: debug: Convert to SPDX
 identifier
Message-ID: <20210906160117.dq2lpk63xs7pfnre@maple.lan>
References: <20210906112302.937-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906112302.937-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 07:23:02PM +0800, Cai Huoqing wrote:
> use SPDX-License-Identifier instead of a verbose license text
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied. Thanks!


> ---
> v1->v2: change GPL-2.0 to GPL-2.0-only
> 
>  kernel/debug/debug_core.c | 5 +----
>  kernel/debug/gdbstub.c    | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index b4aa6bb6b2bd..da06a5553835 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
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
> 
> 
> 
> _______________________________________________
> Kgdb-bugreport mailing list
> Kgdb-bugreport@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport
