Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4F3EA339
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhHLLCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbhHLLCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:02:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B86C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 04:01:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b7so6791543plh.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DDhtQcuUXCKgq8bSzq02Y00UE56X0SuRgSK70Eim4XM=;
        b=d4sdlcw7YE/VfJgcdlLPCBuC2gCpccfOHVU3kK6kij74jirpezO90YeAtR5Q1CIFRQ
         htiiMsgQar06AZWvqJQCfMTiLaytxaEqGCOE9eO5K5vAPWIYdOUR5L6jz16/gxLKYvR4
         hXNaBP6bM3rMR6IVH8rcCdFhQM2NK04hdskqEiF5QtP/rrU6SDvVJWAun9UY368b+Ozk
         F86drh6ecc44tL4P/Uq19ndgPbL+MJELVPtuQTgtRETtHWMNg0z0DWBdgKqIgESicRBK
         fgrxBozUc/CbSLFU8y638qymYfHXEl7anT5U7n86lhJPG2DjHRzy4aGZEmK4mgvHS7/7
         814g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DDhtQcuUXCKgq8bSzq02Y00UE56X0SuRgSK70Eim4XM=;
        b=tz8jmbtgHn7qfRPbSaMUH3z3D2zeMYmXnku+LzzRTkY9KMloCZGZbb8BRdklLAu/vM
         0c7600v5YR8QMtp2bYLlGLd+r6eS9l4qY7czk+u/nODmFEvRjk2pBu8JmCJnyvVY8ppX
         grHVEj9xpNBFjoRwddRCmrC+nIKl6SeLZMqwbWaBcfv75GLTQ/EajR2w9qbtJJvSo9l8
         uGIwASbYHRBOr4iGIOqU9g+soZcpYpdgSaJ7aJwXeF78tcaIBHWewJvHA6eFmZgu8uFx
         M8NKwiZYGf2ohHpn0Td8iEB7+EXCN+oGs9Mp+2CaDSEYY7l4GXAABeKhHhhmVCnW20us
         QKDA==
X-Gm-Message-State: AOAM530Ou1XFZy04KIg3pNDspCXXOuO4ymTM13iduo8zeCmOAxkCHix4
        b7I2EKacEolzqrd0pgvQ8UA0DC5WDY8FSA==
X-Google-Smtp-Source: ABdhPJwhTGWJfHP1L7Xsaom5NR39UWbE+gu2q5ngSMcRIsKLOHmQ0bilIejQVi5Bx8Cf80be8fUtPg==
X-Received: by 2002:a17:90b:3a8e:: with SMTP id om14mr3750992pjb.73.1628766094047;
        Thu, 12 Aug 2021 04:01:34 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id p21sm2915208pfo.8.2021.08.12.04.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 04:01:32 -0700 (PDT)
Subject: Re: [PATCH 0/1] __asm_copy_to-from_user: Reduce more byte_copy
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <65f08f01-d4ce-75c2-030b-f8759003e061@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <a70451d1-57ad-6b49-24c1-6408ef94a959@gmail.com>
Date:   Thu, 12 Aug 2021 20:01:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <65f08f01-d4ce-75c2-030b-f8759003e061@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter, Geert and Qiu,

Would you mind testing this patch?
Thanks,

Akira

On 7/30/2021 10:50 PM, Akira Tsukamoto wrote:
> Adding none unrolling word_copy, which is used if the size is smaller
> than 9*SZREG.
> 
> This patch is based on Palmer's past comment.
>> My guess is that some workloads will want some smaller unrolling factors,
> 
> It will reduce the number of slow byte_copy being used when the 
> size is small.
> 
> Have tested on qemu rv32, qemu rv64 and beaglev beta board.
> 
> In the future, I am planning to convert uaccess.S to inline assembly 
> in .c file. Then it will be easier to optimize on both in-order core and
> out-of-order core with #ifdef macro in c.
> 
> Akira Tsukamoto (1):
>   riscv: __asm_copy_to-from_user: Improve using word copy if size <
>     9*SZREG
> 
>  arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
