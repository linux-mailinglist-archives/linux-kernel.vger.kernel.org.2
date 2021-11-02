Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CDD44391C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhKBXAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhKBXAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:00:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A122F60C4A;
        Tue,  2 Nov 2021 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635893859;
        bh=3BOv/ija1egZ7nfQnSST5pWotxV4DwGdCkgat+w0yB0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fsg31NdmWk/2k8yKeoLE3P63QWNckWgfIYke+GRIRpJnO6DIA3fbXUSpB8FvsOYQw
         Bu0xc5QuOSujXnWAOPSzfTUoft+XZFJO02ktdWwaji5CENlly9pIeBdEejk+lY9vlr
         hkXhVFS6kOC+POZ3dRAGegYaOXXpvEQde52Uk5AEX/La12cz7e4twweNCxOdTmkTJ2
         Kp1nqgGmppbotQEEg2yYRQDcf1ZPDobZodqC+WUxGuiN8SFJCcFhRynuXOMpOP//cS
         XcaclmqpF0xo54uoDDZev+t6r7lHAftJP/lDi9ptEOK9YfKWb9kuwtLZYMSCKqdk+v
         6TMO//MVC5Sag==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 91AB860A90;
        Tue,  2 Nov 2021 22:57:39 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYFpIp/sa4Oiix71@slm.duckdns.org>
References: <YYFpIp/sa4Oiix71@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYFpIp/sa4Oiix71@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.16
X-PR-Tracked-Commit-Id: f9eaaa82b474350aa8436d15a7ae150a3c8b9d5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4075409c9fcbc4b7967f2e92d808acc0b441d92e
Message-Id: <163589385953.10018.48532391562234297.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 22:57:39 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 06:36:50 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4075409c9fcbc4b7967f2e92d808acc0b441d92e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
