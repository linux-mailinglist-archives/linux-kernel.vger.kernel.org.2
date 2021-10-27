Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C10243C46C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbhJ0H4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:56:46 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51590
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239074AbhJ0H4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:56:45 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 72B9F3F1A4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635321259;
        bh=jrIERodREqehysnV6gsM61G1ahaaesQ+KVjNvRfOpIo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ep0T11q9uoj0kUewI9HjgYetNfyl4YiPWXnK/ZGdnA+OCWOJuCtnOJk0uuM8/nYqi
         C7VwlyIAXVxhgdF7o+t9g7V2CNjU7XlWXup8zOmSzrNDyhAaruaMqBj35RI8NZbzIN
         mmy28C/gL8xRhwXPvkeFEGm2NSp6M/R6KLOW5vMVqKN3CYkFDMSR5xWtzAK5SGG+qn
         9hGfsBd4RDZ66KKRqq/BV/VZkOHGNXAWrOuaPGOs4CEUxA0xMwKdoQHfpAmhUHSHwB
         /8VNfePfaEVbi2zZyhP85YqRUfPUndmZ9DNTy+IiYf60r5vDI503Tx+5BapNBtLZK+
         BDtKzvHDkNJvA==
Received: by mail-wr1-f70.google.com with SMTP id b8-20020adff248000000b00171bceb5139so312471wrp.18
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jrIERodREqehysnV6gsM61G1ahaaesQ+KVjNvRfOpIo=;
        b=ir2CJjuL555GYFMYZ80AXcYrCiQQgppAHF5pdA6sroV9qLhoYrGK5EpORQsigppQPp
         0Nh8w3pho8qcsVWeI1NEUo2UIWwZyPcHCrqymxuNC59HUjo+jCmE+55SxPrRPJvSTU7k
         I3NiXP56Sm9GBsn6oAU8jBD6IEYiDvxS6jdJW5i45pFseWBjKQho5vYLP6+dddu89+Ga
         PAiLtfWTyRji0TBLISAws3J4+ThKH9exC+/tUBFupwh6uxXpUatKw/PhNdXnkx+L70P1
         gEoH6FL0mQ20DhwvIjhT5KF+KXGaeld752P785IsaE8GrbeY7RK5yNxCYb6/B0a156FX
         vDKQ==
X-Gm-Message-State: AOAM531PFP7VQhJieglqX3QncrnLhtrQrUUpcykXtzwRfmAhPao8vz2o
        dima3siYsCzWMG823D5N8ZvMeCZDEQk47vLOVKR9kDcByG7UMw524pWT/IIyLGheRfWpiyLBE2b
        1mxKI5hOzTHK0Vk1rprKX/4J3Hh4uhLCDMrgbfkpkvg==
X-Received: by 2002:a7b:cd16:: with SMTP id f22mr4132872wmj.42.1635321258929;
        Wed, 27 Oct 2021 00:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6qDUvnuv6opusaRgyH+GKdjmFxmU7S/Ic0X3KxUzeyS5RGOxCGIbPbcPVKjnEkiGVgKpkog==
X-Received: by 2002:a7b:cd16:: with SMTP id f22mr4132838wmj.42.1635321258655;
        Wed, 27 Oct 2021 00:54:18 -0700 (PDT)
Received: from [192.168.123.55] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id s11sm13060053wrt.60.2021.10.27.00.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 00:54:18 -0700 (PDT)
Message-ID: <7b8233f4-b7d7-7142-3c09-4d5c3e06d287@canonical.com>
Date:   Wed, 27 Oct 2021 09:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RESEND PATCH V3 0/2] riscv: add RISC-V Svpbmt Standard Extension
 supports
