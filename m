Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA72736959C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243040AbhDWPHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243041AbhDWPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:07:09 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E6C06174A;
        Fri, 23 Apr 2021 08:06:30 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso23070651otl.0;
        Fri, 23 Apr 2021 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=OcfjnCUcskahTQWlnQZrT0iOCsWTSnSbXMcim9420F4=;
        b=fbPLagiBeVS/ZmJ8Xvjj+Fp5pj75u1jOOI5YZ0y9Uizii5F9qU2DnXMP+dnautWazt
         RzPgY0buXZ05Wa6AObRwyKsZ4XFzLyc8bORsSp94YBFe3q6Ky6d7qMwTcyqx+EIcrOqQ
         FEDgAHbmOPNFa2TYoEwxNPG4g8i5Tskm8YBEJyCqBaq3aAJK7aDo6egmwubSGg1wrUY0
         +RArNlHCd2Di1ziFF1qdDPn29tZbxYFSDlrLLoQYHb5Y8aWfDDwmF4yUIN2HCmmNK+zB
         N9rW7dbg77Ym4QSwe2q4Kx65KyZkCGB/IjV8BgUk9p5y0cmMvU92jiucmbtELB/SJSh7
         xDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=OcfjnCUcskahTQWlnQZrT0iOCsWTSnSbXMcim9420F4=;
        b=hPfRFqpqtlB+B/W8oMWeJUmlgc6bRnUEIysxRhzyUuRo1ZWZb6vf/S4C+5bS4MZ2F7
         8KwTe42luZu7s+78ecf6FPXWgLNjb57b3k6JCT02NdgbM6+fon0S3BnD+sd85oZnshno
         FuC6406uSrASJi4dNVhANNNrOinVPOg1T+kRPnzFCsLz0MPBposLBn82OwFwl4J4BAYD
         H5vrMf6MLBG26l4ggQXeKkhAgdqKjBn2GAzu9ZHJmgfdYYbSlEy3LiUIzic0IklpBpN4
         qjscUTyHU6DaNSoMW1+yxfUWneJiX1o6JhyHkRhZylbIr7a0WbSR1nPsRC5bK9nn9KR8
         G77g==
X-Gm-Message-State: AOAM530kETn3F6SV75cMUy6NoYCi6NE7X5ye3bZX4StmMVXk3Fau051v
        wotcX6fqZCvOPEquBGpbiDL5/L/TW1o=
X-Google-Smtp-Source: ABdhPJwEqNzZMA2/E4p5Ot/M6Lctzlbr6P4J9j1NTnYzfhFmB2Sx+mvIQd6MFSLNu+6kwHMlYnXL+w==
X-Received: by 2002:a05:6830:18dc:: with SMTP id v28mr3740051ote.310.1619190389918;
        Fri, 23 Apr 2021 08:06:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w66sm1452038otb.69.2021.04.23.08.06.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Apr 2021 08:06:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH] usb: gadget: Drop unnecessary NULL checks after container_of
Date:   Fri, 23 Apr 2021 08:06:26 -0700
Message-Id: <20210423150626.138188-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters passed to allow_link and drop_link functions are never NULL.
That means the result of container_of() on those parameters is also
never NULL, even if the reference into the structure points to the first
element of the structure. Remove the subsequent NULL checks.

The changes in this patch were made automatically using the following
Coccinelle script.

@@
type t;
identifier v;
statement s;
@@

<+...
(
  t v = container_of(...);
|
  v = container_of(...);
)
  ...
  when != v
- if (\( !v \| v == NULL \) ) s
...+>

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
After the recent discussion about a patch which tried to add a check
against NULL after container_of(), I realized that there are a number
of such checks in the kernel.

Now the big question: Are patches like this acceptable, or do they count
as noise ?

Guenter

 drivers/usb/gadget/function/uvc_configfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 00fb58e50a15..b9d1bcb4f4ff 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -914,8 +914,6 @@ static int uvcg_streaming_header_allow_link(struct config_item *src,
 
 	target_fmt = container_of(to_config_group(target), struct uvcg_format,
 				  group);
-	if (!target_fmt)
-		goto out;
 
 	uvcg_format_set_indices(to_config_group(target));
 
@@ -955,8 +953,6 @@ static void uvcg_streaming_header_drop_link(struct config_item *src,
 	mutex_lock(&opts->lock);
 	target_fmt = container_of(to_config_group(target), struct uvcg_format,
 				  group);
-	if (!target_fmt)
-		goto out;
 
 	list_for_each_entry_safe(format_ptr, tmp, &src_hdr->formats, entry)
 		if (format_ptr->fmt == target_fmt) {
-- 
2.17.1

