Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF8435DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJUJMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:12:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43922
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231446AbhJUJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:12:30 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 454013FFF8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634807411;
        bh=bbSHRxsR73bGstaaNlqrnr2h4OekYl5/Y0NpOv9VPBw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=GiU2ougumgmG6uUTccWbtxnuXlWgVr3da9PbCxCKBeDFG/r5nSGbd27f0fPQdp9Qk
         zMpP8NuMd69UlfOcHqnQ2wZnV82hAZNalisRtj1eqeBRcX4D4uLIc8jwyzQhSEq/7W
         oGoFINOMP3IKltFK04IK5U0dcuj+H8ta0hzy9ogjd5tnnHW7XNE8unhF6OeG4FHvNs
         Dx1Cix6eB/TKFN6ovimHQqgNz7IoAiscFS9xU7rCyaP33b2fAFQAoAlMN2JYftnziW
         kewhpBsjMhgQMIoumEls940J/I+TjLUzrGlioCZzxKr1NZw6MyS8/pZ6wTMgHxI5fP
         lDYkka2ciCSOA==
Received: by mail-lj1-f198.google.com with SMTP id t7-20020a2e7807000000b00210dad8b167so299156ljc.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbSHRxsR73bGstaaNlqrnr2h4OekYl5/Y0NpOv9VPBw=;
        b=2falXzkDxrk80NkncMpSHbAnh4/6eLD7VbakNRLBQLrE8irGAG9B4BO0q1SDUkRSq1
         FsTNpDXoKo1XHfmJN6R6eoRpxySujcx78uE6uM7ZPgvXmtGtFV2HMxhPLCvrF3MpoMtg
         Akj7T0ktaf6H6aQ5YgjaCLOBOEYGpDJpXCj4BtfirgkSUC8hXkY3y4RQfJ8jrmQhilXG
         QviA00Hqb+q1buBMvHcVlb8+Fd37OwhgMhA8UTnzDyiKOoxFqV+8PltGs3Q2MhGhy5ca
         Up51psFk4Z6gefyypAJ4a1+BZJ8cRFVsM3zCe5HV01U2KgWmqIEjdk0lnsOXp7SAoQF6
         jw2g==
X-Gm-Message-State: AOAM532aAPkeFH9A8/jFT5glC8hatfnho3TFH0raxhPaCwhFz1Di4A3K
        cOy3BVoqTWqjRP7FIIHF2i+pD8h/POadr2dwUqx1bh9lEvvcgt8I0a0jDpszhNldTKDcsyG6ZQE
        LL+Uk+/Jn+Z4mjA2zA8FwQnYU32JsnRM7UPafwGraHg==
X-Received: by 2002:a2e:a171:: with SMTP id u17mr4669563ljl.371.1634807410715;
        Thu, 21 Oct 2021 02:10:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJi51V3uLcQ6VQf22lZE+UEugXH6TyHQQH8xsi40Ilosw8EeaKsw6tjG5kUM2pWTCLIevk/g==
X-Received: by 2002:a2e:a171:: with SMTP id u17mr4669547ljl.371.1634807410497;
        Thu, 21 Oct 2021 02:10:10 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v7sm523707lji.81.2021.10.21.02.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 02:10:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [GIT PULL] riscv: dts: few cleanups for v5.16
Date:   Thu, 21 Oct 2021 11:09:55 +0200
Message-Id: <20211021090955.115005-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

I have an old patchset for RISC-V dts cleanups which I sent to mailing lists in
August 2021 (v1, v2), resent in September and pinged two times.  They got some
review (from Alexandre Ghiti for SiFive, from Conor Dooley for Microchip) but
unfortunately Palmer (RISC-V maintainer) did not respond here.

The usual RISC-V patches go via Palmer to Linus and I am not planning to change
that, but I want to get these fixed.

Could you grab these to soc tree?

Best regards,
Krzysztof



The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/riscv-sifive-dt-5.16

for you to fetch changes up to 9962a066f3c1d4588d0dd876ceac2c03ef87acf3:

  riscv: dts: sifive: add missing compatible for plic (2021-10-19 10:59:57 +0200)

----------------------------------------------------------------
RISC-V DTS changes for v5.16

Cleanups of RISC-V SiFive and Microchip DTSes with dtschema.  These are
few minor fixes to make DTSes pass the dtschema, without actual
functional effect.

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      riscv: dts: sifive: use only generic JEDEC SPI NOR flash compatible
      riscv: dts: sifive: fix Unleashed board compatible
      riscv: dts: sifive: drop duplicated nodes and properties in sifive
      riscv: dts: microchip: add missing compatibles for clint and plic
      riscv: dts: sifive: add missing compatible for plic

 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi   |  4 ++--
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi          |  2 +-
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 10 +++-------
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts |  7 +------
 4 files changed, 7 insertions(+), 16 deletions(-)
