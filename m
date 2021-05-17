Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705F0386CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbhEQW1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhEQW1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:27:30 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB8C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:26:13 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id s10-20020a05620a030ab02902e061a1661fso5769790qkm.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=puap4zYglf6RuvLQbjq0WWUfB5Aff47YdCO+nGa3JIw=;
        b=GF8VhTJw5Qj9m7VAbMjTvlsOc24zyImWxcOQA8L63oxL427Dgz8JigvnwHZrHohxWH
         MjR38Mq6/uYfiDNXDob6u0XCkx8MeMQ/LcbKlIeuWQGOaoBLmPAA89+o36nsHalPpY4n
         O6JCQj3W00JDWEDFdQpJhOkjrDhfffyd7OWA+5GRgx8vCm9MAQeku56Tp26D/XvFFo8a
         bDaEHp+Vc6pC9Hko/BLsQsG1vsqBtv5L8tTjjBWbUi079X5IfpXLZ/nHXKjV9iQrRmov
         OtJmAAyKs0cN882FrpnZMKal8cJge/6lboJtQoBpc/QhvmO8lCLGBviy6QDfREKFOpLg
         +gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=puap4zYglf6RuvLQbjq0WWUfB5Aff47YdCO+nGa3JIw=;
        b=CcrZUU+rWOKWCmW4/SNDnD/IxaCeyL/01nu0TdCpqXqhLaqmfYDcSVJTtLeBncjAeo
         3gn61ZvyyUCxIuu1bs3v/l0mlvGa5wDjv04CfYXQrFctgsfGIchyyDEOi0iJ9y3vlS2S
         s4d3xahgSyND5x9LR1mRQqvxLiBXc5xtO9rYqYS2ZM1xTKB1haY2IIc+js/Rv4Tvazn8
         YFXNkC1Z6nbYq+j2YreFscF/m4nW7KnU7dKuy+u8zLJJC0kpR3DrCByUC89SpaR3jM8l
         h4vDg91CzdMXXQlOcxN5fpirq53MZ6W2ITzdnr7EIQbaR2XzejRV0KUw6LHiinkWpEB9
         SmWg==
X-Gm-Message-State: AOAM533PGbdBCokfEsFryi6twNdwmFJA2QSL8k5tKOEY8zw7LXM611zR
        N57Tjf10PaDXXAa6+rZ5Gh3ik8GlK4CkaomB
X-Google-Smtp-Source: ABdhPJx9xi4RbdgNH+aq3V96cm7uGAwCHl1zUGXVB8O8ob7VsIb4096IRfQQ4zQ8CdSPL4qdhjdJlbkgoqqbie49
X-Received: from chu-dev-docker.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:80f])
 (user=linchuyuan job=sendgmr) by 2002:a05:6214:a91:: with SMTP id
 ev17mr2180876qvb.9.1621290372073; Mon, 17 May 2021 15:26:12 -0700 (PDT)
Date:   Mon, 17 May 2021 22:26:06 +0000
Message-Id: <20210517222606.3457594-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] hwmon:q54sj108a2: the PMBUS_MFR_ID is actually 6 chars
 instead of 5
From:   Chu Lin <linchuyuan@google.com>
To:     linchuyuan@gmail.com, jasonling@google.com, zhongqil@google.com,
        linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chu Lin <linchuyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMBUS_MFR_ID block is actually 6 chars for q54sj108a2.
/sys/bus/i2c/drivers/q54sj108a2_test# iotools smbus_read8 $BUS $ADDR 0x99
0x06

Tested: Devices are able to bind to the q54sj108a2 driver successfully.

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 drivers/hwmon/pmbus/q54sj108a2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
index aec512766c31..0976268b2670 100644
--- a/drivers/hwmon/pmbus/q54sj108a2.c
+++ b/drivers/hwmon/pmbus/q54sj108a2.c
@@ -299,7 +299,7 @@ static int q54sj108a2_probe(struct i2c_client *client)
 		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
 		return ret;
 	}
-	if (ret != 5 || strncmp(buf, "DELTA", 5)) {
+	if (ret != 6 || strncmp(buf, "DELTA", 5)) {
 		buf[ret] = '\0';
 		dev_err(dev, "Unsupported Manufacturer ID '%s'\n", buf);
 		return -ENODEV;
-- 
2.31.1.751.gd2f1c929bd-goog