Content-Language: en-US
To:     Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com
Cc:     Anup Patel <Anup.Patel@wdc.com>, Atish Patra <Atish.Patra@wdc.com>,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, Christoph Hellwig <hch@lst.de>,
        liush@allwinnertech.com, lazyparser@gmail.com,
        drew@beagleboard.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, taiten.peng@canonical.com,
        aniket.ponkshe@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>,
        wens@csie.org, maxime@cerno.tech,
        Daniel Lustig <dlustig@nvidia.com>, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com
References: <mhng-ac32ff92-86cb-4377-ba63-de1856e84fb1@palmerdabbelt-glaptop>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <mhng-ac32ff92-86cb-4377-ba63-de1856e84fb1@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 02:12, Palmer Dabbelt wrote:
> On Sun, 24 Oct 2021 21:06:05 PDT (-0700), wefu@redhat.com wrote:
>> From: Fu Wei <wefu@redhat.com>
>>
>> This patch follows the  RISC-V standard Svpbmt extension in
>> privilege spec to solve the non-coherent SOC DMA synchronization
>> issues.
>>
>> The svpbmt PTE format:
>> | 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>>   N     MT     RSW    D   A   G   U   X   W   R   V
>>         ^
>>
>> Of the Reserved bits [63:54] in a leaf PTE, the bits [62:61] are used as
>> the MT (aka MemType) field. This field specifies one of three memory 
>> types
>> as shown in the following table：
>> MemType     RISC-V Description
>> ----------  ------------------------------------------------
>> 00 - PMA    Normal Cacheable, No change to implied PMA memory type
>> 01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
>> 10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
>> 11 - Rsvd   Reserved for future standard use
> 
> Do you have a pointer to the spec that contains these?  I'm specifically
> worried about these page-based attributes being elided when paging is
> off (ie, M-mode), which has caused issues in systems I've worked with in
> the past.  I'm assuming there's something related to this in the specs,
> but I'm worried we'll need some sort of ack from M-mode that it's been
> setup to work that way.  One could imagine an MPRV-like approach 
> working, but I don't see enough in the old specs and I'm having trouble 
> figuring out where the canonical version of this lives.

The draft version of the spec is available in chapter 6, p 87 of
https://raw.githubusercontent.com/riscv/virtual-memory/main/specs/663-Svpbmt.pdf

According to 
https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/nOrD9t9ImEw/m/tstjm4QbAAAJ 
review has started Sep 17th.

Best regards

Heinrich

> 
>> The standard protection_map[] needn't be modified because the "PMA"
>> type keeps the highest bits zero.
>> And the whole modification is limited in the arch/riscv/* and using
>> a global variable(__riscv_svpbmt) as _PAGE_DMA_MASK/IO/NC for
>> pgprot_noncached (&writecombine) in pgtable.h.
>> We also add _PAGE_CHG_MASK to filter PFN than before.
>>
>> Enable it in devicetree - (Add "mmu-supports-svpbmt" in cpu node)
>>  - mmu-supports-svpbmt
> 
> Maybe this is enough of an ack, but we'll need to have some pretty
> specific documentation if that's the case.  It's not described that way 
> in the docs right now, they just talk about CPU support (IMO we could 
> probe that with a trap, but I'm fine with the DT entry as it's a bit 
> simpler).
> 
>> Wei Fu (2):
>>   dt-bindings: riscv: add mmu-supports-svpbmt for Svpbmt
>>   riscv: add RISC-V Svpbmt extension supports
>>
>>  .../devicetree/bindings/riscv/cpus.yaml       |  5 +++
>>  arch/riscv/include/asm/fixmap.h               |  2 +-
>>  arch/riscv/include/asm/pgtable-64.h           |  8 ++--
>>  arch/riscv/include/asm/pgtable-bits.h         | 41 ++++++++++++++++++-
>>  arch/riscv/include/asm/pgtable.h              | 39 ++++++++++++++----
>>  arch/riscv/kernel/cpufeature.c                | 32 +++++++++++++++
>>  arch/riscv/mm/init.c                          |  5 +++
>>  7 files changed, 117 insertions(+), 15 deletions(-)

