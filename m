Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AC0456ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 08:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhKSHOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 02:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhKSHOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:14:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AABC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 23:11:00 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 206so2835132pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 23:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yc23194KjB+LQokKRPaiWSmxOLe3qSzA7p0t2/5nyw8=;
        b=28w1Ed8HMNqLh14pOZq36vMrE4impBd2S5s88c1708Rt3qNLFxA9LH+1dT3fZx2Ejv
         QHbynFpxbZ6S3biCryrgvk8QAodoWlh/X/htAO79oUbjsIw4OP/REP2p7eDOs2CN+r+X
         URgUc4W9nSlMmZl4lJmXBdJaxKyjl2a2CRbMayUYurvieU0ZqG4S3MZ9sqet8kUQBC7I
         QTMUHEI0RC91MFYUNhOp2aPOYFA7a3W7Akhp4B5f5Iu/Z+xoJvi1y1g4Y45api8IohDX
         9DHmJLUDmnacRGuAT3VtEokGN95d0ddzK3dq0k/xVwUV+pS1nxNGXsnYvQmtx8w/vS95
         e/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yc23194KjB+LQokKRPaiWSmxOLe3qSzA7p0t2/5nyw8=;
        b=fzWQ0PcZ9EKySF6uuDVZMksj34s5XgipfC5qiyS0Oe9vC4Xtfy2u/6zasHr7yWM1qp
         an14Y2Pb88SKI1LwTNmyVwFv8k7EyNORzjz2kaxW/ciLr3Iys/RWU1MDRPW/T+27/Hpa
         cXbhlRho82c/I7mpu9Yzgu33IElX1YPjDKZDW7eln5NCpRwWbQgzcnPRt0FPE+WyRfid
         7pQv6qCXeRLen82qR+ibCkiShtmsPossEf96i4hpmkkE07SQhNmgwxX7OerK2YS4hSBM
         4O7bup2shNcuQySdz3y+Qukfxp0H7mWiYOfIgmCBSjDj1JW7ogV0RfbDWXCkCY3RYYM3
         sK/w==
X-Gm-Message-State: AOAM531aEsGwOJ+cHRMpQAdUagcdvN596FtWUsotHlQLp0AYrfN8a8z5
        9FfKNcJRTe1DFBvTaj+tOyoObA==
X-Google-Smtp-Source: ABdhPJy6ryy8jv007aCo8Sr8vrylP8cE+uuZGWUeT1h8S8piRNU3wWOC6MG3OlpeFbCIhzBm10gDxw==
X-Received: by 2002:a63:7d04:: with SMTP id y4mr15781419pgc.131.1637305859339;
        Thu, 18 Nov 2021 23:10:59 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d2sm1725774pfu.203.2021.11.18.23.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:10:58 -0800 (PST)
Date:   Thu, 18 Nov 2021 23:10:58 -0800 (PST)
X-Google-Original-Date: Thu, 18 Nov 2021 22:17:19 PST (-0800)
Subject:     Re: [PATCH v2] RISC-V: Enable KVM in RV64 and RV32 defconfigs as a module
In-Reply-To: <CAOnJCULQJj0ZyyF+Q1cogXsC9GDQKLTms8vHvNNpj4aHntmx6w@mail.gmail.com>
CC:     anup.patel@wdc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, pbonzini@redhat.com, anup@brainfault.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-d3ecff31-cbc9-414f-b235-faaac49224f9@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 23:53:59 PST (-0800), atishp@atishpatra.org wrote:
> On Wed, Nov 17, 2021 at 12:47 AM Anup Patel <anup.patel@wdc.com> wrote:
>>
>> Let's enable KVM RISC-V in RV64 and RV32 defconfigs as module
>> so that it always built along with the default kernel image.
>>
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> ---
>> Changes since v1:
>>  - Rebased on Linux-5.16-rc1
>>  - Removed unwanted stuff from defconfig PATCH1
>>  - Dropped PATCH2 and PATCH3 since these are already merged via KVM tree
>> ---
>>  arch/riscv/configs/defconfig      | 2 ++
>>  arch/riscv/configs/rv32_defconfig | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>> index c252fd5706d2..ef473e2f503b 100644
>> --- a/arch/riscv/configs/defconfig
>> +++ b/arch/riscv/configs/defconfig
>> @@ -19,6 +19,8 @@ CONFIG_SOC_VIRT=y
>>  CONFIG_SOC_MICROCHIP_POLARFIRE=y
>>  CONFIG_SMP=y
>>  CONFIG_HOTPLUG_CPU=y
>> +CONFIG_VIRTUALIZATION=y
>> +CONFIG_KVM=m
>>  CONFIG_JUMP_LABEL=y
>>  CONFIG_MODULES=y
>>  CONFIG_MODULE_UNLOAD=y
>> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
>> index 434ef5b64599..6e9f12ff968a 100644
>> --- a/arch/riscv/configs/rv32_defconfig
>> +++ b/arch/riscv/configs/rv32_defconfig
>> @@ -19,6 +19,8 @@ CONFIG_SOC_VIRT=y
>>  CONFIG_ARCH_RV32I=y
>>  CONFIG_SMP=y
>>  CONFIG_HOTPLUG_CPU=y
>> +CONFIG_VIRTUALIZATION=y
>> +CONFIG_KVM=m
>>  CONFIG_JUMP_LABEL=y
>>  CONFIG_MODULES=y
>>  CONFIG_MODULE_UNLOAD=y
>> --
>> 2.25.1
>>
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

I was actually just about to send a defconfig cleanup patch set.  My 
tests are all still a bit broken, so I'm going to hold off on sending 
the defconfig cleanups until I can get them back together.  This is so 
simple that anything it could break would already be broken, so I'm just 
going to take it now.

This is on fixes.

Thanks!
