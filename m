Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD05141FE33
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 23:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhJBVLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhJBVLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:11:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84650C061714;
        Sat,  2 Oct 2021 14:09:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e15so53525382lfr.10;
        Sat, 02 Oct 2021 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rAJVE/w9KiqvhdEv8mKiokL9ibOtM5WhQZbELUyv8Ro=;
        b=eilICxT7smJb4oeQnL34hqhFjcm6Rzh4TdyfiF2dlbALoKqgTp5eYEIBs24yTQTGS8
         acPBMhXOASdMy4IHXmLtvzCOPkMWkNPg8JigXMLFCT1kPvubg+t3L6j1wLxW2JKPDgOE
         QAc5KPxzrqjfU9PzyseA9N/EU8TaOgyqNPFmKbQ8pKJwjADfgo55OyTH9seg7U0dv61d
         0iV3o9p/rCqKv6vg7UvJnqL38wafM+Wjtm8L3bP2tA/Dd31WCdFm/cQYYfxaTzmptwQI
         rrzyQHpBPT8e6iPV7lHB3S7zVBoRDlwpEm/DawsOEpSFjGXfmWO9UptpsDq8TEkeWxAm
         dBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAJVE/w9KiqvhdEv8mKiokL9ibOtM5WhQZbELUyv8Ro=;
        b=OYDgBHB+jmMX5HufLft4v9JkNFRUCAzBpH9VwqzBhoAmKL8ftELBYOuDVfE8neRK3y
         L7d0THZecBkV4YHl4HrUDfzntrjq+dj0t0D0f6tsdplY456YqGkfM9DCcgumYuGKhqky
         XSuGgRCETFh0+ifkYDWQAWS0vlsic00zN5HLE0/CT7igqK6vsCmW5aNPXxsFASljJ0Sd
         0xZyDQ+ceLMtFL40K5QTIEASNONxqtXQFM07uXp57liBo/EC8t9fye2n5z97Kd+JejqZ
         7Hmp98DpXifmA9S9vNmS4b2SqPX+e9OxBZd6eUbuBoek2I5bydHa8Nce+bNDDdVTWTob
         aJxw==
X-Gm-Message-State: AOAM532p/lwAuT/ajZaCCiHsP2UD3S5sPy05XVcfLP8mBAPM0vXy+1Ja
        8dkMhdUaxzv67J8+vOxucMU=
X-Google-Smtp-Source: ABdhPJzqbURaaRJf7Rz6Jq4aQa1y3j56URwUGwvcvBEnQTXu1O5+Pq9wZzt6xu3CgcbTjzUZv4poWg==
X-Received: by 2002:a05:6512:3196:: with SMTP id i22mr5321350lfe.416.1633208990899;
        Sat, 02 Oct 2021 14:09:50 -0700 (PDT)
Received: from localhost.localdomain (105-28-94-178.pool.ukrtel.net. [178.94.28.105])
        by smtp.gmail.com with ESMTPSA id l9sm279511lje.32.2021.10.02.14.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:09:50 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (nct6775) Add additional ASUS motherboards.
Date:   Sun,  3 Oct 2021 00:08:54 +0300
Message-Id: <20211002210857.709956-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211002210857.709956-1-pauk.denis@gmail.com>
References: <20211002210857.709956-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support:
* PRIME B360-PLUS
* PRIME X570-PRO
* ROG CROSSHAIR VIII FORMULA
* ROG STRIX B550-I GAMING
* ROG STRIX X570-F GAMING
* ROG STRIX Z390-E GAMING
* TUF GAMING B550-PRO
* TUF GAMING Z490-PLUS
* TUF GAMING Z490-PLUS (WI-FI)

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: matt-testalltheway <sefoci9222@rerunway.com>
Tested-by: Kamil Dudka <kdudka@redhat.com>
Tested-by: Robert Swiecki <robert@swiecki.net>
Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>
Tested-by: Igor <igor@svelig.com>
Tested-by: Tor Vic <torvic9@mailbox.org>
Tested-by: Poezevara <nephartyz@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index aa58ead0ad43..8eaf86ea2433 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4986,20 +4986,29 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
+	"PRIME B360-PLUS",
 	"PRIME B460-PLUS",
+	"PRIME X570-PRO",
 	"ROG CROSSHAIR VIII DARK HERO",
+	"ROG CROSSHAIR VIII FORMULA",
 	"ROG CROSSHAIR VIII HERO",
 	"ROG CROSSHAIR VIII IMPACT",
 	"ROG STRIX B550-E GAMING",
 	"ROG STRIX B550-F GAMING",
 	"ROG STRIX B550-F GAMING (WI-FI)",
+	"ROG STRIX B550-I GAMING",
+	"ROG STRIX X570-F GAMING",
+	"ROG STRIX Z390-E GAMING",
 	"ROG STRIX Z490-I GAMING",
 	"TUF GAMING B550M-PLUS",
 	"TUF GAMING B550M-PLUS (WI-FI)",
 	"TUF GAMING B550-PLUS",
+	"TUF GAMING B550-PRO",
 	"TUF GAMING X570-PLUS",
 	"TUF GAMING X570-PLUS (WI-FI)",
 	"TUF GAMING X570-PRO (WI-FI)",
+	"TUF GAMING Z490-PLUS",
+	"TUF GAMING Z490-PLUS (WI-FI)",
 };
 
 static int __init sensors_nct6775_init(void)
-- 
2.33.0

