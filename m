Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE94A39B63E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFDJzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:55:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E7C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 02:53:45 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a15so6590003qta.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FlfOt5ZHd9jswm+VbsyTDC9ioUME0yS40PkkEczf0Y0=;
        b=Je2OMatfku272SCys5wuDeevnAQuoLeZkgdAbEr/5K4pXTiED5RWjXXFR6ASBJkcga
         4RfBcqtAd0IEbQ0zMUoqZrkmh//WGaFOMBQ69RV54tQfjUQ2j7cYRWC2ty4gvYeARXNM
         zOFzgoQG7/yDFnrzF1kCUkEX42wG+jzUP752BWL+iisTJItJC/DFS5OD8Un3gsKexafi
         6MFnmuN9Yie17X2YSDJqir774ETG2ESiWC7iDaZa5C/b7KGdcQLhkfjgol4vJQgDSeXw
         hsiEnsAZihm4EUozsqqAo/CY41FQHSd1FraBTNt8/kTl4L4+alMm2Aci7LVS+YZFPtAA
         o5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FlfOt5ZHd9jswm+VbsyTDC9ioUME0yS40PkkEczf0Y0=;
        b=by72XsVBSuf74TKkMG7qTadywHpChbgNEA/TC79TWjtrevnBraiSCLcdPLXfR/AoVC
         M+lleXPIESoS/w7t2723+B9/MB6+Al0sAqdRecIbPyNcfgtaC3xBKhtPCCEHCoB3Ayrn
         Q/rwDEWN5NRBMvcqh1fLHHA6H2V2uYJlTLeWDskuNZ7/G7T4PKdK6JjK78mu4gDi1zBx
         YPgSeCrOg/8oYaE7YVlkqFk8khwjLKp8Ccfl9UIkjwl1seOHoaoYBZj1gkWYacSYzaMJ
         9R81wM54xgmCJ1fVlTAgL2rrlAKbDbdfWzl5tLSxT3gQ12TSVl7C1n4FpO5gmChUmc2Y
         JOlw==
X-Gm-Message-State: AOAM5339ePn+CuUOFbYQAnfoVMaQQzZqzXaGDLThDjyyPvOzFdFkQ5F2
        D34cm5DFx222Ipno9a3FS2DQo3HJPIain+e9j4c=
X-Google-Smtp-Source: ABdhPJwVwznMNJLi7K3cb0oL7/O0blrCBHqQbUVLtyL8W6808bqa4dS7SJcbZZti9fTrimhgectolbRglfaKv4KR5Ww=
X-Received: by 2002:ac8:5313:: with SMTP id t19mr3898290qtn.190.1622800424625;
 Fri, 04 Jun 2021 02:53:44 -0700 (PDT)
MIME-Version: 1.0
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Date:   Fri, 4 Jun 2021 18:53:33 +0900
Message-ID: <CACuRN0NjftJDUAsF2pkXbx0jnJ=bba9+j-hJA8Mjj0r4RVicLA@mail.gmail.com>
Subject: [PATCH 0/1] riscv: better network performance with memcpy, uaccess
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Nick Hu <nickhu@andestech.com>,
        Nylon Chen <nylon7@andestech.com>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        linux-riscv@lists.infradead.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am adding a cover letter to explain the history and details since
improvement is a combination with Gary's memcpy patch [1].

Comparison of iperf3 benchmark results by applying Gary's memcpy patch and
my uaccess optimization patch. All results are from the same base kernel,
same rootfs and save BeagleV beta board.

First left column : beaglev 5.13.rc4 kernel [2]
Second column     : Added Palmer's memcpy in C + my uaccess patch [3]
Third column      : Added Gary's memcpy + my uaccess patch [4]

--- TCP recv ---
686 Mbits/sec  |  700 Mbits/sec  |  904 Mbits/sec
683 Mbits/sec  |  701 Mbits/sec  |  898 Mbits/sec
695 Mbits/sec  |  702 Mbits/sec  |  905 Mbits/sec

--- TCP send ---
383 Mbits/sec  |  390 Mbits/sec  |  393 Mbits/sec
384 Mbits/sec  |  393 Mbits/sec  |  392 Mbits/sec

--- UDP send ---
307 Mbits/sec  |  358 Mbits/sec  |  402 Mbits/sec
307 Mbits/sec  |  359 Mbits/sec  |  402 Mbits/sec

--- UDP recv ---
630 Mbits/sec  |  799 Mbits/sec  |  875 Mbits/sec
730 Mbits/sec  |  796 Mbits/sec  |  873 Mbits/sec


The uaccess patch is reducing pipeline stall of read after write (RAW)
by unroling load and store.
The main reason for using assembler inside uaccess.S is because the
__asm_to/copy_from_user() handling page fault must be done manually inside
the functions.

The above result is combination from Gary $B!G (Bs memcpy speeding up
by reducing
the S-mode and M-mode switching and my uaccess reducing pipeline stall for
user space uses syscall with large data.

We had a discussion of improving network performance on the BeagleV beta
board with Palmer.

Palmer suggested to use C-based string routines, which checks the unaligned
address and use 8 bytes aligned copy if the both src and dest are aligned
and if not use the current copy function.

The Gary's assembly version of memcpy is improving by not using unaligned
access in 64 bit boundary, uses shifting it after reading with offset of
aligned access, because every misaligned access is trapped and switches to
opensbi in M-mode. The main speed up is coming from avoiding S-mode (kernel)
and M-mode (opensbi) switching.

Processing network packets require a lot of unaligned access for the packet
header, which is not able to change the design of the header format to be
aligned.
And user applications pass large packet data with send/recf() and sendto/
recvfrom() to repeat less function calls for reading and writing data for the
optimization.

Akira

[1] https://lkml.org/lkml/2021/2/16/778
[2] https://github.com/mcd500/linux-jh7100/tree/starlight-sdimproved
[3] https://github.com/mcd500/linux-jh7100/tree/starlight-sd-palmer-string
[4] https://github.com/mcd500/linux-jh7100/tree/starlight-sd-gary

Akira Tsukamoto (1):
  riscv: prevent pipeline stall in __asm_to/copy_from_user

 arch/riscv/lib/uaccess.S | 106 +++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 33 deletions(-)

--
2.17.1
