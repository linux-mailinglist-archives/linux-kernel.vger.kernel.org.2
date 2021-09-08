Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0B4041CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbhIHXdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343490AbhIHXdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5083F61100;
        Wed,  8 Sep 2021 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631143916;
        bh=x+XelfeeqhWDNl2iMPP9iaHyLgfZFI+rwHq6sE1Ub0k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PKzuTfypcq+CZ8QDBDseJCT5d/Ih4tjVH6BTJVzs7dPslRYnrzwB1fZoovqVQXvbY
         s+qsCVW+oZApmQ9os06+LY9p8rKafjeWGyrZgcsscNvKKGmhX0UGd+3U2O05n5R86s
         GnylC6+CtAd4etvfeFmssWhSCzyOeR4IbKhrbDn1fKlYmyCtC7WzvFTTnKkEQwSfHd
         3/WWmSHgUjoHlSt0JQQ/Q7RGQsppQ7KjMHU0Yj0W9L55/MLi8iCyZ1lDTi2BMHwZhm
         23UFtRb6x6Voh6OrTExtPKfe3JnY/vkA7kSttfLEFvbJXsmbdXfpqT4fLgq8LmQjxi
         DjMnFkFnujdqw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4979B60A24;
        Wed,  8 Sep 2021 23:31:56 +0000 (UTC)
Subject: Re: [GIT PULL] Modules updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTic+hlkHGgdv6hY@p200300cbcf13dc003adeadfffec0265a.dip0.t-ipconnect.de>
References: <YTic+hlkHGgdv6hY@p200300cbcf13dc003adeadfffec0265a.dip0.t-ipconnect.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTic+hlkHGgdv6hY@p200300cbcf13dc003adeadfffec0265a.dip0.t-ipconnect.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.15
X-PR-Tracked-Commit-Id: ced75a2f5da71de5775fda44250e27d7b8024355
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dcaf9fb623fb87b08e3896cdf6116744bf00668
Message-Id: <163114391629.13056.16397601828947497237.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Sep 2021 23:31:56 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 Sep 2021 13:22:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dcaf9fb623fb87b08e3896cdf6116744bf00668

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
