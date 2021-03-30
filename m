Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEFE34E0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhC3Fyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhC3FyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:54:19 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E91C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:54:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l76so10923297pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ULHvWovowCzcgsVAcye9+8nDN8kG4FPChtXUvkrF8dc=;
        b=C2vTCndtRJJ005jcly56OIHJ8oEzYdRlpJdwbQ4kxqm17peFNaZngpOQSCTMDpD5UY
         bysGhULBk8YeYqoectTdu5H56G7GUcbwqziTjd49M0hNoTTEH49TuIF8rTWTdc9ZlOvY
         Io4krfeRAfJAYHsYyMd5N7ceIThABEyEbq6AGD9dMUErLsZrYNAdSq7XUoLuoEtsdvg1
         2JMUAbQpBeh3CQBHkVC4de/sk1teysE5bpVbXTG4DPCdmVe8dTh/lG5N9avEnlKdEwTK
         GonUgf1uv5y7QVBsf+8qLYzT/AVdlDvgOARI9OFxc9g2Fp4p4gTcMsb0AN5650fBevSL
         tz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ULHvWovowCzcgsVAcye9+8nDN8kG4FPChtXUvkrF8dc=;
        b=GWrGyoBZhc0jK7oyjx6B7JiHVXsO711hmHPRzVS3BvNTRsChOE8HEKT7wKHQCuH9PX
         7MmcNZqb7JmBZ+UZKABFST4ObUZOCxnagnID3Gqx/Mcw20XcwmUZwfNLcG5UcAlvwMZB
         HtFWPeLJlBYo9th6Q1zQyI1Pvy2pNI6FDLr6n1POUomRQpqO8qw9x6AQzPMJxxG2YqSs
         MA+HrNQ6lqscWV6I7NvsnMARbytNQ/xdjwhqAEhVJlIKU5Ir0p7GLKwYGQ4kE1n9Im6a
         w1mbQS4yeGmX3gXOcDv2giQ5yZLqNc6qPsmIKb0Or1CWC+wuHNL0Jh98AHf3EL/jv5N8
         AImg==
X-Gm-Message-State: AOAM530MhAp8RZQPvNoHBPL4lJ2tIYkCnQMjoZCeHI9aPfaTcLZeQ0z9
        R8IUjEcvcHksFqqA3fErqGeI6Q==
X-Google-Smtp-Source: ABdhPJxratnlnJNCe1ARb2oeJGfz/Zx7jg6R2XcRyILqncEt8HCAT/cf3O8AK2BT4GdXdpoaSeubpA==
X-Received: by 2002:aa7:824e:0:b029:20a:3a1:eeda with SMTP id e14-20020aa7824e0000b029020a03a1eedamr27872954pfn.71.1617083658670;
        Mon, 29 Mar 2021 22:54:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v14sm1505969pju.19.2021.03.29.22.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 22:54:18 -0700 (PDT)
Date:   Mon, 29 Mar 2021 22:54:18 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Mar 2021 22:50:14 PDT (-0700)
Subject:     Re: [PATCH] riscv,entry: fix misaligned base for excp_vect_table
In-Reply-To: <20210317081725.28412-1-yuzihao@ict.ac.cn>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        yuzihao@ict.ac.cn, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yuzihao@ict.ac.cn
Message-ID: <mhng-400b7987-97a8-4f74-8fbd-a11057c46d0d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 01:17:25 PDT (-0700), yuzihao@ict.ac.cn wrote:
> * In RV64, the size of each entry in excp_vect_table is 8 bytes. If the
>   base of the table is not 8-byte aligned, loading an entry in the table
>   will raise a misaligned exception. Although such exception will be
>   handled by opensbi/bbl, this still causes performance degradation.
>
> Signed-off-by: Zihao Yu <yuzihao@ict.ac.cn>
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
>  	.section ".rodata"
> +	.align LGREG
>  	/* Exception vector table */
>  ENTRY(excp_vect_table)
>  	RISCV_PTR do_trap_insn_misaligned

Thanks, this is on fixes.
