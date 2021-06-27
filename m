Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F343B534F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 14:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhF0NBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 09:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhF0NBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 09:01:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52A4C061766;
        Sun, 27 Jun 2021 05:58:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s137so4077298pfc.4;
        Sun, 27 Jun 2021 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fA84hBdi5Y61f4a0iRh+qsCOjJMAhTeQ0LqXQzqjcYE=;
        b=kEZ/tuMJaZhRd0Shzxehn/w/XJigpaWLtpSKHwxvu6ohAA0HgVDjn91wldLd/jU+0P
         l2t/YFrfqs/ewdL97EW3yItAEW/l5BMgbYdOy9rC/AuzfhafQoOAmONT6mJxuqd7K47s
         Ha7zE3zISV3biQiBGNxsH6++UqQHlpQywH8PqxClW/OEB1/bzbe/S4jUrTeFk6YcWPZ/
         7q9HdbQvnng8meyCQ++U2tTJAo2kSEchmfNQy7sgrCnTceGmfbXIkgATnOpI/OaaMXwp
         uf7q4dcbY896pCLxU+AKcS2sq6wVwpoC13v5ZWWiy5Pihs+AgMYqK22bz5esXqxvcCv0
         5GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fA84hBdi5Y61f4a0iRh+qsCOjJMAhTeQ0LqXQzqjcYE=;
        b=IPxds9Ia+dY0mX0d7UIadWFjJKqCmL7Jvz3xsDq9lph3i6aIWoRL1MD5l04+loWXCk
         NSPAF+Uzn7LTPcC94n8ARW0rkQYmqBaASPU7dgudTvDHuszMdhwXEg4Y12Hd99z7OpGJ
         BuQCBdIo5RW6vbRZMU139nhBhbdVoEQYwotJzayHqu410HEBF6SRXduZogo66sWXzZhR
         AFtwTp+tA7n3TSLtD8/8ILyfn0ki6Svsv/TUXJDYxrjDNPxnBRx+81oZzmxUBLiZZtBP
         wA18udME1WZ23f1GtUzqAoBkntmMjFNgTM6k4XlUCNtyT5XKWT7EL7Gf2q+lr9poUJ5q
         tmPA==
X-Gm-Message-State: AOAM531XL2dFUKBXmJzrDpq9fUvgF1VkWvLrfeMMjtPFdM0+Qbtt6Cc0
        7e1GcW2z5QXZ8CGapxRFqXo=
X-Google-Smtp-Source: ABdhPJzYH1hH4Moa1z4YTuzEbau0wzXnw0FmnuJm62ox8cP9/xjBEoOgPt7f/VpRyDH75+62GBlSHw==
X-Received: by 2002:a63:1a5b:: with SMTP id a27mr18843624pgm.427.1624798723452;
        Sun, 27 Jun 2021 05:58:43 -0700 (PDT)
Received: from localhost.localdomain ([113.76.110.29])
        by smtp.googlemail.com with ESMTPSA id c5sm11270260pfi.81.2021.06.27.05.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:58:43 -0700 (PDT)
From:   Kelly Devilliv <kelly.devilliv@gmail.com>
To:     gregkh@linuxfoundation.org, shubhankarvk@gmail.com,
        lee.jones@linaro.org, gustavoars@kernel.org,
        chunfeng.yun@mediatek.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelly Devilliv <kelly.devilliv@gmail.com>
Subject: [PATCH 3/3] usb: host: fotg210: fix the actual_length of an iso packet
Date:   Sun, 27 Jun 2021 20:57:47 +0800
Message-Id: <20210627125747.127646-4-kelly.devilliv@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210627125747.127646-1-kelly.devilliv@gmail.com>
References: <20210627125747.127646-1-kelly.devilliv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should acquire the actual_length of an iso packet
from the iTD directly using FOTG210_ITD_LENGTH() macro.

Signed-off-by: Kelly Devilliv <kelly.devilliv@gmail.com>
---
 drivers/usb/host/fotg210-hcd.c | 5 ++---
 drivers/usb/host/fotg210.h     | 5 -----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index c38a6c2a8d95..48ff10958d0d 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -4462,13 +4462,12 @@ static bool itd_complete(struct fotg210_hcd *fotg210, struct fotg210_itd *itd)
 
 			/* HC need not update length with this error */
 			if (!(t & FOTG210_ISOC_BABBLE)) {
-				desc->actual_length =
-					fotg210_itdlen(urb, desc, t);
+				desc->actual_length = FOTG210_ITD_LENGTH(t);
 				urb->actual_length += desc->actual_length;
 			}
 		} else if (likely((t & FOTG210_ISOC_ACTIVE) == 0)) {
 			desc->status = 0;
-			desc->actual_length = fotg210_itdlen(urb, desc, t);
+			desc->actual_length = FOTG210_ITD_LENGTH(t);
 			urb->actual_length += desc->actual_length;
 		} else {
 			/* URB was too late */
diff --git a/drivers/usb/host/fotg210.h b/drivers/usb/host/fotg210.h
index 6cee40ec65b4..67f59517ebad 100644
--- a/drivers/usb/host/fotg210.h
+++ b/drivers/usb/host/fotg210.h
@@ -686,11 +686,6 @@ static inline unsigned fotg210_read_frame_index(struct fotg210_hcd *fotg210)
 	return fotg210_readl(fotg210, &fotg210->regs->frame_index);
 }
 
-#define fotg210_itdlen(urb, desc, t) ({			\
-	usb_pipein((urb)->pipe) ?				\
-	(desc)->length - FOTG210_ITD_LENGTH(t) :			\
-	FOTG210_ITD_LENGTH(t);					\
-})
 /*-------------------------------------------------------------------------*/
 
 #endif /* __LINUX_FOTG210_H */
-- 
2.25.1

