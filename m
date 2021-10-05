Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27657422A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhJEOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbhJEOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:09 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9CCC08E868;
        Tue,  5 Oct 2021 07:03:25 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HNznl3pTBzQkHt;
        Tue,  5 Oct 2021 16:03:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=sSUSvUhYetKqhetcftUrbC/bhAw4qXKyzeHFsBWvZ/M=;
        b=pAbuOv3cT8fcMIdvXGN+/n7/1iIJcjN/BIYv1mQ81+qdwdV24Qu+4xx9ZWdMMLP6/rUrYI
        0AyGBKXaSCuKS/naXhVoTCX+lYmQCDaXWAvWkj7j4oABGdneijm1F+m/Z8iJTNS+uupeVT
        yuO4QAWtGXwcN+uAZeeyZeF+lxS/2PpSfTq5N+JDp//5C5zbsNwwKGEwPkNdx8u+jP41BJ
        37wGOzfnO64T1xJ7qoLkHDNhRtXYFpsex0X7hfR/Y9jo40vN8W1LBuuFWxzybkeUj2+3EL
        9AMZsKN//HW3GY3iysYkbJRXLMuN0NkGQPdwHblj6Bl3+MZLfni5To2AUBn4Qg==
X-Mailbox-Line: From d28be71c181a0626326d558a6dd3a59a5ad5aeb6 Mon Sep 17 00:00:00 2001
Message-Id: <d28be71c181a0626326d558a6dd3a59a5ad5aeb6.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 13:37:30 +0100
Subject: [PATCH 04/13] usb: core: config: Avoid multiple line derefrence
X-Rspamd-Queue-Id: BFFFD2A7
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:

core/config.c:816: WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'intfc->altsetting[n].desc.bAlternateSetting'

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 5de26d64a00b..f6c90214bba0 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -812,8 +812,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 		intfc = config->intf_cache[i];
 		for (j = 0; j < intfc->num_altsetting; ++j) {
 			for (n = 0; n < intfc->num_altsetting; ++n) {
-				if (intfc->altsetting[n].desc.
-				    bAlternateSetting == j)
+				if (intfc->altsetting[n].desc.bAlternateSetting == j)
 					break;
 			}
 			if (n >= intfc->num_altsetting)
-- 
2.32.0

