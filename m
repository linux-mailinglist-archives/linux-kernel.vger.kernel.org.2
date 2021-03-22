Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE4343BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCVI1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCVI1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:27:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150AFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:27:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so19742995ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l+BDFfhmpfMChR10QeWibz7ivIzCkn0HHk1zDvsRjuU=;
        b=w8/LRQezNhY7NHzEHNuQvuRraZtak1c8qIn64pmC7wePGHY6zGPRfyg8no1YiLF6L9
         +52YtLp4Gjdx+ZKf+zchO/mIggVFhhNfb8BV1tLzuyNIMwpd5Oh4j05TpgWLTyQI6t9r
         gvqe3mjKPJsaN93RceTQxpDnHt2rF1jF0ze3kLV0ycdfDI65wpN5BWOpjQSVG6AZujMv
         LQq62TsPpvXGxQ5abw36pWBL9e9H+aCuWQ2TPMQOWl47cfgjexzN52FobNIdCvrXJuqm
         XIj/1Trxkq2wTCvxlkmrhfxqySn+XMLGjC7rN2ILXjX7DhsKhQ3zaEWEhTVxdtgBPxDl
         4Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l+BDFfhmpfMChR10QeWibz7ivIzCkn0HHk1zDvsRjuU=;
        b=EIkX5Zl6mL47k2JEDjyriOQ+B1V7BdLQdQyyjmmVnf/74u8ekIOxYcgQ0V9J6Ai9za
         FgS2CzopsL6eCGprgnKJogDjeqTQpJiuhhWhJNxpmeGr/oyXkY1Ngb9B5PvDkgSUOdxw
         7d/jAPRE4VZhJh1gReCAn8cwF/QftRioZDGKo2vFtOb18/cucBYcWAeLo0ym8pC+5kyF
         QQbBPEYWmfoltIx93kTt8N40o2QU+HobYDhtrmYrcKqdKtmFzGLd9+8qAfst832QM3TH
         W3j99V9o9v92+kvCKv9K6n7kh4zgNpFolA8PcDIQzW4kd4f+EvihOIFGXzqvztzPv1/a
         HfQA==
X-Gm-Message-State: AOAM531LogKWk4vRZPENZaf9pNmNWXJyIdT/+ONyCb85ddt2LnZxl/7M
        efa4r3G7R/fAevO6Y0SBcNiI/xMBnz+TIx76
X-Google-Smtp-Source: ABdhPJynowhp3kkQu29v2ax+Wf/v1MD51JPfJ9narj7A9SNgkBqdC3//LaICAT1myzO1RnmBxnYkdQ==
X-Received: by 2002:a17:906:39cf:: with SMTP id i15mr18035901eje.534.1616401635823;
        Mon, 22 Mar 2021 01:27:15 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id gj26sm9225323ejb.67.2021.03.22.01.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:27:15 -0700 (PDT)
Subject: Re: [PATCH] microblaze: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210319045323.21241-1-unixbhaskar@gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <4afbe9f6-4be0-d02f-3c63-899f10c13972@monstr.eu>
Date:   Mon, 22 Mar 2021 09:27:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319045323.21241-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/21 5:53 AM, Bhaskar Chowdhury wrote:
> 
> s/storign/storing/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/microblaze/lib/uaccess_old.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/lib/uaccess_old.S b/arch/microblaze/lib/uaccess_old.S
> index 0e8cc2710c27..eca290090038 100644
> --- a/arch/microblaze/lib/uaccess_old.S
> +++ b/arch/microblaze/lib/uaccess_old.S
> @@ -188,7 +188,7 @@ w2:	sw	r4, r5, r3
>  	.text
> 
>  .align 4 /* Alignment is important to keep icache happy */
> -page:	/* Create room on stack and save registers for storign values */
> +page:	/* Create room on stack and save registers for storing values */
>  	addik   r1, r1, -40
>  	swi	r5, r1, 0
>  	swi	r6, r1, 4
> --
> 2.26.2
> 

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

