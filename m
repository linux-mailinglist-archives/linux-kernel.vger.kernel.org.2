Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18FE4466BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhKEQLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232766AbhKEQLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:11:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6C6E4610FD;
        Fri,  5 Nov 2021 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636128512;
        bh=OHe8PsCei6WRyW7UebGUaYICAPpw5LlEI30p7caeNJI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bQguU6e7059WOCvLX9zi8oJ2IX1UsX56ktETH0+qMqDqghSMpo4ZriVdSn6uGMeBR
         39/4zm7Adgrut0IRc2r0Sv+v49X2cvbayNh38AJwlyqyJVKqVjmneuCTuql9izcJzV
         BTf3VPDEO+3TdoU7N7mcGTva3HiI8N5qGdDVpwvPAwhVE4x2kYONMK0IkU6QkulhEy
         G+1DAsz6PQf2dmNlqjrpkiXcprBc4xHB+VFlolllurGd/ObuK9K08jdHICFRX9Ce0C
         pn9ddlZFM2JhlZG3pFYtyoCvd5XEYSfEvQMNBXv0+tpglALNzHOq25PLtmx+e2wtyN
         pLrb3kPhSx7Rg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 65DAE609E6;
        Fri,  5 Nov 2021 16:08:32 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2111051220020.12554@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2111051220020.12554@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2111051220020.12554@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 5a2506bb8cb3e618fd79966a92454edac67fb468
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5af06603c4090617be216a9185193a7be3ca60af
Message-Id: <163612851240.17201.9192052199789416163.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Nov 2021 16:08:32 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Nov 2021 12:23:08 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5af06603c4090617be216a9185193a7be3ca60af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
