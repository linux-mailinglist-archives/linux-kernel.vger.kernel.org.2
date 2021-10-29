Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE7440362
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhJ2Tml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhJ2Tmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:42:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45461C061570;
        Fri, 29 Oct 2021 12:40:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r8so5333989wra.7;
        Fri, 29 Oct 2021 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iz1/9itNHKzffmv7IN5WPf90NYweKtO8I55T4DTR9D0=;
        b=GknvBqosrvVRhdZWoPFA+3S31LbF1oV4x9HxyljybQQ23m+RoG2gKywxQ0HZ6fED3J
         BcVwHgxs8cioVJtb228bhJ324CHDurEOpI8ATUl9jnB+oSQwDudn31MUlXM2KgAwMnpz
         rjacikS1rfXpddPdo6fUNln/VZTsfNjaLZ2v94BlBR3yOlKnahcC+E7kR/SIYuxuboey
         uOIlk2kIAyxxC95nWyXy4ouNkqh67Hv7/AKObkGXv0Qn7q1jBbCWPfOPzFGj8urwhaIk
         iM7NLeXR6v249tMoF6oyZMdLCooLY8fxlYBm1XzAU/tMFml4TDLOsXc/VZKNDbVKKIkp
         Qm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iz1/9itNHKzffmv7IN5WPf90NYweKtO8I55T4DTR9D0=;
        b=12HHBV32o6M24GAg7K9Q2AaJuWPe7ICOLFA3Bio4q9KGY6amlibf6iNqTskL+mIL1Z
         0mMyvK7Yra5EEbW1iv+YrLX36dCppwzXIW1umtQRbm4poBvY5AcA1hcQGOY4tsTlGZuA
         DFy+fNDjlwy9r0U/f++PrTWR5rbpAnu5/ENKYsCmW0yN7PksHipL/9I4YWBi1Cy2/DoP
         Gc4SOYuPuqyJFRC8JrQmfMYPCzvsj68H7WZB3LPURPsloZrr8lJYW9j3+SwangM/Uh1l
         TuQ1u254ikDpT7y6LN/ci9kFMyVYqyI4jfWIb0NLfM8ICb+ucf4bgj+yRNJi87012jKG
         5yig==
X-Gm-Message-State: AOAM53082k2+3GMqy3J+fORCReQu1RHkqN9UNWAySxRmFGoV40wadC1q
        o26Lype86+Ndo1QrmecjF1c=
X-Google-Smtp-Source: ABdhPJxEeM3pFnFyFERc9wtUPhS4OJ2spbRuHRdt3kYkkRiryh4lKyQTQey5MM4yKG0wg6/Z/YLnhw==
X-Received: by 2002:a1c:2397:: with SMTP id j145mr4339558wmj.113.1635536406942;
        Fri, 29 Oct 2021 12:40:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06341d0f9ebdf4bbe019.dip0.t-ipconnect.de. [2003:c7:8f4e:634:1d0f:9ebd:f4bb:e019])
        by smtp.gmail.com with ESMTPSA id f10sm7126673wri.84.2021.10.29.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:40:06 -0700 (PDT)
Date:   Fri, 29 Oct 2021 21:40:04 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 3/3] Docs: usb: update writesize, copy_from_user,
 usb_fill_bulk_urb, usb_submit_urb
Message-ID: <939d9e91d1ac12003a08d7694b6d6bd29ba2a57d.1635533924.git.philipp.g.hortmann@gmail.com>
References: <cover.1635533924.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635533924.git.philipp.g.hortmann@gmail.com>
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
index 14eda0342649..02c28ee10b91 100644
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

