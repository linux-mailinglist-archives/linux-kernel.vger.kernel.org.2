Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9CD33EB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCQIbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCQIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:30:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64934C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:30:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z2so878731wrl.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTo2lq3PDu4WGFFq1mhOr8xSWejm9N9TQezVn74QV2U=;
        b=vAaAUsa/COHtV4cLxsSywSoISFUKa72oGocoAShP8GzMsu4VnLzLxHplR51NIem1Dt
         4SH5wo7AnV2GMfGbaQHCR2wSdM0Fz+xdBq1qkM/6JKPYo6O61hhdSsOpkxWPtfN46xIH
         JatlJMAtbZ5GARS64wj29j/RuMdVqxtZlAcMfOoJ+PVSj5i5OGcXtcKqkLJzme85c399
         RDCpdMuwOvVgxxRvYvfzFyalKDTdHZvzLD5oK5xoSmTf/YvwYTT0HXjbt1q9HoyKCxix
         r5PvnQh5x4N9X30IEXWEKMsJUHmDIXe67vjRRzz4LjrXgsgHt2NcoL2O1dq9r0W2kH2Q
         rTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTo2lq3PDu4WGFFq1mhOr8xSWejm9N9TQezVn74QV2U=;
        b=NXyDKfvfuUvnFctIdW0NdNIBLJ+JkAAsyon8f+CQGGKQjzkoT75JoVtbtawpSd6ugP
         At/WAieBrnlJyqJ/uUexfpQKGhSh2MMLlnMDa02Z7xcPVZz3SOJMTjhjPtL0EnAOCMLo
         ni26wXTDDCrwzOuVyTSnV0ZnU3PTgrjiuwknaBSv1xUJLBC4izH4cB2H+dSvPwT/fBuL
         OMqZYkDV28Zi+ZwvUlYOGl75tCi1cXbMao0L5YqcvYTGZ+cR1479FHhwrCZpKTHKjVd6
         EBUL9A5OsKMdZF4nN3tcYw36fkiyDZzeJehgcWMoCqb6x2BFpEvVDI6abXJc01dDGtO4
         KtHA==
X-Gm-Message-State: AOAM532ivZhwX6cG9nF26YAsQ5FpWTHh3y+ZTVdMox41ZPCYeIC93WFl
        le/58jlqYUgUPxiIJom77r9G9MUJ96JpfMxw44Yu92WcjAI=
X-Google-Smtp-Source: ABdhPJwzU0AYHnivEEGyJoYiVkM/szQNyY6KsnMWtQVOlqjVMqGpb+Z0NPlyFcZ/+koyMxsQoDwxstEXCVKvXrPtIAg=
X-Received: by 2002:adf:9544:: with SMTP id 62mr3114501wrs.128.1615969851060;
 Wed, 17 Mar 2021 01:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210317081725.28412-1-yuzihao@ict.ac.cn>
In-Reply-To: <20210317081725.28412-1-yuzihao@ict.ac.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 17 Mar 2021 14:00:35 +0530
Message-ID: <CAAhSdy1wzH4N-4kFS63sOWSNdX7w9i8ZS9od6hfruMTMEOY=_g@mail.gmail.com>
Subject: Re: [PATCH] riscv,entry: fix misaligned base for excp_vect_table
To:     Zihao Yu <yuzihao@ict.ac.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 1:48 PM Zihao Yu <yuzihao@ict.ac.cn> wrote:
>
> * In RV64, the size of each entry in excp_vect_table is 8 bytes. If the
>   base of the table is not 8-byte aligned, loading an entry in the table
>   will raise a misaligned exception. Although such exception will be
>   handled by opensbi/bbl, this still causes performance degradation.
>
> Signed-off-by: Zihao Yu <yuzihao@ict.ac.cn>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/entry.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 744f3209c..76274a4a1 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -447,6 +447,7 @@ ENDPROC(__switch_to)
>  #endif
>
>         .section ".rodata"
> +       .align LGREG
>         /* Exception vector table */
>  ENTRY(excp_vect_table)
>         RISCV_PTR do_trap_insn_misaligned
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
