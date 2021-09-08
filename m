Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149844041F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347985AbhIHXwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347582AbhIHXwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:52:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 88A8C61168;
        Wed,  8 Sep 2021 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631145053;
        bh=I4pGjZge3ujDJDPCZPBi9TeWtKbKvSEcPh8pZd8/Pxs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=njUq0woDzq+ib3bACz9/fQ9gzgcTEK99bRL8vCuEE0vnomRj/nxLxDBuUDd18sEOT
         ekizRXG3R6zQyYT4bECTwb9bzbkfEj8Rhts5iEf+ce9/5cgQLwHftSeqKRLMhvJ1ON
         3R+r1tm+25kFTyxwx6eoAPaZI9+xG4I3cIksnksvoUSk70jt0PEAQsWFj5W7hrUWtp
         BY6NwstqXutHWKvN1OW9kmWQqCNRI/HRk44f+q2aaTDhtIiyNjEwclsUIYyp75YYeA
         JQyz63oiZd90HJVC3voPOXcBsrSMIOrjvTLfZrT33mfsWr9fFf+lf4p9YbNgdBMz0X
         QMujp8hKT3e0w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 82E2F60A24;
        Wed,  8 Sep 2021 23:50:53 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTjZCfR7SfEMDYAP@google.com>
References: <YTjZCfR7SfEMDYAP@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTjZCfR7SfEMDYAP@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.15
X-PR-Tracked-Commit-Id: 4665584888ad2175831c972c004115741ec799e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 730bf31b8fc8e94f3d2d58aaee5f07e5f1f8146f
Message-Id: <163114505352.23960.13504260773045239328.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Sep 2021 23:50:53 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, enric.balletbo@collabora.com,
        bleung@chromium.org, bleung@google.com, bleung@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 Sep 2021 08:38:49 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/730bf31b8fc8e94f3d2d58aaee5f07e5f1f8146f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
