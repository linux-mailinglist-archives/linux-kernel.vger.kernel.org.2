Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB194423C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhKAXNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhKAXNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9BFEC60EFF;
        Mon,  1 Nov 2021 23:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635808256;
        bh=3NG575F8HOWYKAieSyOKU6bav1OMoQ71tYDYOGMzRG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nKkTaeZW3jjB0Q0PEkU1PxORmfHamipUeYA8oQGJQ/WKD5/RAbpMHWMaNbxxDP7Vm
         exfzmzhuokd0SWRwZQ8bruZ/I7HNWZIDYVLGohjThXfQwJDWW02PZvHa+Fmm/7rFAj
         g6//ho55m+VU6+ocoBN+mA5oSIvjQTS5hiUuOfcJA+UEq5CtfQgLrt2ax8XNpgacbt
         ul9C0U3LDL4ciqFGrFqaVMGUyGuYSefH1Xuqd4qe2U+9AyXZwL8vK2tX47w8IsVewJ
         ebnADi2HQvCJD5WnSSYgA7QM0JOsoBYAolZKbfZAFUxJkd5GZ84VfsGsq1+VWQBqSD
         5AVeNKHMGTHZg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9268F60A94;
        Mon,  1 Nov 2021 23:10:56 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX+1JHxvxDUHTjFw@zn.tnic>
References: <YX+1JHxvxDUHTjFw@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX+1JHxvxDUHTjFw@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.16_rc1
X-PR-Tracked-Commit-Id: 15802468a95bd8ec9060eb861468f4a0f0106fa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 158405e888133f89dc9ec3e179c33544acdcf22a
Message-Id: <163580825659.31036.16937481351901767282.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 23:10:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 10:36:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/158405e888133f89dc9ec3e179c33544acdcf22a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
