Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B8430D1A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhBCCfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhBCCfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:35:45 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3168C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:34:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id a20so3513161pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=OsVRDdfzv2cQbndm8SwipZXw//lhG27z+lIqx8n8u4I=;
        b=ev1N4tqbQGAmcYrqbbf7aYJ1pHLWCRq5evlGjJ+X8gLY26uHoe9J+rGvi973/X3Qdq
         M7hnsGE6k4jqow/ZvdNNcSX+BbIyhycdU6Wjh5xPUjzlOW/0+9bKGB71PdEMAGDnr6C7
         +RuAugnZ4hlFokomD5cipwrHAAqVugFb0ivn4vpVOfEU9gwhKnUP/0IZ86LcX6ghYvj7
         KI+27jSZgH3WUX4DC80ES/PiYfL/PS5VhBSOvnuQRExzoJx+NdLDAERKajYLZ2Bw9/HJ
         Hzoid43wxPdtEJ0cZU0op7iwxPeyzK6kQxQaB6p6CYh9Zo7SbDJVqKDZc+TOguKFLT1j
         9BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OsVRDdfzv2cQbndm8SwipZXw//lhG27z+lIqx8n8u4I=;
        b=aSrfKXsMnXEEn3Yovc65A2GxixPtX8Yk+SKSoJZU40eW3+sI4XmsmMZ6vkA8/QX6Ez
         DuxAYkC3hFyTpQOPkMV7IAflMP236A0mTDQMnnhcYg8iHMqTLQPnKUTIZ2vURqMZ9zqq
         hpnD68Ca1D18V/8kUscSBhy7CDK4LvVKAFkvQC087LBlbLwK5pUlVbYRfMTmTzaT24eT
         8xkxgle7/Ob3hm2s5P0Ocw2RIGpnJalTxR3xA9r6EOxDCfXvz58T5GnPEt4dMbuaerGN
         V3JMrtxK+1Wbm0m0mKCYCvgaK0x4itbCKiFIoY4lKFOu2A6IlOPcAmRm3b6Nb3mbrKPc
         4gnw==
X-Gm-Message-State: AOAM530mrkLV58ixAckeYrDV/Wxl+ifjJ179yBgukEM03NxmnCanbXe4
        GpkEnEXHrbFCWijyxSnS50td1/r3o3fOPA==
X-Google-Smtp-Source: ABdhPJz1fAW3weygbL3KOp7CRNmIw8lvfQugj7PN6ZHI0VXzW5uHNSemyVGxyiaYFQNctaUPSIxSlw==
X-Received: by 2002:a17:90a:17c8:: with SMTP id q66mr848452pja.167.1612319699220;
        Tue, 02 Feb 2021 18:34:59 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c5sm294732pfi.5.2021.02.02.18.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:34:58 -0800 (PST)
Date:   Tue, 02 Feb 2021 18:34:58 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 18:33:29 PST (-0800)
Subject:     Re: [PATCH 3/3] RISC-V: Define MAXPHYSMEM_1GB only for RV32
In-Reply-To: <20210129190038.1001626-3-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        rdunlap@infradead.org, geert@linux-m68k.org, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>, ardb@kernel.org,
        kirill.shutemov@linux.intel.com, linux-riscv@lists.infradead.org,
        ndesaulniers@gooogle.com, Paul Walmsley <paul.walmsley@sifive.com>,
        svancau@gmail.com, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-3aa36699-55e0-4f82-80f7-0d7248ac3b5c@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 11:00:38 PST (-0800), Atish Patra wrote:
> MAXPHYSMEM_1GB option was added for RV32 because RV32 only supports 1GB
> of maximum physical memory. This lead to few compilation errors reported
> by kernel test robot which created the following configuration combination
> which are not useful but can be configured.
>
> 1. MAXPHYSMEM_1GB & RV64
> 2, MAXPHYSMEM_2GB & RV32
>
> Fixes: e557793799c5 ("RISC-V: Fix maximum allowed phsyical memory for RV32")
>
> Fix this by restricting MAXPHYSMEM_1GB for RV32 and MAXPHYSMEM_2GB only for
> RV64.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e9e2c1f0a690..e0a34eb5ed3b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -252,8 +252,10 @@ choice
>  	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
>
>  	config MAXPHYSMEM_1GB
> +		depends on 32BIT
>  		bool "1GiB"
>  	config MAXPHYSMEM_2GB
> +		depends on 64BIT && CMODEL_MEDLOW
>  		bool "2GiB"
>  	config MAXPHYSMEM_128GB
>  		depends on 64BIT && CMODEL_MEDANY

Ah, I guess here's the patch :).  This is on fixes.

Thanks!
