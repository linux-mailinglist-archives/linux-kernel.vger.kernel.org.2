Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03F23524E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 03:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDBBDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 21:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhDBBDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 21:03:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 04F0C610C7;
        Fri,  2 Apr 2021 01:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617325415;
        bh=14qODsBJrQ7OylTE9M7cPl9PTFi6HW12EZn/DnDKU7c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y5e6GOaPQgjsFYTZSm9C481S4RVuoB3h5qGJhxuTQDDQFyKlm62ZWJhvOq3gywIKK
         VfM4UtOZt9vqCLO1Vz0MFedOnfcvwHxRHP1WsWt0t3LhLPKInLnuNVQ2KMdInX5Ruh
         6jTYMOxYj0adaAJQ767bGnfU2Bhp6ToDHE10SBmp7eBbKUrdJixBD78jGyOQpkl2Sl
         lEdS8zGYEA8GRwO45oDh2e4LfXiLGqZ/8QoaC/JyyZw1JcTU8tZ9A3ANfILJGCoZcx
         HvBA4B+ZoRoXmhXXAccHJDFQQQSo9YwG/euLCbPebKcISnxYO3d0IQ3Fw39YGl3BPw
         BpF6OFHw0Ay2A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E56F0608FE;
        Fri,  2 Apr 2021 01:03:34 +0000 (UTC)
Subject: Re: [GIT PULL] LTO fix for v5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202104011435.78CF22D@keescook>
References: <202104011435.78CF22D@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202104011435.78CF22D@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lto-v5.12-rc6
X-PR-Tracked-Commit-Id: 6a3193cdd5e5b96ac65f04ee42555c216da332af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1678e493d530e7977cce34e59a86bb86f3c5631e
Message-Id: <161732541488.23096.10434236784485900682.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Apr 2021 01:03:34 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sean Christopherson <seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Apr 2021 14:39:19 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lto-v5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1678e493d530e7977cce34e59a86bb86f3c5631e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
