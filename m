Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39F135744C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355303AbhDGS2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355291AbhDGS2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 483156113E;
        Wed,  7 Apr 2021 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617820090;
        bh=FAEVW8RxY+1NwvDR94N62hhfOJBG5Mnl2qw8f4BHObg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pJS2/WCmArm7F/yHFYJAZg4Q2eWsdZQ9uvQB0y7GatlmXkOVMN15KLAASayxpIp4e
         gwilGnF4F3r/7nnl8W/NR7B/K5uuiqO+YDZ9QJqhd2H9PFl82b9l4YNuGNUZmSivy2
         VSw+WJtiOhomRF1kNcQ3iwmCzJZZvQkkMMYVNcoHK9n6VYwe0C6BD4Af5IY4zFrjJl
         Ap0ISpZ6v/P9ekxaZLV2/MuutARNlRH/cO+PTb7rwNatRNbAaSbDiVDGpWFu4SGGPM
         ftI7SQiPkjXuHk/r0Pa1Pk7M/n4DvOMwALrl/6RHF7j2Aoa029XDrDopPNL8iHUM09
         gT3n710tBwPlQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3A3C9609D8;
        Wed,  7 Apr 2021 18:28:10 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YG12tezhGsQ5R/lG@ls3530>
References: <YG12tezhGsQ5R/lG@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YG12tezhGsQ5R/lG@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-3
X-PR-Tracked-Commit-Id: 0aa2ddc9af44bf9032098a587aeabada4da181a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbaa5d1c254e1b565caee9ac7b526a9b7267d4c4
Message-Id: <161782009018.7121.3622472284901915724.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Apr 2021 18:28:10 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Gao Xiang <hsiangkao@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 7 Apr 2021 11:09:09 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbaa5d1c254e1b565caee9ac7b526a9b7267d4c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
