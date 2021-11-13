Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FF044F4D1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 20:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbhKMTSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 14:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236153AbhKMTSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 14:18:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A98FE611EE;
        Sat, 13 Nov 2021 19:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636830931;
        bh=BMDCJ5c3VOClVu1cOYSmwdRyxt45zSfhSlSMmm9jqjw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ELxHM+UF354/mPvsjNe8gjPkuuwOzvg0MdhGc9XV6Kg3FiXtN2koYOXq94mqsAEWD
         vuoQnuwp25ENk65244werxXaTL0prsIdi5XMdV1KqEyg1TX16L+hsPksStcbsHLOUy
         ZsQp5MZly6Y6XqZH0RiHYLwuFIDweVwT20Orr+Nw3YUybvNvclSsCifT3cVa8KKDeL
         fe+WW/rxxRpOZakoodfGNeoDnnf85Gy1CMIa6Ibu8GqOoGZEOsQQ2Wr6fK5LtDvkjm
         AXFUCp3NmIrzCxHYn2PM9x3RN/O1Dnwv7F/NE/8/AVpeDY7YtR53DWQ2XqhV0wpW7q
         PqKtN9rs+qdwg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 91C2860721;
        Sat, 13 Nov 2021 19:15:31 +0000 (UTC)
Subject: Re: [GIT PULL ] signal/vm86_32: Remove pointless test in BUG_ON
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y25toy2g.fsf_-_@email.froward.int.ebiederm.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-9-ebiederm@xmission.com>
        <874k8htmb2.fsf@email.froward.int.ebiederm.org>
        <CAMzpN2jkK5sAv-Kg_kVnCEyVySiqeTdUORcC=AdG1gV6r8nUew@mail.gmail.com>
        <87ilwxrvu9.fsf@email.froward.int.ebiederm.org>
        <CAHk-=widK1vko2EN9PtV3jTo02u-expXxozui-fsK-0uKrcGHg@mail.gmail.com>
        <87ee7lqe6k.fsf@email.froward.int.ebiederm.org>
        <CAHk-=whf-nR4xDSEDtXeowFn4QQKY3s_MXoM8Ha-dPiOzFzUxQ@mail.gmail.com>
        <CAHk-=wjU1Nf+zzFgwE5bAGSq2W9DifmKDsAOFuZcaaHq3vEQ8w@mail.gmail.com> <87y25toy2g.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y25toy2g.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.16
X-PR-Tracked-Commit-Id: c7a9b6471c8ee6a2180fc5f2f7a1e284754bdfc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4fa09e514cdb51fc7a2289c445c44ba0c87117b
Message-Id: <163683093158.10343.13792820646469910637.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 19:15:31 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Nov 2021 15:37:11 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4fa09e514cdb51fc7a2289c445c44ba0c87117b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
