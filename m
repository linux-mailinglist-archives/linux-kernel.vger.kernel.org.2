Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D4A41A444
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 02:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhI1Aon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 20:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238236AbhI1Aom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:44:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 667726120D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632789783;
        bh=ZF8e/FM0+eopT+Y8KRCcbREFQBdAT4gmwboao8jTDsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j5X9Mo/9sZRA8a5d+Ol0b+nU24yJqJL1tPQhFoPdaLsNKvGILqdDqvK57Zsm9Jge3
         URoJ7ENq50jVWgzEuLKEtk2D7XLrfzEghOkWxQ3h6sFIKJX2REBkmKhigyigF9i7hm
         MSd/je4oKSfnQCa34J+P5CW+wVzo0w/Lgv9xnW67+wvghktKpoyz6p8pPGw+AZXApI
         4X92egnLM89E1NFMv58bxNCdj2G2OzOcai9doXYdkHEcZRzusH6NGwLzvQg6PiZGRp
         FoLLCfhC+bLSb2GJnUAX36+ZW8AGmc5v6mCzXb9cbsKe2Vytv9caVdCXRYLLClaP7+
         LlJEPvEpkiWkA==
Received: by mail-vk1-f171.google.com with SMTP id b67so7738839vkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:43:03 -0700 (PDT)
X-Gm-Message-State: AOAM531Th1RY90A0fjD21vevs7QdiJWmEibpMmmPtBnzcHRkdLnK9HnU
        6JC2w0pIXlvdSZZ1H5dos+xPjzcCRK711AIRQi8=
X-Google-Smtp-Source: ABdhPJy8GldO52SnlP7VBZDhPaFIid6a1O3zfroXvQOKN+eNASjt8B0G5rE5CZs5QPVvEAUKwfO1ScPfpxWhUjXz2BI=
X-Received: by 2002:a1f:1844:: with SMTP id 65mr2903239vky.3.1632789782389;
 Mon, 27 Sep 2021 17:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172107.1117604-1-guoren@kernel.org> <20210923172107.1117604-2-guoren@kernel.org>
 <CAOnJCU+6hUSdviwCM6uwCQr=OV3xQP=RF-BmdJFY8Tzgd_L51Q@mail.gmail.com>
In-Reply-To: <CAOnJCU+6hUSdviwCM6uwCQr=OV3xQP=RF-BmdJFY8Tzgd_L51Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Sep 2021 08:42:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSbPbVRYkhD5zaFT=UWKiRjj1-pxjfCVxL3AWgAiASp5A@mail.gmail.com>
Message-ID: <CAJF2gTSbPbVRYkhD5zaFT=UWKiRjj1-pxjfCVxL3AWgAiASp5A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] dt-bindings: riscv: Add svpbmt in cpu mmu-type property
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 3:32 AM Atish Patra <atishp@atishpatra.org> wrote:
>
>
>
> On Thu, Sep 23, 2021 at 10:22 AM <guoren@kernel.org> wrote:
>>
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> Previous patch has added svpbmt in arch/riscv and changed the
>> DT mmu-type. Update dt-bindings related property here.
>>
>
> This is the first of many small ISA extensions to be added to RISC-V.
> Should we think about a generic DT property and parsing framework for all hart related ISA extensions now instead of adding
> to the existing mmu-type.
Change existing mmu-type will cause a compatible problem. If we still
keep current solution, I think it's still okay. eg:
mmu-type = "riscv,sv39,svpbmt,svnapot,svinval";

Or, if we still want to change, how:
mmu-type = "riscv,sv39";
mmu-type-ext = "svpbmt,svnapot,svinval"

Still keep mmu-type like before.

>
> We will soon need to add the CMO extensions as well.
>
>>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Cc: Anup Patel <anup@brainfault.org>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/riscv/cpus.yaml | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> index e534f6a7cfa1..5eea9b47dfc6 100644
>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> @@ -48,15 +48,18 @@ properties:
>>
>>    mmu-type:
>>      description:
>> -      Identifies the MMU address translation mode used on this
>> -      hart.  These values originate from the RISC-V Privileged
>> -      Specification document, available from
>> +      Identifies the MMU address translation mode and page based
>> +      memory type used on used on this hart.  These values originate
>> +      from the RISC-V Privileged Specification document, available
>> +      from
>>        https://riscv.org/specifications/
>>      $ref: "/schemas/types.yaml#/definitions/string"
>>      enum:
>>        - riscv,sv32
>>        - riscv,sv39
>> +      - riscv,sv39,svpbmt
>>        - riscv,sv48
>> +      - riscv,sv48,svpbmt
>>        - riscv,none
>>
>>    riscv,isa:
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
