Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6305A3FF75A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 00:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347895AbhIBWnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 18:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347880AbhIBWnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:43:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4B0016023F;
        Thu,  2 Sep 2021 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630622566;
        bh=4I5VT0FScapdz6dPuU7Ck3fjJsR8OUbnD7OeIEw4xME=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nFkyWE4EtTguDhy/3ZyMDLvaaXdpJVa05UU2KlNzVkcqbgC2zgU+PsKw2QxbYspEF
         ThOY7WxHTbnpYNeRq+NKv31m06LNg94YbAXyRy1SOLyOXdECc7ct2OFCqCMJBjcKzH
         /v0BMGh1lJ7JZ+Lo8whGewOAx+B7k3dTYHTKrFqY2MKkZj68rPP6n2nrLChogVbfB9
         gjpJR7fVkXZJJtUZjDfGY03yYisniMDxh9hvyeFPb5qKkl5KCTQOlMyLo93/MfZqYn
         yn3lirSODspslWgoyV4gCVuGMHdUyh0+413zAetw7JmvEYg6L7D+w0d61j6r9V4HTn
         OJuxoCIP3lqIQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 43F3560A0C;
        Thu,  2 Sep 2021 22:42:46 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2109012214370.15944@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2109012214370.15944@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2109012214370.15944@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 46a226b50ec3d5d9ff2f4399702ff6c1b427f824
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83ec91697412ae64d25dcca74597ed03029aa00d
Message-Id: <163062256627.25965.8404570904903106323.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 22:42:46 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 22:16:29 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83ec91697412ae64d25dcca74597ed03029aa00d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
