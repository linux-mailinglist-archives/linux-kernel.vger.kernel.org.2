Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9623D44DE50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 00:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhKKXMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 18:12:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234458AbhKKXL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 18:11:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 877666134F;
        Thu, 11 Nov 2021 23:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636672148;
        bh=RNhd+D9s7KF21vYeNOZthkUP9oH0/tKBUhcje1QFwmA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LGxziFQHEeA0YCYHuEBck7WW2wiKUajobHoMpvE5a8rQD+azZMb/5HEPcj8vTHTFg
         XyCMHfXI7WBQrNyvNX76T15Pquev20SVABEuiI4IyRep3n2QPMtOXYZJkUvo5YVc5f
         an3n4i7WO8lXuzQO651QBYQ9FhGyGUL9XHo9i8otYEoAMkrf6aRHKO6kreu1NyypXI
         AgVaIaEI1im21ET+4Ne5aYBaJtAtUVY9D1jlkLqAlLuX+4dcYanYDJf8GoFO2v7rZQ
         9ak0KX2BowYPCCjzA0RsTuAFVTYkdmL/CmYJXvwLny+fwcYi0JQFFOCNPvQAeqUjWD
         g38ZXKOSURePg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7FFC6608FE;
        Thu, 11 Nov 2021 23:09:08 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <318e7461-6fec-a6ac-5c88-e17b6fb914cc@linux-m68k.org>
References: <318e7461-6fec-a6ac-5c88-e17b6fb914cc@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <318e7461-6fec-a6ac-5c88-e17b6fb914cc@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.16
X-PR-Tracked-Commit-Id: 6dbe88e93c351a6cf5b7c70850d7a1a7f67d83ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d76f6eb46cbf8334b37352f2c2908329d028286
Message-Id: <163667214851.13198.12999618153843175407.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 23:09:08 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Nov 2021 09:49:14 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d76f6eb46cbf8334b37352f2c2908329d028286

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
