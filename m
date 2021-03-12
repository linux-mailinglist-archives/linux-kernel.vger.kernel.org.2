Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A809338A25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhCLKa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhCLKac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:30:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:30:31 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id c10so52298769ejx.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aqm9GcxomxlWPkmow5zbumRNqEy5q1/hxuLaX5HxNKU=;
        b=gTpEa4YpBIXY+SjxxBnQCniFgFa5ZGRctoOHiFNZuRxFdqSjdbXf/G7CgfcUVr06CI
         DcxdVHslQhdTObFgofDNZkhDMkFXnSJ+s48WHuv8ZLibSLXGWTqGhsGSx/EU96JHg480
         1ujMc8dCbVTbeJwG+/7mQBroYL1FYDfdJokJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aqm9GcxomxlWPkmow5zbumRNqEy5q1/hxuLaX5HxNKU=;
        b=GH6aEvWOVswlLTPj1jea8qJ/Ssa2QLUMmFIZVjUrgcXiyyswwMfgp5xuqVEjqImfEr
         4ID1Y5IwOcdnk3x580jfX3SyPYDgxDJ69pmbq4IzWsN7QOGubG+gCfhagvWOb5j6u/4U
         jYDn+T0nu0j2d7OpcGxZAgDt7dDItWEuwRP8zlHcNwuc9sLilplFygj8o1AwuURCl8N6
         TS7h3E7fgojDZXrGV5cONCiCnP+2x7q2HEtTbU/o4kLRJpBaGn/vFsuy45xUMTTsMNii
         AJLy50TqFhDaraVEYmP8Y593gXIxaG7y/k9mIwbO2su5T4BK1CGd6nrIqQEdi+awLmsQ
         suQw==
X-Gm-Message-State: AOAM531kR+nWLwdwS+HaSASDmFrpqt5JTN4gOUUdUFKTpfNmtyE4UP+B
        ConVfl+oL6bknhRfpAQuvjQbbvtWq8u4Gw==
X-Google-Smtp-Source: ABdhPJypXvlDaP8gulBmc5GCHbSIOqhHfaHztjn0HLxKbAmBDjdA00aiwnFd8xTVks6RLTaca6/aDA==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr7793798ejz.318.1615545030405;
        Fri, 12 Mar 2021 02:30:30 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id r13sm2735729edy.3.2021.03.12.02.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:30:30 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] devtmpfs: fix placement of complete() call
Date:   Fri, 12 Mar 2021 11:30:26 +0100
Message-Id: <20210312103027.2701413-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling complete() from within the __init function is wrong -
theoretically, the init process could proceed all the way to freeing
the init mem before the devtmpfsd thread gets to execute the return
instruction in devtmpfs_setup().

In practice, it seems to be harmless as gcc inlines devtmpfs_setup()
into devtmpfsd(). So the calls of the __init functions init_chdir()
etc. actually happen from devtmpfs_setup(), but the __ref on that one
silences modpost (it's all right, because those calls happen before
the complete()). But it does make the __init annotation of the setup
function moot, which we'll fix in a subsequent patch.

Fixes: bcbacc4909f1 ("devtmpfs: refactor devtmpfsd()")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/devtmpfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 653c8c6ac7a7..aedeb2dc1a18 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -419,7 +419,6 @@ static int __init devtmpfs_setup(void *p)
 	init_chroot(".");
 out:
 	*(int *)p = err;
-	complete(&setup_done);
 	return err;
 }
 
@@ -432,6 +431,7 @@ static int __ref devtmpfsd(void *p)
 {
 	int err = devtmpfs_setup(p);
 
+	complete(&setup_done);
 	if (err)
 		return err;
 	devtmpfs_work_loop();
-- 
2.29.2

