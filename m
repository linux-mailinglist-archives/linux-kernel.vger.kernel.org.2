Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E422038C089
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhEUHST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhEUHSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:18:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3AFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:16:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 6so13533954pgk.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=v8o79yJvUV9XNLlx99r5MWL3uESjn0TyS1fm7mwk/Po=;
        b=S+AwRhJWNxcbOisGQ50V0vydf9YkmUbFoTej+maYSerXugONCEuBeIEK1tnFjWumS9
         1nFn/+fa1g3kLNm0pM8W8ndMiISnDZDU4rjJ49qDtcv/EYdpPf1IWX9SsiFSJ7tJG4sc
         b2hJGkVmR3XKysYvrXlPa6mZGf2yRr6FmES/6DKXw4ZBGGWRanlWTaDqUqhiGCvMoExL
         6m/JJJor4H8jvC27is01w13YADq5VqQM19J8SoSFmpTarYxvBymeG4IIo8ZMfnnPIjEq
         FWMqmAKmvhVe5Sa9aYuDRRrhcynnHFp/652VN7dn+9Gc9A3nTXPOOej8jq2ses9kIvF9
         46uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=v8o79yJvUV9XNLlx99r5MWL3uESjn0TyS1fm7mwk/Po=;
        b=rnNTg8ff2Ria/RTbP+OuWCOCwFnL4Ug5neAULtKcXCWbV1N1xJXVKy/jMPfuGLiPvt
         Z+Xz8PsmEGXgnVPtNkvZ2yeF7KHzFGGv5Zo8BIdyDjZNxmHfV/alCiA5GqCBSJD/Ydmn
         5h4E8h/R4xfLPlNRLcfQZh1c3H0Ev/5sYmjz4Tw5d66KA/3jdi2IdSSQ4q6pAJJv10dO
         k7VDADoj7BST4BVoO947nZcO9/gLYwLc7D9vmhe5x/nM+moSUUz75yR8dQV1wiwNO0va
         XmDwXBTcfsmmcGZjwf5edm29T5eZSDkGcaPu0Z0k7vkgntvAsDv2nEPfY8OivFmDWgFS
         IaPA==
X-Gm-Message-State: AOAM5336PPMOGhBT3CaDvZy0trx5nTvRT18vRtXGvxVZbmREGB7x5JJH
        ki0mHufSSapRYZSrPZWqjDpINqmz090=
X-Google-Smtp-Source: ABdhPJzZ5Ci4gxfutn4gXM4i2QIiviYDf09w5qw3xezUZIAvwep4j7nb+2ARA/c5KGgmp5oEmoxyZg==
X-Received: by 2002:a65:4887:: with SMTP id n7mr8453834pgs.284.1621581414315;
        Fri, 21 May 2021 00:16:54 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id b15sm3588098pfi.100.2021.05.21.00.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:16:54 -0700 (PDT)
Date:   Fri, 21 May 2021 16:16:52 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: [GIT PULL] OpenRISC fixes for 5.13
Message-ID: <YKdeZFKthTY31705@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 8b549c18ae81dbc36fb11e4aa08b8378c599ca95:

  openrisc: Define memory barrier mb (2021-05-15 16:00:10 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.13

A few fixes that came in around the time of the merge
window.

----------------------------------------------------------------
Christophe JAILLET (1):
      openrisc: Fix a memory leak

Mike Rapoport (2):
      openrisc: mm/init.c: remove unused memblock_region variable in map_ram()
      openrisc: mm/init.c: remove unused variable 'end' in paging_init()

Peter Zijlstra (1):
      openrisc: Define memory barrier mb

 arch/openrisc/include/asm/barrier.h | 9 +++++++++
 arch/openrisc/kernel/setup.c        | 2 ++
 arch/openrisc/mm/init.c             | 6 +-----
 3 files changed, 12 insertions(+), 5 deletions(-)
 create mode 100644 arch/openrisc/include/asm/barrier.h
