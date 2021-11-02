Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA10244265A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 05:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhKBEXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 00:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhKBEXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 00:23:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9652B60F4B;
        Tue,  2 Nov 2021 04:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635826861;
        bh=rtmmTKfvXZQZIhVdkF2jMQnXwoVq77KolaFU3LPwtgI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hn8AjQrclXQ78RPMQGDTwAOAa3ldIpCMdtFnJStShKzcZyZ5ZCLHYiXaDIwo0Jmt6
         5UgB/NFSpRPMZXiTvRL97EbumBXDwMjHQnIP93jv3dNiAKvCjOGERAzwLMwrpj6C2j
         kbcmdi5tDnT97xZluykrOSCskXv6rKdf2XJEkWwNcBOZe17YhWV5alwHMV0Lb9e36e
         41ML7pjXzuavh7ZaVuMrD08b8bxiNKv/zOBAzM3rr/l2qIaBnlhmguN8k/HVKilHjQ
         Du3363D2tpRP+PEmaRzEEbDg43q6nRzEJ1A1k2TYCoWHlq4pMLu0hAS8hiBM7laj2B
         BDB0rAnx+5G4w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8D4EB60A9D;
        Tue,  2 Nov 2021 04:21:01 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAEtDzYQHS+j2kN3tys0QM_Myqx5BTLkkcTx6AjHEJh=zzxqY-Q@mail.gmail.com>
References: <CAEtDzYQHS+j2kN3tys0QM_Myqx5BTLkkcTx6AjHEJh=zzxqY-Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAEtDzYQHS+j2kN3tys0QM_Myqx5BTLkkcTx6AjHEJh=zzxqY-Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20211101
X-PR-Tracked-Commit-Id: d9516f346e8b8e9c7dd37976a06a5bde1a871d6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2fac0afe89fe30c39eaa98dda71f7c4cea190c2
Message-Id: <163582686157.28234.14702171802785858808.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 04:21:01 +0000
To:     Paul Moore <pcmoore@umich.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 19:59:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20211101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2fac0afe89fe30c39eaa98dda71f7c4cea190c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
