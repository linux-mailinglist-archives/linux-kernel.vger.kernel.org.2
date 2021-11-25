Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35445D71C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354105AbhKYJ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:26:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55010 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344779AbhKYJYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:24:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 40F851FDF3;
        Thu, 25 Nov 2021 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637832059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rll1uYbFob7J30NMc3pj9IfWKE4UB2l0V0OWrDn+p70=;
        b=MAzp7gBiss3bNz8fRBLhUjFo+YXsTYcsfFvb3J7ImaGbepkDIH1SGe2msLKgNFXEi4OVni
        B0I5WH/p73MjCakbEsECLNUqv+zu05JoecDnZnOZYPBEyKeSHyHbMQFKS+3bLIB6PDimN7
        tcANznhZd2iK8u9yf/+8D/pWWmbMcdk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9EFA13F62;
        Thu, 25 Nov 2021 09:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qJGiN3pVn2FpHwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 25 Nov 2021 09:20:58 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] xen: make HYPERVISOR_set_debugreg() always_inline
Date:   Thu, 25 Nov 2021 10:20:56 +0100
Message-Id: <20211125092056.24758-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125092056.24758-1-jgross@suse.com>
References: <20211125092056.24758-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HYPERVISOR_set_debugreg() is being called from noinstr code, so it
should be attributed "always_inline".

Fixes: 7361fac0465ba96ec8f ("x86/xen: Make set_debugreg() noinstr")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/xen/hypercall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 28ca1119606b..e5e0fe10c692 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -281,7 +281,7 @@ HYPERVISOR_callback_op(int cmd, void *arg)
 	return _hypercall2(int, callback_op, cmd, arg);
 }
 
-static inline int
+static __always_inline int
 HYPERVISOR_set_debugreg(int reg, unsigned long value)
 {
 	return _hypercall2(int, set_debugreg, reg, value);
-- 
2.26.2

