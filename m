Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF626402F78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbhIGUPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346082AbhIGUPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:15:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 997F561100;
        Tue,  7 Sep 2021 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631045673;
        bh=BDyCTfuSPPyUJGc2/XR80E6iL0W1L8n42HmeFIqb5aw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=baABJ2EReacyOxeUIyJKfBeNutrJuRxmN+fUJqiTnaEvTHpYjYHlwjbPvjgMliQ35
         txJ8qvuGxnjs28zsIeoJ9rtD0RsxNztLoWSbbFu7bFqHUvz9xTQ/+C1p9D7HPGFXgg
         fgJyTFKXt2cV/p0ZHjsvf+CoTSiBiosK6Hpk8xR7tQPTLC2xQMpCECbHsbGBUnMXlc
         lTUpUjy18iSkc3hpr5enf3J/FdgUK9M8E5kDftCqBw/m4WpUrkoEAcFASUnZKWOFXP
         Gmz+DYO8WVKcUyVhdL5S6Lr5XqUukQ39pHyLWzf1m1M0o9XgpVT/tYxT8XJnOqNhWE
         FbohVL6b3cb/Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 93D0F609F5;
        Tue,  7 Sep 2021 20:14:33 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210906180209.GA14486@athena.kudzu.us>
References: <20210906180209.GA14486@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210906180209.GA14486@athena.kudzu.us>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.15
X-PR-Tracked-Commit-Id: 38de3afffb7257176978dfa9b3ab67d0c29af95c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1735715e0fd7a16972402ac98197e6cf30988a45
Message-Id: <163104567359.21240.10721410239847224990.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Sep 2021 20:14:33 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Sep 2021 14:02:09 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1735715e0fd7a16972402ac98197e6cf30988a45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
