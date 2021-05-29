Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A6394D37
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhE2Qu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 12:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhE2Qum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 12:50:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 75DEE61104;
        Sat, 29 May 2021 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622306945;
        bh=zngPtRKVtPeVaRNTGTQU66NMLGT2S5eZ99v/cKSo27U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OtjTsh3Z3t44/OrxyK5wEFl5QrukVHH3QOxdvZ7Nmf6hbU92f8NCnPCUzK+LI5wlq
         7PVk4zNTTa9JTjIDXuuJjWVpJM7CC/fZwbKMoUoiB84BZfoL1ijYpy0SbvhKLaOnaK
         XIwWF2wr3gDHhGsJ/PHIpGqnIFZxd11BrxiwJY8hTvFeANivojlYp/x6IzhosS9J7w
         ZJnFBxC0O2/03Aqmjy2treIs7QGHu8Y+HRlzXONcdkM0xV4k3GWcQdbOsxylKNwc2N
         6SuLue5ou8r/+ZOR2ghGCskfi7yC/w/hCynoj9Oq2gnnZc0Ks0ig0w0d3eOz4hbSbn
         oROYAlbRzzsjA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 688CA60A39;
        Sat, 29 May 2021 16:49:05 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YLJPTFZ8aIx7Mu20@kroah.com>
References: <YLJPTFZ8aIx7Mu20@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YLJPTFZ8aIx7Mu20@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc4
X-PR-Tracked-Commit-Id: 0c8713153fbf7ba4e45172e139d501c86006dc03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1a9e3db3bb59c2fa0c0de0b3381c64b3b6ffba7
Message-Id: <162230694542.3322.8203966477798616036.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 16:49:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 16:27:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1a9e3db3bb59c2fa0c0de0b3381c64b3b6ffba7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
