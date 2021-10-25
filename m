Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6E438DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 06:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhJYEJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 00:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhJYEI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635134796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xt4dSqCcvO8Ds9ncTZOb5dKcnC/w5v8GuDpHPG0IPbk=;
        b=YHcPnIHnkaJz8ssUf0KKbYViIaDviDO3V8Vu6goYuua+CC9kgICUe8CSZLbk2hG0OH8GIv
        gODnLYORD+n0RQSuNco+Sz+A3NUU8Y6sSSfHfDNFxpaTl1h13yjlfNSEOyldZEdzt4RAg5
        g6OgkKe6W3Vg4YJLDNmeG+7dP0bVROM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Al4uKfP2Oc6R-qJ-uRfIew-1; Mon, 25 Oct 2021 00:06:33 -0400
X-MC-Unique: Al4uKfP2Oc6R-qJ-uRfIew-1
Received: by mail-pg1-f198.google.com with SMTP id a18-20020a637f12000000b002a44c4f0e66so901888pgd.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xt4dSqCcvO8Ds9ncTZOb5dKcnC/w5v8GuDpHPG0IPbk=;
        b=6B9yWUAyA4y4tFY/fTYg+2HEn+TfDBNG/3AI9wEliYhw/Ge8L6jn2U22dI7nu9EPRo
         d1eoh4DEi4qD4IjRhLCaSW4WqZ7hKi2EHnD1VR19FHspSsb5UXN8a1c3f4y2bb9dXoQs
         LaUL8s/KUk/ZJdcG9PEbVR+fnlPqBt0Dzl6nmmteurryHlyEY1RHHTaoNVnQYqGJoVuV
         iFLuntAxNAiDTczgA3XwlDQYLtl7z+93E0F+mZZN0aRq/QiNZXCNRE6D0n/52TkoBBf2
         l/j3mEutfKIlr8GCqLPVThl8OmcmKIe22SCD9TIfgB9CAems7MZhtuDDTW9RQquwo0lI
         StGg==
X-Gm-Message-State: AOAM5303c7jJDZw8U+jn+a0eMQ4i1vinLvlSvM8C4dJkouJWl0xAh5/G
        lQSfTvhRiZ3eYsWTpa4s7d2fbLUq0Xc77RPKEWEz/YJh88BstqOe3QEzUCX03HQJ8qBNVuxhvXo
        uOd+5QjX0CIe/joriUhgZ1AaS
X-Received: by 2002:a05:6a00:1591:b0:47b:eaa8:1a70 with SMTP id u17-20020a056a00159100b0047beaa81a70mr5341971pfk.75.1635134791967;
        Sun, 24 Oct 2021 21:06:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuKpgNNfZmeGA9xdRKARCXaMf4DsW7R45QGzXVYEhI4kpnnozmulSLyekCqG+/q0mMPlXAoA==
X-Received: by 2002:a05:6a00:1591:b0:47b:eaa8:1a70 with SMTP id u17-20020a056a00159100b0047beaa81a70mr5341936pfk.75.1635134791662;
        Sun, 24 Oct 2021 21:06:31 -0700 (PDT)
Received: from samantha.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a12sm19583944pjq.16.2021.10.24.21.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 21:06:31 -0700 (PDT)
From:   wefu@redhat.com
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, arnd@arndb.de, wens@csie.org,
        maxime@cerno.tech, dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com
Subject: [RESEND PATCH V3 0/2] riscv: add RISC-V Svpbmt Standard Extension supports
Date:   Mon, 25 Oct 2021 12:06:05 +0800
Message-Id: <20211025040607.92786-1-wefu@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fu Wei <wefu@redhat.com>

This patch follows the  RISC-V standard Svpbmt extension in 
privilege spec to solve the non-coherent SOC DMA synchronization
issues.

The svpbmt PTE format:
| 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
  N     MT     RSW    D   A   G   U   X   W   R   V
        ^

Of the Reserved bits [63:54] in a leaf PTE, the bits [62:61] are used as
the MT (aka MemType) field. This field specifies one of three memory types
as shown in the following table：
MemType     RISC-V Description
----------  ------------------------------------------------
00 - PMA    Normal Cacheable, No change to implied PMA memory type
01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
11 - Rsvd   Reserved for future standard use

The standard protection_map[] needn't be modified because the "PMA"
type keeps the highest bits zero.
And the whole modification is limited in the arch/riscv/* and using
a global variable(__riscv_svpbmt) as _PAGE_DMA_MASK/IO/NC for
pgprot_noncached (&writecombine) in pgtable.h.
We also add _PAGE_CHG_MASK to filter PFN than before.

Enable it in devicetree - (Add "mmu-supports-svpbmt" in cpu node)
 - mmu-supports-svpbmt

Wei Fu (2):
  dt-bindings: riscv: add mmu-supports-svpbmt for Svpbmt
  riscv: add RISC-V Svpbmt extension supports

 .../devicetree/bindings/riscv/cpus.yaml       |  5 +++
 arch/riscv/include/asm/fixmap.h               |  2 +-
 arch/riscv/include/asm/pgtable-64.h           |  8 ++--
 arch/riscv/include/asm/pgtable-bits.h         | 41 ++++++++++++++++++-
 arch/riscv/include/asm/pgtable.h              | 39 ++++++++++++++----
 arch/riscv/kernel/cpufeature.c                | 32 +++++++++++++++
 arch/riscv/mm/init.c                          |  5 +++
 7 files changed, 117 insertions(+), 15 deletions(-)

-- 
2.25.4

