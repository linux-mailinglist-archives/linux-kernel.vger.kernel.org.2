Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA284421B0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJEAVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJEAVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:21:07 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83591C061749;
        Mon,  4 Oct 2021 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UGnZuFAcpMUOmEXXyT7AcnFvYR5lLxeczg5QY3FKNLY=; b=xDuLagZaSCnZjjWpsOiriywC9q
        g+u74sCgC9CoPdFGVR0t42o4iAhCEdnEvihJKNkIu2EL9QrE1QTjl8AyvhD8AldymGBa1cJeSoR8N
        eLYSl+pNq9KgPCL6mVJ0tvZhvBbMuqfAdOciUzHwzIXOdcdmkaaytVKnP4qb02eI2dvzDSOGA0Utv
        393asZkp1N9cxRMsDvvvzkxfdThCLTQfkiHX8LHJe+lLJpk8lxCT4ICvBNzNLj5Fz+XCfFeQYUxcY
        et+h6Y6rzbz1/KYQZVGnPAKi2dsJ7w/9MXWdTO02aOszs1qp81fhFZghpkwH3nhTz2sz0/VCZRWmm
        o3UlF5nQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXYAv-008SGi-35; Tue, 05 Oct 2021 00:19:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/5 v3] sh: define __BIG_ENDIAN for math-emu
Date:   Mon,  4 Oct 2021 17:19:13 -0700
Message-Id: <20211005001914.28574-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211005001914.28574-1-rdunlap@infradead.org>
References: <20211005001914.28574-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this by defining both ENDIAN macros in
<asm/sfp-machine.h> so that they can be utilized in
<math-emu/soft-fp.h> according to the latter's comment:
/* Allow sfp-machine to have its own byte order definitions. */

(This is what is done in arch/nds32/include/asm/sfp-machine.h.)

This placates these build warnings:

In file included from ../arch/sh/math-emu/math.c:23:
../include/math-emu/single.h:50:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
   50 | #if __BYTE_ORDER == __BIG_ENDIAN
In file included from ../arch/sh/math-emu/math.c:24:
../include/math-emu/double.h:59:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
   59 | #if __BYTE_ORDER == __BIG_ENDIAN

Fixes: 4b565680d163 ("sh: math-emu support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
v2: use same preprocessor method that nds32 does;
    add Geert's Reviewed-by;
    renumber patches;
    add more Cc's;
v3: renumber, rebase, and resend;
    add Tested-by: JPAG;

 arch/sh/include/asm/sfp-machine.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-next-20211001.orig/arch/sh/include/asm/sfp-machine.h
+++ linux-next-20211001/arch/sh/include/asm/sfp-machine.h
@@ -13,6 +13,14 @@
 #ifndef _SFP_MACHINE_H
 #define _SFP_MACHINE_H
 
+#ifdef __BIG_ENDIAN__
+#define __BYTE_ORDER __BIG_ENDIAN
+#define __LITTLE_ENDIAN 0
+#else
+#define __BYTE_ORDER __LITTLE_ENDIAN
+#define __BIG_ENDIAN 0
+#endif
+
 #define _FP_W_TYPE_SIZE		32
 #define _FP_W_TYPE		unsigned long
 #define _FP_WS_TYPE		signed long
