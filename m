Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A03D84DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 02:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhG1AuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 20:50:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232883AbhG1AuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 20:50:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 929C460F59;
        Wed, 28 Jul 2021 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627433416;
        bh=RA8Bk6N54tMlSb0oE/9C00ZcPcgPOkz1/lYJvfEXgDo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GKe+BWN8/HcuddopT5zDv48wJR6dpfcvMfz6bEJijTGoIyNSHxhvJtAB3l4HKbjRc
         O0PzS4S1llKqkERz2HA1Rgd5GG35jJZtKdBMnKeyB8yFry0eMOyZzq9ul6H95aYIuo
         caBxndDKMYH2EtmIgpjn2EUgFdLy9WeM5G5DdPDKvbV80KROTBOjJvtGKVFkQmNgCe
         FrQfHVMcYr+VgU9PabbroSemWXlnbwOGP0jJSBtCnlVebc/U7rbdqXWAMBAoUN5j93
         VusEKf19MFGOuLxo0uHLck1alAOouXuRyLz1jPJQh/FkLoUVxnYHa0ZRSS7v7U5UYT
         Xh3oyw8qSqTwg==
Received: by mail-lj1-f175.google.com with SMTP id a7so951421ljq.11;
        Tue, 27 Jul 2021 17:50:16 -0700 (PDT)
X-Gm-Message-State: AOAM5318D6bSC9SL4I72hta3kbcmwD3V+WcwdCGslgiSL5ebg9eVV6gw
        t/Lh1cYoG8VDmxBJQBITErezklEW67Ub8n4oo9w=
X-Google-Smtp-Source: ABdhPJwckmzC8X3DD+nAYICKnT9aWOL5fsiMDn2h2S8fJwqnXBNuyO9aMqaxvAUezEVAkr1h5h9sBZdjimj0t1tlIfM=
X-Received: by 2002:a2e:8557:: with SMTP id u23mr17307440ljj.115.1627433414969;
 Tue, 27 Jul 2021 17:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210727133426.2919710-1-punitagrawal@gmail.com> <20210727133426.2919710-5-punitagrawal@gmail.com>
In-Reply-To: <20210727133426.2919710-5-punitagrawal@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 28 Jul 2021 08:50:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSmWbFUQz-qB5t2Kf+BRr2xg5iVi_Vu2g60vF+2QVjgqA@mail.gmail.com>
Message-ID: <CAJF2gTSmWbFUQz-qB5t2Kf+BRr2xg5iVi_Vu2g60vF+2QVjgqA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] csky: ftrace: Drop duplicate implementation of arch_check_ftrace_location()
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked, thx.

On Tue, Jul 27, 2021 at 9:35 PM Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> The csky specific arch_check_ftrace_location() shadows a weak
> implementation of the function in core code that offers the same
> functionality but with additional error checking.
>
> Drop the architecture specific function as a step towards further
> cleanup in core code.
>
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Acked-by: Guo Ren <guoren@kernel.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/csky/kernel/probes/ftrace.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> index ef2bb9bd9605..b388228abbf2 100644
> --- a/arch/csky/kernel/probes/ftrace.c
> +++ b/arch/csky/kernel/probes/ftrace.c
> @@ -2,13 +2,6 @@
>
>  #include <linux/kprobes.h>
>
> -int arch_check_ftrace_location(struct kprobe *p)
> -{
> -       if (ftrace_location((unsigned long)p->addr))
> -               p->flags |= KPROBE_FLAG_FTRACE;
> -       return 0;
> -}
> -
>  /* Ftrace callback handler for kprobes -- called under preepmt disabled */
>  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>                            struct ftrace_ops *ops, struct ftrace_regs *fregs)
> --
> 2.30.2
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
