Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BD31994A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhBLEqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhBLEqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:46:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B7C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:52 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so5069362pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OaDhEf2TURcQXwPJDjXVEJyRtzWJZ+THczH7U9wbEVY=;
        b=MNXLVK+jGxHDtQhZPbzkfOaFP5xdopRPiWpTL0QhjUWY6mATVpbn6wY26X8h4FK5nb
         TdibNZRCU1QBGahl/gBxYG5U2/C/NwqiXWIbWvVGD9w1WzvRGqyplE9j2Od08mOv9CpJ
         D8yATYqApFW2j5a+Oh5jkb3GZZHwkpJKixc9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OaDhEf2TURcQXwPJDjXVEJyRtzWJZ+THczH7U9wbEVY=;
        b=CZF7mF9p6+l61fZkJzvpaHMBOVJIVTY1lZBREfpaecjvEm4p43+9DnsKafjZEFUCME
         z8GqRLKvRTp76ySUT5ufx09VIqaV1vOgpUTzO+QDdvd16Fy72epmp8xwISnEFkaywPPi
         m1JevWT9TsDxnaK+iHmUdJ9Vmpkz/HN1cigRi4UYghJ3YdcLutCS3Gw49bdlEz03pEx9
         X1sSGN4RNYlrfQH6PAqtNOBBNVtzoCudkQWMw4gCzpL/S4dqI4NJbOKgIDxGz2XKD4NT
         V2LeyNr/XncAIEZqgwHZUMcrh6DOcdsSdo8XuEtNnJ070geoaYmmQPOd2uQkIKKevIgg
         fjkA==
X-Gm-Message-State: AOAM532ykvCiexp86iW+kWZv3g0QugI2ZR+Yd//PdcNzsRja/sUXApAj
        CC0srMCwtLWEQHp7KWi+Zyo3pg==
X-Google-Smtp-Source: ABdhPJzcQcQM3XahqYooklJl9Dd/fNA50pHlLwQp7Bsln4PHtBZJTG1npyXHTDcYLAlotzgesJWdCw==
X-Received: by 2002:a63:a312:: with SMTP id s18mr1428070pge.229.1613105092204;
        Thu, 11 Feb 2021 20:44:52 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:a453:d6cd:41b9:5925])
        by smtp.gmail.com with ESMTPSA id 25sm7298904pfh.199.2021.02.11.20.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 20:44:51 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] debugfs: Add FS_GENERATED_CONTENT to filesystem flags
Date:   Fri, 12 Feb 2021 12:44:03 +0800
Message-Id: <20210212124354.4.Ia131b68596a3404275e84d5ca697b79cbf40d93e@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210212044405.4120619-1-drinkcat@chromium.org>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs content is generated at runtime.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

 fs/debugfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index c35249497b9b..2bbc5e6d3041 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -279,6 +279,7 @@ static struct file_system_type debug_fs_type = {
 	.name =		"debugfs",
 	.mount =	debug_mount,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_GENERATED_CONTENT,
 };
 MODULE_ALIAS_FS("debugfs");
 
-- 
2.30.0.478.g8a0d178c01-goog

