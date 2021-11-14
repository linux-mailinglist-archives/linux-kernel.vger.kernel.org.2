Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B21A44FB61
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 20:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhKNT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234686AbhKNT70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:59:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 44A6661105;
        Sun, 14 Nov 2021 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636919789;
        bh=HcfPAvbJVfzlCdasghoTLjUA9UGQWxKlYA2tyq2qThQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I93htGGCm7F5Mw1m0+dBuSdFQkMIMhghQaeo7jWuVaDFOqRQ74j60jBwUCLp55SO+
         UFSqraOA99GqguXrvwK63IA/vn39yEkd9KN3vhF8gr/5GlZN0qqMlCd0mfA3qdv5ju
         nMvepFMwg7o4tYztZ+lhX2NJ0QoHpiz/89OfKbCjINLs28bFsvHSE0ZEgnRkF8pcxo
         QM8VSfDFBBiuc3jG5jt8/QbOm+AHYzwifX1vUZSnBUGAgAp1TySDiKW3JtpfHOCQMm
         4rto7ipvvVsdVSWsSzZBxlwc0uX9O8/wn59oPT4/VwaXxc+DV5sDebcdXMsLlSv0FK
         MYQ6Pr0Pd7mqQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3EAF46097A;
        Sun, 14 Nov 2021 19:56:29 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.16, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZE6F+5f4ckFmxZg@robh.at.kernel.org>
References: <YZE6F+5f4ckFmxZg@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YZE6F+5f4ckFmxZg@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.16-1
X-PR-Tracked-Commit-Id: 913d3a3f84085e168177ec2ca843403fe2af2838
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d1503d8d864e94e4de1d51baf5353df01708217
Message-Id: <163691978925.22669.17766382570100414750.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 19:56:29 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 10:32:23 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d1503d8d864e94e4de1d51baf5353df01708217

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
