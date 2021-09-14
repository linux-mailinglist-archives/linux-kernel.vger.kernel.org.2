Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC640B95A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhINUiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:38:22 -0400
Received: from wrqvxttq.outbound-mail.sendgrid.net ([149.72.167.116]:33593
        "EHLO wrqvxttq.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233416AbhINUiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:38:21 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Sep 2021 16:38:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wasin.io;
        h=from:subject:mime-version:to:cc:content-type:
        content-transfer-encoding;
        s=s1; bh=cwoMxqGWSt3BO2nOoSMa84BFuZND+djw3Sn79Yk2hEo=;
        b=hheert+vcHXb7m23oDeiaNiYKBz1pZ7BA0pN/0lZ37Rg8zBOqLOAYwq23aFo7NypdWDR
        6X++23ZWXKGheSCHl8yo1BWq+7RwWiJ6eyIgB7USMYiKXfDb4Y6BrZ3YbuxtRCACCQGkDP
        m6vYbc+fQ88QkJQkGndowquUEofarY2vIO74JF/aNZGn02X4n7k7h6KRta1z9qyXvJZSyQ
        AiaEQ6HZkLodUAPEt9G8M4D4/ZjfKc4pQrrivwF1KabRFF4TtPTkr/lLLGz6OvQcbaaogu
        KnJE4bwTsaBjw1fcOq62whr78KTAaY/T/iaabvESf9jX3Ki0jufUof+ec02YHIcQ==
Received: by filterdrecv-7bf5c69d5-v7fwm with SMTP id filterdrecv-7bf5c69d5-v7fwm-1-614106BF-79
        2021-09-14 20:31:59.950264904 +0000 UTC m=+1116706.188552062
Received: from mail.wasin.io (unknown)
        by geopod-ismtpd-5-0 (SG) with ESMTP
        id KIafmjyYT4i2NMyUaX0OAA
        for <linux-kernel@vger.kernel.org>;
        Tue, 14 Sep 2021 20:31:59.546 +0000 (UTC)
Received: from mail.wasin.io (localhost.localdomain [127.0.0.1])
        by mail.wasin.io (Postfix) with ESMTP id 2F047A6CFD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 03:43:18 +0800 (SGT)
X-Virus-Scanned: Debian amavisd-new at mail.wasin.io
Received: from mail.wasin.io ([127.0.0.1])
        by mail.wasin.io (mail.wasin.io [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1_ZfKbKOeQma for <linux-kernel@vger.kernel.org>;
        Wed, 15 Sep 2021 03:42:54 +0800 (SGT)
Received: from haxpor-desktop (unknown [185.134.6.138])
        by mail.wasin.io (Postfix) with ESMTPSA id C25EFA0A25;
        Wed, 15 Sep 2021 03:42:47 +0800 (SGT)
Date:   Tue, 14 Sep 2021 20:32:00 +0000 (UTC)
From:   Wasin Thonkaew <wasin@wasin.io>
Subject: [PATCH] include/asm-generic/error-injection.h: fix a spelling
 mistake, and a coding style issue
Message-ID: <YUEGmz23fZeoExBF@haxpor-desktop>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?zTXXJmbXDq374aSgSvBccBfxYYlnkEq2csSLV7s2zvJ+VzBfif=2FVK=2F1r3dRlUa?=
 =?us-ascii?Q?HKdShZ1bg6oUZY4XHrArWueZhsGUvUpCS+C7EuF?=
 =?us-ascii?Q?GWHzyTNIIrI2B7bBmTcMYRzF+3QWSbTVdKnKjr+?=
 =?us-ascii?Q?nv45mdDFtDPMwo0hhlf91lOpvATeiQU2RSrG5QK?=
 =?us-ascii?Q?HW3xnzYdfHi5eRe0SLW1Ise3JaIJ+GdUWZPOClS?=
 =?us-ascii?Q?qt5xibb196=2FXjgm4Wqn+IBEGCvMi=2FcCXQFeBj7?=
To:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, wasin@wasin.io
X-Entity-ID: 9qDajD32UCSRojGE52wDxw==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
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

