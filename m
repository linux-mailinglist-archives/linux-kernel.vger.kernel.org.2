Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9963F3A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 14:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhHUMNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 08:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHUMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 08:13:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8ECC061575;
        Sat, 21 Aug 2021 05:12:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w4so20395571ljh.13;
        Sat, 21 Aug 2021 05:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pWm+SXTgQ6Ye71KEJYrX8x4GdkySoQhJ1rIbykcEo+8=;
        b=PdP+FH0V3HehypF44h9BTbNRXagbI8NQNesGa1I8ZVFYZPAcDWzTJE2xucd63ht4+k
         L+Sm2L/Wlzx5wAE/Yy6TZtmGDMEGVfeOedQ1tTm0+fgRmo95U2nu94lusFnvvatXkk55
         VMu5HEmvzp4BAYMshEri4nZi1dSjsdMfZpkthNEaJoQQ/L3w/nSqg9E2UVVq0YS5hcJz
         QuTv/RDadePY6PlhoQ20lDtQ5M7+S5Rc3qVO9bG68hh+p7OyibiBFu702T6FdpvW4UQE
         K1xF2fLZuDv1JY0dBhLl1MK5X5/jknYa3lleWtBovCuCnbRDvRV6T8pXwif4BtlhE6QM
         7O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pWm+SXTgQ6Ye71KEJYrX8x4GdkySoQhJ1rIbykcEo+8=;
        b=IFU/MBEdqOc+DbHmLQnLQIuqFn56CW4vXfZzKaySeRKXWCFo7PYcVtigaLIJjzNDVM
         ghqfIWeQKXP4LBGc5p61KL5Nx0/OnT9M+kg//W3o9TJrqXX/Obc3BDHc4IXXnn9IftfL
         RCj2jxWVroPWMPZJRWfAnejJ+nkiZUtJVPD9ebUr5L57pLXYzDgjwyX0GH4PL0Dqsgrw
         b2YzuJwODUo58JupRGQz6UZqKzp7twuqxb1sX12hRwx6nmCLt2nEGcfP3vQVSTn06G3H
         mlxi2GT0E1EGYlnc7w7bix54MM4aBpxXRAKtPFWnhhoBORBqUhRAHnyLv8CKDwCdh848
         O4bw==
X-Gm-Message-State: AOAM533ty7bYdOoT1VDIJYwygI0vPxCGOkZXbImyqJxZLMQZLs4VPLHS
        d7J7WWT9NYRpk7L534bi6Bq4tqG9IIKnRLdn
X-Google-Smtp-Source: ABdhPJxzpXGpfr6mM+l1iD9N4mn5klFS4XearVaT6UBA181MqbAgcDLRPpOff+u9pa0lw0HABapafQ==
X-Received: by 2002:a2e:7c0a:: with SMTP id x10mr19613907ljc.340.1629547968108;
        Sat, 21 Aug 2021 05:12:48 -0700 (PDT)
Received: from localhost.localdomain (h-62-63-208-27.A230.priv.bahnhof.se. [62.63.208.27])
        by smtp.googlemail.com with ESMTPSA id bp18sm564914lfb.201.2021.08.21.05.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 05:12:47 -0700 (PDT)
From:   Niklas Lantau <niklaslantau@gmail.com>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org,
        Niklas Lantau <niklaslantau@gmail.com>
Subject: [PATCH] Usb: storage: usb: removed useless cast of void*
Date:   Sat, 21 Aug 2021 14:11:34 +0200
Message-Id: <20210821121134.23205-1-niklaslantau@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed useless cast of a void* and changed __us to data

Signed-off-by: Niklas Lantau <niklaslantau@gmail.com>
---
 drivers/usb/storage/usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac..e78e20fb1afa 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -295,9 +295,9 @@ void fill_inquiry_response(struct us_data *us, unsigned char *data,
 }
 EXPORT_SYMBOL_GPL(fill_inquiry_response);
 
-static int usb_stor_control_thread(void * __us)
+static int usb_stor_control_thread(void *data)
 {
-	struct us_data *us = (struct us_data *)__us;
+	struct us_data *us = data;
 	struct Scsi_Host *host = us_to_host(us);
 	struct scsi_cmnd *srb;
 
-- 
2.33.0

