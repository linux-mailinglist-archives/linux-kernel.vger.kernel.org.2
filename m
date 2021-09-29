Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29A941C4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbhI2M2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:28:24 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51478
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343839AbhI2M2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:28:23 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB2F0405F1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632918400;
        bh=iH/cPXldDgnABS8nEn4aJPP/G7VcHOpg5XHI2afeaZ4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=iH9ZNEA6CAF9JYw2slCBEwR+NGdG7IjpMFbwZV8x6s1c4dPIZMClNQI1pNIOOz2yg
         h0mB+CF6PZCjPvZpysdpvFqArljvo328n9J7sCKgU9DPOjbil1V1pHtl2hfKo4w8zn
         9kUCJXARqtrP8GHeIK1/BI6ueuIz9xhK8j5pMuEfu4y+sQUfU9D34iO0QTS7yHECq8
         CHxXxpB+xgTZpGlhuKo481qAi0C9NM1gAK6jv0S03wT11tObqMUtSvn/sucSD6zr1M
         3uEFbpFTYM9a0h+Vt8xyg4nJP3WiNrlc92vWeBLlkpX9J8zc++UQziZswU9l3NiHRh
         1jkPKOgB0K3lQ==
Received: by mail-ed1-f70.google.com with SMTP id a7-20020a509e87000000b003da71d1b065so2250770edf.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iH/cPXldDgnABS8nEn4aJPP/G7VcHOpg5XHI2afeaZ4=;
        b=M1fYLYhKmW+J5okd47oFV/vAikyWACuTSqlVa+zliejd/HoGbrbCNlhrXbnUI2b5vP
         jQ4GUSSQaA+SmdNwKOYtYO14c8ZP+pIJXxvvBcHwcMBgiUJxCSajNeopjjgyvglM2EYs
         BCGUmRFP7ZSSFQS7eApAU85PuS7NrSOdhl1+r9dKb99EAF2ssa1KFWnzf6YLQQmCik/i
         P10OUBfOJlgIbzvj9tI68GIOMo/vR7XrFt6en7vA5QH474FuZx/b1hKll8HP7ssDuULm
         9EExlScnsQa6EDB0tVvrQiC7e6mI24WDrsz9O98eb/cLQ2lXaad9Jf4URUdYZadolabW
         yUFw==
X-Gm-Message-State: AOAM532SXqEP6pM2jwZMtudf1+xzF3JmhkFfei0Ub2uZdVrdsjAMPnaf
        TEP0hF3w+Iw/DENA4WBTINDxBYHtVffw+7lfFIWfUGt6WzJoAMsgTjmqUn7PxfLActTWLKn2SOL
        xGCXmxDyVz2Qn4ABGItPGKATCsM1EnwY0I680vCreBw==
X-Received: by 2002:a17:906:3012:: with SMTP id 18mr14286932ejz.136.1632918400409;
        Wed, 29 Sep 2021 05:26:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzic6knnSwMhuoN2x1g6dBpy/Loh23z6fNTkl6oz7ai61L9d1KUxkiRLK88oLwsTMQgB0XUg==
X-Received: by 2002:a17:906:3012:: with SMTP id 18mr14286914ejz.136.1632918400184;
        Wed, 29 Sep 2021 05:26:40 -0700 (PDT)
Received: from canonical.com (net-188-153-155-161.cust.vodafonedsl.it. [188.153.155.161])
        by smtp.gmail.com with ESMTPSA id w26sm1415972edu.59.2021.09.29.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 05:26:39 -0700 (PDT)
From:   Paolo Pisati <paolo.pisati@canonical.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: add missing return type (fix -Werror=return-type)
Date:   Wed, 29 Sep 2021 14:26:38 +0200
Message-Id: <20210929122638.58623-1-paolo.pisati@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c: In function 'input_system_configure_channel_sensor':
drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c:1649:1: error: control reaches end of non-void function [-Werror=return-type]
 1649 | }
      | ^
cc1: some warnings being treated as errors

Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
---
 .../media/atomisp/pci/hive_isp_css_common/host/input_system.c   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
index 8e085dda0c18..f36dadb5230a 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
@@ -1646,6 +1646,8 @@ static input_system_err_t input_system_configure_channel_sensor(
 	default:
 		return INPUT_SYSTEM_ERR_PARAMETER_NOT_SUPPORTED;
 	}
+
+	return INPUT_SYSTEM_ERR_PARAMETER_NOT_SUPPORTED;
 }
 
 // Test flags and set structure.
-- 
2.30.2

