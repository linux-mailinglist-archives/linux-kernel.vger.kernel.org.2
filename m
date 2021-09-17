Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB940F54D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbhIQJw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbhIQJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:52:09 -0400
X-Greylist: delayed 2423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Sep 2021 02:50:43 PDT
Received: from cambridge.shadura.me (cambridge.shadura.me [IPv6:2a00:1098:0:86:1000:13:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D37C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=shadura.me;
         s=a; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:To:
        From:Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References; bh=kAmcUJE+s+UcKX3tNEpbHw9iTWpmSyWHDjrODS1EYpk=; b=KP
        FJt/58aEUII+9uyzaP16ykm4eRNhFSP/f/ALUj88l+QHC/EOVTlKSc9quaORCOKcqpnaRC6yNtohx
        kFI8bc8zOGVEwGihBvhizD2JomHmlk1CX4pCYs60oFxVIWnYBMiespvD8Z7XsyskkvYaj5muK4aRE
        Y6Qz9IQJJV1ozDY=;
Received: from [90.221.255.109] (helo=localhost)
        by cambridge.shadura.me with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <andrew@shadura.me>)
        id 1mR9sw-0003hp-4E; Fri, 17 Sep 2021 11:10:18 +0200
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
To:     linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH RESEND] mailmap: add Andrej Shadura
Date:   Fri, 17 Sep 2021 10:10:16 +0100
Message-Id: <20210917091016.30232-1-andrew.shadura@collabora.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mapping for my old work email for BelDisplayTech to the personal
email, and make sure the Collabora email has the correct spelling
of the first name.

Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 6e849110cb4e..90e614d2bf7e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -33,6 +33,8 @@ Al Viro <viro@zenIV.linux.org.uk>
 Andi Kleen <ak@linux.intel.com> <ak@suse.de>
 Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>
 Andreas Herrmann <aherrman@de.ibm.com>
+Andrej Shadura <andrew.shadura@collabora.co.uk>
+Andrej Shadura <andrew@shadura.me> <andrew@beldisplaytech.com>
 Andrew Morton <akpm@linux-foundation.org>
 Andrew Murray <amurray@thegoodpenguin.co.uk> <amurray@embedded-bits.co.uk>
 Andrew Murray <amurray@thegoodpenguin.co.uk> <andrew.murray@arm.com>
-- 
2.31.1

