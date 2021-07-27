Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E955A3D7835
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhG0OMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhG0OMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:12:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA7FC061764
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:12:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j2so15345909wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxFe0uNWW9r8apP/FU5g02YgcMO4sIOQrIvQ0ldAwCE=;
        b=tKqva2x/CG8NzNjWImVr+kujX/2pkcv6GBJov7A0FHrtTM+AWUaZg2RbsIt+2FlCm9
         MzAOgq5MVu7g44j7ba+GmRwMWp8FsuxUIzw2wnBV/giol1NiN51RCQeb/dbT/KdDnbcN
         xOM10soYVdAlqUz8jz9HAMYFBVicmcOR3rAcAyR3eVJocoqUN2Ei0IVTNdgM/RDIKr8G
         xfDdwLzGJAEsvexyVUv4E2q3DnwYOgmYcTdfoKlH+zb4+LA36Y6VluffdgsH+KN89DNL
         ZP2UaaUjHblc3whx0DDG85xV38HvCrZ0PgS9Oly7LyceGcyk6DUTkcSn995pXbHOt3s0
         tf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxFe0uNWW9r8apP/FU5g02YgcMO4sIOQrIvQ0ldAwCE=;
        b=iJXsR1OuerE29FxZHUUvzbhvH1FYI+iex/E+Fc+DRRRle/7pKrzSNAT8Px4T86KWJf
         qyQ2H6GQ64F2+iKaZLng7tcp0guL2O1Q9q+zJOInxn2mixIAEmWeKnD/uLtIS+WR4l+z
         rO2ozccrB0xIFnjkuD18RsleF/O9OJnxdhU18tH871GeV+xkJe6e7RK66/xuvY6QFbus
         u50chi49qWB2pvNEJ04BFggQqq+yzBphCq09QUdPieyrCoEeVlWS9nhwPQO7aRvfPPAo
         txFtHpk9qfnBtZXyda1wcggZYe5SLcERyn8irimzC9P+SwpIFQ4qcHCTwNX7AJnD+IqK
         /CoQ==
X-Gm-Message-State: AOAM532VU1W2VX3s5T6pLUmP3HqUgJyd/2Lb7Fm6JoRNrNXXw0rlQYZ9
        h1PRed9P2JYR/g+f4JQCeFT22w==
X-Google-Smtp-Source: ABdhPJyo/1NSvfJMApolEVn/Cme3lrJZj6EUMJjCA+6U4kBT2iMR/FUJLcqUvmi6jmSG+c2lQdwkTg==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr25032728wri.290.1627395152923;
        Tue, 27 Jul 2021 07:12:32 -0700 (PDT)
Received: from localhost.localdomain ([89.18.44.40])
        by smtp.gmail.com with ESMTPSA id t1sm3403912wrm.42.2021.07.27.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 07:12:32 -0700 (PDT)
From:   Pavo Banicevic <pavo.banicevic@sartura.hr>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, ivan.khoronzhuk@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, matt.redfearn@mips.com,
        mingo@kernel.org, dvlasenk@redhat.com, juraj.vijtiuk@sartura.hr,
        robert.marko@sartura.hr, luka.perkov@sartura.hr,
        jakov.petrina@sartura.hr
Cc:     Pavo Banicevic <pavo.banicevic@sartura.hr>
Subject: [PATCH 0/3] Address compilation of eBPF related software with clang compiler on arm architecture
Date:   Tue, 27 Jul 2021 16:11:16 +0200
Message-Id: <20210727141119.19812-1-pavo.banicevic@sartura.hr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is fixing compilation issues that are encountered in our usage of the Linux kernel.

Two patches are addressing compilation of eBPF related software with clang compiler on arm architecture.
The third patch resolves compilation of the perf tool in this specific scenario.

We are also interested in possible alternative approaches in fixing these compilation issues which could
then be incorporated into the mainline.

Ivan Khoronzhuk (2):
  arm: include: asm: swab: mask rev16 instruction for clang
  arm: include: asm: unified: mask .syntax unified for clang

Matt Redfearn (1):
  include/uapi/linux/swab: Fix potentially missing __always_inline

 arch/arm/include/asm/swab.h    | 3 +++
 arch/arm/include/asm/unified.h | 4 +++-
 include/uapi/linux/swab.h      | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.32.0

