Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACCC43DBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1HaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:30:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1HaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:30:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A67AA1FD4B;
        Thu, 28 Oct 2021 07:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635406075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=s1H6Hgf+92X5PDjWMvrW0ZAWQ57zgmauDgvkDjzNQEw=;
        b=W6sS9Lg3HJmDdeEnNjwpHBIHJr/K64x8BNLpRXk/C/7c9+zWtPK6+QSuBu3FbHknmNGgQ0
        wUFQFbZw0q/2YD74L4zQkU3/V5NQJ4bXt2Dkn84gWMIONgCBnwcyZ8DlE+MNbAYEruXC4A
        xLF/3abL2rn8eOCFSEFfKQHiiBjrzec=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 503A013ABD;
        Thu, 28 Oct 2021 07:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FZtpEvtQemEmGwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Oct 2021 07:27:55 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: [PATCH v3 0/2] x86/xen: simplify irq pvops
Date:   Thu, 28 Oct 2021 09:27:46 +0200
Message-Id: <20211028072748.29862-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pvops function for Xen PV guests handling the interrupt flag are
much more complex than needed.

With the supported Xen hypervisor versions they can be simplified a
lot, especially by removing the need for disabling preemption.

Juergen Gross (2):
  x86/xen: remove xen_have_vcpu_info_placement flag
  x86/xen: switch initial pvops IRQ functions to dummy ones

 arch/x86/include/asm/paravirt_types.h |   2 +
 arch/x86/kernel/paravirt.c            |  13 ++-
 arch/x86/xen/enlighten.c              | 116 ++++++--------------------
 arch/x86/xen/enlighten_hvm.c          |   6 +-
 arch/x86/xen/enlighten_pv.c           |  28 ++-----
 arch/x86/xen/irq.c                    |  61 +-------------
 arch/x86/xen/smp.c                    |  24 ------
 arch/x86/xen/xen-ops.h                |   4 +-
 8 files changed, 53 insertions(+), 201 deletions(-)

-- 
2.26.2

