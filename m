Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7776D397A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhFATWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhFATWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:22:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E62C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:20:29 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t8so155929pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wNSZ6PEDj3I1kXtwa13X25gdAklt5nxT1YtwBzGa2YQ=;
        b=NhHRA4kT8tiQuiZykTXa40SjjGmLaMqpdUobJPj+9UB6O9VPanYx2GXGoNNW2idVtb
         tSOeuNxywX6WbCQ1hiCrgr3uDWI8i/vEtmIa5SoynKtda2lGyxsFkYlhhnQHp9VFuyVV
         phF+MPvJKH71mbm93+BxK1iJZVF3Uu19OmnwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wNSZ6PEDj3I1kXtwa13X25gdAklt5nxT1YtwBzGa2YQ=;
        b=nB3Whkm4ekvnISjXeD0I0a/BNstvz7FE43uZ4WxNhGUEn6dSMhYcKgpAKhQkGmqaub
         CM+rwRoo2ZyVKz9RzpgUgmWCnwCXFP4ZAOT7tQTMF3Igi2jB0F/8WjN8HlxZZr0gw21V
         ACSSBxT/nZ8WuIBpaFj0EvnWzVHbPn6yMAjM9OcnEXhdHlk9yfEGA7horbPGaAMUHI74
         Bfw64rHwx0cxweJHrjI2JwdTx0MF50S3cZyBmidFnd/eV2ThiidBr25PYdDKDXqsHQh8
         99maTfBoELWzJQ42mgajo93ehdNgCWqepbPUtXzckhUNx+C98uoA8b/rGSd8ifhyTjHJ
         Vp1w==
X-Gm-Message-State: AOAM530ZuEc+8ACRAmIcRSsDKOg0M+tPXQ3ROWGb1S9A36WLiWiyAs/J
        wZKNM/ZPVVUtebmhYXpACSNpVg==
X-Google-Smtp-Source: ABdhPJxgSwrzgiPoAYHk8fJ2FP/69zlFDckk7KeQjqUvaP9nnygyCFBz7Yg0bGTSdlJmazXgdvvoPg==
X-Received: by 2002:aa7:8f3a:0:b029:2e9:c63a:312e with SMTP id y26-20020aa78f3a0000b02902e9c63a312emr14024994pfr.73.1622575229181;
        Tue, 01 Jun 2021 12:20:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mi11sm2712312pjb.29.2021.06.01.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:20:28 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:20:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] kgdb: Fix fall-through warning for Clang
Message-ID: <202106011220.AA0C1482@keescook>
References: <20210528200222.GA39201@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528200222.GA39201@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 03:02:22PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> fall-through warning by explicitly adding a goto statement instead
> of letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 25 in linux-next. This is one of those last remaining
>       warnings.

So close! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
>  kernel/debug/debug_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 4708aec492df..431749dd9ab6 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1038,6 +1038,7 @@ dbg_notify_reboot(struct notifier_block *this, unsigned long code, void *x)
>  	switch (kgdbreboot) {
>  	case 1:
>  		kgdb_breakpoint();
> +		goto done;
>  	case -1:
>  		goto done;
>  	}
> -- 
> 2.27.0
> 

-- 
Kees Cook
