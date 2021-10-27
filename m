Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19ECD43BE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 02:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhJ0AP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 20:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhJ0AP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 20:15:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC0C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 17:12:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q187so1174938pgq.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 17:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FjppYRWyCAJSkLalMKvDYJo3XiQkcxPLw34XLmzJVZg=;
        b=WVD3mqOD9gkjyh8K/rvNcPe/TYeIilGpXvZkcgoGGN5VKGbZTLphd075nFAi76oE6k
         rTYEruae/E3Kb7EYA5J+E2itk3Dd+kxxQvrl1R74/fMiIdBHXmNqUPemu5EsID+uMQkw
         DQkojNazBtJ10dvK0uCxtVOJxCk/7KJE0NH/hy/sJF2wafeMrrPTs7i0n5O542aqyks2
         lSmAPV3Kf/iI0sOV7KVju0jFjBN96Y37ValzdRRPHFAxbTgrWow6bMoK86en1UqSMsVN
         o1NxWjlVLpQZVBi/b51bwZ9cp+Nd5PdYjjH+c97qXReuVfK3bfm3LqO/JWIgVNiYYmqd
         6+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FjppYRWyCAJSkLalMKvDYJo3XiQkcxPLw34XLmzJVZg=;
        b=fhNb0nJtUxI1B0ysqMF0q8Kds9CaE9Camkreq5RjQQDRsxN+n//ud4Tf5b17VVCoW1
         IVajBKj62TdJxm4VObyACE6JX5gsz/fBHG8hi7YPnVFnXoQEMus3cjPk1f3YMgRTYf9F
         vJaE50wRaOk8Gq73zv+6+SgE3HzjjnJo0QQNuCiWUqBZIuk5AqPNgoIX7no1IiX+rtM7
         8aJNiKwAkK+y6N+LYbvV/ByTUSpb0GFFPWA9RgNHZANU27aI4cR6TV+vX28rnlJ6PQ1r
         ON21WEvH+/9okBg6igXeHZ8x+sIBInXbb8QK3v0UlHIPF6jTK0bUokNhpEh//990FIys
         5KOw==
X-Gm-Message-State: AOAM533IqnkzxJQuHDIaCJ2OrEWlmNZgpPKjqyw5mZ+0gHcW8Ft/UMVn
        pIA5odBR4L3p9XtnCpzmi94akg==
X-Google-Smtp-Source: ABdhPJxnbqFvruMJ3zBomBhJkfN6LQPdGjY39ZCIeckMen9Tegf60Y3/1Bjs98G8J4BntqnZDKPA4g==
X-Received: by 2002:a63:b349:: with SMTP id x9mr21330657pgt.421.1635293576927;
        Tue, 26 Oct 2021 17:12:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:676c:ab93:f48d:23ae])
        by smtp.gmail.com with ESMTPSA id p13sm8922920pfo.102.2021.10.26.17.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 17:12:56 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:12:56 -0700 (PDT)
X-Google-Original-Date: Tue, 26 Oct 2021 17:12:52 PDT (-0700)
Subject:     Re: [RESEND PATCH V3 0/2] riscv: add RISC-V Svpbmt Standard Extension supports
In-Reply-To: <20211025040607.92786-1-wefu@redhat.com>
CC:     Anup Patel <Anup.Patel@wdc.com>, Atish Patra <Atish.Patra@wdc.com>,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, Christoph Hellwig <hch@lst.de>,
        liush@allwinnertech.com, wefu@redhat.com, lazyparser@gmail.com,
        drew@beagleboard.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, taiten.peng@canonical.com,
        aniket.ponkshe@canonical.com, heinrich.schuchardt@canonical.com,
        gordan.markus@canonical.com, guoren@linux.alibaba.com,
        Arnd Bergmann <arnd@arndb.de>, wens@csie.org,
        maxime@cerno.tech, Daniel Lustig <dlustig@nvidia.com>,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, huffman@cadence.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     wefu@redhat.com
Message-ID: <mhng-ac32ff92-86cb-4377-ba63-de1856e84fb1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 21:06:05 PDT (-0700), wefu@redhat.com wrote:
> From: Fu Wei <wefu@redhat.com>
>
> This patch follows the  RISC-V standard Svpbmt extension in
> privilege spec to solve the non-coherent SOC DMA synchronization
> issues.
>
> The svpbmt PTE format:
> | 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>   N     MT     RSW    D   A   G   U   X   W   R   V
>         ^
>
> Of the Reserved bits [63:54] in a leaf PTE, the bits [62:61] are used as
> the MT (aka MemType) field. This field specifies one of three memory types
> as shown in the following table：
> MemType     RISC-V Description
> ----------  ------------------------------------------------
> 00 - PMA    Normal Cacheable, No change to implied PMA memory type
> 01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> 10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
> 11 - Rsvd   Reserved for future standard use

Do you have a pointer to the spec that contains these?  I'm specifically
worried about these page-based attributes being elided when paging is
off (ie, M-mode), which has caused issues in systems I've worked with in
the past.  I'm assuming there's something related to this in the specs,
but I'm worried we'll need some sort of ack from M-mode that it's been
setup to work that way.  One could imagine an MPRV-like approach 
working, but I don't see enough in the old specs and I'm having trouble 
figuring out where the canonical version of this lives.

> The standard protection_map[] needn't be modified because the "PMA"
> type keeps the highest bits zero.
> And the whole modification is limited in the arch/riscv/* and using
> a global variable(__riscv_svpbmt) as _PAGE_DMA_MASK/IO/NC for
> pgprot_noncached (&writecombine) in pgtable.h.
> We also add _PAGE_CHG_MASK to filter PFN than before.
>
> Enable it in devicetree - (Add "mmu-supports-svpbmt" in cpu node)
>  - mmu-supports-svpbmt

Maybe this is enough of an ack, but we'll need to have some pretty
specific documentation if that's the case.  It's not described that way 
in the docs right now, they just talk about CPU support (IMO we could 
probe that with a trap, but I'm fine with the DT entry as it's a bit 
simpler).

> Wei Fu (2):
>   dt-bindings: riscv: add mmu-supports-svpbmt for Svpbmt
>   riscv: add RISC-V Svpbmt extension supports
>
>  .../devicetree/bindings/riscv/cpus.yaml       |  5 +++
>  arch/riscv/include/asm/fixmap.h               |  2 +-
>  arch/riscv/include/asm/pgtable-64.h           |  8 ++--
>  arch/riscv/include/asm/pgtable-bits.h         | 41 ++++++++++++++++++-
>  arch/riscv/include/asm/pgtable.h              | 39 ++++++++++++++----
>  arch/riscv/kernel/cpufeature.c                | 32 +++++++++++++++
>  arch/riscv/mm/init.c                          |  5 +++
>  7 files changed, 117 insertions(+), 15 deletions(-)
