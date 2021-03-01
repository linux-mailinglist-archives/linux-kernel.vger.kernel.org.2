Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F23332A008
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575171AbhCBDxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244863AbhCAWDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:03:39 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076BBC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:02:59 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q20so12445083pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qZ//7UGmglUFd9a+K6I+xp+r8KSLdySqRo4lIorwHRQ=;
        b=RKt8VDYlVD/hDSLtRtLJB9q7LoGnpuo2sk84bcxbEoSf84NYm/Dj+wlcOat9vUyLvU
         BpOmRFVA1VNz3TirVy4M4WxwSHOGpHtTr154/1k39CfTegA7vbagTk7V2RuRa6ZDJPip
         u+VdXHk43FdYsOZLjNk09aa0nZMlFXUv3z6cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qZ//7UGmglUFd9a+K6I+xp+r8KSLdySqRo4lIorwHRQ=;
        b=WW9jW7Tz+DIwe4IWC575W5/WgCgDmOVIy0voZnrIonSYPclTCy2lUycyKWWHeCb8Kl
         EvXLrhkIYTIf8joIEv7RC2N41p0HTrtYU33rB8c82FywX84o0HiVefJ8kRg87cXTvg5m
         iAWly2WoLlkxdnuBJPAYIQ2Wn4jfff1c/FYjily9QOzfjEFHlJmMT9ATCXr+Pr7rVlGw
         j03h7T5UaJKb7ithE+Q2c7Y1kWNgsqnWmeKe8zNrKHgRXPzMMzerRwg8SENQcGscPqEs
         wXYvp5ebkT54cVv2JkvL30sKe+E4nuUgNaQ1AKF+jk21pzkeky7YFLY+ZHeYQDjDM762
         cSFA==
X-Gm-Message-State: AOAM5310nqQNrucUXDwYOlyuq5UIOquzzyr/rzUX7aaUOojhRAwUPqAV
        O5wk/DpW0KsEimOewtpPCCMGNVDSWl5FVwgx
X-Google-Smtp-Source: ABdhPJwmq0kilOi0JQKkj25v/mVFtfXKLg24Abgr69OrIZbj+HE+w4Zv7SxblC5O8Gv+agxEKcqrxA==
X-Received: by 2002:a62:5a45:0:b029:1e5:4c81:c59 with SMTP id o66-20020a625a450000b02901e54c810c59mr430011pfb.51.1614636178553;
        Mon, 01 Mar 2021 14:02:58 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-b18e-89be-e1b2-4959.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b18e:89be:e1b2:4959])
        by smtp.gmail.com with ESMTPSA id 16sm5601501pfx.45.2021.03.01.14.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 14:02:57 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/15] powerpc/uaccess: Remove __get_user_allowed() and unsafe_op_wrap()
In-Reply-To: <e0538c71167bd90224a8727fea9ed5b75612e2d7.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu> <e0538c71167bd90224a8727fea9ed5b75612e2d7.1614275314.git.christophe.leroy@csgroup.eu>
Date:   Tue, 02 Mar 2021 09:02:54 +1100
Message-ID: <87im6ao7ld.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Those two macros have only one user which is unsafe_get_user().
>
> Put everything in one place and remove them.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/uaccess.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 78e2a3990eab..8cbf3e3874f1 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -53,9 +53,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
>  #define __put_user(x, ptr) \
>  	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
>  
> -#define __get_user_allowed(x, ptr) \
> -	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), false)
> -
>  #define __get_user_inatomic(x, ptr) \
>  	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))
>  #define __put_user_inatomic(x, ptr) \
> @@ -482,8 +479,11 @@ user_write_access_begin(const void __user *ptr, size_t len)
>  #define user_write_access_begin	user_write_access_begin
>  #define user_write_access_end		prevent_current_write_to_user
>  
> -#define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
> -#define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
> +#define unsafe_get_user(x, p, e) do {					\
> +	if (unlikely(__get_user_nocheck((x), (p), sizeof(*(p)), false)))\
> +		goto e;							\
> +} while (0)
> +

This seems correct to me.

Checkpatch does have one check that is relevant:

CHECK: Macro argument reuse 'p' - possible side-effects?
#36: FILE: arch/powerpc/include/asm/uaccess.h:482:
+#define unsafe_get_user(x, p, e) do {					\
+	if (unlikely(__get_user_nocheck((x), (p), sizeof(*(p)), false)))\
+		goto e;							\
+} while (0)

Given that we are already creating a new block, should we do something
like this (completely untested):

#define unsafe_get_user(x, p, e) do {					\
        __typeof__(p) __p = (p);
	if (unlikely(__get_user_nocheck((x), (__p), sizeof(*(__p)), false)))\
		goto e;							\
} while (0)

Kind regards,
Daniel

>  #define unsafe_put_user(x, p, e) \
>  	__unsafe_put_user_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
>  
> -- 
> 2.25.0
