Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9C396683
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhEaRJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:09:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40246 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbhEaQxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:53:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 7AC591F41FCB
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, dave@stgolabs.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/2] selftests: futex: Expand futex testing
Date:   Mon, 31 May 2021 13:50:34 -0300
Message-Id: <20210531165036.41468-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset expands test coverage for futex, implementing two new
selftests: one for testing different types of futexes and one for the
requeue operation.

André Almeida (2):
  selftests: futex: Add futex wait test
  selftests: futex: Add futex compare requeue test

 .../selftests/futex/functional/.gitignore     |   2 +
 .../selftests/futex/functional/Makefile       |   4 +-
 .../futex/functional/futex_requeue.c          | 145 ++++++++++++++
 .../selftests/futex/functional/futex_wait.c   | 180 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   6 +
 5 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_requeue.c
 create mode 100644 tools/testing/selftests/futex/functional/futex_wait.c

-- 
2.31.1

