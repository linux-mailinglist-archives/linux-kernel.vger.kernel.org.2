Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50BD321F05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhBVSSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232060AbhBVSOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:14:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 33AA064F15;
        Mon, 22 Feb 2021 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017538;
        bh=X0wDxukwtEjYNHOIGbVbdmFI/M64cxx8MZYbHF7ZImM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EFHXhVHZeMHL9aCBQgwQs57mDMRNb9jYjs1Wze7SzB0OsMj5zf+sVunZJJvTBJ54Y
         7osmBddEhlXCHQbMFdr7ph0TG+jZaGQYBCfPgl6w9SCY1tbqifaDvg9dDb4cE24EjP
         7JCaaJoYggHapLFyt8Wnf9tWNSyFjhlWgp+VPd6H74ppjCPOWvctFOWbNCuw4Sqn4f
         VA6PSx40979PPeAonhStGWWduA7w5FbSVWJG0Lg2gTOE+VtnDbX/VWLHXydlH0ybRd
         RURfi9dVdoYuhMbyL1fZQMLOEplGrkZyj8GJpZ7UWkWK/KVKshtDCD1NZyFmb09Bxl
         slPIqtvHZVeBg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2E23160963;
        Mon, 22 Feb 2021 18:12:18 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YC6CnuV/F5c5dFQ1@google.com>
References: <YC6CnuV/F5c5dFQ1@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YC6CnuV/F5c5dFQ1@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.12
X-PR-Tracked-Commit-Id: a59e12218c4f5498d5669a0ee0c725101ca89d52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b996c10e0f5b2cfd5b2cbf048cce83982bfe662d
Message-Id: <161401753818.943.2930296837183892115.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:18 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, enric.balletbo@collabora.com,
        bleung@chromium.org, bleung@google.com, bleung@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Feb 2021 07:07:10 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b996c10e0f5b2cfd5b2cbf048cce83982bfe662d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
