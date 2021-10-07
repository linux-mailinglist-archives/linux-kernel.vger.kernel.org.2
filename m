Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3997B424BAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 03:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhJGBhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 21:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhJGBhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 21:37:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7113B61163;
        Thu,  7 Oct 2021 01:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633570512;
        bh=6g/6xP79GpkRSpkMJmsNb6NrI47wZ0uHxXpsAS59/d8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u7M14iswmST+eePTgkQwVZnEmq37ATRCE3Nikd9rerTWT390K1e4TJvtcsc+CCOJL
         hBxhxEKsHgZC+mZzgcEGYcfAVuEQxlpbali0HYn9OADUM9mIIt33No9/hNPwUockbV
         3ORxA5Q1BLpDt2kmsuz4IuCxpmnrqPglne7qe3ReV3Ed12DbXV6xXsZG24Q47yhOz6
         Wmbbq3/BcErdQffZywbdUNc+4zlPEsw8qvrIe2dAqbFq/72YNba1QTHnCnPaDO3fiu
         jEGOVrXVyJ4IbI/1CGnpfch48yXDcFJc+Tk0otrU2L0oIQFFAjmzlWYfEsIXhbCcUZ
         IVRyeCi3cQ4ZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5E9376094F;
        Thu,  7 Oct 2021 01:35:12 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.15, take 3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YV4WhkB4PQVMCCvu@robh.at.kernel.org>
References: <YV4WhkB4PQVMCCvu@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YV4WhkB4PQVMCCvu@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.15-3
X-PR-Tracked-Commit-Id: b2d70c0dbf2731a37d1c7bcc86ab2387954d5f56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5af4055fa8133662831ae2fb6e188e8f6c172688
Message-Id: <163357051232.16244.13728581848170905560.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Oct 2021 01:35:12 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Oct 2021 16:35:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.15-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5af4055fa8133662831ae2fb6e188e8f6c172688

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
