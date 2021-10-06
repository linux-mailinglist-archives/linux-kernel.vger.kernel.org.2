Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0F424993
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbhJFW1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbhJFW1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:27:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EDBC061746;
        Wed,  6 Oct 2021 15:25:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j5so16463195lfg.8;
        Wed, 06 Oct 2021 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBXjESvX3msnbrxpLOVSaYYf+iWkmJSYFpNtwPzeZjM=;
        b=VoZBP82Olrl6tu9R2m7YT7mfhPftEG6R7z+i3WAN2Cj0lgzmfEkSyRnp8CaLOqeNuj
         hMMbcIDrx2OkKP4bn5HB2b4u+wnT66o+ZLDmJnKdqLhy/EETLv2+srSS6YNrnFzFkGQa
         8TyPDum3Z1yX6X1QaZgsT2gfvBeMfjuB5B8kQw2+2KTLk2qP9JLLT6TEhjVVPaD8GF5d
         5CrNmrVc3yClkvfL3K8VlQkgOOulrgRtMUd1ywoHGqn/LdOxfAkJ9q3WfIEnigWEeadE
         JO3jbEMAs7Rv3Sqc3lODKuns3+bss053hn5Ff20Ngp14sLSUSgBhwU1kRFNR5c+wwi9r
         yJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBXjESvX3msnbrxpLOVSaYYf+iWkmJSYFpNtwPzeZjM=;
        b=YovWOwQIikJKQ2xkXRcF7JwFdFDA7NlEunMR+0KSYs9Xl7kCedTfqvS/ZwX8mgg1VD
         0GGPg4wZzSJvuyYl4JCo5katHMxeYEnbejyAYdGokbvLQPXqe6/fEqN8RS9gxYoiya5e
         98hN4Ch6dC4juhH2Gs75UNHdkT+s7cNix5+NbftIW4Bgdy6Doep6mdHn2ol2Ad0LVcOA
         A27vBFrB04XK1nyAj00bf1jz4Doilm5x0Q3/IxakNGWVnDIjeqYksODgf53j8m23/tgi
         bUzUTfbWCfNPwGpdKVWmMUWmg+CVrz9a/eB9MQx1DbVLdFlkq9tUM5ma4JNZd8aPN6H4
         3CbA==
X-Gm-Message-State: AOAM5323DZ82P3/PDLMM82Pe7HqRUxUDqeftRWxIrDYmquxkyfQdTx5N
        Rcssre+NOQ24EBBeMb1aRYI=
X-Google-Smtp-Source: ABdhPJy6r4SoGf40HdOiNr8SwZcVzhOwbA8dkuIkjvt0BG2Fl8JOHfd9g6BLl1iRSlpCkzUZ/mB5WQ==
X-Received: by 2002:ac2:424e:: with SMTP id m14mr599738lfl.86.1633559122148;
        Wed, 06 Oct 2021 15:25:22 -0700 (PDT)
Received: from localhost.localdomain (206-20-179-94.pool.ukrtel.net. [94.179.20.206])
        by smtp.gmail.com with ESMTPSA id c2sm1364457lfi.277.2021.10.06.15.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:25:21 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 1/3] hwmon: (nct6775) Add additional ASUS motherboards
Date:   Thu,  7 Oct 2021 01:24:59 +0300
Message-Id: <20211006222502.645003-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006222502.645003-1-pauk.denis@gmail.com>
References: <20211006222502.645003-1-pauk.denis@gmail.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v2:
  - Without changes.
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

