Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00C33A129
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 21:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhCMUqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 15:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234555AbhCMUpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:45:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0411B64ED6;
        Sat, 13 Mar 2021 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615668340;
        bh=OxclE0IRvk0O9yDw59ilEel2JELIYvpEdhMsDCBRMOM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xp7rKFZb8/nlyfPuqwEVzUDHau92kOpSA3RFljxt28Wih/XFxrpBsSOwXEktZs25O
         i8hHYkjWCr4ZtY4/OlGq+dHHoEKPGLxzerU+AssNeeTuV7oBeXb2k03v226X5dDC5+
         szuzNtp0dyr3NSrxpKmTRO/jejJxzdfIDzXR0GChFTJx0zbw3GEFSGOYNhJv2twCke
         uT+cdsX8UqIHUmj/rAFN68irHrSyqpL5qJzrQniCIeo0bTk4VoIcdTZ7mnVKoxSB9S
         X+IeAMtXLmysjG4CH+hHtwvwodTb9ZBTqrPxD3b/IoRQV6JJhMjdzKdDadry3IauAe
         a92bJqst3v4cw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F3D3660971;
        Sat, 13 Mar 2021 20:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fix for 5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210313124044.GA488856@xiangao.remote.csb>
References: <20210313124044.GA488856@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210313124044.GA488856@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.12-rc3
X-PR-Tracked-Commit-Id: 9f377622a484de0818c49ee01e0ab4eedf6acd81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 420623430a7015ae9adab8a087de82c186bc9989
Message-Id: <161566833999.19597.9631392118505520065.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Mar 2021 20:45:39 +0000
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Martin DEVERA <devik@eaxlabs.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Mar 2021 20:40:44 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/420623430a7015ae9adab8a087de82c186bc9989

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
