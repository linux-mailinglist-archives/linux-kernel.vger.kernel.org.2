Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8417D44035B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJ2Tm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhJ2TmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:42:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D59CC061714;
        Fri, 29 Oct 2021 12:39:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v17so18081065wrv.9;
        Fri, 29 Oct 2021 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JDiYoNK763JyIWioyKZZjE3flIapLP3PUXlqfcL7yP4=;
        b=CULEJxsyaBq/m2gvs544NSjW1C+y0HJOtAaogTWvThZGfp7xQlkCfuiQJDCPQMHcnD
         VmwyaCFSnsPZVCjeH/hgfxNTbH6zqL1/DT4IiqEzQuAnl/Kqto6RzqEJNFXX9iWNfsjd
         Or912bm9LT0rlieHC41UPMz2S3Og5ML6ionayYHbjKMvzrEaxqXUUBoeyfYdvGN5EWym
         mfp/VRWtKD57EliPBHMlyNsuugSci0cU505WAqcSr/cqiocOGFZlIHCjWxh8vHxfeFN0
         v7M05JDL1W22T2hsWQNx/ULhLcqAFDMRyESh0vUoEfndFlg9wobCRwx9Vb5c9bGFUUVs
         Gd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JDiYoNK763JyIWioyKZZjE3flIapLP3PUXlqfcL7yP4=;
        b=Z1/5AP0pBYqR/B1B1SInmFQZoNJMlX/Ab9+jntEh34BJFa8eyXWz1I2ccrMX2l1lIF
         UszS3Q9eAsZoOjD+3LyWuA8JyQI1Qq6F6WFMY9BhHoTpu+v3wT0cVgyI1Tn5t0lW4pIx
         uVY8gvWJOCfRVUTgBjULSgWEOE69mm/gJAinPkW35K0sTxrhSlpby989/677/yOtN8EX
         QJCv64wuAk3p31SIMVxwnjJR/mHunDkmuc/gKeETrdQNBZSesKVEfwL518Gd9LOnQxoW
         TSjaFT53WSBhZIFYohdhYAyQbQ50osW3lBCQ7LIBZKlI8jdekWJvRsA30sHmMjGvATgt
         du/A==
X-Gm-Message-State: AOAM530tAZYRwpnKuMK8a8DX/gg+IT92VV9TBbLG+zjj6HVUMtOmX8nU
        HJ/tsKiniKpHzwcl0FJH1Bt870AKAck=
X-Google-Smtp-Source: ABdhPJwTWmMyGMYiCW0eEXrlizrsmDt+3gwW9no5KW7B4Q/E3icGn5R0MZj/sq9jiAlrD3RE8nbMfA==
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr14643887wmk.125.1635536394213;
        Fri, 29 Oct 2021 12:39:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06341d0f9ebdf4bbe019.dip0.t-ipconnect.de. [2003:c7:8f4e:634:1d0f:9ebd:f4bb:e019])
        by smtp.gmail.com with ESMTPSA id o17sm10022254wmq.11.2021.10.29.12.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:39:53 -0700 (PDT)
Date:   Fri, 29 Oct 2021 21:39:52 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 1/3] Docs: usb: update err() to pr_err() and replace __FILE__
Message-ID: <e2f2c5c6995a011494105484849776a856af5bcc.1635533924.git.philipp.g.hortmann@gmail.com>
References: <cover.1635533924.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635533924.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update err() to pr_err() and replace __FILE__

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 2176297e5765..5c29e5bdbe88 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -91,8 +91,8 @@ usually in the driver's init function, as shown here::
 	    /* register this driver with the USB subsystem */
 	    result = usb_register(&skel_driver);
 	    if (result < 0) {
-		    err("usb_register failed for the "__FILE__ "driver."
-			"Error number %d", result);
+		    pr_err("usb_register failed for the %s driver. "
+			   "Error number %d", skel_driver.name, result);
 		    return -1;
 	    }
 
-- 
2.25.1

