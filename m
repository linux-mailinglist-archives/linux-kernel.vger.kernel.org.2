Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03531102D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhBERBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:01:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233680AbhBEQrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:47:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F96964E4D;
        Fri,  5 Feb 2021 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612549735;
        bh=cDXk9MQSqiJdERDqiVBVXUYsbbsTj7YvOt3iOUzRiq4=;
        h=From:To:Cc:Subject:Date:From;
        b=OaRJhFk82sN5offnYX7YrpEmbPCtHr2xl2SdCzM2qNbkulXvT+0muyk3zd2Cnte1s
         Srnsb49FXpRM4tMKEml9evlI3Animujfuj3iRd+3ot4WNguxastCBBn732fufX3hLW
         ebZ+lbTYUCh9tgZqQihQ8NbPDR4+BECa9be82PCLKQUfBedYFNH+FQa9aQAkR5xFNg
         nJjGVvuSv3n7365ANRew3X5pH1zY6PpKr7zpCDZdkal9BaXVH3rQC8cQh2GT1gh3Eh
         v1ApHpZwrAY2z2am/+lhTyqNKLvx4O0OWU+OWiBgMmNUiqEMY0rBaSvbnvoVgL/89d
         v0h18toDwaPOw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     dave.hansen@intel.com, Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: Add Dave Hansen as reviewer for INTEL SGX
Date:   Fri,  5 Feb 2021 20:28:39 +0200
Message-Id: <20210205182840.2260-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Dave as reviewer for INTEL SGX patches.

Cc: Borislav Petkov <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b66de2097d6..41b78e20bd1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9227,6 +9227,7 @@ F:	include/linux/tboot.h
 
 INTEL SGX
 M:	Jarkko Sakkinen <jarkko@kernel.org>
+R:	Dave Hansen <dave.hansen@linux.intel.com>
 L:	linux-sgx@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/intel-sgx/list/
-- 
2.30.0

