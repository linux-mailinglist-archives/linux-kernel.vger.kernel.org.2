Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83FD3A4C88
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFLD67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:58:59 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:33396 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLD64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:58:56 -0400
Received: by mail-pj1-f46.google.com with SMTP id k22-20020a17090aef16b0290163512accedso8198758pjz.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XeKsMiBCSivqZqJGijg7smXWpPAkTfjmdDjAR99WSqM=;
        b=oI5h8dC1CGJPDMTJMbIo/MSKy4tkaXw72BAzfrs/q/8G3+cIzWVHc4JQqXzT6HZP2i
         /O1X45uxvkxt+sBzve/17f0B3XhBNjRMweaOSzjfW3rpg8F4EP2lfnT/QpP+e+I0Jjs6
         FC3AFsx8jsicJfOmmxapT8QZ1oSR5OGnsFRTFDWY1WzRkScTd3KgYDpBMi3Gvo9/OU6d
         X/1qQzRDacCNnv6BmFJjI+WY0x2ApO1IpSekik3bWWMNJqZVZwvkRqrLQc+jVzR+jEk9
         r6MIrVKEgbVOeSDhSrwKS3ZxI7Q5piCUcW3DS1oSCVdQLhoAkNT1eC/QTE1ZnFhIwoKu
         pveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XeKsMiBCSivqZqJGijg7smXWpPAkTfjmdDjAR99WSqM=;
        b=QHfA0R5bi7+ckBeMZrxBG3T201dnCt/a3hHO62dvqs9bIBBjdUecdRNX5KrKM94QAC
         JqrcdQmGldldGsMN0AebA8KHLl5/WuUobcc+s401MTLnfHN2Axc/Hcd7tAOsdDnVa5OC
         4rg246G+j+Bz1of/KY4ipQJiQKN3OXKbugmontTSS2h5SSdnmbPuURw1Mt7u/LGT+VhO
         zRPwyOkRf4auVS34vBrW5Tb5Lnm4gL7lLTq/oc8p9HWU0S+BWxqOndhODkm9jepw7J2c
         1vUctOoUDJga3P2PXx96D68d7ZunDts22kvYSHb+D/Xr4cdlvR6uj6dB2AnVwkWn2flg
         NRGw==
X-Gm-Message-State: AOAM530YFbhzAEuQypSEBYTnhQljctqR1c7dM4B20j4juwXeyf3t9H6w
        ymFdyXKVlRNT8xA1PTLIoGP/fD/enEvG5+T1
X-Google-Smtp-Source: ABdhPJyY5WLBpy6Dw1/4RcbjdESopxYWIovjgDFCAIodRD6RpWBrA4wtD+HPPgi6Ddz2J6eicsuFKQ==
X-Received: by 2002:a17:90a:c210:: with SMTP id e16mr12162010pjt.234.1623470149140;
        Fri, 11 Jun 2021 20:55:49 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k1sm6337315pfa.30.2021.06.11.20.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:55:48 -0700 (PDT)
Date:   Fri, 11 Jun 2021 20:55:48 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Jun 2021 20:55:33 PDT (-0700)
Subject:     Re: [PATCH v2 12/15] riscv: convert to setup_initial_init_mm()
In-Reply-To: <20210604070633.32363-13-wangkefeng.wang@huawei.com>
CC:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-bc2d1e77-3bb8-44a8-83b1-a090c6581369@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021 00:06:30 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> Use setup_initial_init_mm() helper to simplify code.
>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/kernel/setup.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 03901d3a8b02..52396874f859 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -264,10 +264,7 @@ static void __init parse_dtb(void)
>  void __init setup_arch(char **cmdline_p)
>  {
>  	parse_dtb();
> -	init_mm.start_code = (unsigned long) _stext;
> -	init_mm.end_code   = (unsigned long) _etext;
> -	init_mm.end_data   = (unsigned long) _edata;
> -	init_mm.brk        = (unsigned long) _end;
> +	setup_initial_init_mm(_stext, _etext, _edata, _end);
>
>  	*cmdline_p = boot_command_line;

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
