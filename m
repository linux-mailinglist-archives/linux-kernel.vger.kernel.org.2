Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5474323397
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhBWWHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232263AbhBWWHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:07:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 64A1A64EC9;
        Tue, 23 Feb 2021 22:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614117982;
        bh=j63NhTtkpfKdjiWBWI5WSTX+OWxoa0ynJzH8ejVkQH8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iMbYyu9QfveNUCsZeK3TDPxn8VJuyL1TjildmPiDWli+INNuwv79x3mGNKcSzO6SA
         BElraNw2err38MqmVYgcWihG7ENHdm0dPf3QAsUw1lVJNAKLXIgl1u6vJ9MQjYn3mz
         FtwDdOQgrcybP0d0MB7M8VwPN0FVtwJ6L6AhVfb+R8shhfywFcpB9R2RxOyb36WmkM
         kNkaczE1PQEzzDdI32XalEyO6sfd/Q+dGH5qTz+6kUYpGmrGiKb4OW8g62/n93YKtL
         jTM4wvEkRH5CfJTm7tleR87A8uPmIbmDigsHf+OrNQkCJIaqYPLRDIi4spY83gFv8j
         F7hJwKMDVAmgw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 54C816096F;
        Tue, 23 Feb 2021 22:06:22 +0000 (UTC)
Subject: Re: [GIT PULL] GFS2 changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210223193429.873467-1-agruenba@redhat.com>
References: <20210223193429.873467-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210223193429.873467-1-agruenba@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.12
X-PR-Tracked-Commit-Id: 17d77684088510df84ff8285982d0eed52cd5890
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6e1e1d1e149802ed4062fa514c2d184d30aacdf
Message-Id: <161411798229.10508.13745625337067735518.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 22:06:22 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 20:34:29 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6e1e1d1e149802ed4062fa514c2d184d30aacdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
