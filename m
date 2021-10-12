Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE642AC16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhJLSgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233486AbhJLSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634063649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nbgsOsSSo9Yem7q4TZdpOJzLhRx02NYo3rwP+kVjrbw=;
        b=TUbYBc46z9KklrUPtJF+vw/jBIkY8pMr+TuLznxDbo3bFA6AmA7UfZgwcKCpeFgxJasmDw
        UrlzykWb56Xx1q5CYvcVbZgWoAt9LE+WxN6UvwCnUbamtZIg+x6et24JIKqHqbjhbBVU1V
        LFgS5cZE+h38viOJALnk9KaNwxsfWQA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-TvePjk6vMJ6_vqUPbJKFPQ-1; Tue, 12 Oct 2021 14:34:08 -0400
X-MC-Unique: TvePjk6vMJ6_vqUPbJKFPQ-1
Received: by mail-pj1-f71.google.com with SMTP id u13-20020a17090a4bcd00b00198e965f8f4so2062769pjl.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nbgsOsSSo9Yem7q4TZdpOJzLhRx02NYo3rwP+kVjrbw=;
        b=nJlczz1kJMAi39tbv8wOWbvHoeRiLgNEEIgWG/vFtL6iHlYIRYDV+v++TMlIo4oQG7
         ZTtx80+COQZzjMaxfSR66mnLG+ws9ufLfa+Pl+osaDSYBb9cKkFCsTkKgDQZpni14KXA
         ZVolAhJk3U5A2UYf+/cw97Lw2pvc8FLkSNY+IhhjrwGL4wctGgq4TgEBzkzR99xpbPYn
         N4+rTsC0/uEzAxBCMZX7SC48jy+kZGTE2NGpgkkt0RiFi9Rofo3yHooPvU1GIwsKlXg0
         XQWJ0ZoHGw+F1AsnxLQlAQjS1RDA0a+ET3CyY1+HJPuS2YFNFRrSXCLzwE5MMlrwTGAc
         dNcQ==
X-Gm-Message-State: AOAM531yUmAsYXEQxzlT1/ikOcgYuE5OhLx03DA0zaJIuTgXCdcmX7WU
        cbhmX8KwegJ7r2o4Xxq5WuebJld5jC2wH7iekznnenuoR3AVzaxK9aSYRAMaTHa3PihI6Jn2Vyl
        YyMJIg9Mnk9VyolfD4VDaMSHp
X-Received: by 2002:a63:4743:: with SMTP id w3mr23574438pgk.245.1634063647124;
        Tue, 12 Oct 2021 11:34:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYV7ys83DL9nO+JaPOB7MrYoWsFwBT15nWiNWaKVgwPs7OrtAs4HQB9269x7iDVWU1Btmyvw==
X-Received: by 2002:a63:4743:: with SMTP id w3mr23574406pgk.245.1634063646889;
        Tue, 12 Oct 2021 11:34:06 -0700 (PDT)
Received: from samantha.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b10sm11617706pfi.122.2021.10.12.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:34:06 -0700 (PDT)
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
        rtrauben@gmail.com, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH 0/2] riscv: Add RISC-V svpbmt extension supports
Date:   Wed, 13 Oct 2021 02:33:42 +0800
Message-Id: <20211012183344.105637-1-wefu@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch follows the standard pure RISC-V Svpbmt extension in 
privilege spec to solve the non-coherent SOC DMA synchronization
issues.

Wei Fu (2):
  dt-bindings: riscv: Add mmu-supports with svpbmt
  riscv: Add RISC-V svpbmt supports

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

