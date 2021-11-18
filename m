Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEB4456478
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhKRUwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:52:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233161AbhKRUwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:52:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4BF4461220;
        Thu, 18 Nov 2021 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637268541;
        bh=wpZdYa5h0d37MIUuRUVbZvYOVjpRxGS+Y7WMEkjmAmo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jYnUoG3pVnUkOhF4MUO5RtYT8OJ7NmeixIAbypf+Et5kkd+dPFnYQsggHE8YLYURh
         qlqaYJH/bzkuqqKAsa4VIZdSaf4DpY+iSd0Ja7WMyHnNHVD2N/Zwfnjf4laNiBh0c1
         qoyaVUVFGHPFDu+AbNpByoQPcITAhkiDkFuvVVcwX9FoJXsWOB3atk7Kk9OiFe7wlt
         rfUNh6K/yiNMBXT6LHkfOkzSo3c6aRpRKOEvIl9UKvgfdSj9jbyjqUE742SmfiRpIv
         +L/5l2CUGZRB1cRuuDHVg2ZncG8Prr+26smZYd7MjMxbtM1F21CEZvcjEGCQ7qDzWP
         Y2sQFA90U268A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 465BF60A3A;
        Thu, 18 Nov 2021 20:49:01 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871r3dg3jt.fsf@meer.lwn.net>
References: <871r3dg3jt.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <871r3dg3jt.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.16-2
X-PR-Tracked-Commit-Id: b96ff02ab2be1791248237b1bf318aaf62e8b701
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ae275bc6d2fb2b399a8723fc0a0be0929e10e0d
Message-Id: <163726854128.10311.7567293196354621521.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 20:49:01 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 03:29:26 -0700:

> git://git.lwn.net/linux.git tags/docs-5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ae275bc6d2fb2b399a8723fc0a0be0929e10e0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
