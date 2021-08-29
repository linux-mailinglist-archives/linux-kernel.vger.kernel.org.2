Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A023FAB02
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhH2LQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 07:16:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47098 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbhH2LQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 07:16:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D3EE1FD81;
        Sun, 29 Aug 2021 11:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630235719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YQWaFXPSVPMxYeKCuUGtF6WHPaVgVgjXkiah4jAWf+4=;
        b=nZnsufdNNuG+vGtxRqExv3GkZ9Ef4CmOEAIsW3Nd42kxdgUJ0NwBWVk3X27IAIyyVFis7v
        tCXj7/xSHDwD8kWl25eyVPaekytjB/PSTtnRQ7D1/MJw9R9zUHkFEwOWAUUkvQLuOsVsf+
        BZV84y0kO141Dz4LyQmI0C0zXFLwzQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630235719;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YQWaFXPSVPMxYeKCuUGtF6WHPaVgVgjXkiah4jAWf+4=;
        b=hJbUttS98xqHqk3/Uu5flAS5iZQhRFKZLIEyEc0xrR6NH63lD3tK3ZAC2N/yN7pbwA9Cwp
        XmF/TEtdOzOAThBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 262331371C;
        Sun, 29 Aug 2021 11:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id TM/xCEdsK2FgbQAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 29 Aug 2021 11:15:19 +0000
Date:   Sun, 29 Aug 2021 13:15:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v5.14
Message-ID: <YStsbMqx/7E+HAGM@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one final fix for IRQ-land, for v5.14.

Thx.

---

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.14

for you to fetch changes up to 1a519dc7a73c977547d8b5108d98c6e769c89f4b:

  PCI/MSI: Skip masking MSI-X on Xen PV (2021-08-27 00:27:15 +0200)

----------------------------------------------------------------
- Have msix_mask_all() check a global control which says whether MSI-X
masking should be done and thus make it usable on Xen-PV too

----------------------------------------------------------------
Marek Marczykowski-Górecki (1):
      PCI/MSI: Skip masking MSI-X on Xen PV

 drivers/pci/msi.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
