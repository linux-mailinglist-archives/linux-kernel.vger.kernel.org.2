Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9557397FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 05:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhFBEBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 00:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhFBEAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:00:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 85ABD613BF;
        Wed,  2 Jun 2021 03:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622606305;
        bh=gcJWcIcXQFZQE7xYAU+BFLgxxdSEPSw0h1Df7jE+8dg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KksZxKvl4wQ52v59CloL1hpA/Z3CFPS9ibu3Ty+MzThwcJRlDc6qNpRJQ7E30QoJp
         gOekLzUOjxQ4zXmmsHaq8mtN2IVyNkCwD2MvZjLwe0HMi54m7PyxZtyCr93HyJmvht
         8NkgQoFfz8+X8XosEGMN7cKYvp8qevnJpVZ1IwkyaZCRhFZFGWhCSlCv02WYvqrEpP
         VDghCG6ClfeX0i1xfJ4TPHei8XuJTlDcLZCrLylGL0GVu+Y+wzOEH5uGbpo+cJc9j8
         nQJxnRtjxdjhEsiY/CmNDtfyBCjPzg8lXTsmH2ZTLl45c2trd2FEkNbx+75cZ5ByRR
         /vU/50lVydyGw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7EE6B60A47;
        Wed,  2 Jun 2021 03:58:25 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2106012353210.28378@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2106012353210.28378@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2106012353210.28378@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: a94f66aecdaa498d83314cadac466d8b65674b94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 231bc539066760aaa44d46818c85b14ca2f56d9f
Message-Id: <162260630551.21167.15583923318513483633.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Jun 2021 03:58:25 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 1 Jun 2021 23:58:54 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/231bc539066760aaa44d46818c85b14ca2f56d9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
