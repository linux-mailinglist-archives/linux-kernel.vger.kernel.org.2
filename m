Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB234372FC2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhEDSbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231861AbhEDSbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:31:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5D3506100C;
        Tue,  4 May 2021 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620153006;
        bh=04dGBdqCSI64ZTJo75OSuP6hE6ZrkZai6etPAF4/Kqk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HaX4tEADcOz/Ty0PlB7MltUWlszhfRlRBxQ6G4B1OcPHhmrMdxlDo3GStmwOpGxMj
         tbb+sd+Yxy0fm3E4Xi/5BMngw26F/WtdMrrnd4aGlhGfZNhUYK0kohoqw+NV2xGgzy
         hdyr5KVhXWkbx0BBh/E+8yBhIPCGdrF/OPev6mTTwZKXMIeXHZMVffuym/+I9BJNuR
         pcaX+MiJrxy5spC+kn8qAhsr+fjZscUG9A6760cBuWBaSM0BSWSHQsvBlncR8e4iMK
         uJtrK0/WY6DJ+V5gqM60eZGphovOHVcfRXTz/IrRQ5Ey/ho3E+6GjDSJUiR0L0xBXe
         5RFV4zeWvXtnQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 42A2E60987;
        Tue,  4 May 2021 18:30:06 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock udpates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210504150320.1468505-1-bjorn.andersson@linaro.org>
References: <20210504150320.1468505-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210504150320.1468505-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.13
X-PR-Tracked-Commit-Id: 1cb8f3e2d8fe7533c26df9925a83bd3d185b312e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c01a4c4ca5b2b06bdc5f633b943eea5fe4f390e
Message-Id: <162015300619.4328.13515992322597643109.pr-tracker-bot@kernel.org>
Date:   Tue, 04 May 2021 18:30:06 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 May 2021 10:03:20 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c01a4c4ca5b2b06bdc5f633b943eea5fe4f390e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
