Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6343663EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 05:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhDUDON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 23:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDUDOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 23:14:09 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DA4C06174A;
        Tue, 20 Apr 2021 20:13:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y136so9537325qkb.1;
        Tue, 20 Apr 2021 20:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCk0W20XhtkIPM/Jkzw1GtBDcNke1OcWBzjVIaUKiZk=;
        b=VGDWY038SMZPifr4QMnJOvsOuhhOC0i/Za6QcfEV2aQRJPJU6aCjpWBQv76Q7RDLlm
         oH95RrSi/TzB2sDmpRyCUKUL2ZMXPDRuegaLAdzQLGVFfsPlS9GYW4ERWXQvO02DoHjo
         oLZU6NeuVK1ckA1vDyiZ3PR7GfciPgjZZhLpgLFNiiVJMHRECm9rUJobr4ikgEyOlVvv
         FJQgjZJXnIWxv10jh5v7X0NzzfJNmuHyswtIXUm/eLasvz6wfRrSiUHbnmzyvGUR7Hi7
         uvd5ZniZ6ybP9zAdI4KdQEONHh6UtsMPwGne34wDXxzaumZAFRaVuRGudGTqt8omJvfs
         dCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCk0W20XhtkIPM/Jkzw1GtBDcNke1OcWBzjVIaUKiZk=;
        b=LwwCMBO5EWp3KO8qDRWvzPwazxaqhv4hrXml+sqN9LU8kfCz7PuVXBnl4eew4JGqkq
         uOolBugoz67mIoUeU7CqOWuBK64oQkUlQ2y8xynyh0jxvddwW/G6a8hSI6F/OnRdaN1X
         c1oKahgEyjhUS7h1fq5JnC/sMMD56HeebkqnOBsU/MMdUBTvIPeMmzDL1qnftkVbcwlA
         Nhmjn/2ILZ6j3tux2gYtkg93ulZKTyQOXBrZvbfwEP4bIGskvakTPROKa36YguWExCbB
         gq2RAioT/3RND8I0cnkDwwL9DpQogi3bbQf6fBdKbnxQBduCXxNGHMVm1DdJSl80Q0uH
         WZ+A==
X-Gm-Message-State: AOAM533J2+8AMESnQ/F+fEhNrNhzUAfdgNbZN/uITsM+HUt+2S05Czad
        1kMyZ+SqmBH6MNVVMJJlwQaUdt/r1ww=
X-Google-Smtp-Source: ABdhPJyqnF+aAL1jU1AirWoU/EKwCOYJ+PT4ZyNB47bjQhIviYJitDnkpC37hOTjkvGLCJWxDvMaiw==
X-Received: by 2002:a37:4017:: with SMTP id n23mr19789051qka.338.1618974809490;
        Tue, 20 Apr 2021 20:13:29 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id d3sm672523qtm.56.2021.04.20.20.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 20:13:28 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/2] bitmap_parselist: support 'all' semantics
Date:   Tue, 20 Apr 2021 20:13:24 -0700
Message-Id: <20210421031326.72816-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU code supports a special group 'all' which selects all bits in a bitmap.
We have recently added 'N' extension for bitmap parse, so that '0-N' would
have exactly the same meaning as 'all'. But because the 'all' is already
used by RCU, it would be reasonable to support it in core bitmap code as a
common and easy-readable alias for '0-N'.

Moving the 'all' support to core bitmap code adds another level of
flexibility for system configuration by supporting patterns. For example,
every second bit in cpumask may be selected like this:
	isolcpus=all:1/2

v2:
 - cleanup patch 1;
 - in patch 2 explain why dropping legacy comment.

Yury Norov (2):
  bitmap_parse: support 'all' semantics
  rcu/tree_plugin: don't handle the case of 'all' CPU range

 Documentation/admin-guide/kernel-parameters.rst | 5 +++++
 kernel/rcu/tree_plugin.h                        | 9 +++------
 lib/bitmap.c                                    | 9 +++++++++
 lib/test_bitmap.c                               | 7 +++++++
 4 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.25.1

