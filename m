Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944E543A43B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhJYUSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbhJYUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:18:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07684C09801A;
        Mon, 25 Oct 2021 12:48:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id f13so3182743ljo.12;
        Mon, 25 Oct 2021 12:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6/UNYNIHjm7t4tiP18pgCTz3xAVqEfYke7Na0k8ljo=;
        b=kU7W54tUtzut/9cvFKbgJ9BdM6GcufuRgvwAP6bDxT5oA8YMGVdiUqImf91dgIFwMd
         dbCsu3aVz1HndDxCJ3WTgABdUh2IKDjosBWcsvxFXp8VOiqb/GbPKpBGcw9sT2RSIKVW
         eJRpQYJLZJr0Q7eUuOyYxb76ayLcMQipB1pHJbAkF7SRx47rwcm19VYYR8YalimrdtZ/
         zbeFcHDE1hDWck1a++hAmW/vmIU/fWTgDbUfMwp6e3r/0LElmCpFYRHVZUf2qSz7Wx4r
         h4/l9GT6KjOaUYfgCsCBOAsbsOnbSWVnL/dr+ivzk9QfHng89Xjlsmm+TCaoPIvxKdPY
         Ppow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6/UNYNIHjm7t4tiP18pgCTz3xAVqEfYke7Na0k8ljo=;
        b=GMhfRr3kn+vKvFP3mFvLrT29hozYRWOm3v/xGOaYNEnQ/FPLOmHxDgBFfWPwif9nY4
         eUbqCiBSy/Z+Zm/Ax7apCo4fI6ZJomyz5dyHlEkTKKJ5Ldw2BoSEdXZFbJqfqsiXPNKQ
         Bk9Ige23mpDibk3MIFLhQ2JsHdxUzCNTYYPSz/fWUbJ0GHw/vQjlCKl7vqzdIlrcB2HF
         +glyREled/CGgkXz3O506EKIpCUqtCUqE/YHOhSNDTDGS4KDLbQy393FZa7/ou4cp6CZ
         I9luMIwcJrKx5ROnamF7dflzHJ93uVv1ezum4dbxvYspPeaPCU34xFHMF0waXQ+AuRog
         IMtQ==
X-Gm-Message-State: AOAM530hi351ubzRNlI8TmCUJim0UATnQg8RLPq9M0vGadrNQ7DEtak8
        fCQ9/3jYTUgVrYvqeu/dP+Y=
X-Google-Smtp-Source: ABdhPJz1ZC/rh2zacUm33hvGfdZlR0eYAbCe3pTGvZv7wZ+besiYVBpQ5MZ3HyI97y+024snBhMqfg==
X-Received: by 2002:a05:651c:a06:: with SMTP id k6mr21214239ljq.237.1635191295281;
        Mon, 25 Oct 2021 12:48:15 -0700 (PDT)
Received: from localhost.localdomain (46-13-179-94.pool.ukrtel.net. [94.179.13.46])
        by smtp.gmail.com with ESMTPSA id f23sm968984ljn.4.2021.10.25.12.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 12:48:14 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com,
        =?UTF-8?q?Joel=20Wir=C4=81mu=20Pauling?= <jwp@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hwmon: (nct6775) add ProArt X570-CREATOR WIFI.
Date:   Mon, 25 Oct 2021 22:47:48 +0300
Message-Id: <20211025194748.6784-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS ProArt X570-CREATOR WIFI board has got an nct6775 chip, but by default
there's no use of it because of resource conflict with WMI method.

This commit adds ProArt X570-CREATOR WIFI to the list of boards that can be
monitored using ASUS WMI.

Tested on:

```
Base Board Information
    Manufacturer: ASUSTeK COMPUTER INC.
    Product Name: ProArt X570-CREATOR WIFI
    Version: Rev X.0x

BIOS Information
    Vendor: American Megatrends Inc.
    Version: 0402
    Release Date: 08/04/2021

```

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Joel Wirāmu Pauling <jwp@redhat.com>
---
 drivers/hwmon/nct6775.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index f345e1902ad9..93dca471972e 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4986,6 +4986,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
+	"ProArt X570-CREATOR WIFI",
 	"Pro WS X570-ACE",
 	"PRIME B360-PLUS",
 	"PRIME B460-PLUS",

base-commit: c0d79987a0d82671bff374c07f2201f9bdf4aaa2
prerequisite-patch-id: e807e002a40988118b5a99c3a5d7362578e3ed54
prerequisite-patch-id: 9a221a9db6d74526910c26c9b41e34c480105ca3
-- 
2.33.0

