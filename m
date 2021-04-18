Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4CB36372C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 20:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhDRSgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhDRSgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 14:36:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7155C06174A;
        Sun, 18 Apr 2021 11:36:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cu16so14650427pjb.4;
        Sun, 18 Apr 2021 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GpyINhSpeyIcXLnHy2tgBVAm+7ut7FEtyoPnAa4TZbU=;
        b=BR/YR7ooVaUdKnTCydUQt763M0UzsxoMIdAdqdBXgS5Fj2t0gILuXA9q9JwU+C92CW
         0t7//rc0jHyhehED7mIMu2zExvb70qELc0w+ItOCUJFOhUV4hQ/v+VaLUuMwSnvEUbij
         5PJzgnLhnudrC4tz3ln7LLy4EdYaKJYFsMm2PL3fCcZ7Y1QDbrQXyxhkEKSqrykkwtRD
         L6ae0KsAdDQbLL9VzFQRGT1mB6f6ijUNsIJk1IDuMP1Qc6l+D4M3ZoWEOv1qH/xqe0ht
         3Y8S52fXcqz18rpmdOJYhC2gOWyQruHST4dcYtIWReL+m8IBOzL/u11edFiSKl5mCdqe
         /wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GpyINhSpeyIcXLnHy2tgBVAm+7ut7FEtyoPnAa4TZbU=;
        b=KXA2lANXeOjGvNdbxSxNMfNnXBBOGRkPPpn8DNpeKic8yB7XdWEv8k3swA9GsHWZAS
         JoYMXlGbEVioyRpUThjRqpcIBiPNAOVoxMrZALLEXG3SGBREavBxrNNVaBZToPJU9IaL
         2ABiJl5obHkPFUXxYIuvz00Xk11dk+VNC+eycg2T8ze9CfArQpc+dhy6BZGMgc0QUXnW
         zjBcaKIERM+puVPgNdpe675cbTluHBI9MYHqk0yJuQ/ik5MsxjZrhdic/6ZC54CsF6q7
         A5cqag0DB+MTmxPwyDRZ1e4IHmdMfrFbX9SpcPwEtwVUTBh6LC5aL7xgifPnKAk8IVa8
         aB8A==
X-Gm-Message-State: AOAM532ywO4Ph3scBB/J4OF6omlSvuUFIYIyLAWvnK1/fmMc0oLg8Anm
        MPJua/IFAkNRUwi6DCPEY3A=
X-Google-Smtp-Source: ABdhPJybwGrr31UijAYZ1m8YeAmKTALVRFaV6iv7eAHWoguf0U+dclERGli5YINxk13bLC4JQKbP/g==
X-Received: by 2002:a17:902:59d4:b029:ea:bbc5:c775 with SMTP id d20-20020a17090259d4b02900eabbc5c775mr19513893plj.11.1618770985383;
        Sun, 18 Apr 2021 11:36:25 -0700 (PDT)
Received: from user ([2001:4490:4409:d07c:b4ac:39e7:e05c:f39b])
        by smtp.gmail.com with ESMTPSA id u20sm11658135pgl.27.2021.04.18.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 11:36:25 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
X-Google-Original-From: Saurav Girepunje <saurav.girepunje@google.com>
Date:   Mon, 19 Apr 2021 00:06:18 +0530
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: musb: davinci: change the variable type
Message-ID: <20210418183618.GA69452@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vbus_state is define as bool but on davinci.c assigning a value
'-1' to the bool variable.

Fix the following coccicheck error:

drivers/usb/musb//davinci.c:532:2-18:
ERROR: Assignment of non-0/1 constant to bool variable

By changing the variable type to int.
As vbus_state need more three values/states more required by
vbus_state variable.

 /* 0/1 vs "-1 == unknown/init" */

Signed-off-by: Saurav Girepunje <saurav.girepunje@google.com>
---
 drivers/usb/musb/davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 704435526394..e3435621a9d9 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -36,7 +36,7 @@ struct davinci_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
 	struct clk		*clk;
-	bool			vbus_state;
+	int			vbus_state;
 	struct gpio_desc	*vbus;
 	struct work_struct	vbus_work;
 };
-- 
2.25.1

