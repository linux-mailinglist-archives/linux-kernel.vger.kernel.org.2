Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6690440896
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 13:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJ3L1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhJ3L1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 07:27:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF9FC061570;
        Sat, 30 Oct 2021 04:25:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v127so9980359wme.5;
        Sat, 30 Oct 2021 04:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LkR4Z3PEhPzZ6fXtkdmCLF9FtgcVowssMvoeMUKZdHg=;
        b=KRC/4GrDCneN9Ju8t5PH+uOrQPXYP0LoApSPT55/c4IXBtZ91PoLXtpwrz+L3u4XHL
         HrAkzG8gy8sN4EH0yVr+TPgIYFk5o1piUS6mOyDHEZqmRTzZyknmHs/6ptStjNBYvvNS
         QgMT+JbVFqe6kgl7rVHJh7bFIL6r0kzBHdQ++7Eu2m1L+Zyl/D8PXFEYet5SpoYJsFyq
         tX7H43EHOydeqwwgje//8mNDRtwB+2hnzdA1FVZ7BuF/eFwsZoG6udjq+DsgoNqbkS7F
         kcEyxZnzpe1I4Z/TY9b1Kr1ZnKPeOz9YMvVeX5JMHIPDvLLbrk1TEuwfbPOrNfXoHFdP
         sjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LkR4Z3PEhPzZ6fXtkdmCLF9FtgcVowssMvoeMUKZdHg=;
        b=6zoSEfCg/61hPQ+mpDMXcQpRxFFFYBjMQ9A6ZyGEiOqG+D0oiPQUdTicU3vNX8/MQS
         zVkNU1ORCn+wAxyKV6VAGt4vJvMmBlI9Nfl4saJb9xh5dgSzJ7UhSkWw4AdFXRVAHhSU
         xc9XaJhweRqOkPlBP52Qvd/DU7/qX3zjPgttvEWuq4Nb+LrVTLCZh3xocK8+0QrUW8F8
         233qThsNuokh13NRrOfpWpjxP+X/v8tLw14g4JcwRbpcqsz9tBI9O9DVy9dTyHW/wbfg
         Nd718Ig/Kns/zyOnOMnYJW2t/Enm2nI3zwW4W0aZCSmV5QoLp4F65ed/GcU2Q+32EVIa
         yMlQ==
X-Gm-Message-State: AOAM533VxZG9vJ8fzdlDw7nUj6UrblxgneqTKfeGXPZ3z9c9xRFgv9fB
        UZYzLemIwDh3Uj1sPXZBpMg=
X-Google-Smtp-Source: ABdhPJwlXO0mfvd0/CXUu9Sq/cBGiwX7nHA5X2uKEty2Qa2TkU4W+Qi6rMUzs4eDNykU9pvZjYkdCA==
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr25739240wmq.149.1635593112313;
        Sat, 30 Oct 2021 04:25:12 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e069113f7f01122185925.dip0.t-ipconnect.de. [2003:c7:8f4e:691:13f7:f011:2218:5925])
        by smtp.gmail.com with ESMTPSA id u16sm7994689wrt.97.2021.10.30.04.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 04:25:12 -0700 (PDT)
Date:   Sat, 30 Oct 2021 13:25:10 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 3/3] Docs: usb: update writesize, copy_from_user,
 usb_fill_bulk_urb, usb_submit_urb
Message-ID: <0c581a83dfc1a8c37e97dfa7279d333f367a9787.1635591623.git.philipp.g.hortmann@gmail.com>
References: <cover.1635591623.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635591623.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update code examples writesize, copy_from_user, usb_fill_bulk_urb,
usb_submit_urb in skel_write() according to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../driver-api/usb/writing_usb_driver.rst     | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 24374cdb677b..9cdd9f923974 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -185,24 +185,26 @@ space, points the urb to the data and submits the urb to the USB
 subsystem. This can be seen in the following code::
 
     /* we can only write as much as 1 urb will hold */
-    bytes_written = (count > skel->bulk_out_size) ? skel->bulk_out_size : count;
+    size_t writesize = min_t(size_t, count, MAX_TRANSFER);
 
     /* copy the data from user space into our urb */
-    copy_from_user(skel->write_urb->transfer_buffer, buffer, bytes_written);
+    copy_from_user(buf, user_buffer, writesize);
 
     /* set up our urb */
-    usb_fill_bulk_urb(skel->write_urb,
-		      skel->dev,
-		      usb_sndbulkpipe(skel->dev, skel->bulk_out_endpointAddr),
-		      skel->write_urb->transfer_buffer,
-		      bytes_written,
+    usb_fill_bulk_urb(urb,
+		      dev->udev,
+		      usb_sndbulkpipe(dev->udev, dev->bulk_out_endpointAddr),
+		      buf,
+		      writesize,
 		      skel_write_bulk_callback,
-		      skel);
+		      dev);
 
     /* send the data out the bulk port */
-    result = usb_submit_urb(skel->write_urb);
-    if (result) {
-	    err("Failed submitting write urb, error %d", result);
+    retval = usb_submit_urb(urb, GFP_KERNEL);
+    if (retval) {
+	    dev_err(&dev->interface->dev,
+                "%s - failed submitting write urb, error %d\n",
+                __func__, retval);
     }
 
 
-- 
2.25.1

