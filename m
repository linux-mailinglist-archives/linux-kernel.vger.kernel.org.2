Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526363FC2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhHaGSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhHaGSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:18:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C72FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:17:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d17so9958880plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=h12y69BzOdAqtGfc38mtOtL/jCEg2kKWm7ttfdSU3V0=;
        b=emCEUMlIwclLmJQocMR7Nf+pbHFowImda37C+Ud6SPflKSIYLYQF718TUTX8KR+Xhq
         fjhyRLZS3IJE8WCoVlQYfGfh7e4uDTSAnw2g6l1eZYG7KudOnCgj0EhOjqSOuL5xxWuf
         y6GVOT0nfPLGpJKb8WL2nBnCtzDqsJXiaNmbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=h12y69BzOdAqtGfc38mtOtL/jCEg2kKWm7ttfdSU3V0=;
        b=ehjFlDffB4wiFzFmE0MZ31eBiP4qj7VuYQohmfTmHIKnmTrXAtyTDlzx2jtdPZwnjJ
         07HeT4BFZzPm7rWnFd/F8XGPqk2xgxI0yQr8yQ7iwrVWbFo4nW3wbAxs9Mny9cmMaPNB
         EMpGPEB8Gunr39XnJSAZ6yJbILke+WH07ccKCOTce0Lcq8hVnYP4SUbOJqQdppsUg1un
         Qz4wnGKOFOvwrPYalVvSTdkf4G80ICAS2EbpWV4L9yXohXNt0W+y/z/v/OIbRo3s1upD
         hl2oJnnWLeRgms2xpqAWPLC12rK4xyJ8M4N5whvclOBTN97PuW1JCrn71GjULRZA82gu
         MyuQ==
X-Gm-Message-State: AOAM533Zvmg0JAzlGTX4R7wxCGXELckeExHm1qQL5m/+miR5rRhxyj+t
        b8Gd0wW2Byn+3XMmBURg/4dRb25sDYYENg==
X-Google-Smtp-Source: ABdhPJxpq2UUe896c6F9+t4U+EcOSQym3Unk4xrZMcWw0fCd5KpWqEqrhj8H2Qi7pXbsdRuKFGmwZA==
X-Received: by 2002:a17:90a:3849:: with SMTP id l9mr3384862pjf.7.1630390674896;
        Mon, 30 Aug 2021 23:17:54 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:a664:ffe7:ee94:4600])
        by smtp.gmail.com with ESMTPSA id u10sm15890366pfg.168.2021.08.30.23.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 23:17:54 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64: Avoid link stack corruption in kexec_wait()
In-Reply-To: <3ffe7775f3fcda8e5fca6a7bc7db0b8251153c67.1629705147.git.christophe.leroy@csgroup.eu>
References: <3ffe7775f3fcda8e5fca6a7bc7db0b8251153c67.1629705147.git.christophe.leroy@csgroup.eu>
Date:   Tue, 31 Aug 2021 16:17:52 +1000
Message-ID: <87ilzm6str.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> Use bcl 20,31,+4 instead of bl in order to preserve link stack.
>
> See commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
> in __get_datapage()") for details.

From my understanding of that commit message, the change helps to keep
the link stack correctly balanced which is helpful for performance,
rather than for correctness. If I understand correctly, kexec_wait is
not in a hot path - rather it is where CPUs spin while waiting for
kexec. Is there any benefit in using the more complicated opcode in this
situation?

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/misc_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index 4b761a18a74d..613509907166 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -255,7 +255,7 @@ _GLOBAL(scom970_write)
>   * Physical (hardware) cpu id should be in r3.
>   */
>  _GLOBAL(kexec_wait)
> -	bl	1f
> +	bcl	20,31,1f
>  1:	mflr	r5

Would it be better to create a macro of some sort to wrap this unusual
special form so that the meaning is more clear?

Kind regards,
Daniel

>  	addi	r5,r5,kexec_flag-1b
>  
> -- 
> 2.25.0
