Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27BB379C03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhEKB0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhEKB02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:26:28 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595FCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:25:23 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so3876920ooj.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zrmRKMfhYQdmQyV7QCWBSNSaV4y4nE0vpkcRYPnOKY=;
        b=O+p9+j5uR83S5wiXzYtAJEFdSmojGyo6UvPwWAyrHBP8lKnyYkeXX21XuIGkuVY0n4
         LyCKY6vu5hX8/MbnbNKLyghn9b2BcofRg9jt42foOhv6x9rzYrfB2be5BJoaNaHO65jh
         zwYGcXRX2689+is8CpGQ6rH0t69ybjfJ6EmEgTv9tqHdmf4fHm6wQJRkkKbHZKQsuCv9
         OoNVuIJfFeLMkAOBM23Xgnrca/YTBNRRDdFab3BuZpff1gD/8msjTDVLBaKG8m916K4E
         dQFMdNYjzrwLS0MR5G546jW2zgDGkde7RnFkLM+N/Jp7K4lF8B/qGzT3AqtX7RAz4fkZ
         P9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+zrmRKMfhYQdmQyV7QCWBSNSaV4y4nE0vpkcRYPnOKY=;
        b=XlDkSKNENLWgtw/XH4KeCDZVnHcC13hTHZLprJrcm/HktOFO0vRXyUtFaybv2ya4Qp
         XS+8GGJnwr1Q4IDwHTfEnXqO/xtoggwu4KlnzSuAById++U60cqOGm9trDzlO1+a2s/B
         PEiyysOP949WtjhzcU8CFw42zLYht33f6N0k7OY06RF1MJJTrnhY91LsDVORgoU8+/bu
         m4hiv/8BaU7QDeYPv+6DzcPkljrminOzPmzlZ8WJSB9OKHddzKavS+aLTPNIyHCWuBnp
         bj0OKtXKZWBcNZSR2dbd2kPW8wwuGCe3Jdy2IEVWmcqUU4b9lhxMZwc8LLXsp2WPEgfu
         r5uA==
X-Gm-Message-State: AOAM530T5YiRIeU+dSeawXTbiGXZSGu6OZMzu8XIGeg4AuxXnAM1qjnR
        9CCRBoRx+3zvCbExLSTlwiU=
X-Google-Smtp-Source: ABdhPJxWDhaIHwP0HN4z6UfoNzeZDQ2EcwmZMT7jJBAx7ezhdanL8wgm7NMlueADj45pafaMg02X4A==
X-Received: by 2002:a4a:e644:: with SMTP id q4mr18666874oot.58.1620696322724;
        Mon, 10 May 2021 18:25:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u13sm1921893oop.40.2021.05.10.18.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 18:25:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] s390/hvc_iucv: Drop unnecessary NULL check after container_of
Date:   Mon, 10 May 2021 18:25:19 -0700
Message-Id: <20210511012519.2359074-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of container_of() operations is never NULL unless the extracted
element is the first element of the embedded structure. This is not the
case here. The NULL check is therefore unnecessary and misleading.
Remove it.

This change was made automatically with the following Coccinelle script.

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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/hvc/hvc_iucv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
index 2af1e5751bd6..3bd03ae01bf5 100644
--- a/drivers/tty/hvc/hvc_iucv.c
+++ b/drivers/tty/hvc/hvc_iucv.c
@@ -438,8 +438,6 @@ static void hvc_iucv_sndbuf_work(struct work_struct *work)
 	struct hvc_iucv_private *priv;
 
 	priv = container_of(work, struct hvc_iucv_private, sndbuf_work.work);
-	if (!priv)
-		return;
 
 	spin_lock_bh(&priv->lock);
 	hvc_iucv_send(priv);
-- 
2.25.1

