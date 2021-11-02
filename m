Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3544259C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKBCWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 22:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhKBCWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:22:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A2E6E60F24;
        Tue,  2 Nov 2021 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635819609;
        bh=Hp5QFtDzyHdLlSPKvZtPGoXeixhP/b0mDXJz3CkXZ24=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rw6MoElu/b5Bqbyp7S4eBEnYJXi7Djg9fLYgfBKhc8XAjeXFQ3bu+ummw1/U0qCem
         64gs1+KTnbPGjUCEaVQilNvk75dQlQtntUkCeXujO/C7mUNVjoOrEdNbu4Py9K++Az
         j3LwtR7/y/9+jvJzsq2pvsUScexL3G6Mc8IljsDbHEExk+JUDMTVaEbw7zny9BZvs6
         m8U1JwSG3nd996t08mRBOIP4ezxREoXNUzhMqzyu8m6P+K4N0bxSgXPV+Qz6xhOE2j
         /6/g8ppdJ/kymgB/W5MTUTIzDDrMVdnwNmMEWOnyEEwdHjxQ5N7b4QhSbq4YFZVUeX
         FIi29JzSK8e6Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9C13260A0C;
        Tue,  2 Nov 2021 02:20:09 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101152057.0D92F610F7@mail.kernel.org>
References: <20211101152057.0D92F610F7@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101152057.0D92F610F7@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.16
X-PR-Tracked-Commit-Id: f231ff38b7b23197013b437128d196710fe282da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2cdb12231859e7110adcfd716cb65a810fc9fc1
Message-Id: <163581960963.22980.14257913884626562359.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 02:20:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 01 Nov 2021 15:20:43 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2cdb12231859e7110adcfd716cb65a810fc9fc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
