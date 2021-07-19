Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227D03CD73D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbhGSOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhGSOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:14:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D21C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:23:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b2so5148030plx.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j4n25LkU4CnK8pwnLWimZ7Sa+0IJqfeinuqyN2R3e7o=;
        b=iLSOt+G9lkCGU+d5/lqsILcxRWOVieMwPb5T9+VJCUgBU1AZj7AeA2Az2GHSkIE2FX
         BM1d3VhKGfgSEVemgkM1GYi9by9mx6iYuEll77+4JtAwUnsMtOmu2EdJRe86++7dauaU
         w+sk89qtXOPkcCZ+3spGwAR67ZTzIQT8NkPtbzog0GDqSPeishdlkOYSMtBh0me15gnR
         PvpJQHo2EziXRIGrltlJT4MXNpesSnst1GqJADlOpFJi+iHJLELE4ILxrpyhcicnIdKo
         BsWgQPqzXb0GzH+CS6u55qSZ0G3oJkvH9BfvRuSlZFAy30BkFPZI0wqTWjiq0UsFh2D4
         aPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j4n25LkU4CnK8pwnLWimZ7Sa+0IJqfeinuqyN2R3e7o=;
        b=q9MlozpaT18GpSxhpm3kLhMyRq6KYQI3IsNBVMkVA286xCq0i/UYR0nQSRMDepSXnV
         FpuU2fYXx4UWLV/w1W7TsA4Zp76e7rkWMAarJJWWx+urmk7vpGTvaW0NitnfuWc3VIO2
         y+wHdXHSMsb5Q022Ip/NKJyuq2p9aZ/ByA7OnT5VXlEnK+aSbPVPUCDXEDBnVg2bWsfl
         /7Dy32qmKNbPqbZcrre2NUTVxqky+dT3QAS1snZdNK35mTomOBFDhGV8v4vjh2KQ41lp
         vJ4PrrkA2+9FFwdt4eTKgpzVNlDXeqtXut4dvz/s0zYxz2LRCpZ+KHQe1a9A6D4osbQJ
         qFIA==
X-Gm-Message-State: AOAM533k5Q/jncLUBD1b5YlwNyY5jJaBJvJYTmUUV4qLSMW/HAytqV25
        0vtgosnZjGFtQj03o6HstJ8EGNJt5yI=
X-Google-Smtp-Source: ABdhPJziBxO9jKYosKBpaD506GGx3R4/n9hiqLQjlkpwagdiRsADMfGyZlJ/I13T13nVeE6pgQrlIg==
X-Received: by 2002:a17:90b:378c:: with SMTP id mz12mr25784888pjb.122.1626706505061;
        Mon, 19 Jul 2021 07:55:05 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id w69sm20640149pfc.58.2021.07.19.07.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 07:55:04 -0700 (PDT)
Subject: Re: [PATCH v4 0/1] riscv: improving uaccess with logs from network
 bench
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <afac7502-5de9-1fec-10c7-03dbb06a3f67@gmail.com>
Date:   Mon, 19 Jul 2021 23:55:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Please do not bather with this patch.
It still have bug for rv32 reported by Guenter and I will regenerate the 
patch against v5.14-rc* since I made the patch against v5.13.x for this
patch.

Akira

On 7/19/2021 9:51 PM, Akira Tsukamoto wrote:
> Hi Guenter, Geert and Qiu,
> 
> I fixed the bug which was overrunning the copy when the size was in the
> between 8*SZREG to 9*SZREG. The SZREG holds the bytes per register size
> which is 4 for RV32 and 8 for RV64.
> 
> Do you mind trying this patch? It works OK at my place.
> 
> Since I had to respin the patch I added word copy without unrolling when
> the size is in the between 2*SZREG to 9*SZREG to reduce the number of byte
> copies which has heavy overhead as Palmer has mentioned when he included
> this patch to riscv/for-next.
> 
> 
> I rewrote the functions but heavily influenced by Garry's memcpy
> function [1]. It must be written in assembler to handle page faults
> manually inside the function unlike other memcpy functions.
> 
> This patch will reduce cpu usage dramatically in kernel space especially
> for applications which use sys-call with large buffer size, such as network
> applications. The main reason behind this is that every unaligned memory
> access will raise exceptions and switch between s-mode and m-mode causing
> large overhead.
> 
> ---
> v3 -> v4:
> - Fixed overrun copy
> - Added word copy without unrolling to reduce byte copy for left over
> 
> v2 -> v3:
> - Merged all patches
> 
> v1 -> v2:
> - Added shift copy
> - Separated patches for readability of changes in assembler
> - Using perf results
> 
> [1] https://lkml.org/lkml/2021/2/16/778
> 
> Akira Tsukamoto (1):
>   riscv: __asm_copy_to-from_user: Optimize unaligned memory access and
>     pipeline stall
> 
>  arch/riscv/lib/uaccess.S | 218 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 183 insertions(+), 35 deletions(-)
> 
