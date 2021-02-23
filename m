Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F948322456
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBWC7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhBWC7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:59:08 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F82C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:58:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e6so1844507pgk.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2wngzZ6mx+/Vpq7Q62N18mbJmvOCii5bU10fpk/sXk4=;
        b=xAg0RMNyoNjVqBWz98xEBHilAwyiq4dVzFeg6Dcn2mxnsprTZuZVDvmhFj0hnOYlF9
         kXlJkDzFE7W19jKisQdSIOBFhB5ZyAX+x7RPnmHddiQkoxm+FsBr1OgI+GOUyIxapFIw
         Qop4NoeEVYKNQuyPBSRrhi5oTHNEnZRUnmEUOjmrGCTG55UX6AWVD6TfAKxPC4o7SB0h
         NuN4D+8LUliVI0usdqOe2ETZbzBuy3kB2aurjf6FBarGPRuwJTLJqv8+3XNlUAHAx+0z
         mA2e0IeGQjEyhPBZ2jbfCaqT1k+8c6FbuLToyM7pt16FeBXPqeXfr5jV0miqzHIeMGN8
         e5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2wngzZ6mx+/Vpq7Q62N18mbJmvOCii5bU10fpk/sXk4=;
        b=GczaZAyfw/igHbcWUhzVyBt6z7lx9EmhT04QzfirqN3j7X7Wnby81NbO66MRJwXbA5
         AWxCqgBFnuxP3chamjcJ6a01bZ8IMPmeWozsexLF73nUqujzJg7lt+eGjXez91eknvyG
         xNCR1Ydtavr2t/H9ZEIejguvSdIACQlqqVxGbBOFK8EpG0iy7iGGh4SywHSG8n7a3ypZ
         UGgxPND7nzzB9yzmselEDd1g14T+XyD0+ooz4gN4JSNwuDmYY2PpeKuCAQjcfBOxp7UQ
         53c8mAGSLyqinBSe+KVXLuPqw6Z/JcPSLHv3C7dEq7Kxuos6S4TmDx73Mme+8X6mK4sU
         KXug==
X-Gm-Message-State: AOAM533Kw9iEXvx02yel7n30ynjyut7j+z5g/fIEMCe2k9VXCrODX2HU
        3MoerMrfqkJPmZ56Clsl8FZHdA==
X-Google-Smtp-Source: ABdhPJw1AaHpGEYHoBeg/cY+uSWG/zywCJNkfv/3STu7tc190XSaa8k+yi7WYSOLbrSsLV5/tlXPkQ==
X-Received: by 2002:a62:e401:0:b029:1ec:fdce:b052 with SMTP id r1-20020a62e4010000b02901ecfdceb052mr24176262pfh.79.1614049101866;
        Mon, 22 Feb 2021 18:58:21 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o20sm874032pjt.43.2021.02.22.18.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:58:21 -0800 (PST)
Date:   Mon, 22 Feb 2021 18:58:21 -0800 (PST)
X-Google-Original-Date: Mon, 22 Feb 2021 18:39:01 PST (-0800)
Subject:     Re: [PATCH] soc: canaan: Sort the Makefile alphabetically
In-Reply-To: <BL0PR04MB651408C561B5E4B6889F6841E7809@BL0PR04MB6514.namprd04.prod.outlook.com>
CC:     linux-riscv@lists.infradead.org,
        pczarnecki@internships.antmicro.com, leonard.crestez@nxp.com,
        peng.fan@nxp.com, joel@jms.id.au, linux-kernel@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Message-ID: <mhng-987a3cd7-9d3e-4471-b47a-67aa97629e7b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 18:31:43 PST (-0800), Damien Le Moal wrote:
> On 2021/02/23 11:19, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> The rest of these are alphabetically sorted, and leaving it this way
> causes a merge conflict.
> 
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> ---
> 
> I missed this when reviewing these patches, but happened across it when
> test merging from Linus' tree.  It goes back a way so I'm hesitant to
> rebase this one out just for cleanliness, but if I have to go back that
> far before sending the merge window PR I'll squash it in.
> ---
>  drivers/soc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index fa7071246546..34b23645be14 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
>  obj-y				+= aspeed/
>  obj-$(CONFIG_ARCH_AT91)		+= atmel/
>  obj-y				+= bcm/
> +obj-$(CONFIG_SOC_CANAAN)	+= canaan/
>  obj-$(CONFIG_ARCH_DOVE)		+= dove/
>  obj-$(CONFIG_MACH_DOVE)		+= dove/
>  obj-y				+= fsl/
> @@ -29,4 +30,3 @@ obj-$(CONFIG_ARCH_U8500)	+= ux500/
>  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
>  obj-y				+= xilinx/
>  obj-$(CONFIG_ARCH_ZX)		+= zte/
> -obj-$(CONFIG_SOC_CANAAN)	+= canaan/
> 
>
> Yes. Should have sent that... Thanks.
>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

No problem, it's on for-next.
