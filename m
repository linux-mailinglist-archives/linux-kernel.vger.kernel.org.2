Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD25835B0CA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 01:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhDJXkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 19:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhDJXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 19:40:05 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0903EC06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 16:39:50 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id k18so4861409oik.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 16:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jbh9yWlGg2BNKfvTRjSRQJvtgak2JcPfucDME7L6Hms=;
        b=TDBrsBDOgQO2yz/IwOBWyZR3aeSBrlRYc88mJ0J3cuHmUATj33Nln6vqyboKsUOsUO
         KJvirM9eVf8WlNTnuoHT9pO46Rqlzs+DvxPBdh7oNqv03EJ2AG3zKiuooprzoMi9xha+
         Hey/Jx4jsjv6bKpqpewrPEI4Hf41pmU3hXLiKE7nuPa0kn7tXlzkRLKDtpTkt67hvytH
         9+oZv1V2zlwZd1cZqhNT44nqtmAR+g5MvMZpdE7yLRY7TDe/FKLVRA3pb1UamuLM4ftS
         p9gxLMTr2VV0kQqB6u1I3QU9hVO63b/tpLpN0ajg/bzqZUymsd4HPDHF29r+cVMRvLsQ
         S8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jbh9yWlGg2BNKfvTRjSRQJvtgak2JcPfucDME7L6Hms=;
        b=Wncs0s+pHjqzFYGyxD/CUcMvZIwFKevppAnDkURR2uDL1AEYdJzIZvmei4GBPxPf65
         PZqS41LJsuOw9ctRDTcjrdJk9ErPwo/k9aGMcUVZqTkACWDeIimoP+ZZ9JcYw95YY6zk
         D3aK4dt6wjC3GnfIOpPNmMtCEThYfbWHhNB0uKMwBBNQP0yNmUd/dO9rtMob27X1BZcQ
         9MRImdon7zqN6KjE9gFMfG65ylNB9wIXAkGWn3bCxAufoBa3/9mcgwMtVzkUkeJzldmQ
         yyfFw4LciLA0osZiAAFjf2xygBi81ZatmanRu6abx3ypgfUPNWq7owRL4+10w6AWi0gq
         HBrw==
X-Gm-Message-State: AOAM530SMdhWu3MkkzszwxdywrV2JnSJuB11bUDtMzg1ekdSqyud9qAu
        L24y3xS8Us27/3VQdVKyiy4uiKyrbjo=
X-Google-Smtp-Source: ABdhPJyTDoW2zL12quMalKfpVkWtz6CY7vQs+OXkH7mWHcoSSFAacdHFNAIa9Rjp/Om/Bw+pFB14Kg==
X-Received: by 2002:aca:cf95:: with SMTP id f143mr14594033oig.104.1618097989394;
        Sat, 10 Apr 2021 16:39:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3sm1645085otk.9.2021.04.10.16.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Apr 2021 16:39:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 10 Apr 2021 16:39:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] powerpc/signal32: Convert restore_[tm]_user_regs()
 to user access block
Message-ID: <20210410233947.GA202696@roeck-us.net>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
 <181adf15a6f644efcd1aeafb355f3578ff1b6bc5.1616151715.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181adf15a6f644efcd1aeafb355f3578ff1b6bc5.1616151715.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 11:06:57AM +0000, Christophe Leroy wrote:
> Convert restore_user_regs() and restore_tm_user_regs()
> to use user_access_read_begin/end blocks.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
...
>  static long restore_user_regs(struct pt_regs *regs,
>  			      struct mcontext __user *sr, int sig)
>  {
...
> @@ -567,19 +569,22 @@ static long restore_user_regs(struct pt_regs *regs,
>  	regs->msr &= ~MSR_SPE;
>  	if (msr & MSR_SPE) {
>  		/* restore spe registers from the stack */
> -		if (__copy_from_user(current->thread.evr, &sr->mc_vregs,
> -				     ELF_NEVRREG * sizeof(u32)))
> -			return 1;
> +		unsafe_copy_from_user(current->thread.evr, &sr->mc_vregs,
> +				      ELF_NEVRREG * sizeof(u32));

arch/powerpc/kernel/signal_32.c: In function 'restore_user_regs':
arch/powerpc/kernel/signal_32.c:565:36: error: macro "unsafe_copy_from_user" requires 4 arguments, but only 3 given

Guenter
