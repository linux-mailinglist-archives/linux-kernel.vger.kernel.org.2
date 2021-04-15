Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330AD3601E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhDOFrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhDOFrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:47:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AD0C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 22:46:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d8so11426949plh.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 22:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=odtA6/PSChT0uGFQNTrylzoG32yU7iwO1L8rlXDU+Kg=;
        b=wVat44suuVOOiYBcJdrS4W77UzKRozTS87Zbdly9Fe7wjrxxiaw8MN9zgK5yBbOqGI
         hAUlPf8o2wRZaAiZUKRpqSmw9qSP543AO+x8r5aVZ5xG8F6kMcpJFqhK4/S5GyPTSnSw
         CoGJy7SN60HrFIrj0erSQvRRX/vImpKlIgc+y5TFPa0kjXC+WuYP6p/zYWQ+aspYjCjt
         z0uk0tqbjks/GjmVtTwUh8gyZ6XOCuIEBb0UkE0H1gICsNGIAPdtv82XhmqY733DCuYx
         ByQO00TvBCsatGAzdCQ5JPpgGbADbXCE2mhrHicuGVSOCGCaE0j8AqqFmkDVA362Eqhj
         BHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=odtA6/PSChT0uGFQNTrylzoG32yU7iwO1L8rlXDU+Kg=;
        b=PMzUZt3WNsRN4uslbYx2JR0fG11vs6SWVog+L1aSTsdWRnXwoAhD07mO/KXCzAi1um
         Xj1MQOtEadJ7kuaFqotlowszfpMzlmfFzHspE8BaiKJCAF2TezD13NAkxdYThThTj6yD
         5T5cENYmvHtpwyoxBfRzfPKDglCKeYFXpgHwrfhFjOwLfwnuSJ4Y8Qa8H738jEFNXxCV
         nqn+KofgR8K1odJyEFCflJO6UdedkiecLY2aDjDV3F9isoA6fwklKUpp8Zy3wZteuwVE
         GUfZQkp3Y+f0sfZILT/iLynD9oGKTr8cN0OT9ttHGYJoOwSWcfCVmhHFC0ylgEZJh4G0
         8HPw==
X-Gm-Message-State: AOAM533zATkaTfO4B/rZ6neANb366N3HENnVWIr+6MBEU4MTBW2udW1M
        hB0swPWRrHppU3jcl59p9vH4iw==
X-Google-Smtp-Source: ABdhPJzKHnsrQ8HiVMdQ2cja6QFAJ2/GpULn8bWVER7rZ1/afC5lqauqcQkkWfrNoXcy7Q6iVr9YFQ==
X-Received: by 2002:a17:90b:389:: with SMTP id ga9mr1921481pjb.195.1618465597193;
        Wed, 14 Apr 2021 22:46:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e190sm984165pfe.3.2021.04.14.22.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 22:46:36 -0700 (PDT)
Date:   Wed, 14 Apr 2021 22:46:36 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Apr 2021 22:46:34 PDT (-0700)
Subject:     Re: [PATCH v2 0/2] Fix binfmt_flat loader for RISC-V
In-Reply-To: <BL0PR04MB65148D80C819A7E3B8365242E74D9@BL0PR04MB6514.namprd04.prod.outlook.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jcmvbkbc@gmail.com, gerg@linux-m68k.org,
        Anup Patel <Anup.Patel@wdc.com>, Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, viro@zeniv.linux.org.uk
Message-ID: <mhng-61cff5f4-32a0-417d-9a2f-eb6d052cf802@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 17:32:10 PDT (-0700), Damien Le Moal wrote:
>> On 2021/04/08 0:49, Damien Le Moal wrote:
>> RISC-V NOMMU flat binaries cannot tolerate a gap between the text and
>> data section as the toolchain fully resolves at compile time the PC
>> relative global pointer (__global_pointer$ value loaded in gp register).
>> Without a relocation entry provided, the flat bin loader cannot fix the
>> value if a gap is introduced and executables fail to run.
>> 
>> This series fixes this problem by allowing an architecture to request
>> the flat loader to suppress the gap between the text and data sections.
>> The first patch fixes binfmt_flat flat_load_file() using the new
>> configuration option CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP. The second
>> patch enables this option for RISCV NOMMU builds.
>> 
>> These patches do not change the binfmt_flat loader behavior for other
>> architectures.
>> 
>> Changes from v1:
>> * Replace FLAT_TEXT_DATA_NO_GAP macro with
>>   CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP config option (patch 1).
>> * Remove the addition of riscv/include/asm/flat.h and set
>>   CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP for RISCV and !MMU
>> 
>> Damien Le Moal (2):
>>   binfmt_flat: allow not offsetting data start
>>   riscv: Disable text-data gap in flat binaries
>> 
>>  arch/riscv/Kconfig |  1 +
>>  fs/Kconfig.binfmt  |  3 +++
>>  fs/binfmt_flat.c   | 21 +++++++++++++++------
>>  3 files changed, 19 insertions(+), 6 deletions(-)
>> 
>
> Ping ?
>
> Any comment on these patches ?
>
> Without them, RISC-V NOMMU user space does not run... I would really like to get
> these in this cycle if possible.

This LGTM, but it's pretty far out of my area of expertise.  I'm happy 
to take them via my tree, but I'd prefer to get an Ack from someone.

Al, get_maintainer suggests you?

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
