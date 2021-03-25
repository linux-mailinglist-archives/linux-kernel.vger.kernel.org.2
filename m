Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A007349632
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhCYP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYPz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:55:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:55:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so2902034pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6n2lhd1tAUerJU3jmezm5RJvOnG3Jo+Q1gBfzhFAzEg=;
        b=Hr38qW+ymlf4XK3GQskrG5LTRw5Rr7BkSLfgM/uKNkkV46+WF5BXbc1c/jIMKWNlAW
         HipEclQ6RFpykbCuOPwzimkRLA9XSeJaTkJM/YV/Xvum38mfP2VAVVQyABSvWygYsGZZ
         pWYI4HkNqA5ybM9nuxTizYxXk9EeV70oDScoPZ/h5SJxYoOnKsw4sZkpVWi+TKMeHrw/
         qY9WfwGEGupe5soAXv7nC5mfynUyvbR9dfD3ceYlO/q91MCZW5aDg/LqurTcocRmniXu
         l0/+vYbfmA5PZb5D6GcNaorGioaHWkRcZLuBb9aZTWA2k+/OGjyrEnf0tB1NhsjZQz0G
         tOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6n2lhd1tAUerJU3jmezm5RJvOnG3Jo+Q1gBfzhFAzEg=;
        b=Krod6EoDhb0Hm5PTPK+Pbh7bx3yH7mQYGHOlnZJorTBJyXlH4K52NtURHxnu3OesDw
         8bw0DNsb6xFyfo9dG4yaH5q+wm58Iyc1ld8So0f2v+es/0dej3zDFpsPpBdaKgbl6I8g
         wIxO3r2cJIvebW+87sMuX8ktl07hjUUpp5QP7jvLaNQg56NCoqWVaE1cY0chwZK5JDWj
         hwykMmEHv3QgxfAFV1eB2Eti53wKnB77qjtnWnXodswcKgmurkANbxHgchX31XMdlFbr
         p+AuVq7OZk6hw2zti9xN0R2k+Ia3UYMA6G8iLtJvVvqH9RbuDxHpz3ntqk/smFGveg+q
         zo4g==
X-Gm-Message-State: AOAM5331zg4iWwird+OCuzK47KA4jjevrB4EFmLyWRORyIkrM8BNB95v
        UM8xanIBFkJB7+HlYKsMlxI=
X-Google-Smtp-Source: ABdhPJzj2F/PdKLf/AOj/lKUOVKN2j2gVEDEhd545yb/4d1SV9k0REJ5Q0/AUptD5XWiwyGq2D9ynQ==
X-Received: by 2002:a17:90a:8408:: with SMTP id j8mr9498953pjn.1.1616687755667;
        Thu, 25 Mar 2021 08:55:55 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id bb24sm5931187pjb.5.2021.03.25.08.55.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Mar 2021 08:55:55 -0700 (PDT)
Date:   Thu, 25 Mar 2021 15:55:51 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Anup Patel <anup@brainfault.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Do not invoke early_init_dt_verify() twice
Message-ID: <20210325155550.udz33f3kivbi7j76@mail.google.com>
References: <20210324150312.20535-1-changbin.du@gmail.com>
 <CAAhSdy19Tpf1D0Q4V7CF0ZOvksHMXxA2fF3L3J2f_Ka8NZgVAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy19Tpf1D0Q4V7CF0ZOvksHMXxA2fF3L3J2f_Ka8NZgVAQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:51:06PM +0530, Anup Patel wrote:
> On Wed, Mar 24, 2021 at 8:33 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > In the setup_arch() of riscv, function early_init_dt_verify() has
> > been done by parse_dtb(). So no need to call it again. Just directly
> > invoke unflatten_device_tree().
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  arch/riscv/kernel/setup.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index f8f15332caa2..2a3d487e1710 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -255,10 +255,7 @@ void __init setup_arch(char **cmdline_p)
> >  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> >         unflatten_and_copy_device_tree();
> >  #else
> > -       if (early_init_dt_verify(__va(dtb_early_pa)))
> > -               unflatten_device_tree();
> > -       else
> > -               pr_err("No DTB found in kernel mappings\n");
> > +       unflatten_device_tree();
> >  #endif
> 
> The early_init_dt_verify() set he DTB base address in Linux OF.
> 
> When parse_dtb() calls early_init_dt_verify(), MMU is enabled but
> we have temporary mapping for DTB (i.e. dtb_early_va).
> 
> After paging_init(), we have moved to final swapper_pg_dir so
> temporary mapping for DTB does not exists anymore but DTB
> is at same physical address so update DTB base address in
> Linux OF by calling early_init_dt_verify() again.
> 
> Based on above, NACK to this patch.
>
No problem, thanks!
 
> Regards,
> Anup
> 
> >         misc_mem_init();
> >
> > --
> > 2.30.2
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Cheers,
Changbin Du
