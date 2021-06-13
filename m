Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11423A5174
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 02:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhFMA0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 20:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFMA0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 20:26:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B47FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 17:23:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso7977878pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 17:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5amvrsViKZuGN7n8MYso1FmYMeenemrS2FHjrjmgxgw=;
        b=LVxiWpFqsZQyn+ZZ8DtF4P3rlEEooBLEsmGsY8djPXWNMJGBmz+8iDaxg855pyRCbu
         ssiTF5vTS9KYsK60OZSUk5EbXgQubqwCBF4p+HC9vnlJ+z1932lkLlVyI9t/HA9t7ygO
         JC/rZ0zJetBkWh+DPmPUDJkxM6cKH00i4DLj7BWWdOBtzNtMqcP3dXyd2HcIDAn0Zf3q
         uKxA6a5LWwSOUVIIJF+d3tIeLKNbGwXfrftgpGtlTZJhaUj5k9sATXrTLKFayw0rI0sh
         xLHZWVDlfZEKG0eiRjqEUoR2Ofy1V/JZvl8+3Ruy16FvX50RpS8aHpfvz/t4971caoPn
         pngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5amvrsViKZuGN7n8MYso1FmYMeenemrS2FHjrjmgxgw=;
        b=c7nixmGJDymZQ96jQhQGHgmXbBKxR61NLHWrFTu3TTMznu9/gaejkqL0kA3fR2f37G
         TisCsOr88JS2sFZ9IGm1sSmW5HghUdeDQm0Pupzo/X5aGLo7gM8jD2L2RDX50KSb/GJC
         kN1DJ5cs75ZMUzwuVmYD05EhlM8LaQfDiS+zrRq+7Vh5afbMudcv1F2aS+xQGfc78GWM
         NvSDrkSQuRQd+qbvaHvbCSnpYtcQI696Re/HI7FGtu9+RarPK9UnRNffGFkl+1U/OOlv
         gEYmrGitHQWC2ZTC2rZCCzB72TQMxlpFjJCJGXPieeIO29jPFjNq5y/tpt/JMNvNQnEJ
         Whbg==
X-Gm-Message-State: AOAM531ultgjGIWJt1Ud2NmuMzypP4I926wSyvvHwUrrkNDCNcuAdDbO
        eVxjTMVchkDjel4Er/ixm4UeBnPGDwSS95/f
X-Google-Smtp-Source: ABdhPJzRQrHT40bjCMJ69QxNRzUQZLrP2Iu9OYdXSxgic0MfNLCBfARHdCvStibiOAc+ewjHe09v9w==
X-Received: by 2002:a17:90a:901:: with SMTP id n1mr16032744pjn.44.1623543830099;
        Sat, 12 Jun 2021 17:23:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b21sm6063221pgj.74.2021.06.12.17.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 17:23:49 -0700 (PDT)
Date:   Sat, 12 Jun 2021 17:23:49 -0700 (PDT)
X-Google-Original-Date: Sat, 12 Jun 2021 17:16:18 PDT (-0700)
Subject:     Re: [PATCH] riscv: sifive: fix Kconfig errata warning
In-Reply-To: <990a9263-dc33-e616-12eb-173e6872c93a@infradead.org>
CC:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        vincent.chen@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-2f2cd07e-8780-45cd-89ac-db2f516b0204@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jun 2021 16:46:15 PDT (-0700), rdunlap@infradead.org wrote:
> ping. anyone?
> thanks.

Sorry, I missed the original patch.  This is on fixes.

>
> On 5/22/21 2:20 PM, Randy Dunlap wrote:
>> The SOC_SIFIVE Kconfig entry unconditionally selects ERRATA_SIFIVE.
>> However, ERRATA_SIFIVE depends on RISCV_ERRATA_ALTERNATIVE, which is
>> not set, so SOC_SIFIVE should either depend on or select
>> RISCV_ERRATA_ALTERNATIVE. Use 'select' here to quieten the Kconfig
>> warning.
>>
>> WARNING: unmet direct dependencies detected for ERRATA_SIFIVE
>>   Depends on [n]: RISCV_ERRATA_ALTERNATIVE [=n]
>>   Selected by [y]:
>>   - SOC_SIFIVE [=y]
>>
>> Fixes: 1a0e5dbd3723 ("riscv: sifive: Add SiFive alternative ports")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: linux-riscv@lists.infradead.org
>> Cc: Vincent Chen <vincent.chen@sifive.com>
>> ---
>>  arch/riscv/Kconfig.socs |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- linux-next-20210521.orig/arch/riscv/Kconfig.socs
>> +++ linux-next-20210521/arch/riscv/Kconfig.socs
>> @@ -14,6 +14,7 @@ config SOC_SIFIVE
>>  	select CLK_SIFIVE
>>  	select CLK_SIFIVE_PRCI
>>  	select SIFIVE_PLIC
>> +	select RISCV_ERRATA_ALTERNATIVE
>>  	select ERRATA_SIFIVE
>>  	help
>>  	  This enables support for SiFive SoC platform hardware.
>>
