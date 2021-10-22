Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6B437F07
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhJVUEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhJVUD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:03:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD61C061764;
        Fri, 22 Oct 2021 13:01:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l13so5764511edi.8;
        Fri, 22 Oct 2021 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mu61AlViEl4nprV1RFc9HeF92MSgcjebjezUglKcXLE=;
        b=igRBpbHQjqE0MJacRAAKe3ZtYLDTm1Bci9Yl2zEjgy5SVwCsxZmLPSCAS2hkDzZwvJ
         Lo3Lt04CDhy6xAG/wPXLX+9g125BJhtUmnVCAY+QUIoCJmMcuhPPotRlaWH7Pjj3Zb2o
         Yr7nw9NxJZj3HWEOuvxRwXQYcSZsjVYvQLyinNbA85/DSFkeIxDNwBn5BxDbmD69Rks6
         i0w+FBCH4dLmx1PFF07ocf1J78G7/fpsCoLUYaYI66jiiUJPWjOgoUm0Bigszqrnb5dB
         SyjX28iEmWB9B8WGPqGsifdFJl68eYMaG/pMVPam6nfEuDtFGbx7a1/pHWFMmkwHHU9Y
         l5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mu61AlViEl4nprV1RFc9HeF92MSgcjebjezUglKcXLE=;
        b=dwYDi5PWBDHPaEmj926HdLKRVFKSScvDXIhPZCnUDY/8ifyw3yhbrpNPffZhXszNv+
         BkmTc9lOH4NFYjIDJQQ/39QY6+aMoX7/hXJjE6mFHwJ6ZaJXA+5lwf1E+IgawyBCetID
         d0Tew+ptlvSPOK+wA8ZfP6Ie8cqTOV6QU/s8wE52645qKDWrfE1j0vpsuaopiHaQ3bSD
         iB754hAy1Y5ytK5ghtGUa+E90F3bnXH1609zG2oRNc0xzmIYoeHO6fgR1KrgEOUieixi
         ftgdR3KQhrzGWpEHbq51vrJNUx0lEgW5zuHqYXA4Bw1UkBRvWLWrVjo0J0SylGZ0/v0v
         wvrQ==
X-Gm-Message-State: AOAM53201iZTP+Od1sWRrPtP8elCs/bu6lJLjAToLycExtS2tA2bwAG0
        +o7b3/oI7m55UdnXMn1bfZA=
X-Google-Smtp-Source: ABdhPJwPKi5j3S+9ziUc9Q28T2q2MUovuQrVwljOyEWprpa3anxSskpNN36piCvqjoKyGrZBtoq9/w==
X-Received: by 2002:a05:6402:1d52:: with SMTP id dz18mr2714946edb.49.1634932897724;
        Fri, 22 Oct 2021 13:01:37 -0700 (PDT)
Received: from localhost.localdomain ([94.179.44.246])
        by smtp.gmail.com with ESMTPSA id d3sm4213475ejb.35.2021.10.22.13.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:01:37 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net,
        =?UTF-8?q?Joel=20Wir=C4=81mu=20Pauling?= <jwp@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/3] hwmon: (nct6775) Add ProArt X570-CREATOR WIFI support.
Date:   Fri, 22 Oct 2021 23:00:31 +0300
Message-Id: <20211022200032.23267-4-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022200032.23267-1-pauk.denis@gmail.com>
References: <20211022200032.23267-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on:
```
BIOS Information
    Vendor: American Megatrends Inc.
    Version: 0402
    Release Date: 08/04/2021
```

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Joel Wirāmu Pauling <jwp@redhat.com>

---
Changes in v8:
- Add ProArt X570 support.
---
 drivers/hwmon/nct6775.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index f345e1902ad9..93dca471972e 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4986,6 +4986,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
+	"ProArt X570-CREATOR WIFI",
 	"Pro WS X570-ACE",
 	"PRIME B360-PLUS",
 	"PRIME B460-PLUS",
-- 
2.33.0

