Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161BD43E74F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhJ1R2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhJ1R14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:27:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D33F3610E5;
        Thu, 28 Oct 2021 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635441928;
        bh=sGn3i0Cyeyw5DwQfEnBJJAsvEWMbCAIYmlhJQYxnsTM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H+3hf36kBpy8/aG+ARNd4yFukdoG7d8i5++PW4tEpb+2jSeqiS+OSKntkVj51iZn3
         EftIl/XJW6NOIZmjNpnkYWcWURdyQRXgzZq07p6D0xP5zy1DOFAVIm/MVln2P6jFss
         eKV4mP6KyduXFn3whlk+yK4YBEQOBYl1rC8wwuJS9z79A1CtvPGX4WDtrNTplIpPpK
         Q3TcAOewQ/gdHML1StG/3bpoaTshzQdZLDfxu4ZphFT7EDSdgP9QT7sakb8AUW8LmS
         G6L9YofCJB1w0wEgkg6M3A2xFh8wt5eNIg5FuPyU3AGxV1BSsHnDCfpxGrl/cF3Q9b
         2SUnupLJc5V8Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CC9E760972;
        Thu, 28 Oct 2021 17:25:28 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211028122340.C5766610C8@mail.kernel.org>
References: <20211028122340.C5766610C8@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211028122340.C5766610C8@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.15-rc7
X-PR-Tracked-Commit-Id: 55e6d8037805b3400096d621091dfbf713f97e83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8685de2ed8c1b0e5cfb07d1986e6a38250a58e8a
Message-Id: <163544192883.14282.117958868677769862.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Oct 2021 17:25:28 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Oct 2021 13:23:37 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8685de2ed8c1b0e5cfb07d1986e6a38250a58e8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
