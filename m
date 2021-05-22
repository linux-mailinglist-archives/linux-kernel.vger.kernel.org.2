Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8637838D780
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 23:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhEVVWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 17:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhEVVWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 17:22:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB0C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wcv2ThiXVnl/yNUWKXIyeJhKwjtkGI4Y78Y/91jUBdM=; b=Zy/28i2k7/Su2oNUKE8TQCv34G
        0uGy6JWMns/WO/LvXCT/Cj05lnhm9/mU6M2tkKhCxpLyF+f3aJ0r2AMMlWmjSukq2xD+e6kQWmjOS
        kNMk5yjgKfwXDaIJxqWFBdKSWsFiVEw4LmZm49l7xAnyqTyWG+UsyYJMoVdigSbIsnXDhfh+D0V3A
        91GhZxEYEFGzmFXLSjYAwijc9NkoBfhXN3uoE+4GQFBrcdKDA0TjLuPgGKXxni1BvUhZciiWxyah2
        04tCyz+JPxJMvqi86lzoFuAPlkT/xKaJwxuKcouSD5VNXPwN+wJWaevMjlUbL4EOUm/ok4/zXdI2Z
        zN1Advmw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkZ30-000D27-Hq; Sat, 22 May 2021 21:20:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH] riscv: sifive: fix Kconfig errata warning
Date:   Sat, 22 May 2021 14:20:36 -0700
Message-Id: <20210522212036.5513-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SOC_SIFIVE Kconfig entry unconditionally selects ERRATA_SIFIVE.
However, ERRATA_SIFIVE depends on RISCV_ERRATA_ALTERNATIVE, which is
not set, so SOC_SIFIVE should either depend on or select
RISCV_ERRATA_ALTERNATIVE. Use 'select' here to quieten the Kconfig
warning.

WARNING: unmet direct dependencies detected for ERRATA_SIFIVE
  Depends on [n]: RISCV_ERRATA_ALTERNATIVE [=n]
  Selected by [y]:
  - SOC_SIFIVE [=y]

Fixes: 1a0e5dbd3723 ("riscv: sifive: Add SiFive alternative ports")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/Kconfig.socs |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210521.orig/arch/riscv/Kconfig.socs
+++ linux-next-20210521/arch/riscv/Kconfig.socs
@@ -14,6 +14,7 @@ config SOC_SIFIVE
 	select CLK_SIFIVE
 	select CLK_SIFIVE_PRCI
 	select SIFIVE_PLIC
+	select RISCV_ERRATA_ALTERNATIVE
 	select ERRATA_SIFIVE
 	help
 	  This enables support for SiFive SoC platform hardware.
