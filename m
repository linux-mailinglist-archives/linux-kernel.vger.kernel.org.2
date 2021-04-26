Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C015936B651
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhDZQAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234153AbhDZQAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:00:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F7FA6135B;
        Mon, 26 Apr 2021 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619452761;
        bh=EmeQk2rnWtsVMUMpXuWo18FjtOl4sWVSbqk49EgoDpo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u/OdadGY6DID23nSgBDum+0DjtuRexga21nMyyuSlIgdDdtZxbd8LWhxEXGUQq5va
         rStAKigObz2GZ9Ht082iawMIzJ14LWnqubsufDKibU7QnTAl+jU70kxQ5GgIWW/nE1
         f0HpCDeBWlGqXfRanJShRDjW3DekTuhJzOFPq8ISaFdmvnMRlG1GW9czc+kxx8C13g
         zvDrzPBCGJ+kNV5gPgNOEhcx+mij3X42+SXSTucChu8/29Ru421KHZfy+EKUr96iWs
         VCJK2Mf0L6co2U0syyE/prfx2+CoBEei/itlJTp8Gsx1l4PTkLjvQavoKSzBDGWfNb
         FaYnNSUMkAz1A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1A65E609AE;
        Mon, 26 Apr 2021 15:59:21 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au>
 <20210215024721.GA20593@gondor.apana.org.au> <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: e3a606f2c544b231f6079c8c5fea451e772e1139
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4a78bc8ead44c3cdb470c6e1f37afcabdddfc14
Message-Id: <161945276110.5751.11099491579718297038.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 15:59:21 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 20:32:00 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4a78bc8ead44c3cdb470c6e1f37afcabdddfc14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
