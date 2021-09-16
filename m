Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2122640EDD2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhIPXVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIPXVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:21:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A7CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:20:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v2so4917278plp.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFXd2zJhYk0TzYHrMnJk45viZw/0P1M7pg7rObvblOk=;
        b=a/xON2yL4Ca3gPyB0hDBfAMCd0mW2TgB03oDtNIQE5n+5QuTZ1N/nY9qU/WByzxeV5
         ZYpYaocKKL9A9C/iARoOYIjV6+3gYUnkFv6Zm5iEopx85zfeOzVwMSwdrIImhm+E6Mz6
         Tm7PXKooHQTYfrAi2x5/R4eWEuIYNsbsgIeew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFXd2zJhYk0TzYHrMnJk45viZw/0P1M7pg7rObvblOk=;
        b=OXoqBV+vYiVDARtMhb0MzQvMG7ENgGkI17EqsrWesw38NrNrDODUKAr60eOF5aHJQj
         RDJvaWcGOOCLoyqQbRgGD4R4+QpphAKgpE4YMC1KOcyrDiZCYQHgPthfp16ClUxmMIgJ
         yuJgyG/o3srLgei5FbZxfc/X5B32rEENtb3aUHgLf+3C3QWQ1jknGyxVdbXTHP/NZhWs
         ydN+8D3zJpJxKk2JKebanowulNbwr/r5JpOItHpN7GmYYOmCMlRM13x6tvXfXOURr90E
         nNgt0HojGBdRtAOg8WyEDA1I7sJzdY/ODVkjaBbZqHSU6mL9+tjj44ehwUuTWTMZ8IZ+
         yQSQ==
X-Gm-Message-State: AOAM532faDuPcXx90neXAtwlnIEQax7yUkN5Uxq9UrL7h7XdoJy23wBD
        4iT7SWG+rA9rijI5kVp3Hjv31w==
X-Google-Smtp-Source: ABdhPJzvIKNdzWxnWeBSjVT22W265ugWWFl+0X3aLpUxmlKXeiAaIydaoVyux2YE2RhpddUobIlUcA==
X-Received: by 2002:a17:90b:150:: with SMTP id em16mr17282912pjb.63.1631834402929;
        Thu, 16 Sep 2021 16:20:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:ef0d:e7a7:2a56:3f9c])
        by smtp.gmail.com with ESMTPSA id p24sm4654917pgm.54.2021.09.16.16.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:20:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     broonie@kernel.org, andy.shevchenko@gmail.com, a.hajda@samsung.com,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Clarify that dev_err_probe() is OK even w/out -EPROBE_DEFER
Date:   Thu, 16 Sep 2021 16:19:40 -0700
Message-Id: <20210916161931.1.I32bea713bd6c6fb419a24da73686145742b6c117@changeid>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some debate about whether it's deemed acceptable to call
dev_err_probe() if you know that the error code can never be
-EPROBE_DEFER. Clarify in the function comments that this is
OK. Specifically this makes us able to transform code like this:

  ret = do_something_that_cant_defer();
  if (ret < 0) {
    dev_err(dev, "The foo failed to bar (%pe)\n", ERR_PTR(ret));
    return ret;
  }

to code like this:
  ret = do_something_that_cant_defer();
  if (ret < 0)
    return dev_err_probe(dev, ret, "The foo failed to bar\n");

It is also possible that in the future folks might want a CONFIG
option to strip out all probe error strings to save space (keeping
non-probe errors) with the argument that probe errors rarely happen
after bringup. Having probe errors reported with a consistent function
would allow that.

Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e65dd803a453..85b8955717fc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4653,6 +4653,11 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * 	return dev_err_probe(dev, err, ...);
  *
+ * Note that it is deemed acceptable to use this function for error
+ * prints during probe even if the @err is known to never be -EPROBE_DEFER.
+ * The benefit compared to a normal dev_err() is the standardized format
+ * of the error code and the fact that the error code is returned.
+ *
  * Returns @err.
  *
  */
-- 
2.33.0.464.g1972c5931b-goog

