Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBB0437227
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhJVGv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:51:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59724 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhJVGvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:51:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F30621987;
        Fri, 22 Oct 2021 06:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634885345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZGFLBrnqymYc576QWcBAPp39DNchapbOqDccE+bC2B4=;
        b=nPoFYAlsG8eI8QkyTtJ/jdrD187CIaKEB4Pi66VrVfFl0vcOszW9dWtjskMIuFJmaWrTGi
        j5DMQGG6b282uRpPenKQornG6hFnM1Y1PwxQUDx58+8xV9Pkkwpo1qiiW0HR7Vfe9t76Zf
        vrKs9+fZVIPp2gILTgfmowX+yujaT6s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27AD313AAD;
        Fri, 22 Oct 2021 06:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4MdyCOFecmEIEwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 22 Oct 2021 06:49:05 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 3/5] xen: flag hvc_xen to be not essential for system boot
Date:   Fri, 22 Oct 2021 08:47:58 +0200
Message-Id: <20211022064800.14978-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211022064800.14978-1-jgross@suse.com>
References: <20211022064800.14978-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen pv console driver is not essential for boot. Set the respective
flag.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/tty/hvc/hvc_xen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index f0bf01ea069a..71e0dd2c0ce5 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -522,6 +522,7 @@ static struct xenbus_driver xencons_driver = {
 	.remove = xencons_remove,
 	.resume = xencons_resume,
 	.otherend_changed = xencons_backend_changed,
+	.not_essential = true,
 };
 #endif /* CONFIG_HVC_XEN_FRONTEND */
 
-- 
2.26.2

