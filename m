Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089453A8862
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFOSTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhFOSTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:19:51 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08992C0613A3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:17:45 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:bda0:7de0:767e:26f9])
        by michel.telenet-ops.be with bizsmtp
        id HWHe2500A4N5gS306WHefl; Tue, 15 Jun 2021 20:17:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltDd4-00HYOO-4w; Tue, 15 Jun 2021 20:17:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltDd3-005qAB-MU; Tue, 15 Jun 2021 20:17:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] Add generic-support for linux,elfcorehdr and fix riscv
Date:   Tue, 15 Jun 2021 20:17:24 +0200
Message-Id: <cover.1623780059.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

While working on v4 of "[PATCH v3] ARM: Parse kdump DT properties", I
noticed the recently (v5.13-rc1) introduced RISC-V crash kernel support
uses "linux,elfcorehdr" in a non-standard way.  Instead of relying on a
"linux,elfcorehdr" property under the "/chosen" node, RISC-V uses a
reserved memory node with the "linux,elfcorehdr" compatible value.

As we may want to fix riscv before the release of v5.13, I decided not
to wait until my full v4 is ready, but fast-track generic
"linux,elfcorehdr" handling instead.

This series consists of 3 patches:
  1. Generic handling of "linux,elfcorehdr", as requested by Rob in a
     review comment for [1],
  2. Drop the non-standard code from riscv.  It can just use the generic
     code instead (needs corresponding changes to WIP kexec-tools),
  3. Drop the now duplicate code from arm64.  This can be postponed, as
     it can co-exist safely with the generic code.

This has been tested on arm32 (with a WIP successor of [1]), and
compile-tested on riscv64 and arm64.

Thanks for your comments!

[1] "[PATCH v3] ARM: Parse kdump DT properties"
    https://lore.kernel.org/linux-devicetree/20210317113130.2554368-1-geert+renesas@glider.be/

Geert Uytterhoeven (3):
  of: fdt: Add generic support for parsing elf core header properties
  riscv: Remove non-standard linux,elfcorehdr handling
  arm64: kdump: Remove custom linux,elfcorehdr parsing

 Documentation/devicetree/bindings/chosen.txt |  6 ++--
 arch/arm64/mm/init.c                         | 21 -----------
 arch/riscv/mm/init.c                         | 20 -----------
 drivers/of/fdt.c                             | 37 ++++++++++++++++++--
 4 files changed, 37 insertions(+), 47 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
