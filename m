Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3DD449CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 21:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbhKHUSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 15:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbhKHUSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 15:18:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8598DC061570;
        Mon,  8 Nov 2021 12:15:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r8so28920058wra.7;
        Mon, 08 Nov 2021 12:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbnUVXNpx41MFEBmV6cmVlmllMJldtnH48jc2+xBXes=;
        b=gu8uqR5kM4ZMhT8ubH93GveON9D48ARdPRc5sffXMVd2zTMimxD9qvJK0Ag/9AS7UG
         Ykt4ACReQnq/tQVUeMHOwjOiG0crPCEUcznhsMNubv92XMkSvv0pGEvtWyNCjGESwvsf
         aW/NqqhzRqk+oUBMANFVLDew5pF+BLn5W8JoKg4CHOt4ltm4p/5WIbWqWOxj0zUGL38p
         j717YEgMo73KtPteZZj6HA+AGnkejKInE78p6LTt8MZPgJq6Zve6UpBipPgsoZZHl6+N
         n99epMwrNhXpBXIZ3PqVQw2mgW8LwGjdvSofyFyi25I2uDkSwYf0SdW4o6MMhQtXdDCc
         qeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbnUVXNpx41MFEBmV6cmVlmllMJldtnH48jc2+xBXes=;
        b=f2YtnMNEDJVSgFoghjarY2LVxipqS44aiBaLCViLZjs1Ek6cKw+F+PjKx+WiuraEWF
         OovCyYjHsu6VHHslsY2n/w+xDinebaO58he8dwadsO83tVE3/FvRE459WWAoPHaX3VzF
         XIw77rtYdydAw/PsSRn/pqmMl8OElvLg02IP6WMtUijC6T23wYBIViCrSq4KK64zZPHT
         O7mAnr2HlG6NXf3/8qjyyCM8xRmW2ctayUDSzdkxZTlKRJFJNQMX+5gRlNVaTGnL3GXO
         J/31v1cMh5VyDBUAhSbdrDqOmJhv7TssQQNPFp9jTzLrxrw79rocb5rReq0YJFHh9/jl
         obTQ==
X-Gm-Message-State: AOAM5319yBwB8t68FrWq+iNOOvoTAwDuXRTCiAwz/SA9vtzRNkvohGOB
        9o8tHNwcpJTBsg==
X-Google-Smtp-Source: ABdhPJxHqPvmfEKhmG6A2lrY3TlcbdATo8YSPh9vxlLHO5ZL1OaSFMI0x624HAfdOxVu+zRWtfoFIg==
X-Received: by 2002:a05:6000:15c8:: with SMTP id y8mr2248952wry.101.1636402515166;
        Mon, 08 Nov 2021 12:15:15 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l11sm17484447wrp.61.2021.11.08.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 12:15:14 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix spelling mistake "aritmethic" -> "arithmetic"
Date:   Mon,  8 Nov 2021 20:15:13 +0000
Message-Id: <20211108201513.42876-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in the tracing mini-HOWTO text. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f9139dc1262c..b8e8f1962189 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5623,7 +5623,7 @@ static const char readme_msg[] =
 	"\t        - a numeric literal: e.g. ms_per_sec=1000,\n"
 	"\t        - an arithmetic expression: e.g. time_secs=current_timestamp/1000\n"
 	"\n"
-	"\t    hist trigger aritmethic expressions support addition(+), subtraction(-),\n"
+	"\t    hist trigger arithmetic expressions support addition(+), subtraction(-),\n"
 	"\t    multiplication(*) and division(/) operators. An operand can be either a\n"
 	"\t    variable reference, field or numeric literal.\n"
 	"\n"
-- 
2.32.0

