Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C8536B709
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhDZQlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234346AbhDZQlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E3C5E613A9;
        Mon, 26 Apr 2021 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455219;
        bh=Olr48yYHT4sOc2sSIC3V6iSfgXOv9PdarINabRduXM0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bT8kim950KfSbliuW8Fhz4utKbmurOWJhIK7unycdlz+Pv+5XfKQRVYlgGK8nOpep
         IlKYYtY0WF5EIqrM7GHxv+uuh5bkuA8yAhSBK9kunpLwEDBwyWIi/wd1gjlMsbWagZ
         d6xVoJOFviU4D62LfWKYdjZwUEBVToGWfw3YMa4rcqLsiCki7CZlM/bA0o9Pb3RrJm
         md95CjOy3g53atsidwhpsQwn/GAYFNZSew1eAwC4uaybJe336shH1YggBF6KkZS/CZ
         RoFe75BwTdkToV8gcn6tC6NHMP5/mjxD0QMhrjSbRtBXLz0m6HFp6kUNTUdIlCzpmH
         ACaMmVva3+74A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D884D609B0;
        Mon, 26 Apr 2021 16:40:19 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIZ+LcDiBCcxYPpB@zn.tnic>
References: <YIZ+LcDiBCcxYPpB@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIZ+LcDiBCcxYPpB@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v5.13
X-PR-Tracked-Commit-Id: 7189b3c11903667808029ec9766a6e96de5012a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41acc109a53dd32cd5739cee996068269dcd2962
Message-Id: <161945521982.27394.13730981788372038429.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:19 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 10:47:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41acc109a53dd32cd5739cee996068269dcd2962

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
