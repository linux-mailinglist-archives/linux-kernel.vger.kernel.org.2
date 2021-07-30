Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86C3DB45D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbhG3HSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 03:18:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43400 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhG3HSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:18:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BBFFE1FDB2;
        Fri, 30 Jul 2021 07:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627629486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DE3ajipCLGOoeJxse+uDWjYBYGnyKVCVQDv9OtWAWVI=;
        b=heVVEeGq2L8PWSC+4CgWL24xdqHuxUwwFHAbMmNldk6K+ldEFw4cvYwy5qm+PebQHx74an
        tuxtPqj/bFZ0VgSdvZauxd0jWoYl4JXLF8JKJ2EZljS8/6GPS23UEduudJZHIGJcjiMRdO
        ZknQTFEzthfc6hzNM1tmd2XkVYJhWPI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6A9DF13748;
        Fri, 30 Jul 2021 07:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HNOqGK6nA2FufQAAGKfGzw
        (envelope-from <jgross@suse.com>); Fri, 30 Jul 2021 07:18:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 0/3] xen: remove some checks for always present Xen features
Date:   Fri, 30 Jul 2021 09:18:01 +0200
Message-Id: <20210730071804.4302-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some features of Xen can be assumed to be always present, so add a
central check to verify this being true and remove the other checks.

Juergen Gross (3):
  xen: check required Xen features
  xen: assume XENFEAT_mmu_pt_update_preserve_ad being set for pv guests
  xen: assume XENFEAT_gnttab_map_avail_bits being set for pv guests

 arch/x86/xen/enlighten_pv.c | 12 ++----------
 arch/x86/xen/mmu_pv.c       |  4 ++--
 drivers/xen/features.c      | 18 ++++++++++++++++++
 drivers/xen/gntdev.c        | 36 ++----------------------------------
 4 files changed, 24 insertions(+), 46 deletions(-)

-- 
2.26.2

