Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2C45D71A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353302AbhKYJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:26:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54936 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbhKYJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:24:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92CB81FD37;
        Thu, 25 Nov 2021 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637832058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2rT60szHDwJSJ0Rdu5vF9loQpB+Xz94z8PaEQrYROek=;
        b=kKmZxshIgV3vZ3ECtAKuWaCJNPlpUH8AZ9ctZAobT6C2ULIsAI2+rc+d2C5y7eMYSRzUrd
        P78kMxkOpjLFTB12wxirRYnLKsF1h5j5E9oFeiAFk6lp3BprukTTkyUP26Zd/ZsYgbQVx4
        PyJMvP+LjnioPu/lO1MW3OkBQOLDlS8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2278F13F62;
        Thu, 25 Nov 2021 09:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W5E0B3pVn2FpHwAAMHmgww
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/2] xen: make debugreg accessors always_inline
Date:   Thu, 25 Nov 2021 10:20:54 +0100
Message-Id: <20211125092056.24758-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Gross (2):
  xen: make HYPERVISOR_get_debugreg() always_inline
  xen: make HYPERVISOR_set_debugreg() always_inline

 arch/x86/include/asm/xen/hypercall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.2

