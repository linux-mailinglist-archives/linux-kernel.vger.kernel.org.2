Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6A32F5A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCEV7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCEV6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:58:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2F25F64FEE;
        Fri,  5 Mar 2021 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614981534;
        bh=Y1HQG5+H8nqDAviy5NZm7UIjAMFSzd7d8oehWyXCSIk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RgrT9ECtZAVp4M89dkPiP4hlGfghtpg5O5Er6uzkPfmT+JJXT2v6/av/ih8lLP9Q1
         eSPfs1/yXDP1PnVELbZOQi7zDu4AsfAwvt6tTHi6JT0NCcdhRKB3Moj/r4VEKJnacK
         CKFqecX/9ezTWLvM5KWyCbgP5AMqsTug0bZf8SuXPCKLQr7VjkRGEBSyUvmQjrSYcM
         jkMs+hrHIOJQ995lkeGB4KlET47eMu72YGtrc/zysqNNQP71hsr3kcIlJKxJJ/Qno3
         /bgVPWt3l94p24uME4eGMKWshbfj2qkIjF05+9hGntQHMcC+Ngzrg0AcwHpBHSvyih
         1rx3cQn9bXejg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 289AA609EA;
        Fri,  5 Mar 2021 21:58:54 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210305153617.GA198234@robh.at.kernel.org>
References: <20210305153617.GA198234@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210305153617.GA198234@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.12-1
X-PR-Tracked-Commit-Id: b5a95bb1883e2bac1009cc88e65c71cff6f931e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bf331d5ce8332a47534b5092cd06a7a22451beb
Message-Id: <161498153416.14373.15136337361607973439.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Mar 2021 21:58:54 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 09:36:17 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bf331d5ce8332a47534b5092cd06a7a22451beb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
