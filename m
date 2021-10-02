Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD02441FE02
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 22:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhJBU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 16:26:18 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFBBC061714
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 13:24:32 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id h132so5948131vke.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gheH1BWtvHm1zTSupgo4rpDcUcxXI3Gdklert++eNsE=;
        b=Qa5Fk+e0vrtXkpOlqgyKxq9fdCMqo2B9CVY8g4xw7CN3+f1sv7VpByX12vgNLSEkYt
         e0qW07WfIqE+PQLA2tb1lsvi5Emkth88DaatRRfI+0JDpyz+LKZU9YkmIAfS6u2Ct5I0
         o5UzeZeCjokrD8ANPCj14YWRBINOBLp8dhL7Fo7qvuea95i0Lb1wXmMaspGZLK4/HZYz
         nSI7uVkR4DNtw2ErK9QV467TW/+FqXxj61z1OEt3Yw2lSlb/eR7par4ZLCRYfJQ/kbBQ
         aVTrNoAX4PeXXFe10lI3ek9eVZ3Nq77JB1Wns7fizh1MO4r9C40W1s2CByAeUbx7UcZA
         Hb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gheH1BWtvHm1zTSupgo4rpDcUcxXI3Gdklert++eNsE=;
        b=1CKYDGhWiSNIEeX7McL00n9LV7EQv+abln8tY6ZWKgszcNXhhzfRgH4ksMTN1jefP/
         8W7qGbFDwNfYzfqk2gdQHozN2N5ZW5bat6Q9r6qzvgQz/4hMm2A+MTNFcxIVpCMqhX2P
         EFJ0AkPGPCBcpVD8GpRsG5bj+P6XU3mpMZRsFYUGSM53FnXM6xeR0oISoij7Fcpv3Lak
         Msu0TPa2Ba/+1LvbS4udpBXBe20iXQXwmg+P5S2hyVnsZXj+WpulCpBgzTpoBwW/WFQy
         4FOxht9adbDPLTCjgvooWCpjjGiolvY+ddzduhdmpNbao680K+oBOgJnG+BleAfJI31u
         VfKw==
X-Gm-Message-State: AOAM5335ZLE6S5rC4NMUMmFuTsisJYIT0j4k1qLmYrQHdo0XZwthcIir
        SOlsLgUaOkyMmRC25zZbx4qL5Q==
X-Google-Smtp-Source: ABdhPJzNTve39xRVt8rmHnTobccKXQkEqcHACW9GMv/Nc5OpzbK2tJq3gt3Ap7dd1/3x+FlUW3L+sA==
X-Received: by 2002:a1f:388e:: with SMTP id f136mr11173001vka.12.1633206271300;
        Sat, 02 Oct 2021 13:24:31 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e21sm4583394vsh.4.2021.10.02.13.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:24:30 -0700 (PDT)
Date:   Sat, 02 Oct 2021 13:24:30 -0700 (PDT)
X-Google-Original-Date: Sat, 02 Oct 2021 13:24:25 PDT (-0700)
Subject:     Re: [PATCH -next v3 0/3] riscv: Fix two vdso issue
In-Reply-To: <20210901024621.2528797-1-tongtiangen@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        abdulras@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tongtiangen@huawei.com
Message-ID: <mhng-62e741b1-d0a2-4c88-a2df-785f061924c9@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 19:46:18 PDT (-0700), tongtiangen@huawei.com wrote:
> v3->v2:
>   Adapt to the latest code.
>
> v2->v1:
>   Add patch "Refactor asm/vdso.h" to avoid vdso.lds syntax error if
>   CONFIG_GENERIC_TIME_VSYSCALL=n.
>
> 1) Move vdso data page up front and introduce enum vvar_pages, This makes it
> easier to introduce new feature TIME_NS.
>
> 2) In arch_setup_additional_pages(), make Wait for the lock in the killable mode
> and return with EINTR if the task got killed while waiting.
>
> Tong Tiangen (3):
>   riscv/vdso: Refactor asm/vdso.h
>   riscv/vdso: Move vdso data page up front
>   riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for
>     write killable
>
>  arch/riscv/include/asm/syscall.h  |  1 +
>  arch/riscv/include/asm/vdso.h     | 15 ++++-----
>  arch/riscv/kernel/syscall_table.c |  1 -
>  arch/riscv/kernel/vdso.c          | 53 +++++++++++++++++++------------
>  arch/riscv/kernel/vdso/vdso.lds.S |  3 +-
>  5 files changed, 42 insertions(+), 31 deletions(-)

Sorry, I thought this was targeted at for-next.  I've put this on fixes 
(not sure if my last copy went out, my mail client crashed).
