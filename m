Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F2F40053E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350496AbhICSqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350435AbhICSqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:46:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 072A861056;
        Fri,  3 Sep 2021 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630694746;
        bh=J0hDsFk/nosrEodgaWYY9c5oA06I4DmXCIO2lHaFIEM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jczS3+W94wYE8ycVCQneT3uXV3N0lD4X5txPK39l+MCbCLZl4GsNtMq5gYmEUFQL+
         gCJHVFd7KgRAFY5tAvO8ptgLugkDcPXFHjBXBx7wNLrx6v66FCTHz5W9k6vBSiZoST
         Jw1g/yIDxVjyH+APgJF3oAnWYGFKXjI9eVcPVZsdL/Gcdr4qD5rlL8/f5ym9K5o8X2
         NMLa0u9BFtu0JpGtay1pRuyWIx4PA36v+BsJi0ybo1sm08QPhIVgcjbvfyNbHLDya/
         vU9IfwyYN+Yrrjr8uG2z92MzaLj3vqrNSVechwPICK0FItXZO4EMLz/GqrVdHusbRo
         og/iNYzSUuXWA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0251760A2F;
        Fri,  3 Sep 2021 18:45:46 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTE+IdUiJ+k+bpDR@antec>
References: <YTE+IdUiJ+k+bpDR@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTE+IdUiJ+k+bpDR@antec>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 1955d843efc3b5cf3ab4878986a87ad4972ff4e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 603eefda5fcf8f9dab3ae253e677abb285f6f3bc
Message-Id: <163069474600.21432.7975798099897254205.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Sep 2021 18:45:46 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Sep 2021 06:12:01 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/603eefda5fcf8f9dab3ae253e677abb285f6f3bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
