Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA4936D0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 05:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhD1DgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 23:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbhD1DgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 23:36:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD24C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:35:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t21so940171plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pkolduBNLLIr5vIIXbQQOt2wpdaq8aKiRXOt5tHWv0k=;
        b=AQ8FCd36kKveqrMIgf7gDWhpb3Z2GF9RhV+CpYRyHF3aTCzjysEv4uLA3Nc/ctIMr1
         FPYLA4bAcRcw0su3LPEK77MXyoAK1/Y0Kawr+7hLLF5oY+4FkGXkSEvuPhWoN40Lw7pj
         MF0NKPcfpE+yM+YAm1UFH3Rh4SP/4nCVjmtJqeruOH2yFL67Pxcxu1nnAPBX227IDRen
         tfG9YMFGLaLIFrKrkCHETFFYXO3IS/QADhw2OmI1EnYSlDeeji820daFlYUT6Kni+/dw
         2I/AOw8spRHZRiip3Gq186c8GufOHoaHt45x0NqHXlU3DHaIFkR4frwxh405j4erOK2O
         ftEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pkolduBNLLIr5vIIXbQQOt2wpdaq8aKiRXOt5tHWv0k=;
        b=LkBAGrWJ4hGef3if24OiedQsKz53V+LU2BkdmuUsn8zcV8Yj5zfD86oSz7OQdV3k3f
         lspqxA+Qyf2zCkpBAWe2a5kEA4ITFyMyUuXMDszzxH34sad0Zz4cpw8CVkjuWDarrNnj
         Yhib6ngkolZumNUS17w5O7jHE2woDekwFQ6woVQ6Dkc991aOYPQjbINI+lQYXFE3if5n
         DS/VSY4nC/qb+KImPfE7qraplvK2v/MTBczhhFrmx/qr0Mfn8p6y5nGSGgk0/Zv6egSi
         KDLPJhpNnzDvvtvjiUrtXXCV6chHBdiGABTtzTOMr0AdrkbqZRO/eIwK4Pg1VviiiX91
         R9fA==
X-Gm-Message-State: AOAM5335lBajK+axGWSiZOcAoHfEpZwCvfU4BmjwMquXUIFdmpnNGnyZ
        tOeFmSvlmTEmflGKPvZgD+/h/w==
X-Google-Smtp-Source: ABdhPJwMgSQQE79CAJ3VE3v1uID2azdmj5M/8eezAiYtjefmEN0N+WVUz8Ar2sct5D1D7zmhD50G2w==
X-Received: by 2002:a17:902:6b4c:b029:ec:a55f:f4e7 with SMTP id g12-20020a1709026b4cb02900eca55ff4e7mr28397654plt.72.1619580921559;
        Tue, 27 Apr 2021 20:35:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b4sm3260291pfv.188.2021.04.27.20.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 20:35:21 -0700 (PDT)
Date:   Tue, 27 Apr 2021 20:35:21 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Apr 2021 20:35:19 PDT (-0700)
Subject:     Re: [PATCH v8] RISC-V: enable XIP
In-Reply-To: <20210428030824.GA196954@roeck-us.net>
CC:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, vitaly.wool@konsulko.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@roeck-us.net
Message-ID: <mhng-6764680f-437c-4733-8569-6f76d9c3aa4f@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021 20:08:24 PDT (-0700), linux@roeck-us.net wrote:
> On Tue, Apr 13, 2021 at 02:35:14AM -0400, Alexandre Ghiti wrote:
>> From: Vitaly Wool <vitaly.wool@konsulko.com>
>>
>> Introduce XIP (eXecute In Place) support for RISC-V platforms.
>> It allows code to be executed directly from non-volatile storage
>> directly addressable by the CPU, such as QSPI NOR flash which can
>> be found on many RISC-V platforms. This makes way for significant
>> optimization of RAM footprint. The XIP kernel is not compressed
>> since it has to run directly from flash, so it will occupy more
>> space on the non-volatile storage. The physical flash address used
>> to link the kernel object files and for storing it has to be known
>> at compile time and is represented by a Kconfig option.
>>
>> XIP on RISC-V will for the time being only work on MMU-enabled
>> kernels.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr> [ Rebase on top of "Move
>> kernel mapping outside the linear mapping" ]
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> In next-20210426, when building riscv:allnoconfig or riscv:tinyconfig:
>
> arch/riscv/kernel/setup.c: In function 'setup_arch':
> arch/riscv/kernel/setup.c:284:32: error: implicit declaration of function 'XIP_FIXUP'

Sorry about that.  I thought I'd fixed the last build, but I guess I 
managed to just miss these build failures in a spew of successes.  I 
just sent out a patch to fix it.
