Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B543772E4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhEHQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 12:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhEHQKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 12:10:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ECF3061448;
        Sat,  8 May 2021 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620490192;
        bh=3O5IDpKDY83jcoMzg8ba634383UgeT4Y+6bHxHaUleM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iSgIC9lXV8hwX1YtZq0SKTCx9a8bTA9kexWQtuMTo6XZM/KCMrtjlQFDqsIekjtV4
         dR+E1cGB6R5FpWfM46g7zzEf/91QXzwRDe+e2vYeviJM8QQNlD3eRXTc0XDH472d38
         K0Wj2L/RSUvwM7ZX9/jW6ecJ6qStDHlKLCNLskjmiBVwbN3Zhw0vLkmnp0m7XoQBmx
         JxwmnRjTz/rp1hW3sz5wg3U5QrqsUIhUPn+2H3BFV32YhtEEbUcShB/dfVc0Mxt+E7
         anD1nb/KBTPWVtF0wxMEjSi20JdB2lX7i2AuXgHru3bu/ORCpsyNkgiDkbOOWav7fW
         sqe1ZezVkUolw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E5AD960A01;
        Sat,  8 May 2021 16:09:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y2cpxrir.fsf@mpe.ellerman.id.au>
References: <87y2cpxrir.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y2cpxrir.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-2
X-PR-Tracked-Commit-Id: f96271cefe6dfd1cb04195b76f4a33e185cd7f92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab159ac569fddf812c0a217d6dbffaa5d93ef88f
Message-Id: <162049019193.24889.5964565284286637928.pr-tracker-bot@kernel.org>
Date:   Sat, 08 May 2021 16:09:51 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        sandipan@linux.ibm.com, sourabhjain@linux.ibm.com,
        Paolo Bonzini <pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 08 May 2021 23:51:40 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab159ac569fddf812c0a217d6dbffaa5d93ef88f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
