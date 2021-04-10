Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBA35B04F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 22:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhDJUOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 16:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234439AbhDJUOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 16:14:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 089FA610E5;
        Sat, 10 Apr 2021 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618085670;
        bh=QmFVJ4IubmBYlTZVq+mXNK7Wiu57BjtPHIAZcxO3Gbo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VDE6IgZdhEH9IYl/z+JQioWYW+/oj5NvUD8DbCZ8Ci3pIwbLeqvNTkUqBECqHr24t
         idgMmReLmch+XnI5320l8NwGO0y8bab75WZGwhqm5+WRAXY7NomUuWNzSdOd+5Vbvf
         V6/toQopB3Lt0AaKgK4usoP3dKpxrYkSWFpyNT28zlrY0LQdgJmIKTY1+32nLiB45G
         TqpdzVVw+01CVbSupznCwnxLNgkPMhn6ZccQ4S3bpKgjRpJawc/HfjGR2Uhjp02BpC
         2wxlCdK6W66kiVAOPfqbQrFcs0oYjI8KBxDaZRV/TemtUwb7MRy7Y5rDj4A4Y2Gw43
         3fmb4zT6I7WDA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 015CE6008E;
        Sat, 10 Apr 2021 20:14:30 +0000 (UTC)
Subject: Re: [GIT PULL] percpu changes for v5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YHHs618ESvKhYeeM@google.com>
References: <YHHs618ESvKhYeeM@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YHHs618ESvKhYeeM@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.12-fixes
X-PR-Tracked-Commit-Id: 0760fa3d8f7fceeea508b98899f1c826e10ffe78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52e44129fba5cfc4e351fdb5e45849afc74d9a53
Message-Id: <161808566999.10926.8098517459875269222.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Apr 2021 20:14:29 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Apr 2021 18:22:35 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.12-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52e44129fba5cfc4e351fdb5e45849afc74d9a53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
