Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0731206D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 00:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBFXVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 18:21:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFXVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 18:21:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3281764E53;
        Sat,  6 Feb 2021 23:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612653663;
        bh=+xyygatuh3Fom9YWTWj4tM9GXTc/Sa+pVyh5PVHATMA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FtJPiiImIruEpLX8X0VZzm4fQz7L/NlOhYBPOy4aCAlq9HI11RWVfX2M7PZJSi7f0
         pwiuOWgQ111Kt0f9kdVlYHNfTEoHqjjLIKwRJr4ScyyPGR0qNn/LAeTOR8ULFrnpAD
         GrsN+DPTa1OjI24zTKtU83CePWgI8p0eF61llSnbO6E1K5475jho77Sfv4ZAs0Ud5x
         wU43DWRXhNOBfur6BC3kJKlN8z24PJ7asVIQdSq2vNUST0HJ9NnZ/DlRjRlGCfQO9L
         6NZnXRLJVSdOhYJcmscv2twiti63CQRtMszei9X4A9T4ma3MB9PaWylm6pCpPtI2QU
         UuzdhIo3DaC7Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 273EC609CE;
        Sat,  6 Feb 2021 23:21:03 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-7 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8735y9pdga.fsf@mpe.ellerman.id.au>
References: <8735y9pdga.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <8735y9pdga.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-7
X-PR-Tracked-Commit-Id: 24321ac668e452a4942598533d267805f291fdc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f06279ea1908b9cd2d22645dc6d492e612b82744
Message-Id: <161265366314.26028.10795279007910033789.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Feb 2021 23:21:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ravi.bangoria@linux.ibm.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, raoni@linux.ibm.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 06 Feb 2021 23:50:45 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f06279ea1908b9cd2d22645dc6d492e612b82744

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
