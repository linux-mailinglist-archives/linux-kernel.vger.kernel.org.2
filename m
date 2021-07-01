Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B47E3B8D76
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhGAFo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 01:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhGAFoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 01:44:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319ECC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:42:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b14-20020a17090a7aceb029017261c7d206so171164pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TucwKz+v5DlXjwmmM09NetwoftkA7mGQQBXI3b6dl+k=;
        b=Kkm76Z2lV470qVfLtyiUDLmtQKzei2APSV0thxaZrOKiSAhzdzTDzpgblm5sGDRt3o
         CI0hm8v6tY+7Jwvw6YFPRuQkyFM7maNMPlsDY4yqNsxpYMF/3w00QiIIJwbfPgMw4nXR
         RGR+pbYdqeDcqI2vrI9z4XObeIbcXeiEUKM9FSnglLqKSCXHvFN/X1E87Nj5miGh7VSC
         8VFlUCRFgmJxzQfd0W+UDSnDD7k5PQEoqBO06dk2hXrFloh7Dln7zT80qolzcOe1i5tB
         RAbGrCCLfXhbUoDygscLB4ChVwqCH3BcGyMJElvunlqbOA3Y+lKVfG67OhDae1qtRUlg
         SW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TucwKz+v5DlXjwmmM09NetwoftkA7mGQQBXI3b6dl+k=;
        b=VANbjmo0VsAWYec4XTFJJLy9PglAPXQK0UwH8hNub+EsJ+8e42ehcF3q3Jgmj63/2D
         pSiG1rrvmu/FabC3dzSugi2Ps0nTJ8bYYnTsm0zDYj31V4Wk0dQmgPZkSxrdWgez63iX
         pAEMngMEdowYZcJgtZPsGtsxovbqC1er7yvuDlC5++PADU79tjgLEragTwgQGgDH16SB
         qrt0wphCovuh1RSYfo0JtAr9GxGMEbV+zTCvepsQLObJOyBzsRAeW2hESl6NTIMu/p19
         MLxgXcr5mwSYv0YowB59UXLYvajgBFWbuvxA5a2Xn0pUxHJPuptonlr+FlANDwBM+R2M
         FXRA==
X-Gm-Message-State: AOAM532PgpySJcWHAGUDNiX9eQ8Jn9bwsjVtS3kSjxLZWCA1qp/WTCaY
        XVLGmb5n7lQKZjPYeKOJe5UWNQ==
X-Google-Smtp-Source: ABdhPJzFry+rk3YDXS83UNhrZJ0tdLKvFcOJCxCk7WjA8qJLoODDQpCXWaDL9EydHVYOHi7ol68qhQ==
X-Received: by 2002:a17:902:988f:b029:114:12d2:d548 with SMTP id s15-20020a170902988fb029011412d2d548mr35586726plp.73.1625118144478;
        Wed, 30 Jun 2021 22:42:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m4sm8383520pjv.41.2021.06.30.22.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 22:42:24 -0700 (PDT)
Date:   Wed, 30 Jun 2021 22:42:24 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Jun 2021 22:42:22 PDT (-0700)
Subject:     Re: [PATCH v6 0/3] Introduce 64b relocatable kernel
In-Reply-To: <8512c6b0-3dff-5485-b5d8-638044594973@ghiti.fr>
CC:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-dd5e2fdf-d349-4114-9cbf-6041e2cd2b27@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 06:33:48 PDT (-0700), alex@ghiti.fr wrote:
> Le 18/05/2021 à 12:12, Alexandre Ghiti a écrit :
>> After multiple attempts, this patchset is now based on the fact that the
>> 64b kernel mapping was moved outside the linear mapping.
>>
>> The first patch allows to build relocatable kernels but is not selected
>> by default. That patch should ease KASLR implementation a lot.
>> The second and third patches take advantage of an already existing powerpc
>> script that checks relocations at compile-time, and uses it for riscv.
>
> @Palmer, any thought about that? There are no users for now, do you want
> to wait for a KASLR implementation to use it before merging this? If so,
> I can work on a KASLR implementation based on older implementation from
> Zong.

Sorry, I must have missed this patch set the first time through.  I 
don't see any reason to wait for KASLR before taking support for 
relocatable kernels, as relocatable kernelsa are useful on their own.

I'm not sure I'll have time to look at this for this cycle, but I'll try 
to find some time to given that it was posted a while ago.

>
> Thanks,
>
>>
>> This patchset was tested on:
>>
>> * kernel:
>> - rv32: OK
>> - rv64 with RELOCATABLE: OK and checked that "suspicious" relocations are caught.
>> - rv64 without RELOCATABLE: OK
>> - powerpc: build only and checked that "suspicious" relocations are caught.
>>
>> * xipkernel:
>> - rv32: build only
>> - rv64: OK
>>
>> * nommukernel:
>> - rv64: build only
>>
>> Changes in v6:
>>    * Remove the kernel move to vmalloc zone
>>    * Rebased on top of for-next
>>    * Remove relocatable property from 32b kernel as the kernel is mapped in
>>      the linear mapping and would then need to be copied physically too
>>    * CONFIG_RELOCATABLE depends on !XIP_KERNEL
>>    * Remove Reviewed-by from first patch as it changed a bit
>>
>> Changes in v5:
>>    * Add "static __init" to create_kernel_page_table function as reported by
>>      Kbuild test robot
>>    * Add reviewed-by from Zong
>>    * Rebase onto v5.7
>>
>> Changes in v4:
>>    * Fix BPF region that overlapped with kernel's as suggested by Zong
>>    * Fix end of module region that could be larger than 2GB as suggested by Zong
>>    * Fix the size of the vm area reserved for the kernel as we could lose
>>      PMD_SIZE if the size was already aligned on PMD_SIZE
>>    * Split compile time relocations check patch into 2 patches as suggested by Anup
>>    * Applied Reviewed-by from Zong and Anup
>>
>> Changes in v3:
>>    * Move kernel mapping to vmalloc
>>
>> Changes in v2:
>>    * Make RELOCATABLE depend on MMU as suggested by Anup
>>    * Rename kernel_load_addr into kernel_virt_addr as suggested by Anup
>>    * Use __pa_symbol instead of __pa, as suggested by Zong
>>    * Rebased on top of v5.6-rc3
>>    * Tested with sv48 patchset
>>    * Add Reviewed/Tested-by from Zong and Anup
>>
>> Alexandre Ghiti (3):
>>    riscv: Introduce CONFIG_RELOCATABLE
>>    powerpc: Move script to check relocations at compile time in scripts/
>>    riscv: Check relocations at compile time
>>
>>   arch/powerpc/tools/relocs_check.sh | 18 ++--------
>>   arch/riscv/Kconfig                 | 12 +++++++
>>   arch/riscv/Makefile                |  5 ++-
>>   arch/riscv/Makefile.postlink       | 36 ++++++++++++++++++++
>>   arch/riscv/kernel/vmlinux.lds.S    |  6 ++++
>>   arch/riscv/mm/Makefile             |  4 +++
>>   arch/riscv/mm/init.c               | 53 +++++++++++++++++++++++++++++-
>>   arch/riscv/tools/relocs_check.sh   | 26 +++++++++++++++
>>   scripts/relocs_check.sh            | 20 +++++++++++
>>   9 files changed, 162 insertions(+), 18 deletions(-)
>>   create mode 100644 arch/riscv/Makefile.postlink
>>   create mode 100755 arch/riscv/tools/relocs_check.sh
>>   create mode 100755 scripts/relocs_check.sh
>>
