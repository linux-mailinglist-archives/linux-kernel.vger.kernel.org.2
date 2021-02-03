Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CED30D1A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhBCCfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhBCCfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:35:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A020AC061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:35:01 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t29so15674729pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fPQam4ndzft14C3DaSgN+91Ad7etOKCRLDjQjoeYJK8=;
        b=OTXg56iU1hkJ7HWuwulOElr299NtTWhlmzuxg05V7A+0w9gy8hR5UaKR/v+7dxkzjj
         +TleqnWVmTiaDeY9JuD5IfUYvbyG/Ijc6FxxDsalbeVNUtGy7JKzklUDbrkTHBS7dO+2
         We92Bw15uhSbI6UCreDJlwayqFGKbdYK4ggQrMcjTp7cr4WrZPmlD8DL3UaE+XD7bxHj
         irMFvCkINaLRA9hGsnQaV7h/Yr2C4o60VppLExRZ5ZvJxPSrJYXv7K513Vjy0cMP/KqI
         mSKetFvsNlk1fyBGXuYXphyzzrAwI8Jk3oVo+3YsvxNRHCJPKcjv6+ijPGEFHsqDE77j
         LVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fPQam4ndzft14C3DaSgN+91Ad7etOKCRLDjQjoeYJK8=;
        b=sSBC5bIZhkAVLkgwO0Rv25aPWcBJvaFngijLQclXG1ecy/AijcQCJWHMMR/bkNnJcK
         Am+3/Q7lVbXdlvIcrM2yqOt5KhkPOva0iEMj/exivm/j1Tx1RkhkOP68s+vLZAET8XAi
         jTrolOHB6gGMhTedOJ8k2WJLYfs9tixJhlScW8B0JJEns0bRVTV7cOcCg4xjciQbkUfT
         hPR++55WtOZgVbu+HK8Y8T2rPnp/UQqDgzjJ9aNqJtmCy4AaObu+ATSPX69GeosJOXBw
         jAA1z4POWgrlM4GwjtAyTztiUktGdIodWlkxIBk1ArKNk1QB8uxg/kQpwNV+5Hi2a6z5
         dl/w==
X-Gm-Message-State: AOAM530+aWimqO69VEOqCIs+wZ80PIVF89x5a7uPKBS21QbFos0OGSsB
        8tYmJ4EKWkj/7YhPFoKMm/8i+A==
X-Google-Smtp-Source: ABdhPJwwzoE5DQ65GzSvq8HYxGVwxgvuO0KnV/mVnlwlTP9TGyTJNOVC4wrBFr+Is9GPBJsZDCBQVg==
X-Received: by 2002:aa7:9402:0:b029:1c5:4e3e:11ad with SMTP id x2-20020aa794020000b02901c54e3e11admr965443pfo.15.1612319701181;
        Tue, 02 Feb 2021 18:35:01 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t206sm275715pgb.84.2021.02.02.18.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:35:00 -0800 (PST)
Date:   Tue, 02 Feb 2021 18:35:00 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 18:34:49 PST (-0800)
Subject:     Re: Kconfig-induced build errors: CONFIG_PAGE_OFFSET
In-Reply-To: <mhng-9b4a74fd-62d8-421f-8150-9147da7e39b2@penguin>
CC:     geert@linux-m68k.org, rdunlap@infradead.org,
        linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-c04f6080-f52b-441b-a4ef-65c4559046f7@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Feb 2021 18:27:42 PST (-0800), Palmer Dabbelt wrote:
> On Fri, 29 Jan 2021 05:52:51 PST (-0800), geert@linux-m68k.org wrote:
>> Hi Atish,
>>
>> On Thu, Jan 28, 2021 at 9:09 PM Atish Patra <atishp@atishpatra.org> wrote:
>>> On Wed, Jan 27, 2021 at 7:18 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>> > I took a riscv-32 .config from kernel test robot (it was for a clang build)
>>> > and did a "make olddefconfig" (using gcc tools) and got build errors
>>> > due to this config item from arch/riscv/Kconfig;
>>> >
>>> >
>>> > config PAGE_OFFSET
>>> >         hex
>>> >         default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
>>> >         default 0x80000000 if 64BIT && !MMU
>>> >         default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>>> >         default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>>> >
>>> > PAGE_OFFSET is undefined for the case of 32BIT && MAXPHYSMEM_2GB.
>>>
>>> Because, RV32 doesn't support 2GB physical memory yet.
>>>
>>> The compilation errors can be fixed by not allowing MAXPHYSMEM_2GB for RV32 and
>>> MAXPHYSMEM_1GB for RV64. How about this ?
>>>
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -253,8 +253,10 @@ choice
>>>         default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
>>>
>>>         config MAXPHYSMEM_1GB
>>> +               depends on 32BIT
>>>                 bool "1GiB"
>>>         config MAXPHYSMEM_2GB
>>> +               depends on 64BIT && CMODEL_MEDLOW
>>>                 bool "2GiB"
>>>         config MAXPHYSMEM_128GB
>>>                 depends on 64BIT && CMODEL_MEDANY
>>
>> Thanks, works fine on litex-vexriscv.
>> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Atish: did I miss an actual patch?  I just see diff here.

Never mind, I found it.  Thanks!
