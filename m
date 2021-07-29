Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA693DA951
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhG2QrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhG2QrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AFE2F60EFD;
        Thu, 29 Jul 2021 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627577227;
        bh=LRrukXj/PZN+PYNNYj7/wJ0ujVE1aByj+tj4tSjSjNI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cPQ9I91w4G9gZRR2OCDr0EG2dIUg5nMxo7mIdv8E/lSkDE5RBlOUI3AjB9sE0cvHn
         cMwS4BxoOz7ntFJ6GMJeidC4JeO58+AnpeSKoCFpWMO+DO+arSl1C3/+p0QUY0CuaZ
         jNTWPIU+eRZWniFyTwNpsamSlbBqVve7FR1BzaVBVcbSysHlbTsJUBJCRMrvgUbRPC
         42B1N0cMDgF3kAljWUwDajzKG7u2s2fPk7qK8yApT8iwlF7w/Makl805xTZlg00IFI
         Dncu+V5wSCJ6IBoIA95wnC2KhbUu9/i/NYQZN8d/V1l+Zsyaq7EDfMDNqutLqO4p+7
         FEyEX3i2Olwfg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9B0A9609F7;
        Thu, 29 Jul 2021 16:47:07 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5e52d59b-09df-be5a-8be9-459949eb16e2@linux-m68k.org>
References: <5e52d59b-09df-be5a-8be9-459949eb16e2@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5e52d59b-09df-be5a-8be9-459949eb16e2@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-linus
X-PR-Tracked-Commit-Id: 9f66861181e64dc192bea136da6c91528910002e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b99c470d50ae01df37c40596f4be58f1d41db06
Message-Id: <162757722757.17762.14888517996328281494.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jul 2021 16:47:07 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Jul 2021 12:09:25 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b99c470d50ae01df37c40596f4be58f1d41db06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
