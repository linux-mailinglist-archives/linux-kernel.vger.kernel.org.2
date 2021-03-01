Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8961432A019
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575298AbhCBDzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbhCAWVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:21:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C22C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:20:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id jx13so538159pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wMX3q2NCKCdQkZCDujwqGQ31ThPGso7OFWe+UfWY/6c=;
        b=clAXYSbtvOkDRyzlGaVMsPGkEIIDxpuKC4vSpzkBkrXxfrZNkqUH6iLVhqgK0cFuND
         jbjQUX4UeFLo8ebPWr6I4kAVOEocI5D4Ne5gk+EbongbqBFT8cFRtT/H1UD785n+fRmq
         ssFJukq6wVJoPcTrPTBfCDwRG2zjwnJmSQ4VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wMX3q2NCKCdQkZCDujwqGQ31ThPGso7OFWe+UfWY/6c=;
        b=U2+Uyq5IyBWuDNZ4RJxRUro03yPYCX5sUmnLeGIa2MLuf53xuFDqCLBvwsCoygIpKT
         jERsBKosARxN5r4bIQf+SkI2MEcvwq7DyOv7guq2W1AwY+u/RCMdVsoWdFdaK7J3KDxW
         oj3hkwqkyKx+vjc51EuY+5Ja6WVarwglim39rYnqwqrFQnlsiCAQteWvv2s78MnHXcHQ
         v230uvPRewTdNuUQTJz7T2PzFVIXQa2GuU9Q64SYLBqxEe8YOc/frjUoXNlnF+KHnbGP
         xfjupG7lCou6qhjzh8hQs1jSnC/hOEB041rNllaad6p3j6N+3cOwkeJubHe8kTu1Qw+d
         nU3Q==
X-Gm-Message-State: AOAM533tMdsR9/7ec07L7CK5TV3fs8cD+NwyAQypqAWvj+KasJQjCtJG
        CfYpeVCyLsaQxf8+a8QtR1fACnz4i4MEexU4
X-Google-Smtp-Source: ABdhPJyIlALZqCEKL0o+XkvYRSX2xp62dBh4C3DvJ5pbvPlKNXlXkGE1tNH5kl71wgPmoS/BlnN+Aw==
X-Received: by 2002:a17:90b:253:: with SMTP id fz19mr1050336pjb.160.1614637215570;
        Mon, 01 Mar 2021 14:20:15 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-b18e-89be-e1b2-4959.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b18e:89be:e1b2:4959])
        by smtp.gmail.com with ESMTPSA id mp19sm1041301pjb.2.2021.03.01.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 14:20:15 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/15] powerpc/uaccess: Define ___get_user_instr() for ppc32
In-Reply-To: <03d1f57f73c74748829994f8026cb274065c1d8d.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu> <03d1f57f73c74748829994f8026cb274065c1d8d.1614275314.git.christophe.leroy@csgroup.eu>
Date:   Tue, 02 Mar 2021 09:20:11 +1100
Message-ID: <87ft1eo6sk.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> +#else /* !CONFIG_PPC64 */
> +#define ___get_user_instr(gu_op, dest, ptr)				\
> +	gu_op((dest).val, (u32 __user *)(ptr))
> +#endif /* CONFIG_PPC64 */
>  
>  #define get_user_instr(x, ptr) \
>  	___get_user_instr(get_user, x, ptr)
> @@ -91,18 +95,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
>  #define __get_user_instr_inatomic(x, ptr) \
>  	___get_user_instr(__get_user_inatomic, x, ptr)
>  
> -#else /* !CONFIG_PPC64 */
> -#define get_user_instr(x, ptr) \
> -	get_user((x).val, (u32 __user *)(ptr))
> -
> -#define __get_user_instr(x, ptr) \
> -	__get_user_nocheck((x).val, (u32 __user *)(ptr), sizeof(u32), true)
> -
> -#define __get_user_instr_inatomic(x, ptr) \
> -	__get_user_nosleep((x).val, (u32 __user *)(ptr), sizeof(u32))
> -
> -#endif /* CONFIG_PPC64 */

The previous version of __get_user_instr called __get_user_nocheck,
this version calls __get_user. Likewise __get_user_instr_inatomic called
__get_user_nosleep and now it calls __get_user_inatomic. I was confused
by this until I chased the macro definitions and realised that both
names refer to the same thing:

#define __get_user(x, ptr) \
	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), true)

#define __get_user_inatomic(x, ptr) \
	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))

(I don't think you need to do anything here, I'm just documenting what I
considered while reviewing your patch.)

As such:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel


> -
>  extern long __put_user_bad(void);
>  
>  #define __put_user_size(x, ptr, size, retval)			\
> -- 
> 2.25.0
