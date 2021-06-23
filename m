Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A213B1A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFWMkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFWMjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:39:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3E2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:37:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so3793512pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=U04a5tKuI2TL7VWt3DNjqjVOlpJsLXPvw3dwHbV38YU=;
        b=QRKbOJAQOGptx6D4nH4buhWTbi4uyjuVaH4qly/uJCKsR5qlLn05eUzoTgEVDNOsYx
         piPr7B8KGzG6M4W3azpDMIf9UZq66UMYq6EtUmiMy8UAomodk/yc7lyJzkR9EVgWZ2+l
         Hdpj67YrSEapItSG0jMcGugfinzbZtIjPPIQnHmUM5kAgasf2lz8DS3M4jUYvLKgGExX
         qPmgi7jF8rronEqhU0X/X/N0StT13RGR4Y22aB9/RV44rqIfhyv2EubmNvG5n20Y+hGQ
         s82pjgZb2zPh8dvy/gBcvLHvxjXuDvDqINsYgOo+1wgrUYWb+Z2upPr2EJwAi1A2wZj1
         OijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=U04a5tKuI2TL7VWt3DNjqjVOlpJsLXPvw3dwHbV38YU=;
        b=p94jkdczF5QhqMeeZ0uGbJAOAeCCAvvxYsgw0nm/9Yx8QZzQ78VsykwNK2XuKPul0S
         u6xwonMj7ur8LS6TQJwN9YPwfJS59NIgATXK/DguzB2wD77/D2l6zo1Ht1YjKIhVslTe
         F1wMZPmpZghQUJjVJdLdZIxHmHcLK+LKolNg8hVuijJgdS5P7D/x00A6ir+qyEElgWa8
         GXhlmoPNT7/541KtC+VeMWk0p4qbz6yI0TH05c941zUxIlZSxlaQQBZAYNk83yvGXW+9
         mrZHIqAGW9+WiQuXRcgXUv91tIPzcT4M5eD+m9aj2k4G1vQke9CVAkW4zZXcsDUdqLlq
         S1Ng==
X-Gm-Message-State: AOAM531gVBmf2xr+RniENd7vLvhVBgdTG1rf/s0E7BxIVl7Sypsqib4d
        PqB9dr84Bi7N+JE9nPCwhIdby/jtI2Gqd6QA
X-Google-Smtp-Source: ABdhPJw8J8V65q0vN9d5Dfise1pt+61c3pFshmQCSeBDrD1wE6zL4lAbzDt8PDJ2TudwXgGaZBs2Eg==
X-Received: by 2002:a17:90b:810:: with SMTP id bk16mr8750049pjb.2.1624451851537;
        Wed, 23 Jun 2021 05:37:31 -0700 (PDT)
Received: from [192.168.1.153] (163.128.178.217.shared.user.transix.jp. [217.178.128.163])
        by smtp.gmail.com with ESMTPSA id j2sm2522114pfb.53.2021.06.23.05.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 05:37:30 -0700 (PDT)
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Subject: [PATCH v3 0/1] riscv: improving uaccess with logs from network bench
Message-ID: <3e1dbea4-3b0f-de32-5447-2e23c6d4652a@gmail.com>
Date:   Wed, 23 Jun 2021 21:37:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimizing copy_to_user and copy_from_user.

I rewrote the functions but heavily influenced by Garry's memcpy
function [1]. It must be written in assembler to handle page faults
manually inside the function unlike other memcpy functions.

This patch will reduce cpu usage dramatically in kernel space especially
for applications which use sys-call with large buffer size, such as network
applications. The main reason behind this is that every unaligned memory
access will raise exceptions and switch between s-mode and m-mode causing
large overhead.

The motivation to create the patch was to improve network performance on
beaglev beta board. By observing with perf, the memcpy and
__asm_copy_to_user had heavy cpu usage and the network speed was limited
at around 680Mbps on 1Gbps lan. Matteo is creating the patches to improve
memcpy in C and this patch is meant to be used with them.

Typical network applications use system calls with a large buffer on
send/recv() and sendto/recvfrom() for the optimization.
 
The bench result, when patching only copy_user. The memcpy is without
Matteo's patches but listing the both since they are the top two largest
overhead.

All results are from the same base kernel, same rootfs and same BeagleV
beta board.

Results of iperf3 have speedup on UDP with the copy_user patch alone.

--- UDP send ---
306 Mbits/sec      362 Mbits/sec
305 Mbits/sec      362 Mbits/sec

--- UDP recv ---
772 Mbits/sec      787 Mbits/sec
773 Mbits/sec      784 Mbits/sec

Comparison by "perf top -Ue task-clock" while running iperf3.

--- TCP recv ---
 * Before
  40.40%  [kernel]  [k] memcpy
  33.09%  [kernel]  [k] __asm_copy_to_user
 * With patch
  50.35%  [kernel]  [k] memcpy
  13.76%  [kernel]  [k] __asm_copy_to_user

--- TCP send ---
 * Before
  19.96%  [kernel]  [k] memcpy
   9.84%  [kernel]  [k] __asm_copy_to_user
 * With patch
  14.27%  [kernel]  [k] memcpy
   7.37%  [kernel]  [k] __asm_copy_to_user

--- UDP recv ---
 * Before
  44.45%  [kernel]  [k] memcpy
  31.04%  [kernel]  [k] __asm_copy_to_user
 * With patch
  55.62%  [kernel]  [k] memcpy
  11.22%  [kernel]  [k] __asm_copy_to_user

--- UDP send ---
 * Before
  25.18%  [kernel]  [k] memcpy
  22.50%  [kernel]  [k] __asm_copy_to_user
 * With patch
  28.90%  [kernel]  [k] memcpy
   9.49%  [kernel]  [k] __asm_copy_to_user

---
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

 arch/riscv/lib/uaccess.S | 181 +++++++++++++++++++++++++++++++--------
 1 file changed, 146 insertions(+), 35 deletions(-)

-- 
2.17.1

