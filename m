Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A743ADD67
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 09:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhFTHNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 03:13:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43322 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFTHNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 03:13:48 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19D5E21A9D;
        Sun, 20 Jun 2021 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624173096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NAiSF52GrCAkSmKYqsc2yKMGNqYpYmkE6MIFuXbBGnU=;
        b=UhJcQeYQcWr08liohti+/YcDOPpNeFLt794WzoZAcBtZNk1vXoDJ0Mp2aq2HxiDd64ZUzv
        AT2OmRotgF/lU2D1NiN1bcaBpcJYECUCN9zIaYqTz21mGSQhigtW8V6UFjMm++6t5xsWOJ
        3NTcf+Uk+10zwaYti1O+L2aY8KYbV4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624173096;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NAiSF52GrCAkSmKYqsc2yKMGNqYpYmkE6MIFuXbBGnU=;
        b=KRYivqksT33HO7v94p3dLM8Q9JHF2EgD3APuXeTPJJiS0uN1zLtDhV3/iNbb78HOUileaA
        47AjyKQQ79SzbHBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E370F118DD;
        Sun, 20 Jun 2021 07:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624173096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NAiSF52GrCAkSmKYqsc2yKMGNqYpYmkE6MIFuXbBGnU=;
        b=UhJcQeYQcWr08liohti+/YcDOPpNeFLt794WzoZAcBtZNk1vXoDJ0Mp2aq2HxiDd64ZUzv
        AT2OmRotgF/lU2D1NiN1bcaBpcJYECUCN9zIaYqTz21mGSQhigtW8V6UFjMm++6t5xsWOJ
        3NTcf+Uk+10zwaYti1O+L2aY8KYbV4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624173096;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NAiSF52GrCAkSmKYqsc2yKMGNqYpYmkE6MIFuXbBGnU=;
        b=KRYivqksT33HO7v94p3dLM8Q9JHF2EgD3APuXeTPJJiS0uN1zLtDhV3/iNbb78HOUileaA
        47AjyKQQ79SzbHBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id J8CzNyfqzmAdUwAALh3uQQ
        (envelope-from <bp@suse.de>); Sun, 20 Jun 2021 07:11:35 +0000
Date:   Sun, 20 Jun 2021 09:11:25 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v5.13-rc6
Message-ID: <YM7qHTVw1/X1m70S@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single irq/urgent fix for v5.13.

Thx.

---

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.13_rc6

for you to fetch changes up to a13d0f8d117ca6b7885b51c4b21fe8d5a9eae714:

  Merge tag 'irqchip-fixes-5.13-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent (2021-06-17 15:22:31 +0200)

----------------------------------------------------------------
A single fix for GICv3 to not take an interrupt in an NMI context.

----------------------------------------------------------------
Marc Zyngier (1):
      irqchip/gic-v3: Workaround inconsistent PMR setting on NMI entry

Thomas Gleixner (1):
      Merge tag 'irqchip-fixes-5.13-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

 drivers/irqchip/irq-gic-v3.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
