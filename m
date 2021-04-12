Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA46435D04C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244857AbhDLS0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236716AbhDLS0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:26:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C278461350;
        Mon, 12 Apr 2021 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618251947;
        bh=ZN2vqozDRocKnahAkvqi8qAJMlrIbH7pnklh3KTzCug=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qjK4UxJWzyhi0NTymYkgIzhvCvB5buzE5A355/uBLGkUutWRt8cKXC9bjEWcM9+X4
         x9akBLS80H1RD2iNCHiq6pPl8uJkJg7nnk8PyUCImqbbcLZKt6HDtQ3F3AiUBodFYQ
         iS3Hmov6cqXlWH7eeSJhGmTgwChsQqBYWYcDnZ303AEuSZr48Tgz/8x7QKxAmvQDU3
         x9x0aGiJuKmifEfvEn/mxPkeiAo19orkqXlIW2c8gzFNEin65/Iahj+YW/Yempr3qG
         9XdAZPAhnYep1tXPWbittWI/9SA2KSJilmKbzym0uijplC7h5d+rjhMomGi2Usp3Jf
         JI7/V3NC8IV3Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AE17560BD8;
        Mon, 12 Apr 2021 18:25:47 +0000 (UTC)
Subject: Re: [git pull] m68knommu fix for v5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <274538fc-42c0-e425-53a8-6a2f0234aae1@linux-m68k.org>
References: <274538fc-42c0-e425-53a8-6a2f0234aae1@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <274538fc-42c0-e425-53a8-6a2f0234aae1@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.12-rc7
X-PR-Tracked-Commit-Id: d2bd44c4c05d043fb65cfdf26c54e6d8b94a4b41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89698becf06d341a700913c3d89ce2a914af69a2
Message-Id: <161825194765.14899.11975799559047537024.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Apr 2021 18:25:47 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Apr 2021 11:13:57 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89698becf06d341a700913c3d89ce2a914af69a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
