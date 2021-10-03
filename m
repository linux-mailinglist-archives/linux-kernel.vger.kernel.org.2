Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D615442030B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhJCRL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhJCRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:11:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FCBC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 10:10:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so2261119pjw.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XqU5xxUtbfKhmbzvtVRG2mL5cvmccHFZc23S52GP8YU=;
        b=3HhqwmyONH+HAZjlWbQ4qlMsCx3Jbe8gS1rUYF86cMkuWV61LNl35jeXbpcH5NSMpF
         sW0zU0viXMSYz1ivdfEVmSB60LEcOsvFXd163p2+K98AqPgmjf1rQkGGW0FttZo2tKlI
         p1Oz6Ox1CbitgyRs5oDXPTFKOuLwKiJj4X2bvcO1YZcSMlddiCwIWC4SpuJRbAsSde0r
         qP8PWtf5hRIUcnz9m80sLs+vpB5fbvuw65OMZiAeY7ExpJs3U2ywghS/5+o+xlovnIcX
         2lljUN3HPFRR9Zv5XekuTTlqVGOZ2kKZaH4rmXAc44dRL+j6bwvskdWdrVMbPp4gsH2w
         EWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XqU5xxUtbfKhmbzvtVRG2mL5cvmccHFZc23S52GP8YU=;
        b=UoFEBcy6mrQ4JT4FgSpR5fnmDCIC8CVL6CtnpurKa6fyx0RTPFGSUaqW2o9A/JyqJ/
         bxA/Jjfq/HjxYL5s1Q0Sr9XL7smFW8l7eH0P2tQ64h7Jq29IPSamO1sfJSfWX3fEV3Zf
         SpWrdyXMUfj3/+pLvnoW2kx8A61DMLt/iZzb/1fuzCMpgehGuQaWjysjEiZsjQoe4/EZ
         fTuuFJGkrQI5HCPa6CX1qSGle5XjNmBo1ArzPnMQCOWZMl3a14bRdBdOOFfhhZYvp/dM
         4evOGqZT+u9axdLtYBETl2ybERI1Vn0l66Pasag+imucuGydB1/43jkp3NZZUChHfTDf
         JywQ==
X-Gm-Message-State: AOAM530Sqae1JELeP6Zh2fNWic1X5T3y50Nmb0EzHnuRjDsNaPZfaltf
        cAar32dc2GMXFHQJGc0ZTtp/dg==
X-Google-Smtp-Source: ABdhPJz5wVVQBO5UVRyqKi7Bs/arqdH2MJINzBJBYNffFsOvVV+m0U3Xe2Gj32qC6yodgt2CeR4qlA==
X-Received: by 2002:a17:902:8682:b0:13e:5d9f:1eb3 with SMTP id g2-20020a170902868200b0013e5d9f1eb3mr19542381plo.42.1633281010437;
        Sun, 03 Oct 2021 10:10:10 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g22sm14079578pfj.15.2021.10.03.10.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 10:10:09 -0700 (PDT)
Date:   Sun, 03 Oct 2021 10:10:09 -0700 (PDT)
X-Google-Original-Date: Sun, 03 Oct 2021 10:09:48 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: mm: don't advertise 1 num_asid for 0 asid bits
In-Reply-To: <20210908173029.1104897-1-vgupta@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>, jszhang@kernel.org,
        guoren@linux.alibaba.com, wangkefeng.wang@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        vgupta@kernel.org, anup@brainfault.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vgupta@kernel.org
Message-ID: <mhng-b9942988-c667-4fb9-9047-7033a62dbb74@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 10:30:29 PDT (-0700), vgupta@kernel.org wrote:
> Even if mmu doesn't support ASID, current code calculates @num_asids=1
> which is misleading, so avoid setting any asid related variables in such
> case.
>
> Also while here, print the number of asid bits discovered even for the
> disabled case.
>
> Verified this on Hifive Unmatched.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
> ---
>  arch/riscv/mm/context.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index ee3459cb6750..ea54cc0c9106 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -233,8 +233,10 @@ static int __init asids_init(void)
>  	local_flush_tlb_all();
>
>  	/* Pre-compute ASID details */
> -	num_asids = 1 << asid_bits;
> -	asid_mask = num_asids - 1;
> +	if (asid_bits) {
> +		num_asids = 1 << asid_bits;
> +		asid_mask = num_asids - 1;
> +	}
>
>  	/*
>  	 * Use ASID allocator only if number of HW ASIDs are
> @@ -255,7 +257,7 @@ static int __init asids_init(void)
>  		pr_info("ASID allocator using %lu bits (%lu entries)\n",
>  			asid_bits, num_asids);
>  	} else {
> -		pr_info("ASID allocator disabled\n");
> +		pr_info("ASID allocator disabled (%lu bits)\n", asid_bits);
>  	}
>
>  	return 0;

Thanks, this is on for-next.
