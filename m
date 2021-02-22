Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6400B321EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhBVSQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:16:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhBVSNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BCCB964F08;
        Mon, 22 Feb 2021 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017530;
        bh=l+ojQ4qENmjRMsN3gsqaJuynWA2e409JidDHCJ5sz1A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XFysuGxKDuRrs32qoxQG1P7vZnBbZriyUvZczd5NfGfdoQZr4jVL+QMWIBmYeEDt6
         6NZSmQvDc8uzrb5YHZGAlyubC4uRSABWqLEprAFwXBUy511fp59hp6b8+yofrpeKeT
         oB2t/F5OQiScNOLGQZibM3iCY+lI6cBdoDSi56IgLG/B6C8Jmh89vxVa/oyKCCR+6I
         AaXk++Cn6R2SrkkPzEB6lTuflO5XAkR00Or/7RUC+xP2co51/tPRvuVQAyAH8Upde5
         eXJreVRETppK3kSrOrcx/2kSbNeVmeNlt7O7QrnxV2Vl6u4LsldZQWvLJNq0j71eRO
         JVHXnjylCw7iA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B89C160982;
        Mon, 22 Feb 2021 18:12:10 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215044138.35831-1-linux@roeck-us.net>
References: <20210215044138.35831-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215044138.35831-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.12
X-PR-Tracked-Commit-Id: 6ab3332cc692ad04dfa30c92d3391aea8b971ef2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a26a9d8ab4f9edbdfb087a563b6613e9970ef0b0
Message-Id: <161401753075.943.10637408132963796574.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:10 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Feb 2021 20:41:38 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a26a9d8ab4f9edbdfb087a563b6613e9970ef0b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
