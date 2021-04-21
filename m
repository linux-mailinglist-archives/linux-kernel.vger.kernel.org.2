Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19227366E44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbhDUOcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhDUOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:32:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04299C06174A;
        Wed, 21 Apr 2021 07:31:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so63855733ejo.13;
        Wed, 21 Apr 2021 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=76/MK3U9p2w1LAxessam/b1YnGwnwr95hug2odeXPdY=;
        b=rSGq4LsRS/EdSViNrrkL8PPr/4AV5XwIM0Ey3yO5xb3CZAuPiSFViSdNhtSx9PnwQU
         8x6axKQaLh4x0+3fIwLqv6ZIV+LNPy/zS6Sd4g2Hs/RG7/FN2LYELIVDpZ1Gec8wlsBA
         nrJ36Ck76N1GDh4tZkA0gc/x7n5YIEICX8wi3sjJ6DPmGDPzkd6FF06aiECWLD4Mx1d+
         cnjL1sWiDyTypQw/3qF3sAGC86MlYI4qh2P98fqmtO77avCA69keTOutF1JEfeu4+sbv
         lzq2ruTeq6Bju7Pe+fIWdhaWxyjGer9Mx/GBpLqDYyMqQu5n+tKkvtVDESxBUhibAjiP
         RADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=76/MK3U9p2w1LAxessam/b1YnGwnwr95hug2odeXPdY=;
        b=dSRQJ/lxUZdBAarG3hM+szCWlelNL5uKrYHepUcDu/AJwdWUfVWvRRql7Dx+tCGSjf
         SKD/ADM+z3zuazcFUsdsS7m3VTPqXHYLbsF8VMfaGdH3m89JDMwTFq8vdaCenHgq1gxV
         ifsW8cq9Pxkpr2YQ+TDdORT67V7wLUSCFlkSwTNKHg41/TX86bxbJmRiFtzFj6GTVYs7
         BBnUKixcCYP/jglOgvTP6xrZDGFSAyi5EguL8ymEeWBnVQorEjVlB+7+mbKE1WhGmyNf
         s0Uwx3Ipdd5xeFgytzhnqnUUnHCPlLzCSgwKW4yVyNbSzbeF0r62GlfpFf2bQrqFzJIs
         61IQ==
X-Gm-Message-State: AOAM532L9TGBw/sITssLCtDWD69pwV1gP5MIgUb5uYkVUcmDOfQgDRGy
        2KxYmpaa5tFEmLYhDuwnLbo=
X-Google-Smtp-Source: ABdhPJwXIFr4CdAKCHSzNSXUMcFnND3YA+X11z+WT1K03k7HMaOSBeGd8VTUC/u1cKlQ2Y5yhn8z6A==
X-Received: by 2002:a17:906:cb88:: with SMTP id mf8mr33804099ejb.541.1619015506673;
        Wed, 21 Apr 2021 07:31:46 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dab:e100:dc6b:6f9a:b8a4:111b])
        by smtp.gmail.com with ESMTPSA id s8sm3586133edj.25.2021.04.21.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:31:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] of: address recent kernel-doc warnings
Date:   Wed, 21 Apr 2021 16:31:24 +0200
Message-Id: <20210421143124.17873-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, make htmldocs reports these kernel-doc warnings:

  warning: Function parameter or member 'output' not described in 'of_property_read_string_index'
  warning: Excess function parameter 'out_string' description in 'of_property_read_string_index'
  warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Overlay support

Address those kernel-doc warnings by simple adjustment of the comments.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210421

Rob, please pick this minor clean-up patch for the devicetree tree.

 include/linux/of.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index ef6b161d1f91..4d84674f8aac 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1192,7 +1192,7 @@ static inline int of_property_count_strings(const struct device_node *np,
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
  * @index:	index of the string in the list of strings
- * @out_string:	pointer to null terminated return string, modified only if
+ * @output:	pointer to null terminated return string, modified only if
  *		return value is 0.
  *
  * Search for a property in a device tree node and retrieve a null
@@ -1203,7 +1203,7 @@ static inline int of_property_count_strings(const struct device_node *np,
  * property does not have a value, and -EILSEQ if the string is not
  * null-terminated within the length of the property data.
  *
- * The out_string pointer is modified only if a valid string can be decoded.
+ * The output pointer is modified only if a valid string can be decoded.
  */
 static inline int of_property_read_string_index(const struct device_node *np,
 						const char *propname,
@@ -1473,7 +1473,7 @@ static inline bool of_device_is_system_power_controller(const struct device_node
 	return of_property_read_bool(np, "system-power-controller");
 }
 
-/**
+/*
  * Overlay support
  */
 
-- 
2.17.1

