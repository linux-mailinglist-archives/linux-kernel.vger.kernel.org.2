Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C5334A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhCJVsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhCJVrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:47:46 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A056C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:47:46 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t26so12283866pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=mCiogpXAvnyIZ07NXe3U+jkz++MrPHNJq4E2jewoVME=;
        b=bJVDkR3wZsBDZQRcdc+hvRJ1PGY2Hy2AjnBbtHH48u/3UTXKpLx2GJnN8CtqqEI2IE
         t6a5cS6JRWbLHVsWfNnGvUjZCtDMie7O0bFnwatk6kpCMWr50sJksoUJ5SOFfm/v5Dev
         R4Q55JBOGbBSDtz9n+CT3p6TXvqnwojvbaPtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mCiogpXAvnyIZ07NXe3U+jkz++MrPHNJq4E2jewoVME=;
        b=YT9N4qQ10pplQmH+G/tCCa5jFpNzqJP115SZxxf2DmP2/SiGPDtDMY9CP5/CAg1jr8
         PHNOJZ5l3BwIFVBzNo1+OXxI2fPfZ3dG81V8b/LtRSbRyGtEwcHYaGthDJrNb96CdMXI
         tTXw0JoM+sCyHo5HgxPYRW+Sp2MCG197SefLxKRy6BX6FW4Xw3yUxW0EaPCEppu1Sbjg
         louPZc4lRh3Qg7Qs+WKXGVsvELQNEO49xaDNpjZKfM8DzD/EKBEi4YWgbuJDPY5leT/Z
         T0hbpw367uoehumXB9qAf3pnhaV6p5l3cHE8mA4KwFhQEPuL8AcuzUS0aWRdAELpbXW6
         5Wng==
X-Gm-Message-State: AOAM533rEX0qmS3kVQL5/hK5fPUUs8MGNIKkul3t/PB7JP9MSFfUC74E
        LJuxKW7ZWhA2JMIplY1E9O5YLwTMhhj7h32A
X-Google-Smtp-Source: ABdhPJz6yqPHIcO/YXVHTgYXA8LMt5NUkJPVvXtvcu/MlK1eW5X9GcRbADpaXIsp5RSETNpnQ0j0fg==
X-Received: by 2002:a65:4344:: with SMTP id k4mr4502725pgq.48.1615412865961;
        Wed, 10 Mar 2021 13:47:45 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-0e28-c46d-f4e0-67e7.static.ipv6.internode.on.net. [2001:44b8:1113:6700:e28:c46d:f4e0:67e7])
        by smtp.gmail.com with ESMTPSA id j3sm290489pjf.36.2021.03.10.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:47:45 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] powerpc/uaccess: Remove __get_user_allowed() and unsafe_op_wrap()
In-Reply-To: <439179c5e54c18f2cb8bdf1eea13ea0ef6b98375.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu> <439179c5e54c18f2cb8bdf1eea13ea0ef6b98375.1615398265.git.christophe.leroy@csgroup.eu>
Date:   Thu, 11 Mar 2021 08:47:42 +1100
Message-ID: <877dmed6kh.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thanks for the answers to my questions on v1.

This all looks good to me.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

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
>  #define unsafe_put_user(x, p, e) \
>  	__unsafe_put_user_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
>  
> -- 
> 2.25.0
