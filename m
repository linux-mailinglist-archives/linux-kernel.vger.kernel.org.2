Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56E4351DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhDAScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238820AbhDASKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:10:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6204D610C7;
        Thu,  1 Apr 2021 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617300611;
        bh=ooYUzIDrRYvx1tOspWJfEuAeWrLls2N9c9GdGFNZarg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lgJDjfzGGKfaJ+0ot7VriTsbIN0xVy0hotKUGPySczj/TlVQUxS+Tgj8kF6eQCR0z
         PQkIDlxd6e+Hu1d+h2eXRIgaW82ufaotQiuRTmbJJ816qxbk5qXqqs2KpZ4TauwXWH
         zhAaqEJHUDuQI2qH8FYiF2w2LcbwLvcXj4DMSHeJLQTC2r6iJyDM1qWyjIvVuhkd4G
         vKREGV6YDuEhG33IFVL2W3K6SiIr583b/K90PtGRB9GkYLo4u9zN2XLADzeqsSAaIK
         UaHThAfHwUMqAxnAg+CAjUASXZhstbhfl1/pqZ6DDGL84aYZoD9Y+aSnr9cJ3xo3/O
         rcuGo87F9nnnw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4F679608FE;
        Thu,  1 Apr 2021 18:10:11 +0000 (UTC)
Subject: Re: [GIT PULL] XArray for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210401125045.GC351017@casper.infradead.org>
References: <20210401125045.GC351017@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210401125045.GC351017@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/xarray.git tags/xarray-5.12
X-PR-Tracked-Commit-Id: 2c7e57a02708a69d0194f9ef2a7b7e54f5a0484a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8d1895883da8048266a7da43b0a381588dca87d
Message-Id: <161730061126.10373.12752728003527941402.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Apr 2021 18:10:11 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Apr 2021 13:50:45 +0100:

> git://git.infradead.org/users/willy/xarray.git tags/xarray-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8d1895883da8048266a7da43b0a381588dca87d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
