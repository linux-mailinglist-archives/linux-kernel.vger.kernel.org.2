Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0231F405E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbhIIUwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 16:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234786AbhIIUwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 16:52:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 985A660FDA;
        Thu,  9 Sep 2021 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631220654;
        bh=BTqM18BTh2R2R2sBWj3mQEPB7Xza9ES38vz6aXcuP+U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t+kgkcRQ3PP0TUGm2mrsWwAHeubDoqyZiufe+dKbgKXMomAgU2s8q/WbPhAXBuNsK
         eOjXFYf+fMo4Ky4GVFUaGQLyAc3uqaNkR6UUDvuo4Kv2LKTsiXWSsYmQvEwuJ1rjtU
         U+e3byVQNNyshWUyEx5RRiGrdLWdw4/oTe6g4Nzln8VgduogQncRvHm56DkcKC/gX6
         oCkQ9conzZRLVCU4dkemrUDzseV+dSW6u1BaV3+eOHikoXLglQDL/wlZVrVEg8x0QN
         JOmduZOA0yVmxpL1297CGJHwVEwjN8UvqetYMYCa9wwVqxfuifDYJfB5Yqw6hcFUMB
         tdWuT8hS2GjSw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 866FE6098C;
        Thu,  9 Sep 2021 20:50:54 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <547678000.58650.1631215677820.JavaMail.zimbra@nod.at>
References: <547678000.58650.1631215677820.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <547678000.58650.1631215677820.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.15-rc1
X-PR-Tracked-Commit-Id: adf9ae0d159d3dc94f58d788fc4757c8749ac0df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6c338a741295c04ed84679153448b2fffd2c9cf
Message-Id: <163122065449.10185.319334111165698312.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Sep 2021 20:50:54 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Sep 2021 21:27:57 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6c338a741295c04ed84679153448b2fffd2c9cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
