Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED94084A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhIMG1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:27:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhIMG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:26:58 -0400
Date:   Mon, 13 Sep 2021 08:25:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631514341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Evf6TSTkFBhKIBbpScXRNo+1XXA8BAl9Def55JSVH1U=;
        b=CYy9uyiL8uRYWTiRBV6+qw27FEoCHKUPmI9S6m+lJQYxj/RXBAv+vpMwhRAKpD78yB236a
        Sa+H8Ocjh76CVOQXij8ZO4QVpWo++Pa/9ADlxMAH33MiNc0jzMEvMiLGz6PSNGPioI1Mch
        oyNemwfUIv76T3yrPR1TarBrClrVSgWFbGC94NFb0VQanvF9k/Pz4KxaYq8Cb5sOh1vF0g
        V0xlf53eYW+TcynSK2V3o6ivcNfNtbDMk+VHvQ/Qks/aokdym1qFRovCIB40S3q2w7zD/I
        eHluhE/c9+Um4+VZV4BpOvmGbXY27URZnpGzdXaQAza2sBBYZ1jTHWJmc//jVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631514341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Evf6TSTkFBhKIBbpScXRNo+1XXA8BAl9Def55JSVH1U=;
        b=teXD4NdCxItReVSWVbmEBqfz9rnNOoLqYlfLq9UKwLV+j277CJX5pD2sia+2CBsiZT9df7
        J0d0ws011ViJ04Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rc1-rt1
Message-ID: <20210913062540.kxerifxlu3dtbga4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rc1-rt1 patch set. 

Changes since v5.14.2-rt21:

  - Update to v5.15-rc1

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rc1-rt1

The RT patch against v5.15-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rc1-rt1.tar.xz

Sebastian
