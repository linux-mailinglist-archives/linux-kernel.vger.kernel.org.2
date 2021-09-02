Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9123FF27F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbhIBRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346748AbhIBRiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:38:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 91FA761102;
        Thu,  2 Sep 2021 17:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630604240;
        bh=zFUvN5qBPtwRBQr7ep371gPER1FncwLeEVCa1l+6qe0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G7BshcN4PQHVouk4mbJeydz6vXVLSKweSYC6VDtNMznUXn/x2YieA9Bz9EFQDeAOS
         HdbNgSvjFKsVkX8m8za33q1bbpGN8QxfxXoY4XNL28SwotpYjvStYn6wGGDUM/ZPrX
         oNDnkg+NMJ+/W/j5jvDX5j5ypD+lKHuAdDQ9H7Dt0fSnC42CQHeidsw4ljreJMQHim
         DDWuBJsmv2C5J1qDIQ2vmAeQiW5gLJilgVTTPJm2fTd93KP7OAmTG7hEIkxwdRDXgb
         CeuIhiXxJeTnIDO47CMeL9GzG1SVajGlhDrStkmBQKVIVFsFsT7vT/1JZme5ZGL0wZ
         5dGt9qB7BsO9w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8CEC560982;
        Thu,  2 Sep 2021 17:37:20 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210902141745.GA31274@redhat.com>
References: <20210902141745.GA31274@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210902141745.GA31274@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.15
X-PR-Tracked-Commit-Id: ecd95673142ef80169a6c003b569b8a86d1e6329
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 265113f70f3d63ae8b6eb1ce4303d14dbbd71b2d
Message-Id: <163060424057.29568.5554941689590199502.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 17:37:20 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Sep 2021 09:17:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/265113f70f3d63ae8b6eb1ce4303d14dbbd71b2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
