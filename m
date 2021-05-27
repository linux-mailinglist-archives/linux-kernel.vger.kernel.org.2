Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9D3929D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhE0IsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbhE0IsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:48:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DBC061574;
        Thu, 27 May 2021 01:46:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 22so28510pfv.11;
        Thu, 27 May 2021 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G6YOkfmoYTQzY6BFJvCrKbTuX6EkhVXWhoTaGEyzrqg=;
        b=M8v6UDP7SkzMjXeIDuAOKB3SHRLOascPDy/s4mNYBn40bhixb8oZanP7aZuXWlMs9O
         +WwQ/HmeYLFwosCJvq3bYf+0xBil+CDgq3WuRCtZBBKCndH04TKmDfOVA+SUp3BwBv4C
         ZyYcuplcAPqbM2R5MaErMEpV/Os08LuxcTioK7k/JFI/1WStoEIjeorSnmAlZuFWlPVQ
         yO5qhREBmHRoQW4uPRj3S4JG9nt3NHF+K9FTDhyV806Aqf5Vryl+wvBcpfefAft9zI+D
         kpW0K9cG8+3aYMx4LTxAK3SXNCy4F3AmisgkDHfUQAKguq79QjS2d5QMVxScBM5wg27W
         yV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G6YOkfmoYTQzY6BFJvCrKbTuX6EkhVXWhoTaGEyzrqg=;
        b=l5QFDV04H8GVCAHSO9ZDC+PZKBHLCrI7MuhN/deoPcRjei2JbBU9652eLTEfB7zGng
         X6YU8yaf03OsIlhgqyvTiVngn9grq4hXqjQxVZoUhZaCvWsWemmMssNJG6lZNsBrRwmH
         zXIARrybu8kKrOeOEV2rh3+5FdJiuG4n753Bb8hBsIaIfqR8tcTHEqrlJN68to3hoABi
         1iXO1wry3WL91oJXhTIpciBPTn91J/s/8XZNkprCfBjc49A8H+L7afeVoheK9AzaKwWs
         NBylpDLSlwAzhfA8pl7mLPQQ62qbKSASiqMbg2c/jGVeCC27RMA7ucoO+Csa0GYP4nML
         FKww==
X-Gm-Message-State: AOAM532qro6s+/llHR407Pe4RnZGmBpq972GVbh6thWDjzG44+cadsXK
        Kp2CLlpAv4v2r4Drl4KJJ50=
X-Google-Smtp-Source: ABdhPJyutrX/JWhRjoZHJ97VrezGjFx49PxUNCF3PZZb/f0O8dHmXbDhA5PKkjkH7j4SBxaZKeSG2Q==
X-Received: by 2002:a63:ee53:: with SMTP id n19mr2727304pgk.268.1622105191763;
        Thu, 27 May 2021 01:46:31 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-5c02-729b-db77-9bf2-2339-2201.dynamic-ip6.hinet.net. [2001:b011:5c02:729b:db77:9bf2:2339:2201])
        by smtp.googlemail.com with ESMTPSA id v12sm1278502pgi.44.2021.05.27.01.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:46:30 -0700 (PDT)
From:   Crag Wang <crag0715@gmail.com>
X-Google-Original-From: Crag Wang <crag.wang@dell.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     mario.limonciello@outlook.com, crag.wang@dell.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] thunderbolt: add self-authenticate support for new dock
Date:   Thu, 27 May 2021 16:45:03 +0800
Message-Id: <20210527084504.7310-1-crag.wang@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <crag.wang@dell.com>
References: <crag.wang@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new device known to support self-authenticate on disconnect.

Signed-off-by: Crag Wang <crag.wang@dell.com>
---
 drivers/thunderbolt/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index 57e2978a3c21..892cf0e8ada5 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -21,6 +21,7 @@ struct tb_quirk {
 static const struct tb_quirk tb_quirks[] = {
 	/* Dell WD19TB supports self-authentication on unplug */
 	{ 0x00d4, 0xb070, quirk_force_power_link },
+	{ 0x00d4, 0xb071, quirk_force_power_link },
 };
 
 /**
-- 
2.25.1

