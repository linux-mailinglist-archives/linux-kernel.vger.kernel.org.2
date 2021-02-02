Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3E30CA92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbhBBSyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239010AbhBBStd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:49:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0368D64F6A;
        Tue,  2 Feb 2021 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612291722;
        bh=63kqSSFZ5QH2VK3XFozK55E2qyeCN3RZHFfIQ5yIexo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fsnaknA/aWKGjgWYHQHjKaTi1hPIRnZuIJIq6C8fHpmIDOhpAcDDGRHQT+9WE3qdd
         oq0eK/H5ucOzAjv+S6JgOtFe0IjSwQPBpHmbhlOUuObio5QQEUhODMToaCCTRFhQsl
         akRtyOBKKi8qLjHu6PQXqVkWHYpufHQNxz1UYSyjSq43UutZVN4q9JuvlQMmFSLi8F
         lzoBWDjA+w0nOEZe5357OSuBwJSUrzUnpu/W6VIC2xTsEpRs5zjCoVIFqYpWCMBvfS
         GL7xsiwsZuBpBlKhK1okLot6kPoJ8oayMLxSrX5crOAP+vH9HC5T7p6vZ9FegwhA4R
         8n9LUan/47Y4Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ECF00609D9;
        Tue,  2 Feb 2021 18:48:41 +0000 (UTC)
Subject: Re: [GIT PULL] clang-format for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210202145846.GA25454@kernel.org>
References: <20210202145846.GA25454@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210202145846.GA25454@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/clang-format-for-linux-v5.11-rc7
X-PR-Tracked-Commit-Id: 1074f8ec288f537f3b8462d09997a69b40f87e38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3aaf0a27ffc29b19a62314edd684b9bc6346f9a8
Message-Id: <161229172196.14515.4887622610523097110.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Feb 2021 18:48:41 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Feb 2021 15:58:46 +0100:

> https://github.com/ojeda/linux.git tags/clang-format-for-linux-v5.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3aaf0a27ffc29b19a62314edd684b9bc6346f9a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
