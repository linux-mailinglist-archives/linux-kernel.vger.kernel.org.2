Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628A033A7BD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhCNUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233634AbhCNUBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:01:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E40DE64EB0;
        Sun, 14 Mar 2021 20:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615752103;
        bh=qEY4KPv1FWfeCeJsaHspGiIahwMh3VNtau7jhcQ52fo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GZRNGqtbJ5EeJvjxSF4N2kmvCHxlOiojavtiUKwhLnIyOwNtVpf2r1XM1JxUm4vpQ
         YfAFSDuiSXr6EPMC9uvhnEfRTelHnC6EKN+qx4UhEWv8VwwbGJFqFqj3aXljKzeSML
         T0lQoOUBs+7uJAd2j0ZeuTgnl1HheSmmOMq+cs2tVStj1RRqtFaO7XAaq0wWkOWer+
         cqvRUeQYUhU4HNb4CAwZyNLXbz4m4kszSNxEOvnOUsg4hkvdgWzrg1IkTC63NmVB8J
         zIZJY1E/uk9cQTPEiDRTFZv97kpntWeu5tevMZ3UbpcVOp+NUi/CW+LfVF0E9Wyo/f
         DExtoSH5PdlcA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CD28F60A45;
        Sun, 14 Mar 2021 20:01:43 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87tupe3utv.fsf@mpe.ellerman.id.au>
References: <87tupe3utv.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87tupe3utv.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-3
X-PR-Tracked-Commit-Id: 0b736881c8f1a6cd912f7a9162b9e097b28c1c30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3c7579f5e3b4826d32af0521e53d5d565ed5a73
Message-Id: <161575210377.6248.6875830079837121926.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Mar 2021 20:01:43 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        dja@axtens.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Mar 2021 21:15:08 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3c7579f5e3b4826d32af0521e53d5d565ed5a73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
