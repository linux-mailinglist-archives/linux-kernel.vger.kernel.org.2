Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB44237E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJFGVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:21:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54596 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJFGVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:21:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C6A622470;
        Wed,  6 Oct 2021 06:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633501193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OEUzqfY9J3CJj8oYNpzjv2N/kxiY+V/QZvH33Q4Al1A=;
        b=iRZshKpiC7wF4aJj5AuGpMoKfhXQsUwB/PQWxgWHbFgtCRQFLYg1DoTtWDS8kxwUdPPK0j
        pvoYqwcdODu5OzsKZj0f9BjgRvVWgW0CXV8TQALMuH+bSDAccnaTbtFUDGNGPy1K4A2pZg
        w5dEBFIakM8iMcUprtaHxXfjg7YXLyQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34CED13DF0;
        Wed,  6 Oct 2021 06:19:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id URSDCwlAXWGebAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 06 Oct 2021 06:19:53 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] x86/pvh: add prototype for xen_pvh_init()
Date:   Wed,  6 Oct 2021 08:19:50 +0200
Message-Id: <20211006061950.9227-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_pvh_init() is lacking a prototype in a header, add it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/xen/hypervisor.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index ff4b52e37e60..4957f59deb40 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -62,4 +62,8 @@ void xen_arch_register_cpu(int num);
 void xen_arch_unregister_cpu(int num);
 #endif
 
+#ifdef CONFIG_PVH
+void __init xen_pvh_init(struct boot_params *boot_params);
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
-- 
2.26.2

