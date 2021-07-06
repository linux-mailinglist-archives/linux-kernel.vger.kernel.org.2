Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1223BDFB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 01:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhGFXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhGFXTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 19:19:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B222C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 16:16:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b14-20020a17090a7aceb029017261c7d206so2497928pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 16:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YB0aJ87kDhO/1B2h0F5KDySwNSSX3rvAy/FYrFFVQlc=;
        b=iSZbpF1Xsl1ngnpX0FGs6yoICy3udzry/XyJ/AIEwYcIcs/ZJ4AKAOVmCam8QH0yzf
         FRi5GfEN9HXueX1jHSjJvRHgkdFnWO193rJGFDZnCKRFftHevQ5H5snY+uNDOiWf4hZF
         tzi/CnM/aQ6KMiUKeYtSoDElHYhVWr3H/JLFXKCLpE8BauxEk1hfsmgMmxhLyDONG7iK
         0ZxlNOc1Wy+/LgfPYHrU/4eOjmqr3ouN8id8q1nuBIm9P5EaI1dTnr0Fre4Pky5tiznY
         YKYaOwXfup6MRbBdIRmNdPUWGno9F7iEO5ATLEVo9m9oin1UGHWKbtOdfymYK0bCWMPP
         TmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YB0aJ87kDhO/1B2h0F5KDySwNSSX3rvAy/FYrFFVQlc=;
        b=pt4/X2gRuQpmeGXPVly2loGjxS2k+FjZcUazljBoQdkSac/RAQc3uMfbekBtioRn11
         apUwU+PW94ByxbN9l5iujIYefyGgSHUsFlYzsPaOk/5QbmffKUx7VBATmbH4BbyVHnb0
         /JQ6rr+/n04q8f4v5i3/7vpHJ8tO9bmrV95EXG8PsD/5Xsg537gYNHXPOZE2uVCpKDNg
         sbGp/Wrd6HoblfBDEA6CZfKM8MvvXuJE7jIdUBuNCBD0fGJz87yZ2EhK6ToNtl9r4Jlj
         ZdDxieBJHTo+SihHkxFzFYx42IVGlr94yziYfOanfTJimx50ntNVGfcjM4MgaKjV/udH
         4TNQ==
X-Gm-Message-State: AOAM532w5/Pz2Dqu45vZgtxY8kV2KOzdHQ9rYKlD9xTD70C6U7b6cN8n
        Vzw2KihoAT8296DbEpKoQuWnsg==
X-Google-Smtp-Source: ABdhPJwbPQYkennidxUbwzkbwmIxPNQx7Gpxejgx5Bg4l/zKoHdMRGzrfsVL+jNN6ypruCBkhit2Dg==
X-Received: by 2002:a17:90a:f2d7:: with SMTP id gt23mr2664215pjb.21.1625613415584;
        Tue, 06 Jul 2021 16:16:55 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y13sm18527251pgp.16.2021.07.06.16.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 16:16:55 -0700 (PDT)
Date:   Tue, 06 Jul 2021 16:16:55 -0700 (PDT)
X-Google-Original-Date: Tue, 06 Jul 2021 15:52:09 PDT (-0700)
Subject:     Re: [PATCH -fixes] riscv: Fix PTDUMP output now BPF region moved back to module region
In-Reply-To: <20210624121721.2828421-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        jszhang@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-fe8bcaf3-d184-4584-99f5-6ea4b9144934@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 05:17:21 PDT (-0700), alex@ghiti.fr wrote:
> BPF region was moved back to the region below the kernel at the end of the
> module region in commit 3a02764c372c ("riscv: Ensure BPF_JIT_REGION_START
> aligned with PMD size"), so reflect this change in kernel page table
> output.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/ptdump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 0536ac84b730..22d6555d89dc 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -98,8 +98,8 @@ static struct addr_marker address_markers[] = {
>  	{0, "vmalloc() end"},
>  	{0, "Linear mapping"},
>  #ifdef CONFIG_64BIT
> -	{0, "Modules mapping"},
> -	{0, "Kernel mapping (kernel, BPF)"},
> +	{0, "Modules/BPF mapping"},
> +	{0, "Kernel mapping"},
>  #endif
>  	{-1, NULL},
>  };

Thanks, this is on for-next.
