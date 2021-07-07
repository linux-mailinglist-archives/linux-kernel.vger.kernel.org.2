Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1594E3BEFCC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhGGSsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232006AbhGGSsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:48:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 17C4761CD4;
        Wed,  7 Jul 2021 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625683534;
        bh=u/BBX5cqEHNvlw7yAtrZhH+iIu9hxaAFwXsbXaFnCSU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XUQLl/zP/VKyLQ6+Eg7hcFGI+hLtfLVUW37nvSXd1u3JCfB7WHWS5rNB0OaRy4ccD
         VidlyBWjYmMlFkScD3CU9RBvZ0CDYTOmh0tcnuPh01Sru76eYhZ0mq/b3u3biLFp/0
         u0am/8nTMkkSWPG6wFQUOrAGnqeG/VHGB/icYJVPZHv5+kKjbL9+FzfyzwODb4L1sf
         UO5dNm70AsBlqXHajCWQyiiIQwHPP2c0k4pbrTgZJmVKeJ0NgEDwtGfNtRwPysQl2p
         Wgy/VdTBl6u+460wNfWetmwjNy7y9rvdUAXAnuEavA8RPLewDwsxZ+VewIDvaq9IWE
         PVgx4ORpxyVXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 121EC604EB;
        Wed,  7 Jul 2021 18:45:34 +0000 (UTC)
Subject: Re: [GIT PULL] Modules updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOW5w/4Gr3IPHj8c@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
References: <YOW5w/4Gr3IPHj8c@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOW5w/4Gr3IPHj8c@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.14
X-PR-Tracked-Commit-Id: 2c0f0f3639562d6e38ee9705303c6457c4936eac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a931dd33d370896a683236bba67c0d6f3d01144d
Message-Id: <162568353406.3837.17140356889911857632.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Jul 2021 18:45:34 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 7 Jul 2021 16:27:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a931dd33d370896a683236bba67c0d6f3d01144d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
