Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE53C35D9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhGJRiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 13:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhGJRiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 13:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 45BE561283;
        Sat, 10 Jul 2021 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625938539;
        bh=aMSg/W3JKgk/QSLRr710QgamKXcuDAfnGN0BhCnQEZU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nVFNCT+gO7X/M4N0YpNIndi/3/H1l/8gofzDjAfYy239AGj1Y1gpVePf+ZEVIMba9
         uNbYdxOW48QTw48jVR33k3ScA8mFzVCVL55gJsRkWaBYttoKJuALBLwy4gFUwcGpmE
         krQD7PyfvY0nWGdbdcWUCAiZmKVI19MXO/ugOptadeV2SXk5f7ATI4tIrGB/y9/7qG
         UCn+BBN+hRdmj2B5OyovsaYwcNGp6wnQcBI9HVCXry6ATd5prG0j0JWoP1UuSl1ZEu
         TS+/HmB50w4cwDSUq/hFLT/+WwjWknMyWZcqYBXS82rTg3h4HyIVmWpBq7hfC9/jl9
         xbOdUbkl6i5PQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 30E5860A08;
        Sat, 10 Jul 2021 17:35:39 +0000 (UTC)
Subject: Re: [GIT PULL] percpu fixes for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOWld9O5CZpzOUKA@google.com>
References: <YOWld9O5CZpzOUKA@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOWld9O5CZpzOUKA@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.14-fixes
X-PR-Tracked-Commit-Id: 93274f1dd6b0a615b299beddf99871fe81f91275
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20d5e570aee77afa44849dc652ff256290ea978e
Message-Id: <162593853913.16773.6869893322697341248.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Jul 2021 17:35:39 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 7 Jul 2021 13:00:39 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.14-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20d5e570aee77afa44849dc652ff256290ea978e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
