Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0886E445807
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhKDRMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232126AbhKDRMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5DECC61186;
        Thu,  4 Nov 2021 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636045809;
        bh=CeBpdAGWs9Y2KivLX8aozWjmA5Au1dDrvwaAqtUbNZQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sOr/1vpNkApCqC/0eioh9/P9YkPWMhlkKC5qwa2KwPTZ7cmJyAPThs7lDYx5bXUa1
         FFG0ko9Dp2RozroSj5Uaxa8HBDjwA2uEyEu8oI5V/JBJkk2pQXNhvQX3SS+14zRELD
         VAD0b+TxDgRVIV5rJT9K+6eeb4u2o1+2yKAUfDHdsFQWNMZ7syVh8kq64dB+NjPbcS
         juNhVJIspnPw5VYakQo+XIsFG2pTBuTJ0tItDXkZjbUUGMsit9CobaqKlCb4cVSwpr
         ue2GFz9h8PWTNaSxTaHynrZt2siuwGbzriw3lKsokNsa4e9v2ri68rR6KwDIohU+lw
         uOmKDojxCrDQA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 56B7B609D9;
        Thu,  4 Nov 2021 17:10:09 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYPbujTBPoDtuPM1@kroah.com>
References: <YYPbujTBPoDtuPM1@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYPbujTBPoDtuPM1@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.16-rc1
X-PR-Tracked-Commit-Id: 27e0bcd02990f7291adb0f111e300f06c495d509
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95faf6ba654dd334617f347023e65b06d791c4a6
Message-Id: <163604580934.24234.12821663880724867679.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Nov 2021 17:10:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Nov 2021 14:10:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95faf6ba654dd334617f347023e65b06d791c4a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
