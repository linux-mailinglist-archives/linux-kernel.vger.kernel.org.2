Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E31937AE03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhEKSJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhEKSJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:09:22 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03244C061346
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:16 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id ee9so378455qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJPCudzb/Ou4GJ6RU5NgC6ZAZYELLNF2PjvvnraTbLs=;
        b=jOnMJrqZdmWyP0o57NUCpDxilR4xUtkwq7WWOW6jkBIyJpKJXpzcdDSHVUram4Fw2l
         R1tS10lyDQmNrTXBf0Ef+so2J9GOUYMuLI7TtWn+gCC/YPr8pjlWw+vaZu230sWpy5sM
         okitfqjHivB2xFoRsRZKQ4C4eXRXsuPzskeu1+VIVfPfnLZ8xqv9Yl5tWbdYa8eYOwlA
         cYOYFubxxgTbc6oIGZb3j6344nwr0L+lLXRp0oS401XIKDCKk3c+/mY0gONhzVc+JZm7
         4vS7hNDGqDy2iXnR7RSUdSBsAkC3GyYIw5uGsgbMAh+4+zGTsJnqBXybMn/1eye0kzfs
         ZnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJPCudzb/Ou4GJ6RU5NgC6ZAZYELLNF2PjvvnraTbLs=;
        b=kYnzdOGIZcPCHLGRrxeQTqwZWTUgvP+NEesNAC3yi66icyUskSdA9evQpDXZp9+oNW
         LRxXJTNXH8MrXv5JG174/ZEVaZfdjNxUZTMMSuK2uxJP3XuxdGFLsDQ3WDo1COpx+mbQ
         LkAZY7B6mIUk6pBhcibRZndbkbii2P1/cYKYhOSQx447Ky6R9S1bl9I5jPHgNoTQQxEI
         nvWEl7DHovb1ffI6c4bfR7vhuAUub7Dq4DnRzBJt0HQI40mPmc3hQ8osb59xl6YYASrW
         Lf0fjNYGI47ysxSpDQnp/lJcwRJp6Wv0IC3h2sQaa3LQpgxGDHPBX3bBy+v1+mkI1Kjj
         oAHw==
X-Gm-Message-State: AOAM530jINCWRttAqdKu7uT3UX72i0VsbEoxZE8BcFjIIZYuknH0Cj21
        sJoeKwmXhozd7O/Gmks/KJTJ4Q==
X-Google-Smtp-Source: ABdhPJyt6UKeePHWiG6MVDsBLdK4vH8HRXo1wZJkRcNm+uOQADMV2j5NAOIHOn15+yCV/riECKHTYw==
X-Received: by 2002:a0c:8521:: with SMTP id n30mr30551676qva.53.1620756495291;
        Tue, 11 May 2021 11:08:15 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g5sm17104476qtm.2.2021.05.11.11.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:08:14 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:QUALCOMM CAMERA SUBSYSTEM DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 07/17] media: camss: csid-170: support more than one lite vfe
Date:   Tue, 11 May 2021 14:07:14 -0400
Message-Id: <20210511180728.23781-8-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210511180728.23781-1-jonathan@marek.ca>
References: <20210511180728.23781-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the IS_LITE condition so that it returns true for the second lite
vfe found on titan 480 hardware (8250), which will have id == 3.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/media/platform/qcom/camss/camss-csid-170.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-170.c b/drivers/media/platform/qcom/camss/camss-csid-170.c
index 3958bacd7b97..af134ded241d 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-170.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-170.c
@@ -21,7 +21,7 @@
  * interface support. As a result of that it has an
  * alternate register layout.
  */
-#define IS_LITE		(csid->id == 2 ? 1 : 0)
+#define IS_LITE		(csid->id >= 2 ? 1 : 0)
 
 #define CSID_HW_VERSION		0x0
 #define		HW_VERSION_STEPPING	0
-- 
2.26.1

