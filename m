Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4700B43E8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhJ1TcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJ1TcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:32:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C130C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:29:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 46D4F1F42FC9
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/2] selftests: futex: Some improvements
Date:   Thu, 28 Oct 2021 16:29:34 -0300
Message-Id: <20211028192936.81640-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series makes a futex_waitv() test more correct and test
the timeout for the new FUTEX_LOCK_PI2 opcode.

André Almeida (2):
  selftests: futex: Make futex_waitv's invalid clockid test more robust
  selftests: futex: Add FUTEX_LOCK_PI2 for timeout test

 .../futex/functional/futex_wait_timeout.c          | 14 +++++++++++++-
 .../selftests/futex/functional/futex_waitv.c       |  7 ++++++-
 tools/testing/selftests/futex/include/futextest.h  | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.33.1

