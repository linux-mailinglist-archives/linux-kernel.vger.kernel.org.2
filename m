Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966743CF66B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhGTIQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhGTIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:09:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA3C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:49:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u126so11270668pfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/1BmjzMq7Dia3dSS0Ypp2zIpetpQss4HMpALBUnlA2s=;
        b=fcKNBnRWQcBqixvo6hoTKqYM/1TeepOTwTBWSK3uMM/Z+ltndAN7bcBTFW797CaTEl
         UVfKysaU78AEx36ZSNaNPRkP9sfrzkMKNM2/IoaLmNvJ9wPE/5WfB6O+bQsEH8ifYsc2
         i18myaTv4s542Ad4V8arIGOv7nHZZKxTYaPuor78jAo+cRuNIEu/RP+LJk6/OOWxJz39
         8WSKt2/jcHJJ3RwMaNBtmn8ZwWiLu7UaAGKnGu1TDaWZ8tyUVcn2/KRQ58d17YTon15K
         x4jC/alhny4aoIsyKt8rERDexv1egqwN/DL1peZlG7P7TQgUKda7sAiUzAaEKqyYYEbQ
         rsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/1BmjzMq7Dia3dSS0Ypp2zIpetpQss4HMpALBUnlA2s=;
        b=Pt0QW7M1imOxquThfCoTSvNNPeH+QZ92afeGyXDBTvTdfPwZbPwD+Fhd662nblLGHN
         yJOtk3MlcOymbNrQOFAedH7e6nmoLJ//tfGSIC6TYNTYv6PQBc72zxYx3ySPiQv4xpul
         odIIvepX3vtxUJjg/B98BXDqXMRwcAF3GJXtQflvcGKLh1aLwZzKDgrKKemjTepnxpo4
         nmtheom27E4HGhPOUTxsNt/lNTZJlS2mmefe/pPsLr15+SQDd6RIrp4prY1GjiB73XWK
         hRFTAU9zNSp5c7rlvlldOKo73s2XHeeQzu3XaD3DECpYHrcfyqhFs2BvdwEZnUMH63Ej
         T/pg==
X-Gm-Message-State: AOAM530K5sIBV1mEI34K6QXlm1oYghvQd/sdbXxeGil2pTn1sYOhPBzn
        XHSGEmjck43mnMETTLE0+vkvyMMFUvU=
X-Google-Smtp-Source: ABdhPJzDdxa3bqQIwB/IQOPYu3smOyBxEZHVt5I6QQqOo66tRJ8cH5CdG7+j7lZ6jipt5wO3euewDg==
X-Received: by 2002:a63:5616:: with SMTP id k22mr29506544pgb.211.1626770988933;
        Tue, 20 Jul 2021 01:49:48 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id d1sm13778298pfj.24.2021.07.20.01.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 01:49:48 -0700 (PDT)
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Subject: [PATCH 0/4] __asm_copy_to-from_user: Fixes
Message-ID: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
Date:   Tue, 20 Jul 2021 17:49:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are series for the fix reported by Guenter, Geert and Qiu.

One patch to fix overrun memory access, one patch to fix on rv32.
And two more for clean up and typos.

Have tested on qemu rv32, qemu rv64 and beaglev beta board.

Thanks for the report and instructions to reproduce the error on rv32.

Akira

Akira Tsukamoto (4):
  riscv: __asm_copy_to-from_user: Fix: overrun copy
  riscv: __asm_copy_to-from_user: Fix: fail on RV32
  riscv: __asm_copy_to-from_user: Remove unnecessary size check
  riscv: __asm_copy_to-from_user: Fix: Typos in comments

 arch/riscv/lib/uaccess.S | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
2.17.1

