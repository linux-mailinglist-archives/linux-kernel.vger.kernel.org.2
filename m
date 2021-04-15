Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F293611D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhDOSPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234208AbhDOSPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:15:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2B7906105A;
        Thu, 15 Apr 2021 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618510501;
        bh=DAseODubZrC6lnUSMeOOEr2nCgWJPGLKeu/DKmQsF/U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JzRM6xn2+UWx49OLc3qHhFyzF7yoUkoypDA7oAUMELcc/L43/FyQbkRTPadFAn9zQ
         CRzD/nG5RXi7H80YaEcVtwnRFvx3eVmukRhvqSJE4X1toWWxmsaDfd7/pZXTLwEirI
         MFMyn0/m3Pfk/CbZyDh6u5ZAZx+XSdZONn54crR4RmTsFxXfAT+EHxIFX3S5BrVIip
         CTvnR1BBpgyJIdp/PjvK/OaH6AONrgcjxCsEKKoi8BZBG8GaWuOkq3eXSS457CJ0hw
         u15DkCrSmIbU9TNJDZ2ac8iIp4nIhUhKRUdQtuv4C/UCvfuXVfI8FetO7s38utg4ID
         RzcuSJrRuZE5w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 23ED560CD2;
        Thu, 15 Apr 2021 18:15:01 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2104151547250.18270@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2104151547250.18270@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2104151547250.18270@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 276559d8d02c2709281578976ca2f53bc62063d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7e3a53b30d6e6f54eef81400ddfe8b32224b77f
Message-Id: <161851050114.16434.4915578637901564412.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Apr 2021 18:15:01 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Apr 2021 15:51:04 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7e3a53b30d6e6f54eef81400ddfe8b32224b77f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
