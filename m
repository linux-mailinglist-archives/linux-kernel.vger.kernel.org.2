Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E12635A79D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhDIUJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhDIUJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:09:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7069961074;
        Fri,  9 Apr 2021 20:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617998964;
        bh=8gFshgeHPGAlwmZy0/IGPaf17g0L+Ns1ANN5OOBfOCE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D85iFi4GQZ6DPvOmoesKd1np57kSn1NgPm+B5QcVFtoCpqeCiogyyRpoia00l5LRm
         K3KoFZp4BADq8fCWcLwVDlqRh6HnA32gRIRKhGJPJllqwiJdQpbXe1G/WSN/4jjQw7
         4swabbVS+FAbbq0no4+v8TCG/i6AVKxvCr4oq+Dvn5op4wwfmWC9I4tZxKZFjVPY29
         1HqvY6QZ2JaU+igorCkMVz1ZS73w78io50t3IHLSzxKWcLSdiinS1qyjfUmYjJFK2n
         xhNusiIunrnADYQu/pMPa4L7ooFtxBshiTIMXhkyDB2vCBCdACxGNtmLVMUAJf/o5m
         gMrTocCULsrVg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 61FD260A71;
        Fri,  9 Apr 2021 20:09:24 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.12-rc, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210409200009.GA4050302@robh.at.kernel.org>
References: <20210409200009.GA4050302@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210409200009.GA4050302@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.12-2
X-PR-Tracked-Commit-Id: d473d32c2fbac2d1d7082c61899cfebd34eb267a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2521822bdfd73bd40d7cd81dfa89cc922b1cff4
Message-Id: <161799896434.13555.16647799407076305143.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Apr 2021 20:09:24 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Apr 2021 15:00:09 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2521822bdfd73bd40d7cd81dfa89cc922b1cff4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
