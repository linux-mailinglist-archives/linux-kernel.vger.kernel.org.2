Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97E045862B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhKUTm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 14:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhKUTm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 14:42:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B73A660F42;
        Sun, 21 Nov 2021 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637523562;
        bh=tHtRoZOVc+QFEAcepM1DCrmT34VcIIc2lsf+5Rmuvmk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AEdX6RTYo6qvc2FHThAa+q8JO2Qvhctzp9+VGpoIjcvi9oymwmJ50W6sm5LpTBCZF
         9pY/hN1pzasQc0vEptp/N04W/Iat50hAR1KDzUyFceARVVNPEP6dFySVsJ1/XHmCgT
         XNDOkGwupe64mwbPDvJKmdjYqpEgDLcnrybjkODnc9sgqzxICTRQsj9OKCariGt6LM
         cfDdbTbmZefrrY7rHndc7Ll5/ZWy0fT/fl55LMYGkHtxC0eBV1mXt2PlYdp7gXJxJo
         dKyMx2eNhhHYTKZY+QbRImfjUeaBOJJFdgSmCFj3I8h85LeG6WAgxfdlM9eEIaF96Y
         WSLRBKJVgg0+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B0994609D9;
        Sun, 21 Nov 2021 19:39:22 +0000 (UTC)
Subject: Re: [GIT pull] perf/urgent for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163750734517.21962.4980600300710105647.tglx@xen13>
References: <163750734517.21962.4980600300710105647.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163750734517.21962.4980600300710105647.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-11-21
X-PR-Tracked-Commit-Id: f3fd84a3b7754b60df67ebfe64e1d90623895111
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af16bdeae8e036942590a2c1f4227fecda477e7a
Message-Id: <163752356271.15895.18097402963144326252.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Nov 2021 19:39:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Nov 2021 16:09:26 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-11-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af16bdeae8e036942590a2c1f4227fecda477e7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
