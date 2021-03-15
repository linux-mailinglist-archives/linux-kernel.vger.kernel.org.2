Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF7E33C7FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhCOUr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhCOUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:47:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7CEC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:47:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso142878pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MjoMbH2IgXQqrLsfNTjFPTA182WJmfI1LoyU1nvk9uw=;
        b=WMF8eJj+uuAS0WTr4cYS95+QiRXz9ym4ox14ST2bkKtpLHBMgzId5Q04lOwxiCFpgm
         xe8YF+YxAdSdH02avnMEz5XCysml4P4pB9FbC9f8pzJXvNIks7RUNFCwt/Nuue/Qh4P0
         JrqybpT8rDrsx4VJ3C6xHBBkcuA3m8Dqn1rC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjoMbH2IgXQqrLsfNTjFPTA182WJmfI1LoyU1nvk9uw=;
        b=sEe7EwGutoQnVSdlfmyfbJdlF9E3I+p9FMasMUVO+tvplL82mNZQ2w5713Mw0aoONW
         LAom9VwiwaTPhu7GCTw9C9ZSX+8A795GvMB24XMbXu/dYbtJ/7alQ99NvTOAXKaE+qX5
         DVcvRI6JeHkX/aN5HtmVCF4+Jy3AkBqMlBCIa7njMtBze+9aqNrhWBOmB0cwuiiRad8W
         XjZLKKfJUDntXFWoKK1VzfKPk9GOCFgwqU3S0DTjOc54OIWzPCtAWkBsb+ZwMh/IXwnP
         0nOOumIINT9CGChxzg4BdbAzgzmuSxgg8aWAXTxzeeV7RkjPnrmNm/HAnGrwdcfO/MeI
         Bo1A==
X-Gm-Message-State: AOAM531sKsKy8Z4AqY5kqIvIHaWAN1jMAHvGgSBx+SQhRRP2kaE9XLb4
        Cbf06oCZxPmQWaRwwjmPM/3SBw==
X-Google-Smtp-Source: ABdhPJx6i599Wgyk/PeP+I/z6+hTTyj/H5/EsWQ7ulD31DTiITATmfpNYeNBuzLSw1q3MyNWxftgYw==
X-Received: by 2002:a17:90a:e542:: with SMTP id ei2mr965694pjb.134.1615841223685;
        Mon, 15 Mar 2021 13:47:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j21sm14368091pfc.114.2021.03.15.13.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:47:03 -0700 (PDT)
Date:   Mon, 15 Mar 2021 13:47:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     menglong8.dong@gmail.com
Cc:     ebiederm@xmission.com, gustavoars@kernel.org,
        viro@zeniv.linux.org.uk, zhang.yunkai@zte.com.cn, pcc@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: remove duplicate include in signal.h
Message-ID: <202103151346.F7FE09F43D@keescook>
References: <20210313111108.366380-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313111108.366380-1-zhang.yunkai@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 03:11:08AM -0800, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> 'linux/string.h' included in 'signal.h' is duplicated.
> It is also included in the 7th line.
> 
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/signal.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 205526c4003a..c371d3a3ff61 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -124,7 +124,6 @@ static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
>  #define sigmask(sig)	(1UL << ((sig) - 1))
>  
>  #ifndef __HAVE_ARCH_SIG_SETOPS
> -#include <linux/string.h>
>  
>  #define _SIG_SET_BINOP(name, op)					\
>  static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
> -- 
> 2.25.1
> 

-- 
Kees Cook
