Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B702438DBD4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhEWQQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 12:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231818AbhEWQQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 12:16:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C61DD61166;
        Sun, 23 May 2021 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621786496;
        bh=Tr4CcQgjnIdsIXv2LMLCXOXbYnpnXMkfhBRnrigX1ag=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J659SvmmYHqD2RHsUA58LdVADCicL1QnzafhPE+nbNmtQm3Tr4rkUiMXgSit7hS+r
         ENGziVxDy35ogsKPjPMcnehGWYduM2a2gMlop5bb4ZBMHJLMFD/cN3tuuPx5Kqm3XB
         DubLVMtui4AguOxC2NMbeU5bZEi+IqXxV4guesTxW2mMuxDzxGltjPnRrhUA1mjvR8
         hF5EjiB5EwBKxAm7KZdpzcmv4NP5wzx+A1YrUDqpRcXC3MSBJS/RGi+oyZuSzHOywQ
         E9sT/oqsjbOJwqJfMVtlE2Z81JBhKlywW73DbfTtKiaXkzLHOIWe2vfzYVNWwkJmZj
         11OF+91PUVVzA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B2A5160A0B;
        Sun, 23 May 2021 16:14:56 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmxhivw1.fsf@mpe.ellerman.id.au>
References: <87pmxhivw1.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87pmxhivw1.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-4
X-PR-Tracked-Commit-Id: d72500f992849d31ebae8f821a023660ddd0dcc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28ceac6959e1db015729c52ec74e0a4ff496c2b8
Message-Id: <162178649665.14510.12044359947385635542.pr-tracker-bot@kernel.org>
Date:   Sun, 23 May 2021 16:14:56 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, aik@ozlabs.ru,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        "Dmitry V. Levin" <ldv@altlinux.org>, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 May 2021 20:31:42 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28ceac6959e1db015729c52ec74e0a4ff496c2b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
