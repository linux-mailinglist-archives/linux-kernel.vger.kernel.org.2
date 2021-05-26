Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DEC391E24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhEZRbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhEZRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:30:58 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72652C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 10:29:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f22so1519860pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nftD8Ovn49TMt2VJgq8EIyq7dzikLLs6FMzeX6li7D8=;
        b=VEXXKYydQ3YbaIKTVTGtXwiu4Dmw56ffQvv3qQ49w/K65BOT/YfnJ7v/0SoV8Im9Hc
         2797jqlLW7VwScUMQ3Qxj0AtWygZ3XU70iHewx6Vad6ao+Yqn7DC4GdBkyZ151kvELww
         Ch6dHGjA59ki6nhZNX3Ids477h7FzI3g0bT+tYdRTsXSR+tB540Iad1V03fTudGkGal7
         TfKQpHtmyJAWiH2LZh3sYVEMCtt2jjSTZdu+AKK8DgqdPYVSdaalv0LghG9knzVOMQQh
         Gd63Uq/QaBasvX3mKkHh37wb6IYmF5QFUrXD5t/IisvOEzpb8hTqRMb/HEBkSMM8VNXF
         Oe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nftD8Ovn49TMt2VJgq8EIyq7dzikLLs6FMzeX6li7D8=;
        b=B8O72J8jPvkcWZkiqXq1FvYEdJ9H/mooj0FtqcWIucfP7mJ+iOqaL/GqLev9MmHCfb
         dAId9xfAEm6rJg30QWdioUWR/D4mShVi66ieSSDvYPQhf+5agvCaArqAVlU4MXpqQ5q+
         ceLmkTN2zy5TsKfyHx9q1MxvZjxPqTP3pbJ5OLKCcl23ChBewdl/7HZ7cdUBYHOYFWX4
         1HHmf1DXKu0JBaYkNChBQjBn2TKtC2YwJ8xygOFNhZ4CwnNxe3gS4ueOSzuUyegBZ33J
         zJbTH4ixZU8BynWBvVvvdVZKgcEdhigYRy49gklo7siET0kiah/Z6GCq+EI17Ji1nnfl
         CMdw==
X-Gm-Message-State: AOAM532bPzTsQs59eaY7yKWi+zlrOcL3FzCE3GGAA/yPEktXGxKvlqmb
        Phsbvqpr8+0R4ioY+/dHEik=
X-Google-Smtp-Source: ABdhPJx6V7sAr9IXgDsXzlHtizpo+MyWdxbrD4Nr8RkJU9Z/CUM1/6dvMgtn3yU0h+wuOE3N2LlHiQ==
X-Received: by 2002:a63:6c9:: with SMTP id 192mr26453695pgg.39.1622050163749;
        Wed, 26 May 2021 10:29:23 -0700 (PDT)
Received: from localhost.localdomain ([106.77.36.0])
        by smtp.gmail.com with ESMTPSA id h9sm15230876pja.42.2021.05.26.10.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 10:29:23 -0700 (PDT)
From:   Piyush Thange <pthange19@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        john.oldman@polehill.co.uk
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Piyush Thange <pthange19@gmail.com>
Subject: [PATCH] staging: rtl8192u: Fixed warnings of coding style
Date:   Wed, 26 May 2021 22:59:00 +0530
Message-Id: <20210526172900.56093-1-pthange19@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style issues with comments.

Signed-off-by: Piyush Thange <pthange19@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index bac402b40121..725bf5ca9e34 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2876,7 +2876,8 @@ void dm_check_fsync(struct net_device *dev)
  *	When		Who		Remark
  *	05/29/2008	amy		Create Version 0 porting from windows code.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 void dm_shadow_init(struct net_device *dev)
 {
 	u8	page;
@@ -2915,7 +2916,8 @@ void dm_shadow_init(struct net_device *dev)
  *	When		Who		Remark
  *	03/06/2008	Jacken	Create Version 0.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_init_dynamic_txpower(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-- 
2.25.1

