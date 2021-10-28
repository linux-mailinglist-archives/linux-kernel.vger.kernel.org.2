Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE06943DCBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 10:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhJ1IOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:14:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47732 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1IOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:14:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0749421969;
        Thu, 28 Oct 2021 08:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635408744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MAdAn9lpXksqynEY71tU+xB36Uh2pHZMgZIOmXx5QU4=;
        b=oHPcT2FRTlfOw5yijkWBtet9X2gojCMg6OeMHOToEdrwFfsTjLhzRvqSpw0D2tQG0a8pa0
        xcIGS5u++8uvD2Qxr75dbGuvqfKHVXNd/W2R1qKUMFHthtVP3ocDnuubBMr3ywbae33Rwr
        d1iPp8Gg8fKtI8iVlvKc+O1Bw939tn4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94FC613B7D;
        Thu, 28 Oct 2021 08:12:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cAz8ImdbemE/MQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Oct 2021 08:12:23 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] xen: do some cleanup
Date:   Thu, 28 Oct 2021 10:12:17 +0200
Message-Id: <20211028081221.2475-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups, mostly related to no longer supporting 32-bit PV mode.

Juergen Gross (4):
  x86/xen: remove 32-bit pv leftovers
  xen: allow pv-only hypercalls only with CONFIG_XEN_PV
  xen: remove highmem remnants
  x86/xen: remove 32-bit awareness from startup_xen

 arch/arm/xen/enlighten.c             |   1 -
 arch/arm/xen/hypercall.S             |   1 -
 arch/arm64/xen/hypercall.S           |   1 -
 arch/x86/include/asm/xen/hypercall.h | 233 ++++++++++++---------------
 arch/x86/xen/enlighten_pv.c          |   7 -
 arch/x86/xen/mmu_pv.c                |   1 -
 arch/x86/xen/xen-head.S              |  12 +-
 drivers/xen/mem-reservation.c        |  27 ++--
 include/xen/arm/hypercall.h          |  15 --
 9 files changed, 118 insertions(+), 180 deletions(-)

-- 
2.26.2

