Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A7945D71B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353863AbhKYJ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:26:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54982 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbhKYJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:24:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E58DA1FDF2;
        Thu, 25 Nov 2021 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637832058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+kg43gH5f/VeO+5uCJZLTpM/p/LHUGCKqHELE4mgbs=;
        b=acI1XCkmVlG9zzoj+M7uftnNs2xwfPfCf6ZvidUV5Yf7QJ4/5/sOfIZw7H1xuXnCIV6A9c
        WgtZouaHhstKIjaKqHajqioTe1yx98HP9AIciRp1G6D0MungIx0Suz1uPkHl93twsrgWpa
        5JFBYJekN2DzK8HLq7z0R/RkHvHWzuE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CB9113F7C;
        Thu, 25 Nov 2021 09:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wJ4+IXpVn2FpHwAAMHmgww
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
Subject: [PATCH 1/2] xen: make HYPERVISOR_get_debugreg() always_inline
Date:   Thu, 25 Nov 2021 10:20:55 +0100
Message-Id: <20211125092056.24758-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125092056.24758-1-jgross@suse.com>
References: <20211125092056.24758-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HYPERVISOR_get_debugreg() is being called from noinstr code, so it
should be attributed "always_inline".

Fixes: f4afb713e5c3a4419ba ("x86/xen: Make get_debugreg() noinstr")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/xen/hypercall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 0575f5863b7f..28ca1119606b 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -287,7 +287,7 @@ HYPERVISOR_set_debugreg(int reg, unsigned long value)
 	return _hypercall2(int, set_debugreg, reg, value);
 }
 
-static inline unsigned long
+static __always_inline unsigned long
 HYPERVISOR_get_debugreg(int reg)
 {
 	return _hypercall1(unsigned long, get_debugreg, reg);
-- 
2.26.2

