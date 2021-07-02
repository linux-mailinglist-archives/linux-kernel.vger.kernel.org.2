Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8314E3BA540
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhGBVuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhGBVuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:50:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CCD88613C5;
        Fri,  2 Jul 2021 21:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625262462;
        bh=sJhh7+rjezK2kHg3H40Q6vnJAD0nK1IiKNJjsNN8+5Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cnmvis/eVgYBQQYyRnGVEIfpUWC/i4A2OIU27/58yzNppoLV1RByis03Q2TvI+QRo
         MqxLAAIV8r3pVT4HCttZQOYwkC57YtM6rpxVpAHZZZmpaucV7ipRTy783tEIFFUzg0
         Qa2Vc2j8+zedfHlKKouQsrUdFsn9kgtkKATOZHlm3LGQAqlkQBFd9vPhzc53FrwffQ
         B8Ya64HhcjvAVyPsqSp9Mx23QYO8w6sXd4c2NGZ/9qNmM1TlyPK3KTpoyLkjmVV6V+
         xdZC5PeSf0b+v263lCj/qBWCq3eTt9IxDFPEqOa5UpYdNFl/JXi7L23J/DoZvUeyB4
         hsAmeodkpT3ig==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C6C1360283;
        Fri,  2 Jul 2021 21:47:42 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0a301710-7be3-e1ed-9690-14b4de9e1fb6@oracle.com>
References: <0a301710-7be3-e1ed-9690-14b4de9e1fb6@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0a301710-7be3-e1ed-9690-14b4de9e1fb6@oracle.com>
X-PR-Tracked-Remote: git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.14
X-PR-Tracked-Commit-Id: 5d299f44d7658f4423e33a0b9915bc8d81687511
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4aa67b023167c570be95a39149a918cca9e36a0
Message-Id: <162526246280.28144.2025535420436317557.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 21:47:42 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Jul 2021 14:44:38 -0500:

> git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4aa67b023167c570be95a39149a918cca9e36a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
