Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB708351EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbhDASvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237185AbhDASdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:33:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98E606137A;
        Thu,  1 Apr 2021 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617293200;
        bh=pMvThrYGS+kTLiULFh4dIBeWNAKzy5JLuHHDyI1pkwA=;
        h=From:To:Cc:Subject:Date:From;
        b=sUl58mLkaTR9oMjcm37ZWZil8KHcEut+fwVOqvCsxf1KIZvwmchsC3jhRYbhoeRMH
         QWECMUqxpiu7vYySxroV32GhRv4sD5uaftM/mv8qMPw0Hum0Dyoih+q/oWYB9sw20/
         sPtYC8JIq2BiHaQWtfkis/euSRfTD5Daji81/lFG3K0Y1COtxpkYww8djzZEhVhdnM
         laYWMTpKoyWyx/KUUTfimKjg5oogULIO9TqKoKpV0cLdGCIJoutzOCSlGpbjmiXlIl
         Q5WrXp7j6S5oQEhOuv9DP3Tu8oflxVYQe1IDgVrgkZdTy1lvjYD09617icrrdiuqVE
         WG7kQqpvj3HRw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] overflow: improve check_shl_overflow comment
Date:   Thu,  1 Apr 2021 09:06:29 -0700
Message-Id: <20210401160629.1941787-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 'false' return means the value was safely set, so the comment should
say 'true' for when it is not considered safe.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/overflow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index ef74051d5cfed..0f12345c21fb5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -235,7 +235,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * - 'a << s' sets the sign bit, if any, in '*d'.
  *
  * '*d' will hold the results of the attempted shift, but is not
- * considered "safe for use" if false is returned.
+ * considered "safe for use" if true is returned.
  */
 #define check_shl_overflow(a, s, d) __must_check_overflow(({		\
 	typeof(a) _a = a;						\
-- 
2.25.4

