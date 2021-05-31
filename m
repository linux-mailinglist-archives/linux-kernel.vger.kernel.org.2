Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F9E39573A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEaImd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhEaIla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:41:30 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C835C06138E;
        Mon, 31 May 2021 01:39:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 6so7839910pgk.5;
        Mon, 31 May 2021 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NWTb3kdPmLr7sKD07yJCp0knjPnFCFA8bPac8FRxIIo=;
        b=ZgnzSik+GAg7uwOGtlvNMUrPxzaB7suopIvaKUcZ6OtnKGqbC/mMayE6Q66Qwsd56Y
         CknbOav50+lgWGdpB2qRMH/AiSEdmLmkjG3VsQ/ksyyTwu64bOWbhCLtChdejMPDwJib
         iYm4YuCSTPotyaGpntimckRB2oHkOQVxjLVSl8ICpxXY55O9It7wAsA6g8uOGnERixcF
         Hq/ZsIccx+k9V4I37yzrTAkmqktPA7F8wIP2b1QJ5qhIJ6pXQNuZPsxFyxQOaCXlsd6z
         Aq7rI9Ayd44z4aIpfVzqvY6RZERfIpqBnC/EEoJIvDYPso7GbDPs10tRKqhNKhbjhCi0
         X1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NWTb3kdPmLr7sKD07yJCp0knjPnFCFA8bPac8FRxIIo=;
        b=aZk8L9Xh7BEaDZKzmH9batdlHCUtO2Dei97XpvcouXCSQurpbG279MltF8cx4mPuvq
         7xODiQFJsn8iiOl0PaxBfr+njSGeY/AYIBbh1/a29PUdeBYGqBRTxkuazU2E1F8penT1
         Q8Qq5PJD2SkWpTA8UhvnjW980vqlt16F5VfZHrq3aHaREqml/Cuqx9GxB9yo0cJI+NNQ
         j2oEM4xRxeTR290KyGj1IVtIOX7EIj7JjbHVtxEJIx3C3Ndm8TK3V5a4XM2cMPvJFchS
         yr5AWJY8mWlDE8INiLM5LLFSbOarKDNIzDsK2KaYN7ovO2gVSNpDQCGGM3dyJMObvJue
         0TQw==
X-Gm-Message-State: AOAM53324tEUSk/t57FJFv3bRFV0c0nkW9nhyDmPku1V6JKDuKbpLRoM
        NlLyQnJcNd9wNy3VILjux+I=
X-Google-Smtp-Source: ABdhPJwdSU9/49M7sN2ICGJpw5f47aVDT+mFztS6yR4cHu4lBZyC86u7crKmIFwIDVs3RE/0GMrpLQ==
X-Received: by 2002:a63:d218:: with SMTP id a24mr21588081pgg.345.1622450361785;
        Mon, 31 May 2021 01:39:21 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id u12sm10183681pfm.2.2021.05.31.01.39.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 May 2021 01:39:20 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH] docs: Fix typos in Documentation/trace/ftrace.rst
Date:   Mon, 31 May 2021 16:39:05 +0800
Message-Id: <20210531083905.25763-1-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the usage of "a/the" and improve the readability.

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 Documentation/trace/ftrace.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 62c98e9..11cc1c2 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -354,8 +354,8 @@ of ftrace. Here is a list of some of the key files:
 	is being directly called by the function. If the count is greater
 	than 1 it most likely will be ftrace_ops_list_func().
 
-	If the callback of the function jumps to a trampoline that is
-	specific to a the callback and not the standard trampoline,
+	If the callback of a function jumps to a trampoline which is
+	specific to the callback and which is not the standard trampoline,
 	its address will be printed as well as the function that the
 	trampoline calls.
 
-- 
2.9.5

