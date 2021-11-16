Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CFC45343E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbhKPOgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:36:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36816 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbhKPOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:36:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C61B2193C;
        Tue, 16 Nov 2021 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637073205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RN73WCaI8ljpUhVqo26XGliZVk9RTxTm02hvTAgXtAg=;
        b=Ix/M4CSo6AbjQJA+iGmiKSfudM/ceqO3tzFqj3tSGY7C84To/aSMZ2FE3CJ85liPpG1b9d
        B0hCRJnX+ZwBzfPtQHPYwSiY/fCInxhcmeF6PrkBjqq/Iz/UgExjVMGbBW1GRJgnpTnzse
        91OKAXqBVyFgGVjSljDQ+aK/jWSlC88=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EF2B13BAE;
        Tue, 16 Nov 2021 14:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1sJ0AjXBk2EEGwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 16 Nov 2021 14:33:25 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     linux@weissschuh.net, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH] xen/privcmd: make option visible in Kconfig
Date:   Tue, 16 Nov 2021 15:33:23 +0100
Message-Id: <20211116143323.18866-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration option provides a misc device as an API to userspace.
Make this API usable without having to select the module as a transitive
dependency.

This also fixes an issue where localyesconfig would select
CONFIG_XEN_PRIVCMD=m because it was not visible and defaulted to
building as module.

Based-on-patch-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index a1b11c62da9e..a2e91d3ca372 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -259,9 +259,14 @@ config XEN_SCSI_BACKEND
 	  if guests need generic access to SCSI devices.
 
 config XEN_PRIVCMD
-	tristate
+	tristate "Xen hypercall passthrough driver"
 	depends on XEN
 	default m
+	help
+	  The hypercall passthrough driver allows user land programs to perform
+	  Xen hypercalls. This driver is normally required for systems running
+	  as Dom0 to perform privileged operations, but in some disaggregated
+	  Xen setups this driver might be needed for other domains, too.
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-- 
2.26.2

