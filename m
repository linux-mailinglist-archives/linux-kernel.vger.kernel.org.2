Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3329845E028
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244622AbhKYSEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhKYSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:02:41 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C35CC0613D7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:52:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so28686945edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OX0F7gU0q2Z5daEp+m6mri2L4WNsljYMaLf4qrY2Plw=;
        b=Ij+Q933VfNAOP7OjhUfzziMf75/c3xxHL7bB6jRf/BuG21nhFWBPuX/5AZqbF4q+4O
         SWDIGG9CxKzLoKWl3sCh2RfqzddASwNVZgY0NJXm8Wsa45+/0sEi4FhRK2z0f9yZ5y6i
         Opv9WQzH1onG/SKLr2Ist19s/9GufKPNChxNFm4oPkISPIk5iHeTo9tlGJS+QOz6kxBl
         suEvtxC+OXUUs4bIjksNSCFDMa1P+iO6cg206tcmTXwqOBwjrf0XlbfqU29zR5ZzYy3M
         3Dux0MXronWY1OV5tUGFOlFvfEtpM4jqKZinTEXKq+LZF1gpThXoHW3y3edCDuR8J0CI
         R5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OX0F7gU0q2Z5daEp+m6mri2L4WNsljYMaLf4qrY2Plw=;
        b=OLuOSwfbiGgWp0oqzW+YAm8rLW4WxelL8tdJv4cFYEt8JPKRpiMx12pQzgrwg3+yaK
         Q+lVu/dteovLNfiSR99xAfjOiwDWEUjIuqKEr8MjCCDinCHcl6Hb8ysKwQHnWhweVyLl
         22kgtQc39fawXQkj3rG0JOF6O9E1zNVXk62oTS5LJARM6W6H/l3uJ3gpk5Gsx2JGEPFi
         uuqPQ5i6UZkKle5747RRUsM5WD2yyCGF8y+hb6VrqaqfkN2+/dQstq7aoWj617TUtB08
         gtWNDVBT8gRZfnerBcCArZm7RxEK6pbYHrwwoMu/CMBWhiuJY0lHkVdzV0dfbAhYIAUD
         1NAQ==
X-Gm-Message-State: AOAM5337zSKkGf1GQaXhPNSQ87G2ggH4nESDZ8Tk5mwT6IxMmLYjHStl
        Y3AwSHxbDmqLgNDSlt28Firw2wGXf49T5g==
X-Google-Smtp-Source: ABdhPJyNHgQIAuzdIcSzBHGmngM+xJTwy+lvbQREFhPcktJwn3RVSJ3Fk559rveIHfO9Ddf/rlShpw==
X-Received: by 2002:a17:907:868e:: with SMTP id qa14mr34843121ejc.564.1637862775576;
        Thu, 25 Nov 2021 09:52:55 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id hs20sm1949795ejc.26.2021.11.25.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 09:52:54 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] tracing: Introduce configurable ring sub buffer size
Date:   Thu, 25 Nov 2021 19:52:48 +0200
Message-Id: <20211125175253.186422-1-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tstoyanov@vmware.com>

Currently the size of one sub buffer page is global for all buffers and it
is hard coded to one system page. The patch set introduces configurable
ring buffer sub page size, per ring buffer. A new user space interface is
introduced, which allows to change the sub page size of the ftrace buffer, per
ftrace instance.

v3 changes:
 - Fixed ring buffer readers and writers to work with custom sub buffer page
   size.

v2 changes:
 - Split code refactoring in a separate patch.
 - Changed the logic to work with order of system pages, instead of page
   size.
 - Fix freeing of the allocated pages, to take into account the actual order.
 - Code clean ups.
 - Bug fixes.

Tzvetomir Stoyanov (VMware) (5):
  [RFC] tracing: Refactor ring buffer implementation
  [RFC] tracing: Page size per ring buffer
  [RFC] tracing: Add interface for configuring trace sub buffer size
  [RFC] tracing: Set new size of the ring buffer sub page
  [RFC] tracing: Read and write to ring buffers with custom sub buffer
    size

 include/linux/ring_buffer.h          |  17 +-
 kernel/trace/ring_buffer.c           | 345 ++++++++++++++++++++-------
 kernel/trace/ring_buffer_benchmark.c |  10 +-
 kernel/trace/trace.c                 |  88 +++++--
 kernel/trace/trace.h                 |   1 +
 kernel/trace/trace_events.c          |  50 +++-
 6 files changed, 395 insertions(+), 116 deletions(-)

-- 
2.31.1

