Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F943F667
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 06:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhJ2FCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 01:02:04 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35300
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhJ2FB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 01:01:59 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3223C3F165
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 04:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635483570;
        bh=OJg5Riv5SEPQHw6GUzsRnRLEnZCVPUrqTKYKL32qSlg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Ojjjrddck/GH5h+kjVnTgx3R3EttqtMURgCHtLnZFTeGZphUA2BFWcNuMXU0I5+CJ
         pCCC3sJXwC6d1gzsmiIAwbChVh18oqxBj0KUz0O1wnqzguharDpFLCVy5/RHfaAzE5
         PzpCLLlBfzTuTR4Y42CI3+44HYZgebC+P3y5JhyUgSG7wrJOl12k9ArGKlZ//IkU42
         VaWZ60uSITI2U9Sb+mWgf5LMj0135zYkHtpk8DgEwKzxH88k2aRAs55ZamZR+GV6T+
         mS20jKkQS9xsirJUWVAJ4nGwDHC41vRoxABFuTUhcnfr03cElnR3DMpRdX9TlzyQKW
         Q3E2utzWCeNDg==
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso2974490wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 21:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJg5Riv5SEPQHw6GUzsRnRLEnZCVPUrqTKYKL32qSlg=;
        b=Y+XmG2zo7djT+TNqBY1bgLZ7YhnloK71TYc9NkegZauuX9FhmfNig8jpxEgVAE9DgU
         OXNHDfCpnPMm9qVyfv2RYLaDEUhEdDOn3kdbjfUL6+7gZSyPU4pwv1ZlWSbaI5dkwHBE
         Onx2lkFEL85mwStYhfbKSa73Lt+D+/SvNQufgC1RHQ3KivrTOtwafkjWV010rvkZ2nRY
         /8iyXV2LBP6uoYRUGMl+olZJ8CvHwc9yCrlPaABlVzBprIRThaR41lgRNmFjdYUYgW2J
         UIeTOMBTmrUmLtEZR3wOcb/ICJFc7TZpyYeFBYAn/kXVNQyB350Jach8o9eTeZZn346D
         x08A==
X-Gm-Message-State: AOAM533pF+bi48m5fQ8kUt2nLTe6CPTrjkdnCqtjkff47aXRrRT/rFI5
        6xzfdDkABEdkux/iQNgBc5QTF8JC0FeXkg4TV/iYSbdhbJHSNgCCOQpDOja4a6yqanmH4C65qBh
        EA4FlstUoHSoOHpSsmnF5Y8XkMvDbWFNc5Kfu7O0eeA==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr8777200wmi.69.1635483569951;
        Thu, 28 Oct 2021 21:59:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoSjAtlbuEhehndrjjwCsmEUDmuBiMpCGgdYwnt+96mQvDORVoOvrvS1DNJy40R3xBZiwCEA==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr8777186wmi.69.1635483569839;
        Thu, 28 Oct 2021 21:59:29 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id n12sm376620wmd.3.2021.10.28.21.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 21:59:29 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 0/2] riscv asan-stack fixes
Date:   Fri, 29 Oct 2021 06:59:25 +0200
Message-Id: <20211029045927.72933-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset fixes asan-stack for riscv.

Changes in v2:
 * fix KASAN_VMALLOC=n
 * swap both patches in order not to have a non-bootable kernel commit

Alexandre Ghiti (2):
  riscv: Do not re-populate shadow memory with
    kasan_populate_early_shadow
  riscv: Fix asan-stack clang build

 arch/riscv/Kconfig             |  6 ++++++
 arch/riscv/include/asm/kasan.h |  3 +--
 arch/riscv/mm/kasan_init.c     | 14 +++-----------
 3 files changed, 10 insertions(+), 13 deletions(-)

-- 
2.30.2

