Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F15440892
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 13:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhJ3L1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhJ3L1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 07:27:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0334C061570;
        Sat, 30 Oct 2021 04:25:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso7128069wmc.1;
        Sat, 30 Oct 2021 04:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/KDxxFThUMOPznUOZfbh3igj6eg/in2sKNhVqyAQPnU=;
        b=QFIX7mB6cox9Ay+tQRIGqE6HzTMdx1vjMz2XjlWbWaaUGE0/3XFaJiTlcWnPmd6LpV
         xL8y3+z9pPcURVFSPDmxstQiAcWmaRYq3rEsDN43C6D1Dkt5ZI1zTkbmFbvh5lJHDu/s
         3LZWrQ+RfhpiaRvUm6SXoA7wxbhbfpA1L95wk1qX2CFKo9Uio8SZkjHW36Lx+G1inr/j
         WqseyxsAmysd/mU3bWj78eOd1GpD4GY+n0IhHZynuMSwojJjP/Y2BTz2GyB5zlUOuZB3
         AAAFsUE+Ya4Nmexm6RtbYl7XvN5vGshv9cUe/YL5A6XSZL080oVumsw0dvwPJQl7XFHn
         jWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/KDxxFThUMOPznUOZfbh3igj6eg/in2sKNhVqyAQPnU=;
        b=GqDXKXH7Kh6w5YRQVBW3q13Nd3AN6kzTTSq7qpCAejrLIoZ4dgSIz9GQ9yFBonrXO5
         aH+FPzdgOPGMohZeGnuqXtsh/Nm2WMY7eTuOGG4dFaaxZwjwlLaY9VwvaldKuCE64Tkh
         6UmvO4vONXaKAhTi6k2Q8R44m9Tl+VGzCzRmrlV2+x5A/6k9wAkpcEfQ0raO24as98DY
         8kAvUoQBrqKplo/0Qadu7xik7T1TwAuBcAskc4WKygCcLO9ZODw+xUtsLAvRYtmK0a3s
         8wdkPmRqqMMukPRMZ/pA3zwxdi8ziURtlaH8AiGmZyRli4tgMYGaFsinENUW4URMqGKx
         PSQQ==
X-Gm-Message-State: AOAM53089ruxBrRrsfJwZMz0FxvDpSXO/yGmqPmhwi9LVJ2n1tA3rQyt
        wnFEjiKVu2ftrRpp2UpCRb0dw/jPiPw=
X-Google-Smtp-Source: ABdhPJz1En9/CnyFCIhfyqzedEj4fmXgja7wLzbS8oiG6cT7bmRLnNDiwFwgTDy4RRFyhvps0TEy3A==
X-Received: by 2002:a05:600c:4f81:: with SMTP id n1mr25888996wmq.63.1635593106645;
        Sat, 30 Oct 2021 04:25:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e069113f7f01122185925.dip0.t-ipconnect.de. [2003:c7:8f4e:691:13f7:f011:2218:5925])
        by smtp.gmail.com with ESMTPSA id q26sm5722558wrc.39.2021.10.30.04.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 04:25:06 -0700 (PDT)
Date:   Sat, 30 Oct 2021 13:25:04 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 2/3] Docs: usb: update comment and code near increment
 usage count
Message-ID: <38c6205d6b5c612902f9c187154c05e9cca51107.1635591623.git.philipp.g.hortmann@gmail.com>
References: <cover.1635591623.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635591623.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update comment: increment our usage count ..
and code according to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 85e106f443e5..24374cdb677b 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -167,8 +167,8 @@ structure. This is done so that future calls to file operations will
 enable the driver to determine which device the user is addressing. All
 of this is done with the following code::
 
-    /* increment our usage count for the module */
-    ++skel->open_count;
+    /* increment our usage count for the device */
+    kref_get(&dev->kref);
 
     /* save our object in the file's private structure */
     file->private_data = dev;
-- 
2.25.1

