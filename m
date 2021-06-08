Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821CA39F5FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhFHMGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232054AbhFHMGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:06:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A8CB6128D;
        Tue,  8 Jun 2021 12:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623153890;
        bh=IZ/RU4U66vr4bfniAwwz7HssL9PQnUFcfuC8yUzwVoM=;
        h=From:To:Cc:Subject:Date:From;
        b=sIJZQ5ibdTSLuDClTpoeGCMP6E5M+JeB6qreI6xM/9z/r3hYvlPKIlH0wuvP+BY7/
         sCR6NxJfuLZWN1IJe8ZtkwxTSHs+bq8iNFLM1C/6IS4trwllUSOfQqhJvQ4BGJX60g
         HRC6iQF43mJGY7Sq2O/litM+Q6E4DCvyoWo0NIsBLqwx8qokNMiqfux81nm7ChioI4
         fMVDsfCDFmk3ZLz/FPoVne5UIMg8jTv4f1TsW0YB2pHA1WsLLr1xFExVA2vZP+p2qu
         HsGHhb0dtITKttPe1jYFBTZw1jEURYtw0E4yZrXgSOxOZ+PYa7BQMpUwH9yVEn0fpc
         /qVQ8/Ue9VN2w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 0/2] sched: Define default preempt dynamic boot mode on Kconfig
Date:   Tue,  8 Jun 2021 14:04:40 +0200
Message-Id: <20210608120442.93587-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make life easier for distros and automatic kernel robot testing.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	sched/core

HEAD: 54b77d028543df2d5b091b5542e68e5fe2dca1b8

Thanks,
	Frederic
---

Frederic Weisbecker (2):
      sched: Add default dynamic preempt mode Kconfig
      sched: Always print out preempt dynamic state


 kernel/Kconfig.preempt | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c    | 40 +++++++++++++++++++++++++++++++++----
 2 files changed, 89 insertions(+), 4 deletions(-)
