Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F010308335
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhA2BZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhA2BZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:25:29 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 17:24:49 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id m13so8205186oig.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 17:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=R29x4Xzru4jLJYPGClQXFA096vfPSDIsbcqyZYBWRgo=;
        b=alIXhU/SaEwewQES6i6DOjrRL57RbiriQUZvv0A34q21xJq16YDkpkGRO5ffSMI2ey
         kAsn9U8dQ/6RnRSHF4tr7y2hc4Z+smmKvOMELTVsFXVv+F16N4UesoJI9mDD45NeveYt
         WXpBDTcRsrjX6v94iYECDQecaje7BUMsP2/BI9WoJseyrHkIVqKvYtdna+iFA5zuyk7R
         eTTIrbAv0vG9zdpyLSU2n8Wg6B8MfUD1fjfzVhOC/VgzCrtUHqszCZgxZ2ySUlyC/vev
         IuBJiZXfJdE4jhEDiI0rdcZvkl/WCoJOM0pwE2iDjqC0Q2QT4LN/ElsZig/qLuh6Mtg9
         raKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=R29x4Xzru4jLJYPGClQXFA096vfPSDIsbcqyZYBWRgo=;
        b=paddxMHZrQEErpfPQtRy9DRdRrTfcPFuAKKCYDSCG4FMQFtt8ed5L68yfIdk82PZBj
         uHCxDyZrkmhn0jYa04DKkBrZcvXHN3AHL2x/IfmIM+qfZyTQ7ixfLPMINzcCevnPnzQ9
         0EywUOWLU28T0LloN/e6B7TAf9VM0+wSmUb9vUzC+zpm7gGi535LnsE/KZrc+gkB6AWT
         Rqf3UAtqYGb9lqLuOWU4cGbOKxFq/4lrPHvFWsMxeoiCXYsZVZr7T1JUFoLcYc5WAiai
         lbNwy3KgaeErltA00SIkf8oPE1N6yQKanw3XcgQiPQCrtfz+wyO6pyvARZsF0T5qgp18
         NBKA==
X-Gm-Message-State: AOAM530leo0Ulzn4rG3JmjC8XotEMH/0S2LKVEFuQJB58wyfXdOI8TCx
        OBNsMnhlZpm02cXmebL3JxdP3g==
X-Google-Smtp-Source: ABdhPJxcEQe+No7raaUh56xQoANnGTV+xoaeGn2hNJK8l+TLAK599H4UY5EvRIgPKSQERDU04biVyw==
X-Received: by 2002:aca:c4ca:: with SMTP id u193mr1256788oif.178.1611883488708;
        Thu, 28 Jan 2021 17:24:48 -0800 (PST)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id u2sm1696971oor.40.2021.01.28.17.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:24:48 -0800 (PST)
Date:   Thu, 28 Jan 2021 19:24:31 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [GIT PULL] eCryptfs fix for 5.11-rc6
Message-ID: <20210129012431.GA633037@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 83d09ad4b950651a95d37697f1493c00d888d0db:

  Merge tag 'for-linus' of git://github.com/openrisc/linux (2021-01-21 18:35:02 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-5.11-rc6-setxattr-fix

for you to fetch changes up to 0b964446c63f9d7d7cd1809ee39277b4f73916b5:

  ecryptfs: fix uid translation for setxattr on security.capability (2021-01-26 01:47:14 +0000)

----------------------------------------------------------------
Fix a regression, introduced in v5.11-rc1, that resulted in two rounds
of UID translations to occur, in some configurations, when setting v3
namespaced file capabilities.

----------------------------------------------------------------
Miklos Szeredi (1):
      ecryptfs: fix uid translation for setxattr on security.capability

 fs/ecryptfs/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
