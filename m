Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A27C33B323
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCOM7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:59:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42592 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhCOM7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:59:04 -0400
Received: from zn.tnic (p200300ec2f0786006d6cd745861f0d39.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8600:6d6c:d745:861f:d39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1BA81EC0575;
        Mon, 15 Mar 2021 13:59:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615813143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=tolNH78MDafCo6OmdedWs5qrn87ST6ePQZrYtUe6aZM=;
        b=BBNLzwvSsB9aIkxPQAJePjOjZ15ZoYggn5aHOJLtBOgSpR1zMBja4az1ht7s9vR0w1PQ2E
        tCi3cZr5TkKdAFfEz/eY/30/qpF4Zs+kD8D1o55cBhLtZEax9rBzjVL20cKKyrtImLiwbN
        3zYMiXrmzBNCAodpefNfeexQiCv9pCk=
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] tools/x86/kcpuid: Check last token too
Date:   Mon, 15 Mar 2021 13:59:00 +0100
Message-Id: <20210315125901.30315-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Input lines like

  0x8000001E,     0, EAX,   31:0, Extended APIC ID

where the short name is missing lead to a segfault because the loop
takes the long name for the short name and tokens[5] becomes NULL which
explodes later in strcpy().

Check its value too before further processing.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 6048da34fcc6..dae75511fef7 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -324,6 +324,8 @@ static int parse_line(char *line)
 		str = NULL;
 	}
 	tokens[5] = strtok(str, "\n");
+	if (!tokens[5])
+		goto err_exit;
 
 	/* index/main-leaf */
 	index = strtoull(tokens[0], NULL, 0);
-- 
2.29.2

