Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8628C368BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbhDWDtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWDs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:48:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDA9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:48:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c3so14413009pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+ntpVuO8X+igpPibq9Gc+rNStHJCK1DeGnF4sSyHqys=;
        b=q+8tLAClXdoKZoxwH6aoS8dhA2mAeIiEAz7jxIDqN0n9qnE03NAy3X0j1MrEkrgCTN
         HcSUZKyKOYTMLFzO7PBxcrdMLSXwhozbg3PmqMP4lHT8uCS1AdwGK6GdkQzlUC3wFHNv
         OK6FzK79xQOJ6Gxtx17C8RKo24JbajOBtUoLslGTSNmwaD+QGQBULbQVvimxv83x2W1R
         rVlvBcawqR8zMjVh5HAZhN2kBVsbRfiTLeJ/FWozXbFuIqEfrEoIjzIBQyk0+gkUPMbS
         S/GPgWLDL5Z+PvJrVxHdku9Hi8HTzuRTpy4nBlNJZZQpcZn/cJftbs4j+ZU+w+hTEbvF
         FNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+ntpVuO8X+igpPibq9Gc+rNStHJCK1DeGnF4sSyHqys=;
        b=cVYS6CEq85s4r4ZpGsnfd5VIjVl6Jfxtlcclnb6WVkVc9XzekrDIIykuAs8cxk0UHI
         tMckVNb0CLOcWoOat9rH7tFEamvK09PB4PV2n+D/bi50huzvweCaKa1+dADZAL5aPMCo
         s816WwVrRJHI3+gMBgLDZzCzOM8L1u1oAbStHIR57eQMbG8WMrXBS6aelxuLrwNBzlJK
         uWDbAy0DBwI2++1IQBrxhiY71JcXvEpUzWZuJerC65Hm/kR0TGiyootOaesp1UfCKekr
         3plp68+r0fEKX64gFcTKm9ROGmy7Lq3aptqH0iKLAsU1pz0Gxtyxm+DpcZHWFwvWb6k4
         PxuQ==
X-Gm-Message-State: AOAM531GHG0aNesZ9W6x0ymFeJnUnNI5FLDc4yvohXj9M+3n8trI1A+R
        HTuRXSwDMFUWa3J798yHKx0lEw==
X-Google-Smtp-Source: ABdhPJy+LWkhzAtNZnx/H+Ie1yN35G2kCRwKnOPrL35GhAul1IUChWItJHtRTzAuC7QT3ZwbD5SXbw==
X-Received: by 2002:a62:1b50:0:b029:257:da1e:837f with SMTP id b77-20020a621b500000b0290257da1e837fmr1756576pfb.57.1619149702227;
        Thu, 22 Apr 2021 20:48:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id kk9sm3416763pjb.23.2021.04.22.20.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 20:48:21 -0700 (PDT)
Date:   Thu, 22 Apr 2021 20:48:21 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 20:48:20 PDT (-0700)
Subject:     Re: [PATCH v3 0/5] RISC-V: Add kexec/kdump support
In-Reply-To: <0ce30336b7dfaaf14a20e72e990d70f5@mailhost.ics.forth.gr>
CC:     mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Message-ID: <mhng-c073ca02-d152-4ef5-86c5-4bcf58154afc@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 20:36:56 PDT (-0700), mick@ics.forth.gr wrote:
> Στις 2021-04-23 06:30, Palmer Dabbelt έγραψε:
>> On Mon, 05 Apr 2021 01:57:07 PDT (-0700), mick@ics.forth.gr wrote:
>>> This patch series adds kexec/kdump and crash kernel
>>> support on RISC-V. For testing the patches a patched
>>> version of kexec-tools is needed (still a work in
>>> progress) which can be found at:
>>>
>>> https://riscv.ics.forth.gr/kexec-tools-patched.tar.xz
>>>
>>> v3:
>>>  * Rebase on newer kernel tree
>>>  * Minor cleanups
>>>  * Split UAPI changes to a separate patch
>>>  * Improve / cleanup init_resources
>>>  * Resolve Palmer's comments
>>>
>>> v2:
>>>  * Rebase on newer kernel tree
>>>  * Minor cleanups
>>>  * Properly populate the ioresources tre, so that it
>>>    can be used later on for implementing strict /dev/mem
>>>  * Use linux,usable-memory on /memory instead of a new binding
>>>  * USe a reserved-memory node for ELF core header
>>>
>>> Nick Kossifidis (5):
>>>   RISC-V: Add EM_RISCV to kexec UAPI header
>>>   RISC-V: Add kexec support
>>>   RISC-V: Improve init_resources
>>>   RISC-V: Add kdump support
>>>   RISC-V: Add crash kernel support
>>>
>>>  arch/riscv/Kconfig                  |  25 ++++
>>>  arch/riscv/include/asm/elf.h        |   6 +
>>>  arch/riscv/include/asm/kexec.h      |  54 +++++++
>>>  arch/riscv/kernel/Makefile          |   6 +
>>>  arch/riscv/kernel/crash_dump.c      |  46 ++++++
>>>  arch/riscv/kernel/crash_save_regs.S |  56 +++++++
>>>  arch/riscv/kernel/kexec_relocate.S  | 222
>>> ++++++++++++++++++++++++++++
>>>  arch/riscv/kernel/machine_kexec.c   | 193 ++++++++++++++++++++++++
>>>  arch/riscv/kernel/setup.c           | 113 ++++++++------
>>>  arch/riscv/mm/init.c                | 110 ++++++++++++++
>>>  include/uapi/linux/kexec.h          |   1 +
>>>  11 files changed, 787 insertions(+), 45 deletions(-)
>>>  create mode 100644 arch/riscv/include/asm/kexec.h
>>>  create mode 100644 arch/riscv/kernel/crash_dump.c
>>>  create mode 100644 arch/riscv/kernel/crash_save_regs.S
>>>  create mode 100644 arch/riscv/kernel/kexec_relocate.S
>>>  create mode 100644 arch/riscv/kernel/machine_kexec.c
>>
>> Thanks.  There were some minor issues and some merge conflicts, I put
>> this on for-next with some fixups.
>
> I've sent a v4 that shouldn't have merge conflicts, addressing some
> comments from Alex as well, could you use that instead or is it too late
> ?

Thanks, for some reason I didn't see it when poking around.  There was 
still that one init_resources() merge conflict and I fixed up some of 
the commit texts, it's now on for-next as

b94394119804 (HEAD -> for-next, riscv/for-next) RISC-V: Add crash kernel support
6e8451782c90 RISC-V: Add kdump support
0a0652429bdb RISC-V: Improve init_resources()
d9a8897d6b5d RISC-V: Add kexec support
f59938095b94 RISC-V: Add EM_RISCV to kexec UAPI header
