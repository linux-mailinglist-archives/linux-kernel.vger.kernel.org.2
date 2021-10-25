Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF201438E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 06:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhJYE3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 00:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhJYE3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:29:22 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CAAC061745;
        Sun, 24 Oct 2021 21:27:00 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x13so2462587qvk.2;
        Sun, 24 Oct 2021 21:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5/7//GT6K8saLNYnBNTIJ2rcr8YYQPDQMp7BriZDIdQ=;
        b=PF93yZdWy59wvO7+IDGCd9/qPOo9E+BIGJxY72VRssbYKljmV/ct/V9u/8oaml6F9c
         deO58GNFIypSR5gXlKfQ+o70gXgMYWWJ+ccCDzOlNFYBCMOz02r30wON1dEYxkc6V5qV
         OpgMuVTc8EnCrNu/A5qp2z97Pv00i2h1TN/QFknKhdx/zhHyY1JWpZfFY0wQRTexGRWo
         CvDzEcDAhtJRzL2tkIp8sJDMpeAgaXjtGgD0YOq5VB/ig1xRNEe82+lxcAWlKKb4cmzc
         Me92O4vu5Mjx3TYIs6CvU7kGvx0SYeT7xMJ6F8LGRhT7hGHUodlP6fR07KiW3GyNlhad
         K2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5/7//GT6K8saLNYnBNTIJ2rcr8YYQPDQMp7BriZDIdQ=;
        b=bc/4XsT06vVubBhU/RTmrC4yXTDpwbJ9tQl/Mr7OXLZiXkbo/fVUUwF09YO7cEBnNh
         Y51WCoSLFeq3TJWuoPr9XFyFuViE2Bc3zp0Kn/r6Rh45XNnu5hnH4opzE9epS3EB5Xss
         CD2GqwUrQEl2/4ZsIh2JtkW4jRRw7Hlkmnodcqq2e/FGA8wcTqvfYLJqYSDbgGnYz/eo
         fz5WFLfk4/Q7pfozjX7LklnA1vbR2ExV/NR/vJzbCY1yIjVxKp8bAeV22p5LajlJj8qH
         2FRHNnryX8L7u8RX50vvucqAwn0ihN4+IT+2773M/WPlMJZLsYKnXIVekA49EE5lS4k1
         H60Q==
X-Gm-Message-State: AOAM533SkQxlVRj7P2DO8zZDL+Mp/2sP1XYUJiY5PWjbm5dWC2ZTr62j
        SHZkE+FAjTpezY9cLR9moJQ=
X-Google-Smtp-Source: ABdhPJwfbJAmT9+Xk+wanOlkaP+dWqnnj+VpDQolod3Lvdh9+j8jVGF8kKcNzlor85k/LUk+XRPU+g==
X-Received: by 2002:a0c:b4c9:: with SMTP id h9mr13402579qvf.6.1635136019605;
        Sun, 24 Oct 2021 21:26:59 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id v7sm7940111qkd.41.2021.10.24.21.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 21:26:59 -0700 (PDT)
Subject: Re: [PATCH] x86: of: Kill unused early_init_dt_scan_chosen_arch()
To:     Rob Herring <robh@kernel.org>, x86@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20211022164642.2815706-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d3013783-b5b6-6a60-17c1-4bd65004dd5e@gmail.com>
Date:   Sun, 24 Oct 2021 23:26:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211022164642.2815706-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/21 11:46 AM, Rob Herring wrote:
> There are no callers for early_init_dt_scan_chosen_arch(), so remove it.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/x86/kernel/devicetree.c | 5 -----
>  include/linux/of_fdt.h       | 1 -
>  2 files changed, 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 3aa1e99df2a9..5cd51f25f446 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -31,11 +31,6 @@ char __initdata cmd_line[COMMAND_LINE_SIZE];
>  
>  int __initdata of_ioapic;
>  
> -void __init early_init_dt_scan_chosen_arch(unsigned long node)
> -{
> -	BUG();
> -}
> -
>  void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
>  	BUG();
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index cf6a65b94d40..cf48983d3c86 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -65,7 +65,6 @@ extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
>  extern int early_init_dt_scan_chosen_stdout(void);
>  extern void early_init_fdt_scan_reserved_mem(void);
>  extern void early_init_fdt_reserve_self(void);
> -extern void __init early_init_dt_scan_chosen_arch(unsigned long node);
>  extern void early_init_dt_add_memory_arch(u64 base, u64 size);
>  extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
>  
> 

Reviewed-by: Frank Rowand <frank.rowand@sony.com>

