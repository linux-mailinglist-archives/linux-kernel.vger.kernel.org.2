Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E889741ADF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbhI1Lkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhI1Lkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:40:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C9C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:38:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d6so57318724wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7fGGK90S9C9b8ilOhD1u7GLpSYfNS6f8YE4+w/lDCo0=;
        b=PUSAnVNj5LWSkTf4d+yBUJxjlolDtwmAE1uSUv3MTdsVMhFcsb1OJGFmZHMTiNi0T9
         60td2Xa/W1nl8xZr8D4+54I+qy5iVs/o7JC/hqZdiM/cwJflbnKN+4D24lNUsXC+TJiO
         b+IlMSbr2IuopIcNLoowPEYQIgwj85VZLsw+DurQvee30ZkCQiqSaCRW50naHsFFKDOU
         7Gf4yXegJvLfGTI8xc5Xb2YYDFFMcVJX1tr3VSwbViQA0hP2pNg5fuCfab8DONcz7E8l
         73PAe0XT4thbWvnZzm4HwYD0I8Rytxwb9EZBszPfhJwOQ9YUx+AEiAfd1MccwDyTUk6M
         e88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7fGGK90S9C9b8ilOhD1u7GLpSYfNS6f8YE4+w/lDCo0=;
        b=RXeoWNd5ld9CH2ba/5VT4lPNu01LAteX4ERa0LY2slBz5so/RhBGnZEcLmTivKv5wP
         KsHXm/HV2PC9fBTeUTjQc54vyksYQsrzOT1nCcuYjSEfnpJ7Z4Xke1UG5oOseqa5qbtW
         ukJDhRQgjujFyfMjwUTNh69X46fWj0LUq36c4DvPAr7BEUxhdnRszizTPv/jFhqpUqAH
         CO1JHjy8B33kAIdhg+WlkbgPjg7TB+gOkvo1oK3JvzVMoFPRfk2N9FfY48oBx1H93GAA
         xG5yhOeHas7KyCOHoYIk1apr9VfJ3TXzH+G4J0AniqkYS5J4LsKLWLT81RW3amt5wbQO
         39Fw==
X-Gm-Message-State: AOAM531EJ9VXVSxjqfvFS/cmAXB8EP4avfQ5YRmEZguyeLsI5u5NOToy
        h3s5vOjQ0Z/i7Lw26bf5g/w=
X-Google-Smtp-Source: ABdhPJyvcWTLMQQS65o6b2fZukJp6OubPHpFuA4eWKQ2fOFtMbwqEMXeN/YhcQTZiOV/7bFCxFK6gw==
X-Received: by 2002:adf:ea0c:: with SMTP id q12mr5893522wrm.348.1632829135222;
        Tue, 28 Sep 2021 04:38:55 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id g13sm2361124wmh.20.2021.09.28.04.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 04:38:54 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:38:53 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linusw@kernel.org, kaloz@openwrt.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: intel-ixp42x-welltech-epbx100 no longer boot due to 463dbba4d189
 ("ARM: 9104/2: Fix Keystone 2 kernel mapping regression")
Message-ID: <YVL+zd33DwmLXo6B@Red>
References: <YVLD/UMRYA55WiGI@Red>
 <m3r1d9ng7m.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3r1d9ng7m.fsf@t19.piap.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Sep 28, 2021 at 12:32:13PM +0200, Krzysztof Hałasa a écrit :
> Hello Corentin,
> 
> Corentin Labbe <clabbe.montjoie@gmail.com> writes:
> 
> > I am working on puting my ixp4xx board on kernelCI.
> > But it no longer boot since 4.14.
> > It only prints "Starting kernelUncompressing Linux... done, booting the kernel." then nothing.
> >
> > I bisected the break to 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel mapping regression")
> 
> I guess you build your kernel as big-endian.

Hello

Yes, IXP4XX is by default BE.

> 
> These parts seem suspicious to me:
> 
> -    str r8, [r5]            @ Save physical start of kernel
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +    str r8, [r5, #4]            @ Save physical start of kernel (BE)
> +#else
> +    str r8, [r5]            @ Save physical start of kernel (LE)
> +#endif
> 
> and
> 
> -    str r3, [r5]            @ Save physical end of kernel
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +    str r3, [r5, #4]            @ Save physical end of kernel (BE)
> +#else
> +    str r3, [r5]            @ Save physical end of kernel (LE)
> +#endif
> 
> IXP4xx, being ARMv5, uses CONFIG_CPU_ENDIAN_BE32 (when configured as
> BE), but it needs the ", #4" as well.
> 
> I'd test with: #if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32

Thanks, with the following patch, my boards boots

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 29070eb8df7d..3fc7f9750ce4 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -253,7 +253,7 @@ __create_page_tables:
        add     r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ORDER)
        ldr     r6, =(_end - 1)
        adr_l   r5, kernel_sec_start            @ _pa(kernel_sec_start)
-#ifdef CONFIG_CPU_ENDIAN_BE8
+#if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32
        str     r8, [r5, #4]                    @ Save physical start of kernel (BE)
 #else
        str     r8, [r5]                        @ Save physical start of kernel (LE)
@@ -266,7 +266,7 @@ __create_page_tables:
        bls     1b
        eor     r3, r3, r7                      @ Remove the MMU flags
        adr_l   r5, kernel_sec_end              @ _pa(kernel_sec_end)
-#ifdef CONFIG_CPU_ENDIAN_BE8
+#if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32
        str     r3, [r5, #4]                    @ Save physical end of kernel (BE)
 #else
        str     r3, [r5]                        @ Save physical end of kernel (LE)

Regards
