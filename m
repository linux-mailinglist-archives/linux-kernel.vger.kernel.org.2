Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEEE4424EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhKBAxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232095AbhKBAxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:53:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EA03F61051;
        Tue,  2 Nov 2021 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635814269;
        bh=vhX98WSQ/IOnpdalkg4Kpxb1ipbVPzRGNdRVl5Erprc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SvIvND1zZwDBQ5h0ZvmEM8vlAVqb7hmVZl221bO9pGq5OwzkDIKoq5fUMIsaPz6w+
         e4QrCXboyqUbky0crLJymPPgJ9QBZGNT5krSPglvmtXnj++W2/2Ze5pQ4tirsGghEm
         mORHeZ4msHkvPVRMRjyP31txp1RGsQyyh0O5avKWwVksN61S5fN4wmxJbcGhrQPAFI
         e3Y8xapu+aPVDbTWX/HRCZ7T28BzY8PpkihtsOGLzbIbnFbUUrBukGcc/c2OJkASrn
         H5z2YkV/ohbPmhr6CimCaRoQQ/J0pZbiQj/SHD3+5Tng0qGbuRtWpicAv2VA7ajBB7
         DqwMw/by3LjHQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E34A860A94;
        Tue,  2 Nov 2021 00:51:08 +0000 (UTC)
Subject: Re: [GIT PULL] cpu-to-thread_info update for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202111010908.CA1B15CFDA@keescook>
References: <202111010908.CA1B15CFDA@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202111010908.CA1B15CFDA@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cpu-to-thread_info-v5.16-rc1
X-PR-Tracked-Commit-Id: d9f2a53f64a6fcae994457e64a7124d2a3efd323
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01463374c50e4fe75abec927fa231f8f5d701852
Message-Id: <163581426892.14115.2083506299229931333.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 00:51:08 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 09:12:01 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cpu-to-thread_info-v5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01463374c50e4fe75abec927fa231f8f5d701852

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
