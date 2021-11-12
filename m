Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2787544E85B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhKLOTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:19:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49452 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbhKLOTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:19:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F41CE21992;
        Fri, 12 Nov 2021 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636726592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwnHEnANpUKR9rJNtGidSsceilP/caEJZCQVKOEk2H4=;
        b=eREX6VoSSL5pCUcPv6babOaAYTOvhAXVsLei+2QfUNIh7C/5gFcFCM2bHF6U9tpNBZIS34
        IIe68QDTO70Q3upYBTEPHF/n17JkV0hadVG9z2HlM1ZvTWDowOTyfZ2UVWR2599ZC2abrs
        Dz/GHr5BzQJBc5AOlgdr821A2Pzwi1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636726592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwnHEnANpUKR9rJNtGidSsceilP/caEJZCQVKOEk2H4=;
        b=slGhAko69KPbEi6oSaIZkf9DaOzGYkydxCdHfNJr+WvUhn7Y5Kr2Fkaltdx3HRRzb/NGF1
        qyVnJHTACWh7mJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADCC313C7C;
        Fri, 12 Nov 2021 14:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0FV0KT93jmHhPAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 12 Nov 2021 14:16:31 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     airlied@linux.ie, daniel.vetter@ffwll.ch, arnd@arndb.de,
        gregkh@linuxfoundation.org, James.Bottomley@HansenPartnership.com,
        deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/7] agp/sworks: Remove unused variable 'current_size'
Date:   Fri, 12 Nov 2021 15:16:27 +0100
Message-Id: <20211112141628.12904-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112141628.12904-1-tzimmermann@suse.de>
References: <20211112141628.12904-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the compiler warning

  drivers/char/agp/sworks-agp.c: In function 'serverworks_configure':
  drivers/char/agp/sworks-agp.c:265:37: warning: variable 'current_size' set but not used [-Wunused-but-set-variable]
    265 |         struct aper_size_info_lvl2 *current_size;

by removing the variable.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/char/agp/sworks-agp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
index b15d3d4f71d5..b91da5998dd7 100644
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -262,13 +262,10 @@ static void serverworks_tlbflush(struct agp_memory *temp)
 
 static int serverworks_configure(void)
 {
-	struct aper_size_info_lvl2 *current_size;
 	u32 temp;
 	u8 enable_reg;
 	u16 cap_reg;
 
-	current_size = A_SIZE_LVL2(agp_bridge->current_size);
-
 	/* Get the memory mapped registers */
 	pci_read_config_dword(agp_bridge->dev, serverworks_private.mm_addr_ofs, &temp);
 	temp = (temp & PCI_BASE_ADDRESS_MEM_MASK);
-- 
2.33.1

