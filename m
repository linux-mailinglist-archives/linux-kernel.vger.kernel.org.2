Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083864401F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 20:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJ2Sgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhJ2Sgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:36:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A6C061766
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:34:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so7844934ybe.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=93iwUDOobBuls+/E5vDDQ4gbsROtaRql+3ZjfJ57cYg=;
        b=QoWnKrdqlxAbjyByCl565yFgv7LbAxVEc9fWHpV7QHaZFLrCfCW0jqXuk1TP6EyGVC
         cYAFFnejyfTMEmIs2d3ZqUbS1lJVfB3UI0Qrg6hCPDLOLWTXr1bD+cefwT8dMsIiTEqU
         UIOOTbDRosaY9j42FqnnygRFjwNTsC1OkJiqjnjmIlH7pJd7oRBBPAZ1upYbctfWZBQj
         eRZ4bzqvdE/T0FHzvkKJg1HQUrOOAO820ygOZqL8zZHIew8BjPFuAdPjp5m67cgN0lMB
         1F+yvzVPmR68OngynN9I3P+R7lal48E3sLDPV8F/+yml38UYWQkSzAS3uiXMHi2bxjvi
         X8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=93iwUDOobBuls+/E5vDDQ4gbsROtaRql+3ZjfJ57cYg=;
        b=ke8WtFlUib9aW/k1u8RSprPzx+x6bnWAwZDhsR2wn7JLEWBZmdmXtSbEq7Qlh1ev1Q
         TnpFhD62PJ8WUaIQwFY3fChnAwkPc04DdwEytW7xxsc2Dw/A7Hms5pATdBWh1CUDyPKL
         9GRbfStmUb3ajU1l+i3jp+q8Szf4Oyx1ISsj75OVDnhR3fpZ4gH8z0EtlujSBr888IVR
         iABrhbV58pzhYbIIc3lZ/tVl38ScOhyTNPIaJFMiJTre1RMizceL5CgjGfjVC3Upgfin
         DaQP3bWlmUQj3xXTx5786flIiFFVRcE52X6SCW0CFGatbUyV7VCHJWzxIrbuiwq3L5kO
         RVHg==
X-Gm-Message-State: AOAM533DhQxh8l7tBw8GT9oyPmYba1BXmfAPIeXmx7CdPPS2QtjxlyXm
        VSZkpWPBV8bSgq5VEv2IIlz/OgVpYOuwHISX0g==
X-Google-Smtp-Source: ABdhPJyHZxfyrH6eLpocM017hIpzAqnbrDsn4QA+ZJuqOtZZeAOQQ5gqFAXj+xLsHy4p8JwjyIombNa5Rhgjz7XYbw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b03:1d88:1cf2:4973])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d393:: with SMTP id
 e141mr327060ybf.244.1635532449020; Fri, 29 Oct 2021 11:34:09 -0700 (PDT)
Date:   Fri, 29 Oct 2021 11:33:28 -0700
In-Reply-To: <20211029183339.3216491-1-kaleshsingh@google.com>
Message-Id: <20211029183339.3216491-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211029183339.3216491-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH 2/4] tracing/histogram: Update division by 0 documentation
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the divisor is a constant and zero, the undeifned case can be
detected and an error returned instead of -1.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 Documentation/trace/histogram.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 66ec972dfb78..859fd1b76c63 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1766,7 +1766,8 @@ using the same key and variable from yet another event::
 Expressions support the use of addition, subtraction, multiplication and
 division operators (+-\*/).
 
-Note that division by zero always returns -1.
+Note if division by zero cannot be detected at parse time (i.e. the
+divisor is not a constant), the result will be -1.
 
 Numeric constants can also be used directly in an expression::
 
-- 
2.33.1.1089.g2158813163f-goog

