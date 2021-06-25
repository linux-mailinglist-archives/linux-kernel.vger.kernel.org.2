Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17F3B3FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFYI4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:56:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45872 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:56:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D258321C39;
        Fri, 25 Jun 2021 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624611253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4MEOH6mEooAsDyYd5Jd7U0bsvgXwH4JlnwXZnKAz1Q4=;
        b=ebPDlPVqChQqWjC1mZvIndjMUoYBFNd6zsSQLWpuipxuIqYNE2tfnKvNiRfpepsZuwpxtk
        Cn2Ryor3B0XuAClQRpi8Azh6YbDUleKikaww7imtyzh1hezG+b/CCe8LdE0C8uHNoXXcGR
        xf/1zN+LM7/MJ7eeNaJg/w3JixAjwms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624611253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4MEOH6mEooAsDyYd5Jd7U0bsvgXwH4JlnwXZnKAz1Q4=;
        b=PsKSdyoYSDvHiVYcaKYJ/x6DM5dFJpycZcxyaNYkXus3eOizJ4RBzmPCyzo1Z9714CxZUW
        J8tb/mDD+bamaQAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B852811A97;
        Fri, 25 Jun 2021 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624611253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4MEOH6mEooAsDyYd5Jd7U0bsvgXwH4JlnwXZnKAz1Q4=;
        b=ebPDlPVqChQqWjC1mZvIndjMUoYBFNd6zsSQLWpuipxuIqYNE2tfnKvNiRfpepsZuwpxtk
        Cn2Ryor3B0XuAClQRpi8Azh6YbDUleKikaww7imtyzh1hezG+b/CCe8LdE0C8uHNoXXcGR
        xf/1zN+LM7/MJ7eeNaJg/w3JixAjwms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624611253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4MEOH6mEooAsDyYd5Jd7U0bsvgXwH4JlnwXZnKAz1Q4=;
        b=PsKSdyoYSDvHiVYcaKYJ/x6DM5dFJpycZcxyaNYkXus3eOizJ4RBzmPCyzo1Z9714CxZUW
        J8tb/mDD+bamaQAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ZzniK7WZ1WAoXAAALh3uQQ
        (envelope-from <bp@suse.de>); Fri, 25 Jun 2021 08:54:13 +0000
Date:   Fri, 25 Jun 2021 10:54:06 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.13
Message-ID: <YNWZrnCpcCtlJBt7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are two more x86/urgent fixes for 5.13.

Please pull,
thx.

---

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13

for you to fetch changes up to f9dfb5e390fab2df9f7944bb91e7705aba14cd26:

  x86/fpu: Make init_fpstate correct with optimized XSAVE (2021-06-22 11:06:21 +0200)

----------------------------------------------------------------
Two more urgent FPU fixes:

 - prevent unprivileged userspace from reinitializing supervisor states

 - Prepare init_fpstate, which is the buffer used when initializing
 FPU state, properly in case the skip-writing-state-components XSAVE*
 variants are used.

----------------------------------------------------------------
Thomas Gleixner (2):
      x86/fpu: Preserve supervisor states in sanitize_restored_user_xstate()
      x86/fpu: Make init_fpstate correct with optimized XSAVE

 arch/x86/include/asm/fpu/internal.h | 30 ++++++++-------------------
 arch/x86/kernel/fpu/signal.c        | 26 ++++++++---------------
 arch/x86/kernel/fpu/xstate.c        | 41 ++++++++++++++++++++++++++++++++++---
 3 files changed, 54 insertions(+), 43 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
