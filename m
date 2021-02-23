Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC153223E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhBWByJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:54:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231247AbhBWByH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:54:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D5DC964E12;
        Tue, 23 Feb 2021 01:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614045206;
        bh=P3F/xfDHxag11qUSAjCG+isJYETCAxburWf45MLxJa8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Mvrql0pU9M5CWTXgE5vJdekMchlRIvs1k7uS5oLguFoOfCDYuSh5lCfTdsGyy41uw
         dgrFjcJEgKj+0ihge4zgGP2fwLiVbKdmRHPhF0Aro8C7VwPhjuq8WV3gfTjtz2Fpxk
         UvkjiKJmD1IAOZFF8MWYpJkOpJzetXP78fNldMlmxV91dpDHAwoug6ynWAfsyvvuUv
         sAAKifz/0+wSAmsWFM9SMVpcfx84AeMreTP+qnlroBeCN/CQs+q5yWm4wrDOtikQ2u
         oFMcHWCsoO3METLSyqk638IGGgD/byVfEHdGiDy+hv7ulcSDLpGxgGH5qKKlI1nC0k
         lRN4lqZtKhonQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CA9FE609DB;
        Tue, 23 Feb 2021 01:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] user namespace updates for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <m1o8gkrl41.fsf@fess.ebiederm.org>
References: <m1o8gkrl41.fsf@fess.ebiederm.org>
X-PR-Tracked-List-Id: Linux Containers <containers.lists.linuxfoundation.org>
X-PR-Tracked-Message-Id: <m1o8gkrl41.fsf@fess.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-for-v5.12
X-PR-Tracked-Commit-Id: 95ebabde382c371572297915b104e55403674e73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b0b78df9cca7344960decf3a16805e8378a43b7
Message-Id: <161404520682.2827.11513983365562569973.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 01:53:26 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Andrew G. Morgan" <morgan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 11:14:06 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-for-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b0b78df9cca7344960decf3a16805e8378a43b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
