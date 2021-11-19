Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17894571C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhKSPmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:42:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56682 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhKSPmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:42:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 205451FD38;
        Fri, 19 Nov 2021 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637336356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1j1MNeLLIwQNenVL0GJ3LtVT6hsmn8LBmDa9I+SCdEA=;
        b=RRukonH7VR6a1V4h76tfh3yTxEh1jKqtgW3gZCl02/vOmRZrwXpGtTKwN9imaZUi+HXqEh
        +3AhXsHfIbOUPR7338tVCJ+O6KlQsKvsvZ3//UbZE/rqgP+yDnySYUTcEXjPcVb8wLEnZW
        1pnMgHlMZF+e7t7xPwxtiE0zE/fh958=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5A7C13B35;
        Fri, 19 Nov 2021 15:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HM/1LiPFl2HIIwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 19 Nov 2021 15:39:15 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] xen/pvh: add missing prototype to header
Date:   Fri, 19 Nov 2021 16:39:13 +0100
Message-Id: <20211119153913.21678-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prototype of mem_map_via_hcall() is missing in its header, so add
it.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: a43fb7da53007e67ad ("xen/pvh: Move Xen code for getting mem map via hcall out of common file")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/xen/hypervisor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 4957f59deb40..5adab895127e 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -64,6 +64,7 @@ void xen_arch_unregister_cpu(int num);
 
 #ifdef CONFIG_PVH
 void __init xen_pvh_init(struct boot_params *boot_params);
+void __init mem_map_via_hcall(struct boot_params *boot_params_p);
 #endif
 
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
-- 
2.26.2

