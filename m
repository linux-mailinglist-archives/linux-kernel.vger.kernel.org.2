Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87823CD51F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhGSMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhGSMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:11:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF61C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:10:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c1so12551817pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CZEGhNq+WhK06in660whrcqCiBpcL7TqJd20Aa2w9Eg=;
        b=QVf9+hRGzyRK/JBZm8moySqhZOnydLEjx4OmMiZoHZoZPkGYtt2oPJqB5cVHBq/Fca
         R6JoHf2+Dih8j/xsh17TJ2MajC2saeAdKwXlM6NmnfPZysfe6BnrUQDLVd5g+wXu5KJ3
         Y30wh/DznmIqd9t+OrnYQ/YhctShCfO41gIl/T9muxGeAkEn/ctbRaf90PhQbczvn1Mi
         W7vV5O4/cn+d1H9DbyvIcQ7RP4zHyjgKrGrcuCiD+fMi4De0ehacBfywS3xdPOJ4Lqfr
         9RKQryHPMqNf8o8vJYLe2oVWG9e9MaJF1lyBixjjPuouQHIZJO8031YCL0Y3vEkpv9CQ
         DIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CZEGhNq+WhK06in660whrcqCiBpcL7TqJd20Aa2w9Eg=;
        b=Msg8Ky0Nivtqqabs8HG6ELXAE74e1eb2in3foi99BeYQa1zNL5DTwL0Qqzk2j3KA8/
         g+paijUNz7uD5vsRrVsCAusfp2fPf4vgMp3YRgj5G+4LGccu7i/nXIUCFIa5q/1U6CBa
         aEsk8dR9A9XvfmaYOmgyspoL+jyl+uEapae+LZ83289xSbarEP3Rw+dFImOhxsGyU/RO
         LW3WRo+ghog67+yVi4xHwxUQKRKjnLB+w+Gsuq/WzBnzPmZuxY5rN7Oxyq1RYlxt4KN0
         Xrs0brBIW5eCS3o4pNl9N+ScLRwSVxT6V63nCPIQ04/ipmGFWjwm1Fa1AbuiIrAh5IvM
         SaJA==
X-Gm-Message-State: AOAM531xGWPgOfR55CoSo80OIJnXyLqaf4/TF7AVq4Y/K6/MAU/hQKCf
        LJIYCveIH4OfmJpedU5jwn+24GBI82qkPQ==
X-Google-Smtp-Source: ABdhPJwyA7jgHBHBxda/DWSD0A4x5BFrWvSS1IH7K3F0wBD+fdp6FRynHwTXyZnMqPtX+UAhBrCPOg==
X-Received: by 2002:a62:dd42:0:b029:330:6bf8:b02c with SMTP id w63-20020a62dd420000b02903306bf8b02cmr25445710pff.67.1626699108669;
        Mon, 19 Jul 2021 05:51:48 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id x3sm10046513pjq.6.2021.07.19.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 05:51:48 -0700 (PDT)
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Subject: [PATCH v4 0/1] riscv: improving uaccess with logs from network bench
Message-ID: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com>
Date:   Mon, 19 Jul 2021 21:51:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter, Geert and Qiu,

I fixed the bug which was overrunning the copy when the size was in the
between 8*SZREG to 9*SZREG. The SZREG holds the bytes per register size
which is 4 for RV32 and 8 for RV64.

Do you mind trying this patch? It works OK at my place.

Since I had to respin the patch I added word copy without unrolling when
the size is in the between 2*SZREG to 9*SZREG to reduce the number of byte
copies which has heavy overhead as Palmer has mentioned when he included
this patch to riscv/for-next.


I rewrote the functions but heavily influenced by Garry's memcpy
function [1]. It must be written in assembler to handle page faults
manually inside the function unlike other memcpy functions.

This patch will reduce cpu usage dramatically in kernel space especially
for applications which use sys-call with large buffer size, such as network
applications. The main reason behind this is that every unaligned memory
access will raise exceptions and switch between s-mode and m-mode causing
large overhead.

---
v3 -> v4:
- Fixed overrun copy
- Added word copy without unrolling to reduce byte copy for left over

v2 -> v3:
- Merged all patches

v1 -> v2:
- Added shift copy
- Separated patches for readability of changes in assembler
- Using perf results

[1] https://lkml.org/lkml/2021/2/16/778

Akira Tsukamoto (1):
  riscv: __asm_copy_to-from_user: Optimize unaligned memory access and
    pipeline stall

 arch/riscv/lib/uaccess.S | 218 ++++++++++++++++++++++++++++++++-------
 1 file changed, 183 insertions(+), 35 deletions(-)

-- 
2.17.1

