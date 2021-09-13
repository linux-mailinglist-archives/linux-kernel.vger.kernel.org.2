Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAEA408A30
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbhIMLaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbhIMLai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:30:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDCBC061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:29:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so6237206pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfoENClijP5gdD7xuDkNBoWdUfMDgkyOc6qJ1KAohPY=;
        b=oL+KovyrKNkgVbEbUGhoxjNyuI9WEEKCZaHmtKaUZti3DYBGsD74ZfLqoCwDyw+6sZ
         fwKowR+Wq2IUjOJ6eUuWLrnNSbpu1AN011zm/U9jAlQwgOffXn6iVFzCi5JYkzIA8AM3
         SVYedHa4qsl9UIxjpHFNGtK0F0/AQAh5ObYkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfoENClijP5gdD7xuDkNBoWdUfMDgkyOc6qJ1KAohPY=;
        b=zpAFYvVOvKscvapFzukqP6eRXWs6wVGZUB9b9d3HaTJbctY567FPVUZOV5pTgRzraT
         RWDYtWlENXnDg5FN8lpEgLtvXlKkZT5T/dlrQMSdHVWwAYCcmkBYX4A3m3PFrWwQGB+8
         jnHMuEFMmuM/J8zD2+qc4jclFFN4c9YOZO6v8OdZnfwvZfnwHUK7zQv4Izsny+sTIWcv
         atzOHTitLQupSGFBLvfpU1b0WMkvO6rC1uUvkOeje9/CLXlTGqS8clyOrUQpLL6kpZH/
         SzsnvIQ2niomor//lM7eFaJIkcKej20wb53or11gZpH8VeYPd4BfxobvWnaZ7+y0NiCP
         pvLQ==
X-Gm-Message-State: AOAM531vWlc+Dd6h4hGNiGmNZ3jqjbrnUHSX6Vm1N8zxnbmBkbpgGqni
        IkvUIzWrXN/+h/VJVwzpOyuIAmlVOM7WSA==
X-Google-Smtp-Source: ABdhPJzT/5yaxY/5ENcuHbT99u6Tv7Ca3HYaaLWiHKmqVJiUmD6xN/KRcpkRjXjl6mHAoqlTnrv7kQ==
X-Received: by 2002:a17:90a:1982:: with SMTP id 2mr12341017pji.112.1631532562068;
        Mon, 13 Sep 2021 04:29:22 -0700 (PDT)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id z8sm6650000pfa.113.2021.09.13.04.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:29:21 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     jic23@kernel.org, lars@metafoo.de, jmaneyrol@invensense.com,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: Mark acpi match table as maybe unused
Date:   Mon, 13 Sep 2021 20:29:13 +0900
Message-Id: <20210913112913.2148026-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building kernels without ACPI support the table is declared
but is not used because ACPI_PTR() turns it into a NULL.

Add the __maybe_unused attribute to stop the compiler whining.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
Ignore the first version. I'm an idiot and generated a patch,
check that it worked, noticed it didn't, fixed it up and then
forgot to regenerate the patch before sending it.

 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 95f16951c8f4..3ef17e3f50e2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -249,7 +249,7 @@ static const struct of_device_id inv_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
 
-static const struct acpi_device_id inv_acpi_match[] = {
+static const struct acpi_device_id __maybe_unused inv_acpi_match[] = {
 	{"INVN6500", INV_MPU6500},
 	{ },
 };
-- 
2.33.0

