Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2435242465F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbhJFTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:00:54 -0400
Received: from wrqvxttq.outbound-mail.sendgrid.net ([149.72.167.116]:42234
        "EHLO wrqvxttq.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhJFTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wasin.io;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=s1; bh=cwoMxqGWSt3BO2nOoSMa84BFuZND+djw3Sn79Yk2hEo=;
        b=vwUAYZemmOCawTYdXC4hEM5jF5v1zHA9bFeC5mvFB6mie7qCv1w4n/uvBi+nXOUbsDKT
        HsegwxRp5E99J62mX2qdFttr6tXHpDVrODgtW+yy06FIt+yZimiKixx5gatfKPHbJIc1jl
        V/AX3W+bbfxsjVJtGEt9fJpOvpE3W4Qu+LODlYWRRRTtnUMcCWgvEkRweMeVsJJlYbYNxY
        0Kp/sIelo4G3xPVBPw7t5VFwqfTuwzk7n3HEh9xDq7YFS1NzS4mX0ZuiBgjACE046VSGDx
        TQerJ3ff7liNa/41OmGJ8UUwYLtRXXFDwIJczaKOCdLShWUBQHGsETl0jupba8cA==
Received: by filterdrecv-7bf5c69d5-n84ln with SMTP id filterdrecv-7bf5c69d5-n84ln-1-615DF1F3-55
        2021-10-06 18:58:59.900105142 +0000 UTC m=+3011919.492751969
Received: from mail.wasin.io (unknown)
        by geopod-ismtpd-5-0 (SG) with ESMTP
        id w6RrkRj2SJqaNnYB9I2ihA
        for <linux-kernel@vger.kernel.org>;
        Wed, 06 Oct 2021 18:58:59.180 +0000 (UTC)
Received: from mail.wasin.io (localhost.localdomain [127.0.0.1])
        by mail.wasin.io (Postfix) with ESMTP id 83E8CA7943
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 02:07:11 +0800 (SGT)
X-Virus-Scanned: Debian amavisd-new at mail.wasin.io
Received: from mail.wasin.io ([127.0.0.1])
        by mail.wasin.io (mail.wasin.io [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WIIchQjEnK9E for <linux-kernel@vger.kernel.org>;
        Thu,  7 Oct 2021 02:06:48 +0800 (SGT)
Received: from haxpor-desktop.fritz.box (unknown [185.134.6.138])
        by mail.wasin.io (Postfix) with ESMTPSA id 44F3EA792E;
        Thu,  7 Oct 2021 02:06:40 +0800 (SGT)
From:   Wasin Thonkaew <wasin@wasin.io>
Subject: [PATCH RESEND] include/asm-generic/error-injection.h: fix a spelling
 mistake, and a coding style issue
Date:   Wed, 06 Oct 2021 18:58:59 +0000 (UTC)
Message-Id: <20211006185615.127132-1-wasin@wasin.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?zTXXJmbXDq374aSgSvBccBfxYYlnkEq2csSLV7s2zvJ+VzBfif=2FVK=2F1r3dRlUa?=
 =?us-ascii?Q?HKdShZ1bg6oUZY4XHrArWuedgoPkS2pALNIA1gW?=
 =?us-ascii?Q?MM4qcFa+90Ks5W0M2p0OtF6z3vMv5jZxImPmxSr?=
 =?us-ascii?Q?vtlxlUnfrS6LnQZZiYWFYGe6MKySgIZE0hQ6inz?=
 =?us-ascii?Q?5Fx6Kcq3f8bU=2F+PY3y5KQyoKNTVzSQPRx=2F7xjvX?=
 =?us-ascii?Q?UiMw8a2JQq2ky67G0Xal07z0Zlq=2FlgWPBBReB2?=
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, wasin@wasin.io
X-Entity-ID: 9qDajD32UCSRojGE52wDxw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a spelling mistake "ganerating" -> "generating".
Remove trailing semicolon for a macro ALLOW_ERROR_INJECTION to fix a
coding style issue.

Signed-off-by: Wasin Thonkaew <wasin@wasin.io>
---
 include/asm-generic/error-injection.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 7ddd9dc10ce9..fbca56bd9cbc 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -20,7 +20,7 @@ struct pt_regs;
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 /*
- * Whitelist ganerating macro. Specify functions which can be
+ * Whitelist generating macro. Specify functions which can be
  * error-injectable using this macro.
  */
 #define ALLOW_ERROR_INJECTION(fname, _etype)				\
@@ -29,7 +29,7 @@ static struct error_injection_entry __used				\
 	_eil_addr_##fname = {						\
 		.addr = (unsigned long)fname,				\
 		.etype = EI_ETYPE_##_etype,				\
-	};
+	}
 
 void override_function_with_return(struct pt_regs *regs);
 #else
-- 
2.25.1

