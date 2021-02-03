Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32D330D18C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhBCC2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBCC2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:28:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FEBC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:27:43 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id a20so3503902pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=MIf4N24Ra3Xxgi/gfbzHMgCkQRiEtd0T6Pa2IWM5Gtk=;
        b=cHZnEnErr6ZHsS8F8ThRlcpP81DQ2KE5eG8MH3gx+QDQhOiVQNYj2CueqymCJxb8GA
         lDGGkSQMupS1ExXcsS1KXm86FMBYBukZ6NALe99uBHzeNuj72uhSVZgjHisVpJwiiKw+
         KQg+24Rdzsp3DLcWfxi2EHO3OnT/KEpIy9kRStUMSkE93RlZF5qRhaIMGEzWjyF6bGwW
         3Clf4I08mLquEtz7LRvedvE01DyC0t8RPVd11jnLcBu0PlXwW8tHsb4zHH+m/Cls7mY+
         AUr3QyBQv8s5CLwdMgn1JvqjE9ipbGkjq+avmENwpbRzFDqMcP8vejzn/P7vhuYT/42O
         59vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=MIf4N24Ra3Xxgi/gfbzHMgCkQRiEtd0T6Pa2IWM5Gtk=;
        b=FUMOAHRVws/McPBADxub/pMOcQn1VMAR3MHXZT29BuF6MuBHwUyBML+a8h5AcAVFMY
         quQwZjLAjgH18NvWcZY7IFVhKK7WqeccWkE/rLq7h0HjP2rdEf5poW9RguoaYBRP7BGC
         Qk95qYIbA/OHgEfXpAB0VT42ptPKvW7pj3kfKYMWIeZ1uHZh7mwtUvDCV1kMEFcTpcy0
         xXg3zoSy5og4/xBswtdgS9zlsizLXaD5nfpB7/L+S6iKEoO4KlchrRrHBqc2EJWbnJ9J
         oEqPGv2kDE/ecdBEQV0rJqtBV6iGlDPn+VlJTSGAHSD5IhhQYfvfcPjgPfxmfDd6xruu
         DXFw==
X-Gm-Message-State: AOAM532ODCLnIXJWEPjpaYR+ujYLvg+Ig1IiwaBcwZ1sZpNrDCXYmwpr
        0BBwWnS0LBExckare7VDRqAqjcprbmGBvA==
X-Google-Smtp-Source: ABdhPJwrCIbSVemibRCRVFOJKG32f1WNuTK+0z2lQyV26CT0gklaAyDRXTGJdKAGP57dfBFO8URYgg==
X-Received: by 2002:a17:902:12c:b029:e1:aac:e6f4 with SMTP id 41-20020a170902012cb02900e10aace6f4mr947455plb.26.1612319262976;
        Tue, 02 Feb 2021 18:27:42 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u3sm297863pfm.144.2021.02.02.18.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:27:42 -0800 (PST)
Date:   Tue, 02 Feb 2021 18:27:42 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 18:22:38 PST (-0800)
Subject:     Re: Kconfig-induced build errors: CONFIG_PAGE_OFFSET
In-Reply-To: <CAMuHMdWb8We=-L3mrZi5dSc308rapqH8NyAq9OJU=Qo7YijGpw@mail.gmail.com>
CC:     atishp@atishpatra.org, rdunlap@infradead.org,
        linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert@linux-m68k.org
Message-ID: <mhng-9b4a74fd-62d8-421f-8150-9147da7e39b2@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 05:52:51 PST (-0800), geert@linux-m68k.org wrote:
> Hi Atish,
>
> On Thu, Jan 28, 2021 at 9:09 PM Atish Patra <atishp@atishpatra.org> wrote:
>> On Wed, Jan 27, 2021 at 7:18 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> > I took a riscv-32 .config from kernel test robot (it was for a clang build)
>> > and did a "make olddefconfig" (using gcc tools) and got build errors
>> > due to this config item from arch/riscv/Kconfig;
>> >
>> >
>> > config PAGE_OFFSET
>> >         hex
>> >         default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
>> >         default 0x80000000 if 64BIT && !MMU
>> >         default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>> >         default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>> >
>> > PAGE_OFFSET is undefined for the case of 32BIT && MAXPHYSMEM_2GB.
>>
>> Because, RV32 doesn't support 2GB physical memory yet.
>>
>> The compilation errors can be fixed by not allowing MAXPHYSMEM_2GB for RV32 and
>> MAXPHYSMEM_1GB for RV64. How about this ?
>>
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -253,8 +253,10 @@ choice
>>         default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
>>
>>         config MAXPHYSMEM_1GB
>> +               depends on 32BIT
>>                 bool "1GiB"
>>         config MAXPHYSMEM_2GB
>> +               depends on 64BIT && CMODEL_MEDLOW
>>                 bool "2GiB"
>>         config MAXPHYSMEM_128GB
>>                 depends on 64BIT && CMODEL_MEDANY
>
> Thanks, works fine on litex-vexriscv.
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Atish: did I miss an actual patch?  I just see diff here.
