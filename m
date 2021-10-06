Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9C424032
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhJFOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhJFOi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:38:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052DEC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:36:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so9492568wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btIDYNml351PHhnvKhDxiJ0B4XZ5hfTqoalRMMDJ290=;
        b=bqgb4i6uArQKaHpIE8gdwBHRpWplgsV218TFqcLvgOfwmQBJrAuNxC58yeUCbFxOv1
         dyljkaiLAJQ6UBR2TF4uRjfsKpFCshydZ1mgfz2IG5sfPlLEV34wULHhRkvT2oao3MAB
         Ty2KfxyTxqGSWRUWx0W7txR4jUrL/7A83HATaQ+noX5Eg3Bnxx3OHY0TKChwXr/i5pRx
         2lXKThEQ5Kc08xtoX9h2VI4f9dzlLxRtUgF74RfeY4XDVDPffnJeFb1odHLAbwe8ODA0
         G5JsW3J61PE63XwLSdAHTb4eH1Y8kgs8CCeO5yfxMs4RirIWjf5YQbA4grIcuWptLSJy
         cOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btIDYNml351PHhnvKhDxiJ0B4XZ5hfTqoalRMMDJ290=;
        b=lGZwnzH+vIt+PZmESIXKu34KxlCU6MWnictPb15maMnvD7NyD8PerLog22TwWU6pRA
         MqBXdC4y6VZxqQ+8pJlYs6saC9rnTR6sPuZAxJTjW+tJXnrqP/fWY3ziFfBIND/IKsgJ
         sO5P2WzHYKyKRvgM9PJhfVFL8VYUUj0k0tJ/ob8lvUb3wq3WYK67vg3WMZWE5ir9pwhA
         ODKciUv9/xrOSzfFEeJhgcCXugY1CSYS2IJR3NRTeyqDLLurTEbvhQQX8uHFZkomP94C
         F3Q2BsOb0MurD3OdF4c/mUcDJ91L2pDUS98oGZihzZY2bLvAyhaIAGfXdu8oLaomqQoL
         MsOg==
X-Gm-Message-State: AOAM533J//LJ6ftwC2sgnjBJly95GmghG3rVB3RNw3h1/Oh1/hVWLHYD
        I0vOiCFYvLQqKv8mxn7kCDg=
X-Google-Smtp-Source: ABdhPJzM6lMLLOi3vroxnd0vSFXrUEc0+TNBxSkk0Ze/8jUI0e8Fs/v8qqKfknfQXvCwd+myC56Mog==
X-Received: by 2002:a05:6000:15c4:: with SMTP id y4mr28837316wry.177.1633530993565;
        Wed, 06 Oct 2021 07:36:33 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id r19sm5045846wmp.43.2021.10.06.07.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:36:33 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in sysfs-devices-platform-ACPI-TAD
Date:   Wed,  6 Oct 2021 16:36:30 +0200
Message-Id: <20211006143631.129612-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated world: "the the status"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
index f7b360a61b21..bc44bc903bc8 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
+++ b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
@@ -74,7 +74,7 @@ Description:
 
 		Reads also cause the AC alarm timer status to be reset.
 
-		Another way to reset the the status of the AC alarm timer is to
+		Another way to reset the status of the AC alarm timer is to
 		write (the number) 0 to this file.
 
 		If the status return value indicates that the timer has expired,
-- 
2.25.1

