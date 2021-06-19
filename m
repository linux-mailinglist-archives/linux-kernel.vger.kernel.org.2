Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B883AD9C8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhFSLXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFSLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:23:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840C4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:21:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h16so7204091pjv.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=vF9uOfHJd5f9mPzqhhnKRBmuIenlnkTe2hqoo2WNujU=;
        b=jAcNBEWYtlgil0B8TcQV7IQbsRXT3FQsWsDLHO+2T1Ffyy6WccQN/jydqkKOSWB8AI
         pogmvFeIUzz+zjyROLCR+PLIFTXtDFneTZ1FIzUoDVUBBbMC1Crpofblz5ShHlDHvH4b
         7a8+wCPKFbUnA9w9Hw4BGgv2tMIwMsftki8nHinptNBWBbFZejX3w18AyXuulYyb6A96
         6qS0gSTtaLgI78bl/mpHi3UOrNkoVLhKNwlu1QVjwYnAljQwB6rg9Xhha1s4okjT+ojM
         5pOZAv1rWdGS2inD+2jhDwUVNoq1NA8U3r4YKuZ8WhaULE9XiGeDsCWkqSokbrRsuBTU
         ST6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=vF9uOfHJd5f9mPzqhhnKRBmuIenlnkTe2hqoo2WNujU=;
        b=OTtEpZm7Zh08nIsG44wepOsrIQxsGxknm6uzNdhTkBNcZ/tjDJdSAWpqe+NZTq/gAM
         tiJDE/w7qw7fA7G8UedhY8ZctDhI09D/hPfamiPwWAkeyoubRAvx3ghKxjT//YOw+hdc
         zBF/7hzZTPtBiN6GJvqHjX4WENbfZVgzGK0rpXzzWl4OehQzrayhsALSKc/5KMRMi26H
         uz1uxueKhr4rxwHY0XgNUKVlY6ncwzz/k2esBB4DhlGi75BIluPZmGCXb8uV+KhQbV7U
         0R7kxCzwS23oIgtyRuZXh4ilDk6Mn/Pog01aLP/WyUuq2hZBzpiDePr6WCmDTDJCRbxL
         p+Pg==
X-Gm-Message-State: AOAM532HxS2aVS1t8rZkSTwKrR90l0GZIMa8Ns73lcepjIrBuZ+JWgX/
        cSpBOaxlg69EPEvf9JiJtc39fuMTHAe0GQ==
X-Google-Smtp-Source: ABdhPJyfWmxhkH1IA4NxqFHIOul9JxnZQCQu1y3miRlYPE/Ny2zthirr1eWHuQI8jm8AMXKvu4y5/w==
X-Received: by 2002:a17:902:9a4c:b029:119:d507:dccd with SMTP id x12-20020a1709029a4cb0290119d507dccdmr8856951plv.55.1624101680959;
        Sat, 19 Jun 2021 04:21:20 -0700 (PDT)
Received: from [192.168.1.153] (87.19.178.217.shared.user.transix.jp. [217.178.19.87])
        by smtp.gmail.com with ESMTPSA id z15sm12255218pgu.71.2021.06.19.04.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 04:21:20 -0700 (PDT)
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Subject: [PATCH v2 0/5] riscv: improving uaccess with logs from network bench
Message-ID: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
Date:   Sat, 19 Jun 2021 20:21:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimizing copy_to_user and copy_from_user.

I rewrote the functions in v2, heavily influenced by Garry's memcpy
function [1].
The functions must be written in assembler to handle page faults manually
inside the function.

With the changes, improves in the percentage usage and some performance
of network speed in UDP packets.
Only patching copy_user. Using the original memcpy.

All results are from the same base kernel, same rootfs and same
BeagleV beta board.

Comparison by "perf top -Ue task-clock" while running iperf3.

--- TCP recv ---
  * Before
   40.40%  [kernel]  [k] memcpy
   33.09%  [kernel]  [k] __asm_copy_to_user
  * After
   50.35%  [kernel]  [k] memcpy
   13.76%  [kernel]  [k] __asm_copy_to_user

--- TCP send ---
  * Before
   19.96%  [kernel]  [k] memcpy
    9.84%  [kernel]  [k] __asm_copy_to_user
  * After
   14.27%  [kernel]  [k] memcpy
    7.37%  [kernel]  [k] __asm_copy_to_user

--- UDP send ---
  * Before
   25.18%  [kernel]  [k] memcpy
   22.50%  [kernel]  [k] __asm_copy_to_user
  * After
   28.90%  [kernel]  [k] memcpy
    9.49%  [kernel]  [k] __asm_copy_to_user

--- UDP recv ---
  * Before
   44.45%  [kernel]  [k] memcpy
   31.04%  [kernel]  [k] __asm_copy_to_user
  * After
   55.62%  [kernel]  [k] memcpy
   11.22%  [kernel]  [k] __asm_copy_to_user

Processing network packets require a lot of unaligned access for the packet
header, which is not able to change the design of the header format to be
aligned.
And user applications call system calls with a large buffer for send/recf()
and sendto/recvfrom() to repeat less function calls for the optimization.

v1 -> v2:
- Added shift copy
- Separated patches for readability of changes in assembler
- Using perf results

[1] https://lkml.org/lkml/2021/2/16/778

Akira Tsukamoto (5):
   riscv: __asm_to/copy_from_user: delete existing code
   riscv: __asm_to/copy_from_user: Adding byte copy first
   riscv: __asm_to/copy_from_user: Copy until dst is aligned address
   riscv: __asm_to/copy_from_user: Bulk copy while shifting misaligned
     data
   riscv: __asm_to/copy_from_user: Bulk copy when both src dst are
     aligned

  arch/riscv/lib/uaccess.S | 181 +++++++++++++++++++++++++++++++--------
  1 file changed, 146 insertions(+), 35 deletions(-)

-- 
2.17.1

