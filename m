Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C457319735
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhBKXyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhBKXwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:52:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5A50264E44;
        Thu, 11 Feb 2021 23:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613087498;
        bh=hCu6gUGDP9UN+JzdIaPKdPU+JA0XEE3mofDzVcBUxUM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AZVv5t5L128wKsYqO0qy5imi2ONRaWlkl/vdXGGQwjbhwQcjUfsS36nMfE4vaunVd
         iHYTuBTbq9EdXpFHXVB5MawmhpQQHVbWVBxNx4SDgNk+i1eHeCVabZLmdMchVJbdVJ
         NdbgTpIdRnD6dAkGmsUu67oDV8z7350lHKyvgvfq3J428IclBcuWwxW6u/jxEDzSH5
         C+mUN8pX2R7f9O+u7UqxQjA2ZckzbxpXdraQXclLwfUB22Z53THWJ/ZquKAyi9jv13
         XJQCDZo5JKVtRZXTscKuG528OZ98a8rd57ePUtW4C+SSb0JItoGyxi8Np43+RS86PN
         5h6qviTNIe97w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 44D6560951;
        Thu, 11 Feb 2021 23:51:38 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-8 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87blcqnqkw.fsf@mpe.ellerman.id.au>
References: <87blcqnqkw.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87blcqnqkw.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-8
X-PR-Tracked-Commit-Id: 8c511eff1827239f24ded212b1bcda7ca5b16203
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcc0b49040c70ad827a7f3d58a21b01fdb14e749
Message-Id: <161308749821.14652.3292558738499889917.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Feb 2021 23:51:38 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Feb 2021 10:15:59 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcc0b49040c70ad827a7f3d58a21b01fdb14e749

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
