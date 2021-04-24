Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD8B36A1B3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhDXOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhDXOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 10:55:25 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B558C061574;
        Sat, 24 Apr 2021 07:54:47 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id m13so52102091oiw.13;
        Sat, 24 Apr 2021 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=7Jv7S/tIrsm0fJNvZH7EY4pSQqJrTN9GdoDBxE/VwTk=;
        b=IolVVn9BlI5HauMGHnjgoszZwPggzUvX6Wxqaa6cdtTawfCrOIFPCjVtVF9Bgkhaw2
         4CbZZ0e57ofes9OjSm1S2Dscdu/JN2nLjqwNVqN+5kiEhhg+yGxn1GIMQEnrsG1m09aX
         02i9l3rXelDnvARc44bXQTzzeZL17Ld784vaEoEDke+WNTWOi4OMeilNwbBU5gSexuEN
         jD4zqxd8SDLfp2dx1n5DVSwSQy/C6eM9xm1duZk8C4BQlckJ4PMOcAmRVXX1/tLY4RJJ
         +Ec/KJxPI+h+GfAznCmCn1mNK6Wf9Fo7wbOxfcmq1UajxHS5HqwxeBDE6N4ctmzMXGUv
         +/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=7Jv7S/tIrsm0fJNvZH7EY4pSQqJrTN9GdoDBxE/VwTk=;
        b=Efl+mY6iodu/GvCQR93pdqJ3AionY6rvswY893iDlbgW4zZdv8M5/pX9ZRu9RmRxHg
         iwu/I6lHENzle4k10KPodXL0JDG0Wn+Jx7xAvIA6rTRxaBYWpIiLMPJXMbjqkJ3L1HG6
         P+birbrUY34ERlCex7ty4ZIsQFLym1xaPwfeSDRHVdZ+aXW4RPz0HWIkE2ihILa4whYO
         EWF2YFv6x9Px8cDUjCzh3p2IKcZrJmKPmm9aP4Mr3jYFjvVGvQ6JKIkNuBnAxp4bqGCV
         Odp/j+iNm7gc4WlvLGVXaoIgZDkQuMTSxaR11XxmuqRYPRDfJsP6tRkC6z3Lz8R49RIZ
         +KEw==
X-Gm-Message-State: AOAM533ZeXuc+yHFb7JJQ47doy0aFBcvZDaUFwjWBuCn0Z2RZCpF9AEZ
        9Akmws7zlC9AReKJBvFA4aJ21gtocCo=
X-Google-Smtp-Source: ABdhPJy0TCNZhkwwYHdqT7N+DixhR6/Huoocr9mQ/nNpc2en1Twtwmbjx+RgOJm3DSgqBq4GHylBqQ==
X-Received: by 2002:a05:6808:14c8:: with SMTP id f8mr7647480oiw.55.1619276086749;
        Sat, 24 Apr 2021 07:54:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2sm2237773ote.47.2021.04.24.07.54.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Apr 2021 07:54:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] usb: gadget: Drop unnecessary NULL checks after container_of
Date:   Sat, 24 Apr 2021 07:54:43 -0700
Message-Id: <20210424145443.170413-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters passed to allow_link and drop_link functions are never NULL.
That means the result of container_of() on those parameters is also
never NULL, even though the reference into the structure points to the
first element of the structure. Remove the unnecessary NULL checks.

This change was made automatically with the following Coccinelle script.
A now obsolete 'out:' label was removed manually.

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
Acked-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Dropped RFC, added Acked-by:, dropped now obsolete 'out:' label

 drivers/usb/gadget/function/uvc_configfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 00fb58e50a15..7775f9902360 100644
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
@@ -968,7 +964,6 @@ static void uvcg_streaming_header_drop_link(struct config_item *src,
 
 	--target_fmt->linked;
 
-out:
 	mutex_unlock(&opts->lock);
 	mutex_unlock(su_mutex);
 }
-- 
2.17.1

