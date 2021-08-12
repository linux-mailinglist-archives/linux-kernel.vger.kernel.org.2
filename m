Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA8C3E9E61
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhHLGXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhHLGXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:23:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A375160F91;
        Thu, 12 Aug 2021 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628749392;
        bh=xDz6gPPbQMZsl+V6sOf1p3wHbmMz5HLJjrXo76ZJwp8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GdpAUYDuLC6kR83WaA6ZWJQ65EcIK9Y8BNlTh/ppmxjdqS39uQ0mQ4u5Lu/rPNDrw
         799cPl7FqGhdYiRsTcqICEqv9kpOAYNRbmyfvnOhj1jDNcEdCv4szMx7DRvGAJFdPy
         6WuvdoaPNWlt7eh4s49c3bpok3/vt16nL0EbH4DUdFetEFyDyAhkC2fm0/jTGThx2B
         ZJkvd7MkEBu8EdUIbxrIA9YFI7MitrRc3z02urUtgGsa+zVuGeVCyvt0miVlXPZUWv
         5KmeG4MDFUL/+KfZ33C6l6rW+NV0stNtLeZD5reYMBCqJzTq7IoVl/FElLwkpmkkRt
         s7D6BQvdFTWxw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8F38F6096E;
        Thu, 12 Aug 2021 06:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp fixes for v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202108111159.123B4811F7@keescook>
References: <202108111159.123B4811F7@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202108111159.123B4811F7@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.14-rc6
X-PR-Tracked-Commit-Id: b4d8a58f8dcfcc890f296696cadb76e77be44b5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd66ad69ef5a59f303b595ac8ecf454f213cb7e6
Message-Id: <162874939252.15829.14087841623079608182.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Aug 2021 06:23:12 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Hsuan-Chi Kuo <hsuanchikuo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Wiktor Garbacz <wiktorg@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Aug 2021 12:00:26 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd66ad69ef5a59f303b595ac8ecf454f213cb7e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
