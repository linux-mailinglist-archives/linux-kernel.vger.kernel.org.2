Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211233ADD68
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 09:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFTHWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 03:22:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43530 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFTHWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 03:22:24 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 079B9219CC;
        Sun, 20 Jun 2021 07:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624173612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OAdknP60ZKuYVhOvLe0YwO/m4nwPRgcHaq2PnLPA9w8=;
        b=OsyC8e8FXJrSuWTeVtxMYRtivE23Xnf6JYkIA9cPtDxuzcohdHzs1B3Fi67AkjYX37C57m
        k6Cc/rrLidh8pWk/maPvl+RlTV7DwDEDnSrkHdrAdRMbIZivyHHyPyinNChOzyYEhVkDry
        obMDzIJb1qK4d1L+HM0OE09l1fj7tBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624173612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OAdknP60ZKuYVhOvLe0YwO/m4nwPRgcHaq2PnLPA9w8=;
        b=HK8TUMKb6dG7Q1AtDr+tWx55Qo055luZNMwMCUNfkTSRXfZntocPtkY02cFAuRguflV67z
        08+NgZIfgmahAVAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E015B118DD;
        Sun, 20 Jun 2021 07:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624173612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OAdknP60ZKuYVhOvLe0YwO/m4nwPRgcHaq2PnLPA9w8=;
        b=OsyC8e8FXJrSuWTeVtxMYRtivE23Xnf6JYkIA9cPtDxuzcohdHzs1B3Fi67AkjYX37C57m
        k6Cc/rrLidh8pWk/maPvl+RlTV7DwDEDnSrkHdrAdRMbIZivyHHyPyinNChOzyYEhVkDry
        obMDzIJb1qK4d1L+HM0OE09l1fj7tBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624173612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OAdknP60ZKuYVhOvLe0YwO/m4nwPRgcHaq2PnLPA9w8=;
        b=HK8TUMKb6dG7Q1AtDr+tWx55Qo055luZNMwMCUNfkTSRXfZntocPtkY02cFAuRguflV67z
        08+NgZIfgmahAVAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id LGyhNSvszmCMVQAALh3uQQ
        (envelope-from <bp@suse.de>); Sun, 20 Jun 2021 07:20:11 +0000
Date:   Sun, 20 Jun 2021 09:20:06 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.13-rc6
Message-ID: <YM7sJj5BDD9ncbdB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single sched/urgent fix for 5.13.

Thx.

---

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.13_rc6

for you to fetch changes up to a7b359fc6a37faaf472125867c8dc5a068c90982:

  sched/fair: Correctly insert cfs_rq's to list on unthrottle (2021-06-14 22:58:47 +0200)

----------------------------------------------------------------
- A single fix to restore fairness between control groups with equal priority

----------------------------------------------------------------
Odin Ugedal (1):
      sched/fair: Correctly insert cfs_rq's to list on unthrottle

 kernel/sched/fair.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
