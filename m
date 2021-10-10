Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2284427DD0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 00:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhJIWHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 18:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhJIWHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 18:07:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4F15D60F23;
        Sat,  9 Oct 2021 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633817125;
        bh=M5uV95UnfiqW0HqJ/5bRDHy3Dj2jLeTDaYt9RxLsTEY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IGrcwmdHhcWHJKUskEcysU2bA7RkTQ4nia/ZWyHjaT+cXKhTZ+sbuna7+0SutmPqk
         YmGFiqQMt2393z41zZiSXNkBK/8cZvqm7DLgD0+fH0OjWmLqCfBnppHf6pW7EY41Em
         fsGmfffwoJ7fRA2lnPDM5o0+m0kZVoCzM+Ov//Y/LhaTGE2SRzqFj9IUKtmB367KPN
         biwr7nbD/t/RpNn9ORnJneJljyfOFclDObYu5lZUMyhKV9SvJGz54wKblG3itB+m60
         TBMg3CpIno/U5lqlLuemJMQKj8a5dCZof+zpNsaui4KQoGS2w4hgh9aIIQ9yhtBXld
         BKdASWGnLaZpA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4933060A38;
        Sat,  9 Oct 2021 22:05:25 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msTLfojvmuejv+hO6CvF8cwuAw9CpiJWxs9a_D7pZfSLw@mail.gmail.com>
References: <CAH2r5msTLfojvmuejv+hO6CvF8cwuAw9CpiJWxs9a_D7pZfSLw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msTLfojvmuejv+hO6CvF8cwuAw9CpiJWxs9a_D7pZfSLw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/5.15-rc4-ksmbd-fixes
X-PR-Tracked-Commit-Id: 64e7875560270b8f669fca9fcd6a689fea56fbeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c75de8453c3e2f8a8fcee9171118b7da29d3fb9c
Message-Id: <163381712529.3348.3091109306467539409.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Oct 2021 22:05:25 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Oct 2021 23:59:17 -0500:

> git://git.samba.org/ksmbd.git tags/5.15-rc4-ksmbd-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c75de8453c3e2f8a8fcee9171118b7da29d3fb9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
