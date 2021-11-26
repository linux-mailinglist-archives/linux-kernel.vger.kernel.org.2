Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4088945F4DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbhKZSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:46:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43088 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbhKZSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:44:42 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45EEE62341
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 18:35:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id C1F0A60230;
        Fri, 26 Nov 2021 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637951715;
        bh=9S/92vgY1r+ITMC3wc1Z8mWpA9O4M0yTo3ncFbJ/wyU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B/IuEsi38PlymMXljcjHTXWD7aAWWMx7K2TQVXR0pJ7kOrk6HCzRAjEF51qxEfoVA
         vLhCdI4NkfwiCosz12hjc3ojV3dsat055nBiIAnkMCANZakDPPsSdMCj5BP2OASBJC
         d6t2sCGb1z2m1RcpXtJMEmXMVoRtDZfUVImmUhqS9E0ZvNjLq3hKafkXbvVG/NXj7p
         Ea5hTClRObTywggW+Bv4FlllcsiFwQdW89NNQlt6uHeWjOFvCgKMK4njGBfs/6SOBg
         tC4K/189QCv+FOohW4+2JNb2aANg1SLkDdi1O+ip24KKoJFbGvJhWhYH123/LppKEB
         dgqQQ3LTx2zJQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BBE6960A3E;
        Fri, 26 Nov 2021 18:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211126153152.380-1-jgross@suse.com>
References: <20211126153152.380-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211126153152.380-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.16c-rc3-tag
X-PR-Tracked-Commit-Id: 00db58cf21188f4b99bc5f15fcc2995e30e4a9fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b54698aec0b59943f7e8a88151bdf208de990d0
Message-Id: <163795171576.22939.2366989648980472963.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 18:35:15 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 16:31:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.16c-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b54698aec0b59943f7e8a88151bdf208de990d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
