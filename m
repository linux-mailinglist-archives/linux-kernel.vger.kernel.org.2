Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BBF31C284
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhBOTgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:36:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:53520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhBOTgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:36:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613417731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=huVF9EEDlDZfQX73e48v2Rk56zyrCygaxIYZL3Ns1HE=;
        b=niMjHzcoTThWBcXbjurCd2N2yec73EBFolXXDINbNBaEckmQEmHv5KekrqHVTrzQZN3+o1
        YHaCaDgPF0ha+VRadna01+Pg1wOGjpqmMHCNKIM1tekvByDCqXoiVLyWc8bn742bV5NFF2
        tNdItiyxyUGKitG/K0pSO22S+TvrM2c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38D26AC32;
        Mon, 15 Feb 2021 19:35:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7D3C8DA6EF; Mon, 15 Feb 2021 20:33:35 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS fix for 5.12
Date:   Mon, 15 Feb 2021 20:33:33 +0100
Message-Id: <cover.1613416692.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's one minor fix for error handling in rename exchange. Please
pull, thanks.

----------------------------------------------------------------
The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-5.12-tag

for you to fetch changes up to 70779b897395b330ba5a47bed84f94178da599f9:

  fs/affs: release old buffer head on error path (2021-02-09 17:11:03 +0100)

----------------------------------------------------------------
Pan Bian (1):
      fs/affs: release old buffer head on error path

 fs/affs/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
