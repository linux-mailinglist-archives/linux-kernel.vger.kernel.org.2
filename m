Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2553759DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhEFR6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236338AbhEFR6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:58:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C651961107;
        Thu,  6 May 2021 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620323862;
        bh=7hq6JRPExv14wrJEV4oEAqMY4ywekwltCgszlztOM/I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MRcfx0lWCLyZmGJbGw4bstIPVZ/buuQqMRE9zivHH7DX9IVKTLC8/Rhj/jarzU3Jv
         +OYX3OjDnApfXkANUzFFfdMSdjnqIzGLEkamcIt2CI42fx1QxsAgLa3iB/2AARuKrk
         B8SW2D3DFefM/MTMIp3iessi05vLPwT5iYxVM8d/e+x73cgQSHMTqXI3a1wSIoIsJQ
         Y0l1iHHfGvFI70Z7UNFM+1G94+IvEP6QkYZM5Hj5Bl4judqKrRytN+urjnxlDiydGA
         Fw6jQUguZY/txRLPCPwcw9Bxw2VSny8nB3/eSyEQ8NYDhLAzLfGN7aOhTiht7bKl3O
         TIW+CcjCW7CDg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C004660A0C;
        Thu,  6 May 2021 17:57:42 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.13, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210505224242.GA2953573@robh.at.kernel.org>
References: <20210505224242.GA2953573@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210505224242.GA2953573@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.13-1
X-PR-Tracked-Commit-Id: 6799e3f281e962628be531e8331bacd05b866134
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2423e142b37e2fcce61ea6d3c2f103384ae05f92
Message-Id: <162032386277.1989.15293221254226311127.pr-tracker-bot@kernel.org>
Date:   Thu, 06 May 2021 17:57:42 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 May 2021 17:42:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2423e142b37e2fcce61ea6d3c2f103384ae05f92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
