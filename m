Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CA432AE15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360507AbhCBWV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383597AbhCBVQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:16:28 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D1C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:11:46 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id k68so14327825qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2Mto1DCOxlLzDfjtf+5qxXYDPOWq6BI6lEfSm4q36Mg=;
        b=BgrR/JyWnWZom3nQVD3sD8sQb30jz/EPZEoMRT530G/gEBFzea8CpgKsLFmoDI8DMR
         fZTZjDjq218dl+yec+0zPBB0+g9NzYV+4taJdVtA0aHlmHHAYkGou6/Cv94CdSXnd+l2
         l2D7pKf2ds1GxjXK1Ud5Lng1DHbLZDVlEC9xhe6Zg0xifLBn2XWQ7A5DETVWNcqc18rg
         7lZCNP8hFAd7tKGP16dEqQPrdi18m+lB0y9HHFU3VVPNfQIpFF5H52NWkad8tWNi/VtA
         kWbHj7gu+i4LkxgC5iED/RL7LqVTvSFGFBpp4hghOLdL8RgYbYy86CzlrCutn/mSoTPS
         mHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Mto1DCOxlLzDfjtf+5qxXYDPOWq6BI6lEfSm4q36Mg=;
        b=t8TqV0e6BMvUntlhv2abjY1hmj2EyMe3w9x93I0krR4bQN7mkuaDD7XjGRf31LT8il
         3P8ULbpr+atYDH9ib8fr+KfnjgSVfYKteZuD5S4FaqnPoi2U7owdOOPiwLnS8+wttue5
         1Oyw1hLYSmxzvAzV2lDMkjrftJinQeZjrP59S6N95qnydnOo33s35N0g+iiV0o6ND5qC
         zWePOf2w5Y1ZoduJCSYD4T9frVUE22DTsnFgrcYvO8pST1Lt2mFrQYg+mjgIFkH+RHLq
         UjTaYW04pPx/ZyH+kO4vcZTCwvw3vVVhcsIJew02muRXK/OBLc05a9jGXIn2bljUAv7X
         iRwg==
X-Gm-Message-State: AOAM530eZIHhQkty6iBj5bdMOkHW/qjCy27OgF02LlIV/mXyj1wWkvxV
        zzxgsxsR38c92Q8XYClkG9nfc+X7GYyMkD0=
X-Google-Smtp-Source: ABdhPJxKZs+nC8iQ+F7QUYDAfQZIEYEWJ+TjIi+Q9Kq0yfqXcooPjSo2y72D6ySnIjE8v/M3Ma4LcX5lGMJtLXo=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:a1ad:fce1:8a40:59b6])
 (user=saravanak job=sendgmr) by 2002:a0c:f946:: with SMTP id
 i6mr5480376qvo.40.1614719506149; Tue, 02 Mar 2021 13:11:46 -0800 (PST)
Date:   Tue,  2 Mar 2021 13:11:32 -0800
In-Reply-To: <20210302211133.2244281-1-saravanak@google.com>
Message-Id: <20210302211133.2244281-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by default""
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.

Since all reported issues due to fw_devlink=on should be addressed by
this series, revert the revert. fw_devlink=on Take II.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 45c75cc96fdc..de518178ac36 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1538,7 +1538,7 @@ static void device_links_purge(struct device *dev)
 #define FW_DEVLINK_FLAGS_RPM		(FW_DEVLINK_FLAGS_ON | \
 					 DL_FLAG_PM_RUNTIME)
 
-static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
+static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_ON;
 static int __init fw_devlink_setup(char *arg)
 {
 	if (!arg)
-- 
2.30.1.766.gb4fecdf3b7-goog

