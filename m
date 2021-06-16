Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDD03A961B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhFPJaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhFPJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:29:58 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B7C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:27:52 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:cc2e:97ae:7127:22f8])
        by michel.telenet-ops.be with bizsmtp
        id HlTp2500751zX4F06lTpiM; Wed, 16 Jun 2021 11:27:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltRps-0009M5-Ly; Wed, 16 Jun 2021 11:27:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltRpr-0060Yt-Lp; Wed, 16 Jun 2021 11:27:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] of: Miscellaneous fixes and cleanups
Date:   Wed, 16 Jun 2021 11:27:43 +0200
Message-Id: <cover.1623835273.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains a fix and two cleanups for the OF code.

Thanks!

Geert Uytterhoeven (3):
  of: Fix truncation of memory sizes on 32-bit platforms
  of: Remove superfluous casts when printing u64 values
  of: kexec: Always use FDT_PROP_INITRD_START and FDT_PROP_INITRD_END

 drivers/of/address.c         | 14 ++++----------
 drivers/of/fdt.c             | 14 ++++++--------
 drivers/of/kexec.c           |  4 ++--
 drivers/of/of_reserved_mem.c |  8 ++++----
 4 files changed, 16 insertions(+), 24 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
