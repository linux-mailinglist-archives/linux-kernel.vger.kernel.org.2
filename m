Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF90460C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 02:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhK2Bpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 20:45:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235168AbhK2Bnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 20:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638150033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J8MhmGAottj8rByklsYBOCTO3w0A9a0z83LyPAaYS74=;
        b=LCwYlY7dNoibvEbIN5HXFzaZA1Y5B4GBd2wsKs+S8FrsywQj4tqn2SmoryXprKt0HpUe8Y
        OUZeOYxXdV7trmmiXdn6gfNIFkj7uZOr8xdvHVzEnrGw7bmLnak19C0fQ5e4YBWcKEFops
        5OEvJEtkgZyXXdK5gxxqYWV4ecruM8I=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-469-kURwIA6UMpSROsuayyJ5YQ-1; Sun, 28 Nov 2021 20:40:32 -0500
X-MC-Unique: kURwIA6UMpSROsuayyJ5YQ-1
Received: by mail-pg1-f199.google.com with SMTP id n22-20020a6563d6000000b0029261ffde9bso7576698pgv.22
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 17:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8MhmGAottj8rByklsYBOCTO3w0A9a0z83LyPAaYS74=;
        b=xkBCmdENcUObVvKa6fPlqwur+67x26/mTmNfbhmoe/Lup00osyjGRvfvENcgs7cRL6
         yy0ZWMK64YVSrkh6TRMoT9WHM9BVb9zfl+aBcJnJjSoAWUpAYsw69eWYXuWeWRkCH9mw
         Lfyq2zJlHIjoSF64Z1+M9ikz2dygzRJGeAVr8v6RhOKvmqcNqU/mpwz5CR79qjYs3pnj
         /NrIHkacFYdDLu2Gb9GsWiziFK2gnB/Eo29nKGg//zXu0VFv7k1nBjOyRj8D50/VJdvw
         Bu8YfPcQz5P/myw9j+4yGG2hFPEl5WH2uUTZ+hkIQi5a4Xl8JnGKSXfIFgQkk1jckSKT
         1etw==
X-Gm-Message-State: AOAM530eSlyvstdU9juombcBmX5PpBiRkXOapvcwbS4m4qE5E8hFFps3
        bChTsuGb/uj6qX/rW2Jo7f2/jQ6N3SynLluuUPhAeJ3HEHlkO0bk1zzLHqED3OXmCqXWm2ymyJE
        sOeSjarpowMyvIRjMn5JdR6Rv
X-Received: by 2002:a17:90b:4c4c:: with SMTP id np12mr34052990pjb.68.1638150031022;
        Sun, 28 Nov 2021 17:40:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2v0SCntrTCewEggO1HPs1thoxUoYO8KvVGYjWgC0LUSWe22kMuWp7rOlBQjSs8MTbVqBRvQ==
X-Received: by 2002:a17:90b:4c4c:: with SMTP id np12mr34052935pjb.68.1638150030758;
        Sun, 28 Nov 2021 17:40:30 -0800 (PST)
Received: from samantha.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e18sm10367575pgl.50.2021.11.28.17.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 17:40:30 -0800 (PST)
From:   wefu@redhat.com
To:     anup.patel@wdc.com, atishp04@gmail.com, palmer@dabbelt.com,
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
Subject: [PATCH V4 0/2] riscv: add RISC-V Svpbmt Standard Extension supports
Date:   Mon, 29 Nov 2021 09:40:05 +0800
Message-Id: <20211129014007.286478-1-wefu@redhat.com>
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
a global variable(__svpbmt) as _PAGE_MASK/IO/NOCACHE for pgprot_noncached
(&writecombine) in pgtable.h. We also add _PAGE_CHG_MASK to filter
PFN than before.

Enable it in devicetree - (Add "riscv,svpbmt" in the mmu of cpu node)
 - mmu:
     riscv,svpmbt

Wei Fu (2):
  dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
  riscv: add RISC-V Svpbmt extension supports

 .../devicetree/bindings/riscv/cpus.yaml       | 10 +++++
 arch/riscv/include/asm/fixmap.h               |  2 +-
 arch/riscv/include/asm/pgtable-64.h           | 21 ++++++++--
 arch/riscv/include/asm/pgtable-bits.h         | 39 ++++++++++++++++++-
 arch/riscv/include/asm/pgtable.h              | 39 ++++++++++++++-----
 arch/riscv/kernel/cpufeature.c                | 35 +++++++++++++++++
 arch/riscv/mm/init.c                          |  5 +++
 7 files changed, 136 insertions(+), 15 deletions(-)

-- 
2.25.4

