Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4433811E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 00:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCKXMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 18:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhCKXMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:12:24 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF86C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 15:12:24 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id w195so18324776oif.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 15:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdiULIB6ebT4Vr8C+yaWN+9MOsEzs8BW5c8rV4RqHcM=;
        b=M/UWLvP/T1EjzdQSQA7JcJTe4xNPDL3AvFy/vBfJKMoex1jqYqGQO7X9IQ+Y+9xuBb
         YPZTffUb5Ua9TKqQ6BKJPK921+dK8LyZLsCmup0aVByX48GSfJ7j/HfnVDUz9qGF+NAQ
         wbpp7LgkeF3RHVbxqGwxLGMKi5MESlRCygL81d+F8GPnB2QAFbbcivei0sqEP0ROwUFX
         XAsjmd5lMCORwgx5rKF6+bQ+vOiIqT+n3OSl96U/7NsdFKjEHKMeSWAel3N5SrFQWd/y
         mvQTO5pGq6ecjDFc8HXRAnC6Wb2bbciF+5GNReQcarfqP/EEpAq1TP9sPt6WsEgYQzT1
         tOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdiULIB6ebT4Vr8C+yaWN+9MOsEzs8BW5c8rV4RqHcM=;
        b=rKAdubFRG3PaNpG/xqwA2kaDC1TYtcflbqATuBL6tGpKCC7BM9Nc3yZBLsD1ALCbfU
         PpZ75UxbOHjxWvkTCgaOBMRbZ1YH9LWM1NYsMD9SpUe3NxHCSPiVUracZVKWPY4Uqtgj
         TAECr8WmodvsYYVBL2CrARNIfUWOtvfE41O3kqh4Wvg3TBjj5nzLPoGl/cjCy7Y3TcZh
         JOqoRRznWOppmUGT8FWT+QcnrLrkUcJUlQXgXbIhKXzIJUGNjxD64vw+zF3yUEvN1J3c
         dWRNQgWYbIUmXadtNhTGsYfB5O/si9N+J0Y2gLDnccw44+abSGsJiY/vLh8+rctHL4er
         4WpQ==
X-Gm-Message-State: AOAM5323zGCJeU6DCThIQ/5LYZRlKLAQstjcOoSJ86u0XQzfkrFrwlQR
        xg9NvU0pTbS/oQtzylVSsaMm0A==
X-Google-Smtp-Source: ABdhPJzBISRNdzGariH5EcLX6sCGLNea21uuGPiUbMbukx09Urom88NH7SF95VfStC3GDAwf0zgcDw==
X-Received: by 2002:aca:b156:: with SMTP id a83mr8061611oif.8.1615504343804;
        Thu, 11 Mar 2021 15:12:23 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r16sm854193oic.29.2021.03.11.15.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:12:23 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add DT bindings directory to mailbox
Date:   Thu, 11 Mar 2021 15:13:28 -0800
Message-Id: <20210311231328.3248833-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings related to mailbox drivers are typically picked by the
mailbox maintainer, so add the binding folder to the maintainers entry
to make sure get_maintainer finds it.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9095d182deaf..670f1461b65c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10608,6 +10608,7 @@ S:	Maintained
 F:	drivers/mailbox/
 F:	include/linux/mailbox_client.h
 F:	include/linux/mailbox_controller.h
+F:	Documentation/devicetree/bindings/mailbox/
 
 MAILBOX ARM MHUv2
 M:	Viresh Kumar <viresh.kumar@linaro.org>
-- 
2.29.2

