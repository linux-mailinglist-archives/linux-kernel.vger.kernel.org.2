Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D8232BD72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344797AbhCCQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345451AbhCCLcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:32:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 539EC64EF0;
        Wed,  3 Mar 2021 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614770414;
        bh=AnzfF7tobkGm7e+4SUGtM5EsOevh1/Ey3B3CfLfo7FU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YUJ9qlSNuZP4FMvwtu4By6tJneXkWlqX4lfGKapDh1hlKFt0wy8Oy254suKK8MP5c
         m+EiAwVcj/q6mceUmQj03z9T5uXNdtdLt2IXn9ra7x3h0W2fpk9b7EJdKU6Z3YKi5q
         rQpgrPUvmgIIpTLh8wwnVfc+nZqleNAhD27Ge0USVHqGhQuXhspp9033/XPv+ik1Sa
         DQ8KMdwTaLd2M4Am38MmzM42Rq2cME34ZpFy2P6CETDFX4EOeRli/i/ZJFu/2VTZO6
         lNeWPH3/QEFrMTlpQDJx6lNga4hiumIbVfp7UtfRNrJQp3UYOI7NMCx5xZyaaVhyrl
         EVIp5lLQaeqbA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3D6A4600DF;
        Wed,  3 Mar 2021 11:20:14 +0000 (UTC)
Subject: Re: [GIT PULL] Misc 5.12 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <df3ee602-3690-2464-6651-a66e8cded633@kernel.dk>
References: <df3ee602-3690-2464-6651-a66e8cded633@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <df3ee602-3690-2464-6651-a66e8cded633@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/misc-5.12-2021-03-02
X-PR-Tracked-Commit-Id: caf6912f3f4af7232340d500a4a2008f81b93f14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f69d02e37a85645aa90d18cacfff36dba370f797
Message-Id: <161477041419.24116.12612555351854727514.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Mar 2021 11:20:14 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Mar 2021 18:18:32 -0700:

> git://git.kernel.dk/linux-block.git tags/misc-5.12-2021-03-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f69d02e37a85645aa90d18cacfff36dba370f797

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
