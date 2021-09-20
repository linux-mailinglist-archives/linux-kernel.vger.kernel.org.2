Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F46411FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbhITRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 13:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353214AbhITRoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 13:44:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0840EC03548E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:54:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id dw14so12427284pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b1cKu3Nph8t59JJWmO+P4WE6PaxVOKxFgbrtZrwyjIs=;
        b=OX7HFhon8z/Bhl4fx7mpXvk/luDQH0eo6eLGUEz3SCw0vsB69Y9PrPyV5PbT94tDM4
         gruIx5Le+8O6rHlFYS72YjVziB3hmt3YDaSvMHsOsMBp8WEhoORolMqIxo1CFrVhZ7M+
         +HKqFNmu1L9Hd+yW2wpXDtjKvClXATWmdGfPkA7uYGVQVflbR6hfDnXnLBdkKAMtOG/s
         kexvngFS/cQPjcfURTJ0X23sspxjYAckLlAR0jNA8g6mVV0ycUItRuy4SmUtv8WUEPgw
         lB4/9i2x99/8tEIR+lvo2qIqSA+XAdwjMqy+pwu3TbPA5V4wU5t0kC6NdsZu9fXgF3Rp
         85wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b1cKu3Nph8t59JJWmO+P4WE6PaxVOKxFgbrtZrwyjIs=;
        b=f/I1AP7vHybPe7u/3+OHRiFkHG/PrKod3dD2u/G/NITRmNV4QXUgGizzdBWw+NOl+X
         a3V2jlX9xZLuLPa1F2jSRY7hkWcDApmrD50t6usm9sjjm3Zj5xtC8mg0lOcxbez8X/en
         x/GC993ufBiiK7C/UYu5NqPACTjelooVa9w8acOWc+8dP4wDSiE9ZUXdHVFfS4i8/hCu
         AKTMPRlzuaV7wnRHse3HYmSwX9MKIWB/KpPlt945ingT0ZSJUSAG+Ef7zDxR0KrCQKco
         VqLP1Lh2iEKm7OTxPHZTAoqZRPHwJPYCJdRfSUWvGq/gh1IiY1noUMxotp62oJFhMIWX
         o9NA==
X-Gm-Message-State: AOAM532eC/xnZKletdVJEsjpAr0NAycNJO4WyPd1LSsIsu+vvd+uu2gE
        Up4xwM+PYPNopanDEY5ntrixhw==
X-Google-Smtp-Source: ABdhPJzYXwdiiFLuVBZ7pvs2bzvn8uiipZT51pcFWw4B5EsdoMDx0Fns8VveY8yCrUxHmakXzDILrw==
X-Received: by 2002:a17:903:1103:b0:12c:59b:dc44 with SMTP id n3-20020a170903110300b0012c059bdc44mr5527307plh.47.1632156874413;
        Mon, 20 Sep 2021 09:54:34 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id cl16sm35563pjb.23.2021.09.20.09.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:54:33 -0700 (PDT)
Date:   Mon, 20 Sep 2021 10:54:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 2/6] remoteproc: fix the wrong default value of
 is_iomem
Message-ID: <20210920165431.GB2023964@p14s>
References: <20210910090621.3073540-1-peng.fan@oss.nxp.com>
 <20210910090621.3073540-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910090621.3073540-3-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 05:06:17PM +0800, Peng Fan (OSS) wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Currently the is_iomem is a random value in the stack which may
> be default to true even on those platforms that not use iomem to
> store firmware.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Fixes: 40df0a91b2a5 ("remoteproc: add is_iomem to da_to_va")
> Reviewed-and-tested-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_coredump.c   | 2 +-
>  drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied

> diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
> index aee657cc08c6a..c892f433a323e 100644
> --- a/drivers/remoteproc/remoteproc_coredump.c
> +++ b/drivers/remoteproc/remoteproc_coredump.c
> @@ -152,8 +152,8 @@ static void rproc_copy_segment(struct rproc *rproc, void *dest,
>  			       struct rproc_dump_segment *segment,
>  			       size_t offset, size_t size)
>  {
> +	bool is_iomem = false;
>  	void *ptr;
> -	bool is_iomem;
>  
>  	if (segment->dump) {
>  		segment->dump(rproc, segment, dest, offset, size);
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 44e7f9308f4bc..d635d19a5aa8a 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -178,8 +178,8 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
>  		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
>  		u64 offset = elf_phdr_get_p_offset(class, phdr);
>  		u32 type = elf_phdr_get_p_type(class, phdr);
> +		bool is_iomem = false;
>  		void *ptr;
> -		bool is_iomem;
>  
>  		if (type != PT_LOAD)
>  			continue;
> -- 
> 2.25.1
> 
