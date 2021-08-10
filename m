Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624A93E86BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhHJXvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbhHJXvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:51:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD54C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r6so384692wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fpBdLM1jjgCWmFdFG4PeoevZT0phpfn4uYGIZYMaDtU=;
        b=dPId21aa+NzITqtT02ztCNHXgTunSTuesgek5y7mZ+4QohkF0XVlrJhj2R7jU6GXUu
         7CrMI181xRQCtVr62rTkM/HIOxPR3Qas80FUYhxKP/8ulnOXYN1rr61qp5uJoiy6LLDb
         THUGOhRBPKafrNDJV1Zmz7Le3RaBSOhuvWxwmEnzdQ47LZ/jFlfenW/z5FrH5oRpj3mN
         eCdxX4aBLj5H1GXYgRKTXhUYdOZbhjy/dL//DY9zrufxRmOqBayjNu5ZFwSL+QH9PkhZ
         ZE1tqEYJS6CbG+pXhqw9FVw8beMuU1amW5GbYFI+3Z7Nw/EeWVCIGXC40uoaEODeoQrz
         38fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fpBdLM1jjgCWmFdFG4PeoevZT0phpfn4uYGIZYMaDtU=;
        b=WteMsv0jwWMm7PlOVhPXtQ+V7nNfsvhH9zEUYp63APPhh3b9T4nZz7RPNqz8EaHGVr
         SFKurwHeY50K4+xHBxRafa5hMO1QOCyq3F2v3p8mg24EQcaZnfhg9zkqGRYGKoHKAOzH
         36degFccQmwfCmrpuPh93rwgcAUSmuPAXYrG7uJAdcMLmODbFM0XDC1BGd+KjJv7SNdc
         6Mf4DEXkZJRM/MUaSWtebGvFzEjdd6Nc+VkocHLL7D2YNZO9KriadIWdD776dVYkiD/i
         scyezn5QtSGt3Ib4hxNBWtsmu7gY8bDtzyECCXkIss5phjyTN+VzwIaQrxiglfKG85sn
         2rmQ==
X-Gm-Message-State: AOAM530PcYng7fSkqMZyC3S2P4H3o7QTT/CO8gKCnD09DBRfBxMCPpAb
        HZMlcoeQTVyKKOVu3GUSkssN6A==
X-Google-Smtp-Source: ABdhPJywP3kWWA2u+Px59SXSCD+LDZZ3cpzqiUoMoRG8kBZNiQXcJezLI2mVkzTsmGKTrVqd8N30Hg==
X-Received: by 2002:adf:f4cf:: with SMTP id h15mr15572164wrp.67.1628639455231;
        Tue, 10 Aug 2021 16:50:55 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id p14sm13881220wro.3.2021.08.10.16.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:50:54 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: r8188eu: remove lines from Makefile that silence build warnings
Date:   Wed, 11 Aug 2021 00:50:47 +0100
Message-Id: <20210810235047.177883-9-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810235047.177883-1-phil@philpotter.co.uk>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the several lines from the Makefile that append EXTRA_CFLAGS options
to silence build warnings about unused variables, unused functions and such
like. This will enable cleanup of missed warnings, and easier spotting
of future such problems.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index 152d6325b4d9..7f6658f931d1 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -2,15 +2,6 @@ SHELL := /bin/bash
 EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
 EXTRA_CFLAGS += -O1
 
-EXTRA_CFLAGS += -Wno-unused-variable
-EXTRA_CFLAGS += -Wno-unused-value
-EXTRA_CFLAGS += -Wno-unused-label
-EXTRA_CFLAGS += -Wno-unused-parameter
-EXTRA_CFLAGS += -Wno-unused-function
-EXTRA_CFLAGS += -Wno-unused
-
-EXTRA_CFLAGS += -Wno-uninitialized
-
 ccflags-y += -D__CHECK_ENDIAN__
 
 CONFIG_R8188EU = m
-- 
2.31.1

