Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36526393887
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhE0WGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234435AbhE0WGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:06:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 532C7613E2;
        Thu, 27 May 2021 22:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622153091;
        bh=Oad3+bZHUjb0L+dbrxlUe5aYum0RiO2HjqZQwua4ORI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gAVJn1LQ64FYITxpp/tnw33O9viU3YdepDoWsaUiPyB67wvLfKki+YiqFmX/Lu4r5
         x7I4dTxBB+prevdgqhFW512+SUnrWpvef/0x1bpaswYPtuHCPEosyACchmmNBCdvuo
         ekbUyUZH15EDPwn/dHz3N3dRGD0rFi/omSTAmX1GiikHtE4BWcXqrHBlbU+A/eDhZE
         PrZf0E2nFucmTt806/ht6RQHu5SDQDVY480qINW8D2eOMxQfZq9pBAqc5SBKG4n3cs
         kUQ9hQim/XNck/eqsKTogDk/0qdfKOr4Oye/4AxAhBfkMk+pDsknzgJL65ZiYHtZM6
         +7Nj3suAeWiMg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4C33260BE2;
        Thu, 27 May 2021 22:04:51 +0000 (UTC)
Subject: Re: [GIT PULL] percpu changes for v5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YK//pZfXvXnEFbuT@google.com>
References: <YK//pZfXvXnEFbuT@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YK//pZfXvXnEFbuT@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.13-fixes
X-PR-Tracked-Commit-Id: c547addba7096debac4f99cdfe869a32a81081e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97e5bf604b7a0d6e1b3e00fe31d5fd4b9bffeaae
Message-Id: <162215309130.27580.18326690119109716107.pr-tracker-bot@kernel.org>
Date:   Thu, 27 May 2021 22:04:51 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 May 2021 20:23:01 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.13-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97e5bf604b7a0d6e1b3e00fe31d5fd4b9bffeaae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
