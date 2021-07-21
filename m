Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4253D174A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbhGUTHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239655AbhGUTHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:07:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A24316120C;
        Wed, 21 Jul 2021 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626896865;
        bh=rd4uAYwB7OU2RVAQS5s/ge5JjFe7uYcooBaTBZmdtXk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lTglysgqO6/a97dCJo6ZlVvPYzM44Qit8Ui6Zcn1G2yYjCzy/3PCxs97lQp77z+cM
         5135fZ33AtuRHir+FgNclzCE9yU/YzlqKcvgDJL0KnaO9uv+VoeZsQvGuL4EkAc863
         ezu7IPHfndv9/KovyAbcYw/vArpgpTJwaYCHPDQXHO3vEcZZy438oGeIfNbI7NkGjr
         X0sj1dkIi55UOHEge8hTGrTuc017tBduZP2qJdUSuRCFPWnpfO1tuiho2T49tq5HSP
         NwD3h4e/Z8BjvCwsSncL8lxMoGQUEPTesXgG8beIbNsAb/uZTkjFvlHEmUGigVTFfB
         taxypTC4YY6KA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9C3AC60A4E;
        Wed, 21 Jul 2021 19:47:45 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210721173343.C04176023B@mail.kernel.org>
References: <20210721173343.C04176023B@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210721173343.C04176023B@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.14-rc2
X-PR-Tracked-Commit-Id: 1c73daee4bf30ccdff5e86dc400daa6f74735da5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c3d49b0b545d27372f824dce83139afeea61633
Message-Id: <162689686563.6427.13928512862955795222.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Jul 2021 19:47:45 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Jul 2021 18:33:22 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c3d49b0b545d27372f824dce83139afeea61633

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
