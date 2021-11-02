Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035BB4424E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhKBAxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhKBAxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:53:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CE5FC6102A;
        Tue,  2 Nov 2021 00:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635814262;
        bh=djXkAKhVGKIBaAoWHmhh3O7bvlk2dvdQ4uvHU0SNCss=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZuAXRG81p+mHiKdJejMZPX9zvnIbKdwcwOjPG459j5eUS5hj7NyExRpfiI+W2q5ii
         tmUqgg1zruQCtk1rwu95nn0E5HA18/gamcQCfmBhtex96piQc77ihOk/6PiOZRJ2eW
         MvB0cmtvkghqTpIOJ9x56e6r4FKYNHfId/5NMbkPwgCVueXVobgHeznR1FaPQA9i5W
         J8GvtsACBjOXmBtecq2i/bxPz9emofOvGTgC0kjIgz2bXVlhjiECRzLwCtOtY7ufIL
         Uc+8rRDB72J9ZQGkkjsmN0mv/uIr3Lu3FtJ8Mutw7zhXzOv6AISgXxTLVJWS8EzUBr
         aygYstJqDO7LA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C7A5F60A94;
        Tue,  2 Nov 2021 00:51:02 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101113548.GA27758@willie-the-truck>
References: <20211101113548.GA27758@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20211101113548.GA27758@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: e6359798f62da66a4a48061d2324a69ea59ff39b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46f876322820c189ab525cfcba2519a17dbc0a6f
Message-Id: <163581426281.14115.7133228909366925076.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 00:51:02 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, gregkh@linuxfoundation.org,
        mathieu.poirier@linaro.org, maz@kernel.org,
        daniel.lezcano@linaro.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 11:35:49 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46f876322820c189ab525cfcba2519a17dbc0a6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
