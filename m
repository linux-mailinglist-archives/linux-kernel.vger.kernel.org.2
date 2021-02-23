Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9788E323487
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhBWXzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232791AbhBWXhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:37:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 79C7064E7C;
        Tue, 23 Feb 2021 23:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614123392;
        bh=uqY4+fP0Osgh33K3gufVrFSu6UOxr3sTKSJdZmZkFcI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NOsOXaYIMfbUCtEHiDteJ9k8gAbYYh5aV7meGE/guVxCO0go4cqRJQEH961VhFOKM
         fk9yy+q1YEzSyJiSYzeeaGcn0b28oF0EBiUZczdRJxqyO6cf7w0n16lYvt7r5QaQlJ
         7ZYbwjN1HH+GNp3W553uwT7NTklZYLT6qIWNb/Uwrddww6zAcy6uGjmlPjvurAN1GT
         Q/3a550a+VgStGvshou5Mcl1nEw6l7jPyA2WRsg2Kdjxx14xp+Zm8TB8g3QEUEk4RD
         oq057EvZ/vB6gkT62FzFcfVqcfGJ08zoctWiu+CtoSfLDo6VAa0RMzaJGnBXobEiGo
         EzFGCmlj/1sog==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 74AD860176;
        Tue, 23 Feb 2021 23:36:32 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2102231147510.28696@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2102231147510.28696@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2102231147510.28696@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 00522de2f9f184946d5c4384100f48270f88c45d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69aea9d2843669387d100e353b5113d1adc9502f
Message-Id: <161412339247.20258.10285506433149331738.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 23:36:32 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 11:53:51 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69aea9d2843669387d100e353b5113d1adc9502f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
