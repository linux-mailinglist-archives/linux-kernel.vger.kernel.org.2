Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4890F45694A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhKSEnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhKSEne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:43:34 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CDCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:40:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r11so37159230edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIkSZLGA6Zgat2q+EvhMbZPbyjtCYsrKBtM7rL/fLRU=;
        b=PlZbMuiIS4x0qYF0IERFpGAhUs9gXFG7VA8EJco5o46cf0snyDnZSvO5W4vYyANHDY
         DxCe1c7JsZUgTVftpIn3sTdUT/wrQup4Mqk86azv5x9T83BFWtoyQf2i7dvMLcNWxfkG
         fYQaN/9Th++7ujsA1jem/Pv6qDgiv+YApQzgGl8u4/44c8HbJli7PqVon/hok9qbhtgj
         3ZykePlOf5uuhd5VmcIhQAkoyWmaPgun4OBjo5SCqu7qYzBak5PAajpnO8Y/N+pfAu6p
         Vh+YBH6UEJ3Vm2NUdP4oz+6q22a1ROP3o6wCxuernCWgOt70ufJQOgNUPEM9mYjLsKdO
         OM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIkSZLGA6Zgat2q+EvhMbZPbyjtCYsrKBtM7rL/fLRU=;
        b=3WF2ZNF8JvfGyEifEilFz+HAIiXS7PwOxCzZaFeDtCOKppA8bDKJQ0HJSYNPYOdjXF
         iwnrnPYYGZUrwghAJrLnAQVkBeA9hC3NwnxDUhBkDKtAiAH+nh+9zuR79FfHDUqHbI6z
         S7m6C5dQo4LwwSobV3PXLd/XpAppE8RNBNAetQZiOVgep6jr/5bhLqjT9toYIjAjMAxq
         DCLxidl1vSyPPYwNFAypnOYd7veHcdYS4pjDwNL3uJNrRL21ID8UUbo7Zf1lvQM0Zjcm
         XxlvbeYV6trORM+iKPCGMnd25LP662r8CpFmxnHpzb2mL6z0Y63WqfN6oivr7UT7vzTK
         jVcw==
X-Gm-Message-State: AOAM530TEpT2wK3cHiM3AE+S01XDcKVyWJq56cYtupFeSz6pZJlLKgh/
        U/M/Y4fXUaiJ/NY3OoyVNh68qzJIG8dDkg==
X-Google-Smtp-Source: ABdhPJxwSpfmLdKPAOO0fJaHC1lEHBJDHU2YpVi8asGieZ/wDRyEl0xtSbAZloLP1irJ0AOyzsnlrQ==
X-Received: by 2002:a17:906:9744:: with SMTP id o4mr3959693ejy.322.1637296831727;
        Thu, 18 Nov 2021 20:40:31 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id lv19sm694709ejb.54.2021.11.18.20.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 20:40:31 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] tracing: Introduce configurable ring sub buffer size
Date:   Fri, 19 Nov 2021 06:40:26 +0200
Message-Id: <20211119044030.85368-1-tz.stoyanov@gmail.com>
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

v2 changes:
 - Split code refactoring in a separate patch.
 - Changed the logic to work with order of system pages, instead of page
   size.
 - Fix freeing of the allocated pages, to take into account the actual order.
 - Code clean ups.
 - Bug fixes.

Tzvetomir Stoyanov (VMware) (4):
  [RFC] tracing: Refactor ring buffer implementation
  [RFC] tracing: Page size per ring buffer
  [RFC] tracing: Add interface for configuring trace sub buffer size
  [WiP] tracing: Set new size of the ring buffer sub page

 include/linux/ring_buffer.h |   5 +-
 kernel/trace/ring_buffer.c  | 262 +++++++++++++++++++++++++++---------
 kernel/trace/trace.c        |  50 ++++++-
 kernel/trace/trace.h        |   1 +
 kernel/trace/trace_events.c |  50 +++++--
 5 files changed, 293 insertions(+), 75 deletions(-)

-- 
2.31.1

