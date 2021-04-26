Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC836B918
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhDZShW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234819AbhDZShE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:37:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 581C6613C9;
        Mon, 26 Apr 2021 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619462182;
        bh=1c6J+eMPRQqONY19TT9NzKWdXyxllZFWv0onM/b3eEA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TFr7kF3wTmrJ/GRKllPIkIPjgrLDDcLtu5ontUdGZ3HO2XTRpYgaVF2uuJsz6eQq9
         vO/XdeZqRzBNSbyC4stN7hHBLKK88lKbzG38HRX8HQ96H6+8qSO7DF7bW+iQoQgR4S
         VBmECaLrA0Zr62ZsUa7gxGR8ROGL+PmN7GJB8QsUmxgiuUv1LOnyhjaUU7yRhYTqO+
         Xi7TPe5HNYM70vNw2/uMEMDq5PFiH2WGPY8uSkMkX3D50EvZnlKgIQqNanEvgubNmd
         JutX3HYGiC1nkOB5VF5ygMBNy5VKCjx7rRxKqsqEJIZ3WANzIZa9miST/c2oaudOAG
         87c287aTnJUWQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 52C9E609B0;
        Mon, 26 Apr 2021 18:36:22 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver updates for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIa5GtU/7FpKPUAN@kroah.com>
References: <YIa5GtU/7FpKPUAN@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIa5GtU/7FpKPUAN@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc1
X-PR-Tracked-Commit-Id: caa93d9bd2d7ca7ffe5a23df9f003b81721c8e1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef1244124349fea36e4a7e260ecaf156b6b6b22a
Message-Id: <161946218233.19244.12805459436155643190.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 18:36:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 14:59:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef1244124349fea36e4a7e260ecaf156b6b6b22a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
