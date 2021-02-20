Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C46A32069E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 19:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBTSXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 13:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTSXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 13:23:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A61C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 10:22:51 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t9so965907pjl.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 10:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zt+f+ZZ7AgqTp/T9NQYJE8WcutGO9R85KYcRUCR8J68=;
        b=ldrCucySxPeGTMKsmTb0Wj3/r91FMrM3ot+J8doXhYLiOHTvErZeFkIRRktxscPynU
         NDTabqWIgnFM+5/831kTYpheow2Oj67e7lmUTMwgZv2+czIHDCYelK4zpCJkSWX4Sr5n
         VplmXfVjhBe6NcmaFULUEOLIa8xl3lZszyV+Qt7fos88kUSkRON8Jk1eFsH+67OkbE2Q
         SQgsRn13IcmvbL9yDrR/twCDldXltrJMKZX5EnLrdsOEvOuXh1fCBKbHFiKl79qnfthV
         5JjZq/ewAimpDJisbrLJ7Bqp7m1VZX7WBPICQHjaViSM06//mpXfOTY3CXxkB32TYI+Z
         R9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zt+f+ZZ7AgqTp/T9NQYJE8WcutGO9R85KYcRUCR8J68=;
        b=RJUzRKkdxF1MBSfjN4NkTjIkz48OGnmbNYz00+K6meoIYYX24etmAUqnvZ3jcki8si
         os0v8rRdL2Yd6pvXU8Z7fc8iAXCUxgrDeVdwInrfyalyANhNzNpJcswOyJty5q1BF842
         p5d91BeeMLxfC6rV2QZvKuIkSURH8MTb/rLWhPYu6YdMwjTKHUwFq5+jbtuvbLP+yP5O
         bNX4ayKEIFqYDw5GZAUdEr6RkQ/ibQ4tmTKvdaC8SPbcqYYI9nHIvUYGWjWfGM6+FAKe
         raBAEHMEeoy3OgfBN3Rbpiesv451DH4FiSQWVehTdGwcR/kQzjoSZOco+az7t3IcXg/4
         y/+g==
X-Gm-Message-State: AOAM530SZtwm76htmMWN6oaB9PWoiCw9OxKkKZTrlVaayC5EwJ115r5e
        Ncs0j8N+i0hQdfXhfeKV2qU=
X-Google-Smtp-Source: ABdhPJxnHG8/3hVLnIqwCf72FVVXGEeuFtOVI1OLuUuo+tE5pGoRhhpVMftIwPrAmVcTkdIlvTVgow==
X-Received: by 2002:a17:902:ce86:b029:e3:c3e6:59e4 with SMTP id f6-20020a170902ce86b02900e3c3e659e4mr7851906plg.67.1613845370394;
        Sat, 20 Feb 2021 10:22:50 -0800 (PST)
Received: from localhost.localdomain ([106.200.44.186])
        by smtp.gmail.com with ESMTPSA id j34sm12461018pgi.62.2021.02.20.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 10:22:49 -0800 (PST)
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gustavo@embeddedor.com, tiwai@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Atul Gopinathan <atulgopinathan@gmail.com>
Subject: [PATCH 1/2] staging: rtl8192e: Pass array value to memcpy instead of struct pointer
Date:   Sat, 20 Feb 2021 23:51:53 +0530
Message-Id: <20210220182154.9457-1-atulgopinathan@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable "info_element" is of the following type:
struct rtllib_info_element *info_element

rtllib_info_element is a struct containing the following fields as
defined in drivers/staging/rtl8192e/rtllib.h:

struct rtllib_info_element {
        u8 id;
        u8 len;
        u8 data[];
} __packed;

The following code of interest (to which this patch applies) is
supposed to check if the "info_element->len" is greater than 4 and
equal to 6, if this is satisfied then, the last two bytes (the
4th and 5th index of u8 "data" array) are copied into
"network->CcxRmState".

Currently the code uses "memcpy()" with the source as
"&info_element[4]" which would copy in wrong and unintended
information.

This patch rectifies this error by using "&info_element->data[4]" which
rightly copies the last two bytes as the required state information.

Signed-off-by: Atul Gopinathan <atulgopinathan@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 66c135321da4..15bbb63ca130 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1963,15 +1963,15 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 
 	if (info_element->len > 4 &&
 	    info_element->data[0] == 0x00 &&
 	    info_element->data[1] == 0x40 &&
 	    info_element->data[2] == 0x96 &&
 	    info_element->data[3] == 0x01) {
 		if (info_element->len == 6) {
-			memcpy(network->CcxRmState, &info_element[4], 2);
+			memcpy(network->CcxRmState, &info_element->data[4], 2);
 			if (network->CcxRmState[0] != 0)
 				network->bCcxRmEnable = true;
 			else
 				network->bCcxRmEnable = false;
 			network->MBssidMask = network->CcxRmState[1] & 0x07;
 			if (network->MBssidMask != 0) {
 				network->bMBssidValid = true;
-- 
2.27.0

