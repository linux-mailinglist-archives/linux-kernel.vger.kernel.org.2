Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1732DDD0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhCDXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhCDXUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:20:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 15:20:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q20so389400pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 15:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BmHuJ6EbKgv6oC/dKNN76FQAZcbaEkgGB9SgRX7z29E=;
        b=AECHJZxSqvO+H4GKfRfbmYxEEWwhR68+5jgW+7sCDf7jwXzJXGnkkpow7w+vSypoOZ
         mZxKl1Rxqm1dyKVqStc7s0lW7M5tgeNWs/QnZENt9tDvYo8kMmVqS8h+gl3jrVX8tO+A
         /c/zigxHkh/9WkLw1nocQtHKi43PAANebC9vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BmHuJ6EbKgv6oC/dKNN76FQAZcbaEkgGB9SgRX7z29E=;
        b=jc2XuZxyLF0VVqCXvZmYl0HK/K4yTxWBKfE40gv4T4DCJTkJfCf8OPJYBlgGgqOYol
         wRoSx14b4jYFZZuXE2S675KdKW+Qks70jk4Rg+C0FC3o734zOG/JHpFXDEuH/95tgvjW
         cYmu1Kh3p1NFsBrqXhhhogY9GhWKf87FPDAII6jjtXlTL+ea63THmyEhglARDyo9I72F
         rPL5mnwforhnJrUHIfg08NppxbeeTopwZGPBAmfEZKgxFJkp9+g0ek1KlTya7VfNr+7l
         E8qHr78oyNfgCAWZoPE93oVKn+J0pBCeQBf4fO9YSse1KU2jZPI+51L1ePMHEAJnPklv
         00lA==
X-Gm-Message-State: AOAM530OmwdZ8idmMcHOrxUDyVVbCJxMsFT2ch7bt1FLTF0p5qj/hSWs
        CBJLMTy5v6U0F+pQr+fOlMoyCg==
X-Google-Smtp-Source: ABdhPJzL95WWM3jJYkOgx7odmGkUkJlPHvcnpsTZPqC6hZXjg6GSAgg8EYiRpn+3ZgM1ClMsY/c5zg==
X-Received: by 2002:a65:6645:: with SMTP id z5mr5434570pgv.273.1614900032448;
        Thu, 04 Mar 2021 15:20:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d11sm423311pfd.43.2021.03.04.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 15:20:31 -0800 (PST)
Date:   Thu, 4 Mar 2021 15:20:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: rebuild GCC plugins when the compiler is upgraded
Message-ID: <202103041518.22EB819E@keescook>
References: <20210304113708.215121-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304113708.215121-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 08:37:08PM +0900, Masahiro Yamada wrote:
> Linus reported a build error due to the GCC plugin incompatibility
> when the compiler is upgraded. [1]
> 
>   cc1: error: incompatible gcc/plugin versions
>   cc1: error: failed to initialize plugin ./scripts/gcc-plugins/stackleak_plugin.so
> 
> GCC plugins are tied to a particular GCC version. So, they must be
> rebuilt when the compiler is upgraded.
> 
> This seems to be a long-standing flaw since the initial support of
> GCC plugins.
> 
> Extend commit 8b59cd81dc5e ("kbuild: ensure full rebuild when the
> compiler is updated"), so that GCC plugins are covered by the
> compiler upgrade detection.
> 
> [1]: https://lore.kernel.org/lkml/CAHk-=wieoN5ttOy7SnsGwZv+Fni3R6m-Ut=oxih6bbZ28G+4dw@mail.gmail.com/
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

This seems fine to me, but I want to make sure Josh has somewhere to
actually go with this. Josh, does this get you any closer? It sounds
like the plugins need to move to another location for packaged kernels?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
