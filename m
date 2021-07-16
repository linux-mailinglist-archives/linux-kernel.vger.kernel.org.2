Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C343CB10E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 05:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhGPDTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 23:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhGPDTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 23:19:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C766C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 20:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vOMhb0wTnjZKV2R3O4+NFOAUlpGSLLchFVox8X6u+Co=; b=AjYIuxPHCIJKlst1I2ZWm19IUx
        xqt2uROJwPXuO13eIzlJpCF55aQv8UeLMDtYZUN0vZwR3WkYNd/PgWG3ZTtZvsq9NImzu2BLDXln0
        vf4v7ifWRWDUJ7lF1Ak9Zrqw8exBrVcy6+8eatQFLXjMfSCcaLfr14ivF2ZOSYbo3MJNmIoWXYEZF
        3xdwy/wR3mPNyCh6p3MeubbyIk4XYeGO2TlBI2P2DVrQx2W5oIvtzTnI0H8hxL5CF4bdC0KleTh22
        dnCB93P4ocHVBgkdnhVNJsBTsRo16vt+cqBkQpjY2c2tcNY6UeQDAr1ZLigw4no2hBRJ2/czcGP8B
        V66riJVw==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4EKm-0030aG-VJ; Fri, 16 Jul 2021 03:16:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 RESEND] x86/tools: fix objdump version check again
Date:   Thu, 15 Jul 2021 20:16:15 -0700
Message-Id: <20210716031615.4429-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip (omit) any version string info that is parenthesized.

Warning: objdump version 15) is older than 2.19
build-r1020.out:Warning: Skipping posttest.

when 'objdump -v' says:
GNU objdump (GNU Binutils; SUSE Linux Enterprise 15) 2.35.1.20201123-7.18

Fixes: 8bee738bb1979 ("x86: Fix objdump version check in chkobjdump.awk for different formats.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
---
v2: rebase & resend

 arch/x86/tools/chkobjdump.awk |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210715.orig/arch/x86/tools/chkobjdump.awk
+++ linux-next-20210715/arch/x86/tools/chkobjdump.awk
@@ -10,6 +10,7 @@ BEGIN {
 
 /^GNU objdump/ {
 	verstr = ""
+	gsub(/\(.*\)/, "");
 	for (i = 3; i <= NF; i++)
 		if (match($(i), "^[0-9]")) {
 			verstr = $(i);
