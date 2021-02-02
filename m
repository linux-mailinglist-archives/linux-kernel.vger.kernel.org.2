Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D230B5E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhBBDhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhBBDhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:37:16 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C37C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 19:36:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z21so13996902pgj.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Vj03bk7C20eRxq9MRNtull42jIxYqLtfdVc1X9lNV/s=;
        b=CLDpAqPg3mAeh3S9IsnE+Rrto5zL43QGASXrCR09ZQ8346Mw3+D+WsiFmLfVq/SYoO
         ONQLqRqEkw2JMs/6nrjCY2kELuoPqnLFIESKMveIGNYMAUNbnZPOkDjUIRpyJPfSE3A4
         rEufZbuaRFLkiislLQoeATSMw+GHAHFCHtHv5OhztmJDjyH070Y7A83i4RNQtJ62L7f1
         JAKbKqP4FiFHJmSE/tDIUkIijBnJNUUmj17PzTSMOezABayeX6PrS/nrgIbm/wtocxUG
         hxL6lFSvHF7WikCkvwVSBom3SUsDWMGC058BAMuowM9GCLJuHDUM0vdp46SulZwkoi+I
         StHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Vj03bk7C20eRxq9MRNtull42jIxYqLtfdVc1X9lNV/s=;
        b=GRaBNaVlMwS+5Rjsb3EILlcefvEBDb3Y8ahOk1ZCimxPpApnHhSQgtc8Sui/CaUVuX
         ispvjkiPQQM49LlYSwGpkeII7i7iNIzYz+xgMm79yBqXYr24/xELC60yDVXdnnfLR46+
         PkhqwlqQrUUKTAB7YrsX5kkWb1FX5ex+BQyjjFuuB4eqK1mO4GQbVi3nF92TOE73752S
         MHcYG7rfbr72AGuxKecM1a1sFN1ALGOW9EBug7X4GrA+ueuC+6pRjnl8v51w1Wa6zy0V
         SeACzVCDXiBMDiVoqBwMrD/RTKr4lL14TG90ScRbfegZpNZTDsd0bDLLxgCAjoWRhNBC
         HtvQ==
X-Gm-Message-State: AOAM532IC705xJJre6y1j5sevE7PeMtIKibHgMtN+S9TdHdYpvxNlHtA
        4adzpI1GeXmecCP6xB42YBweZ3C4r9Exfg==
X-Google-Smtp-Source: ABdhPJyykLEFVe6h3WuIPkh+50rUN3D5oRYKBcrsUWTLAZTB8d/L7dRhp9gu65iCZKt58YvPvsnWqQ==
X-Received: by 2002:a63:1c12:: with SMTP id c18mr20069830pgc.356.1612236995288;
        Mon, 01 Feb 2021 19:36:35 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 68sm18823296pfe.33.2021.02.01.19.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:36:34 -0800 (PST)
Date:   Mon, 01 Feb 2021 19:36:34 -0800 (PST)
X-Google-Original-Date: Mon, 01 Feb 2021 19:36:32 PST (-0800)
Subject:     Re: [PATCH] arch_numa: fix common code printing of phys_addr_t
In-Reply-To: <20210128035533.23722-1-rdunlap@infradead.org>
CC:     linux-kernel@vger.kernel.org, rdunlap@infradead.org, lkp@intel.com,
        Atish Patra <Atish.Patra@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-ea6bdfae-f473-448f-80df-5042b2a5cf83@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 19:55:33 PST (-0800), rdunlap@infradead.org wrote:
> Fix build warnings in the arch_numa common code:
>
> ../include/linux/kern_levels.h:5:18: warning: format '%Lx' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
> ../drivers/base/arch_numa.c:360:56: note: format string is defined here
>   360 |    pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
> ../drivers/base/arch_numa.c:435:39: note: format string is defined here
>   435 |  pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);
>
> Fixes: ae3c107cd8be ("numa: Move numa implementation to common code")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  drivers/base/arch_numa.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> --- linux-next-20210125.orig/drivers/base/arch_numa.c
> +++ linux-next-20210125/drivers/base/arch_numa.c
> @@ -355,11 +355,12 @@ static int __init numa_register_nodes(vo
>  	/* Check that valid nid is set to memblks */
>  	for_each_mem_region(mblk) {
>  		int mblk_nid = memblock_get_region_node(mblk);
> +		phys_addr_t start = mblk->base;
> +		phys_addr_t end = mblk->base + mblk->size - 1;
>
>  		if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
> -			pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
> -				mblk_nid, mblk->base,
> -				mblk->base + mblk->size - 1);
> +			pr_warn("Warning: invalid memblk node %d [mem %pap-%pap]\n",
> +				mblk_nid, &start, &end);
>  			return -EINVAL;
>  		}
>  	}
> @@ -427,14 +428,14 @@ out_free_distance:
>  static int __init dummy_numa_init(void)
>  {
>  	phys_addr_t start = memblock_start_of_DRAM();
> -	phys_addr_t end = memblock_end_of_DRAM();
> +	phys_addr_t end = memblock_end_of_DRAM() - 1;
>  	int ret;
>
>  	if (numa_off)
>  		pr_info("NUMA disabled\n"); /* Forced off on command line. */
> -	pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);
> +	pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
>
> -	ret = numa_add_memblk(0, start, end);
> +	ret = numa_add_memblk(0, start, end + 1);
>  	if (ret) {
>  		pr_err("NUMA init failed\n");
>  		return ret;

Thanks, this is on for-next.  Did you, by any chance, find %Lx documented
anywhere?  It's not ISO C and the GCC source code says it's a GNU extension,
but I couldn't find it in the documentation (or even where to add it, which I
guess is how I forgot to send my version fo the patch).
