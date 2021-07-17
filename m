Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD193CC0B5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 04:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhGQCP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 22:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232640AbhGQCPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 22:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0148B613F1;
        Sat, 17 Jul 2021 02:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626487950;
        bh=7ZquTdPxZ3oCrMAEx3W7RDzHN/JQqnrKWtmPbL/LX34=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GnPZylmXRj8hT+cMakDn3SXi4QVtEI/F7lk1QlulwlG000j/O9ZIrWpCgdir74Jd5
         usNTDpEP6JlTfwmKGkDfqUj9oGoMX/x85h9mLDUCAFmu0LJD4kLA0yAwDG1iMOlEyM
         3A7mogtTIaXX5N+ZnSY4uiy/jbzki+UAzJqIxDjQ2/vpJkX4PT7wG1ha+ZLuspKnAW
         rv4bxQMe8nYtA0JU81HbzlVGQHrJnM/DW5NZlZjykAQJG4awZDhiz4in48CcH+UehJ
         Hzc4QDms3P+gbJRy7FFMDM7JB/TEbBcBPJ8e7IwIw+9xrt4glvaMOPEF0p/zYrgVeO
         H7Ifld76j9+bA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EE80A60A23;
        Sat, 17 Jul 2021 02:12:29 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.14, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210716185830.GA3769653@robh.at.kernel.org>
References: <20210716185830.GA3769653@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210716185830.GA3769653@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.14-1
X-PR-Tracked-Commit-Id: 50d8d7e19c4398da74d028f367754e73547b078b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d980cc0620ae77ab2572235a1300bf22519f2e86
Message-Id: <162648794997.32541.17093775779890557494.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jul 2021 02:12:29 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 12:58:30 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d980cc0620ae77ab2572235a1300bf22519f2e86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
