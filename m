Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B69344088F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhJ3L1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 07:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhJ3L12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 07:27:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AAFC061570;
        Sat, 30 Oct 2021 04:24:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so5328889wmj.5;
        Sat, 30 Oct 2021 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3XYlB1/wp38jGvLFP8/69z9R6Lyv3a0CuAXL3ejVQQ0=;
        b=Ye+EOjkt1fESsP2qGh/PeGzkMQ5qV6nhSYys4pWRCVCemqfcnZdeOv7P3H4Pw/j5Uz
         UrJptIbFz7t3AKzbdz5fvECPcUGZSa1m1fbcBqzuWr59ojh6oXdR7hMQU25H1TZKqJCg
         rYGq4unfrz+MQ/p/WlULUVGY9+uaQULCMOjpIk0+bP+7rkoWln67y9wMf4pyt90CF8l4
         0gogv4N3d482MrQZ1XPJgghDQ4NcoWIpfZunBD0eUf3EP2FqbwjtLEJ8w/iMwUUObvyV
         uAcXtreNCtWWp8tLdXiA6+TZoHi0IMD71mWydURKjnIKsEWl6u3cPuSOYSeb6sqAjnh/
         /1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3XYlB1/wp38jGvLFP8/69z9R6Lyv3a0CuAXL3ejVQQ0=;
        b=gEWEobbtAVIJElhkQPKngCog3nT4ULE/qVnjH0NC1jO3vLaJuRQaoJe1G+mgYv+PrR
         VERIzyIcpGd7Espqza0IVW9sJ86J6i+J7XmzI9QKq9W0C4dtsb0FU6WsCxJW3a0T1i6R
         L+nRWYjArrUOyhQGy1rSH4VnvIRSr5x9DY7gt7s5GikkDpyyhi/vdjlkfaY+wXNBBCAE
         QbjsObokSG/3Vy0h2fzwBKBkRHdj2EitoqM84J6R3h3eic6sl9WGUNupXZd6pDJHJHdq
         ukMvNOzRdCvXHHt2SIv9s89wda3CJGouW3whHDMWBrDxJSqsDdCFQzMHgmW+huCHhJhz
         5oBQ==
X-Gm-Message-State: AOAM531obedHGozUyEJwkL9LPoK0/QFoCFkKpVdJKEyC3CKU63I9CRdQ
        XKG1qsfNWDMAWhT8wzfbFX0Ez/5ZRsI=
X-Google-Smtp-Source: ABdhPJy9GmjzxibLOtPKLdggoift9Tt/CFaxSBuqZx4bliRw2aQO6p/PQbd8VnEvk7nQzNFjbGmT4g==
X-Received: by 2002:a05:600c:4eca:: with SMTP id g10mr25616272wmq.171.1635593097061;
        Sat, 30 Oct 2021 04:24:57 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e069113f7f01122185925.dip0.t-ipconnect.de. [2003:c7:8f4e:691:13f7:f011:2218:5925])
        by smtp.gmail.com with ESMTPSA id p19sm10814673wmg.29.2021.10.30.04.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 04:24:56 -0700 (PDT)
Date:   Sat, 30 Oct 2021 13:24:55 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 1/3] Docs: usb: update err() to pr_err() and replace
 __FILE__
Message-ID: <2c477cb0cf5214ae9abf9a4a9de28fcb38f90070.1635591623.git.philipp.g.hortmann@gmail.com>
References: <cover.1635591623.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635591623.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update err() to pr_err() and replace __FILE__

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: changed kernel message to be in one line
          added missing "n\"
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 2176297e5765..85e106f443e5 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -91,8 +91,8 @@ usually in the driver's init function, as shown here::
 	    /* register this driver with the USB subsystem */
 	    result = usb_register(&skel_driver);
 	    if (result < 0) {
-		    err("usb_register failed for the "__FILE__ "driver."
-			"Error number %d", result);
+		    pr_err("usb_register failed for the %s driver. Error number %d\n",
+		           skel_driver.name, result);
 		    return -1;
 	    }
 
-- 
2.25.1

