Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB1B444CED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhKDBRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhKDBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:17:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4B1C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 18:15:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b13so4563671plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 18:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pg0zPJRWlVVMJp3FcD2PtNMkF9ls43+k2Njro2lpjXE=;
        b=p3l/JuOs6JibswuOWXbf72RJHPQYi9hszQygen8Cpfr/onDxBmmVPXqW/R2Txhn648
         Dc8abgTtHXIppQIcBSfjMpGS/vHf/epRE0tPrWP34uBpSA5r9o+S5Zaa+egoGNPLK/xb
         ChZHpQsRxsKTNJD/G7vUynYxKsK6kyJzJ6QVDV+gIKJnCS3TIYX6Fofj7D+MW7ZABxCu
         LnetaFF1lMpZKGmZt+jncsKnVK7PqMAUgrnjvA9xV0t+wetbayYDMljkcLrIy649AdWM
         S9Nxm1nDkIumuaXRfLA8PTLrIt59Iml5jCWQsxd5Qw/oMk0OBOJQ6feC3IYGnWMOk8Ky
         aLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pg0zPJRWlVVMJp3FcD2PtNMkF9ls43+k2Njro2lpjXE=;
        b=sU99FT/G3fKJ0n8AZmo4buEb3RK5D6SwmhZ4ddYzcEuB22e8j659JkYYtfTNmhR8/D
         YMUFLQ2twn5Tlw5SOCoEu1lSFG/aLhSXrMMXHzw9WOeU2towL61EPJDNhuzOOh1B4zuf
         gfQs2OZUjsXrOp1dsHTC0fxD0E4PpVdHBpx3tpIoyQovXONlxomBZvP22jd6viiFfA+D
         egaKx7vhstehq7VIZVoyXEgmKAlPeF3B5SKdHeq4F0Nl5x+zsjzUf45rGqwuAnFfRiOX
         yVxLifIRwKOcfqaXsf9EHv1zsHeaUSDWLyKhE0mkzEEAfu58VS6tDlf3GCEuktN5Ckx5
         PNmA==
X-Gm-Message-State: AOAM530tAtVVLSnAnpjS1pyq5nDDcQBpl8T8mU9jnHS1CMkuecak2Pcx
        2HKA1ppTM5yA0x8uOOVm4Nk=
X-Google-Smtp-Source: ABdhPJxRgGQGeB3ZR4j/bxRyMBbKyh8C70dDm9soOjccS/9wDvZ8U9RIwf0MH7qjybLQoWtAHmJHkw==
X-Received: by 2002:a17:90b:33ca:: with SMTP id lk10mr10788629pjb.18.1635988506390;
        Wed, 03 Nov 2021 18:15:06 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id h6sm366407pfg.128.2021.11.03.18.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 18:15:06 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     linuxppc-dev@lists.ozlabs.org
Cc:     davidcomponentone@gmail.com, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, yang.guang5@zte.com.cn
Subject: [PATCH] use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 09:14:56 +0800
Message-Id: <20211104011456.1027830-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/macintosh/adbhid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index 994ba5cb3678..379ab49a8107 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -817,9 +817,7 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 		case 0xC4: case 0xC7:
 			keyboard_type = "ISO, swapping keys";
 			input_dev->id.version = ADB_KEYBOARD_ISO;
-			i = hid->keycode[10];
-			hid->keycode[10] = hid->keycode[50];
-			hid->keycode[50] = i;
+			swap(hid->keycode[10], hid->keycode[50]);
 			break;
 
 		case 0x12: case 0x15: case 0x16: case 0x17: case 0x1A:
-- 
2.30.2

