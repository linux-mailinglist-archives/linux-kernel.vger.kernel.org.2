Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3AD349C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhCYWMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCYWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:12:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D358BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 15:12:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r17so3254896pgi.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DYUjSc1vAjGrU7Upg//GwkOyzK5I7lVAlzXmtTspUfQ=;
        b=il68+HICDOpc315fwdeM5b5fe9U1OGmrgs8JA1Q4TimO7bh5f4kHrj87ZxXtRKuDVK
         lp+v5uD/1rHtyYh4J4hyvUcDa0a5JtY3jBtNgDZvnFz8WNrBCg+rxevJntyvuxlbO3yG
         LfmGszSXA9rGeLIiuuQTOjGLoQ1VPel2tP9d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DYUjSc1vAjGrU7Upg//GwkOyzK5I7lVAlzXmtTspUfQ=;
        b=avpZXpK9vtn2iDAzX3CfFjRiBF1b5ZcC8+ehl+0+y57wHkQU9TJJ3hC29us4zItVbu
         Wwjsf8sYELQlcCRxtlBjm9XZxf1vgf/7oqBdDkWTXCqmC7xy2CWIR8I6FpE8JB28Fq2W
         r4pcqPCW5c6YNCChi9tUJvpa9F6nb6czU/T4iec/Dxay1lpXOs+9AAupOhgM3l/0hvIe
         c8YbnrO6k9DPoycHRYk2myjummIQRwOIxoIEBp92PqflPs7hCFlDBea+OeHsjMjhXi5X
         jwxbqwmVLRpPam/a9Y6WmsWYBtk69dvdHf6hgoDAOpu3VkBBa02ZTGwjntu8fyC05myj
         uiew==
X-Gm-Message-State: AOAM533tbGV5Nl0pQXFwSYL69Q0TqxehaHGo+K/njHlAeqx+b7jU2vMP
        Gm7V1x/IxHd2GobDrIvLqp9IDQcNHWJyIw==
X-Google-Smtp-Source: ABdhPJzyk3/6T2KTl3Q2oxAZNwgaIDL+ylwu4Jhi1U3VGe0zniFZfT/tDO/a8nD10ys8oqpnYWsUpw==
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr9670244pgm.186.1616710345290;
        Thu, 25 Mar 2021 15:12:25 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-5199-f2bf-3cbb-22e6.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:5199:f2bf:3cbb:22e6])
        by smtp.gmail.com with ESMTPSA id w37sm6555685pgl.13.2021.03.25.15.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 15:12:24 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 06/15] powerpc/align: Don't use __get_user_instr() on kernel addresses
In-Reply-To: <d9ecbce00178484e66ca7adec2ff210058037704.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu> <d9ecbce00178484e66ca7adec2ff210058037704.1615398265.git.christophe.leroy@csgroup.eu>
Date:   Fri, 26 Mar 2021 09:12:21 +1100
Message-ID: <877dlukhmi.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> In the old days, when we didn't have kernel userspace access
> protection and had set_fs(), it was wise to use __get_user()
> and friends to read kernel memory.
>
> Nowadays, get_user() is granting userspace access and is exclusively
> for userspace access.
>
> In alignment exception handler, use probe_kernel_read_inst()
> instead of __get_user_instr() for reading instructions in kernel.
>
> This will allow to remove the is_kernel_addr() check in
> __get/put_user() in a following patch.
>

Looks good to me!

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/align.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
> index c4d7b445b459..8d4c7af262e2 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -310,7 +310,11 @@ int fix_alignment(struct pt_regs *regs)
>  	 */
>  	CHECK_FULL_REGS(regs);
>  
> -	if (unlikely(__get_user_instr(instr, (void __user *)regs->nip)))
> +	if (is_kernel_addr(regs->nip))
> +		r = probe_kernel_read_inst(&instr, (void *)regs->nip);
> +	else
> +		r = __get_user_instr(instr, (void __user *)regs->nip);
> +	if (unlikely(r))
>  		return -EFAULT;
>  	if ((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE)) {
>  		/* We don't handle PPC little-endian any more... */
> -- 
> 2.25.0
