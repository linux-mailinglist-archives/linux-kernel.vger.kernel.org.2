Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D2C445162
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 11:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhKDKCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 06:02:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhKDKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 06:02:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 25A3F2112B;
        Thu,  4 Nov 2021 10:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636020001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sPVLpMz2a2Hd4DMqWUY0Jh249thBZhWkZ9sAfNLacFU=;
        b=numXjEeMu+cIWLOSyuKM/GU1mzscb3k2lBkYvmGUOJVug6te9Ym+0fb6ty20ssvgtLqZmC
        G7ygtdpPc955TYvfv0uu6gOlf01IYC5nLwtcb0fUpHY6FeEhuJkj3kXKN57VRxCjX/tpst
        NGue5lWytioEW1GgowrRJAAIYrjgz+0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE46713BD4;
        Thu,  4 Nov 2021 10:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eKezOCCvg2HZKQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 04 Nov 2021 10:00:00 +0000
From:   Juergen Gross <jgross@suse.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>
Subject: [PATCH] MAINTAINERS: add some information to PARAVIRT_OPS entry
Date:   Thu,  4 Nov 2021 10:59:55 +0100
Message-Id: <20211104095955.4813-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most patches for paravirt_ops are going through the tip tree, as those
patches tend to touch x86 specific files a lot.

Add the x86 ML and the tip tree to the PARAVIRT_OPS MAINTAINERS entry
in order to reflect that.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f7288596157..a56f1d728f57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14324,7 +14324,9 @@ M:	Juergen Gross <jgross@suse.com>
 M:	Deep Shah <sdeep@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
+L:	x86@kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	Documentation/virt/paravirt_ops.rst
 F:	arch/*/include/asm/paravirt*.h
 F:	arch/*/kernel/paravirt*
-- 
2.26.2

