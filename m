Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1832258C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhBWFvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhBWFvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:51:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39D24600CD;
        Tue, 23 Feb 2021 05:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614059432;
        bh=Dim4fDKhoIBHzmzkoarUaMU9LM4G/phV1a46xLYzVCw=;
        h=From:To:Cc:Subject:Date:From;
        b=K8O2BSuzseIvWghNYu8hEmFDuJv6hgUdQqc8O9qLA+hQ9en7ppg56QVHDC2cSTAj+
         fr5KFdfpabMWSmzlKBKF+Yuubtky+bVTNsrjsgjy1HoICsG5GecW0DbaBluvWTR/w4
         NPAsVbr4iNbsNn1TmH81GoKJa5+dqJGhjwuhoEU9Yfy7Mr/6iAgm/hMe1knCT9y32S
         Oa4Vq9tJed39R82+kSzxpkLzCvdScL1u/uU7lJC+DNb8OwdS5Lg+53tHMY9dX7uZfS
         LabtZE/2mTFzxGPiY1lWyxS8BqPYqDm+fdF/QyE0+p+y8NsyR0CrYnxDErVbZIWFa9
         s9jhHhod9MWnw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] x86/entry: A compat syscall bugfix and some test stuff
Date:   Mon, 22 Feb 2021 21:50:26 -0800
Message-Id: <cover.1614059335.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compat syscall argument fixup error path is wrong.  Fix it.

This also adds some sanity checks to the kernel that catch the bug
when running selftests.

Andy Lutomirski (3):
  entry: Check that syscall entries and syscall exits match
  x86/entry: Fix entry/exit mismatch on failed fast 32-bit syscalls
  selftests/x86: Add a missing .note.GNU-stack section to thunks_32.S

 arch/x86/entry/common.c                 |  3 ++-
 include/linux/entry-common.h            | 11 +++++++++++
 include/linux/sched.h                   |  1 +
 init/init_task.c                        |  9 +++++++++
 kernel/entry/common.c                   | 25 ++++++++++++++++++++++++-
 tools/testing/selftests/x86/thunks_32.S |  2 ++
 6 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.29.2

