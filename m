Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5438F426
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhEXUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhEXUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C030CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so11570103wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qbgSjbvrbxhtC8nx3czLHv/MpkGXO3a+wE2kpb4lGLM=;
        b=V7jQ5uuhISIKSTQykRCrXLx46TDr26Df+7x6sEsK+vQ1EfSvSWyk3dKhxP3F5zzW8s
         +KTi6ZpGrQ8Hd31aWQ1QeRodj5UIK54iJ74cw9haghCTowdnb6p9WRiostiYhbUy8mfT
         Q4G+SOJYsTO/y6N6AjNbQ+Kq6E4CME2ofCAfAcnZp4IUG96TmWPFasyaF5frca+fuaL8
         vruWmTJm6IKyYwhVZyPySzfmyL2G0oSwKzTQnNFISsz0SrqlizksSZ2yPg7metPvBFHM
         UOUERnz2EulBgIU6BsBaEN3Li00ICdTZe2nZP0FOYNH+ybx5KTcXFIVEgnG01xru0LDs
         Im5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbgSjbvrbxhtC8nx3czLHv/MpkGXO3a+wE2kpb4lGLM=;
        b=MThXtySRkD6s6BfdNtsZX75DiGsq+08ochmUIH/MHJZMrvQ1xrjv4oKt3zcL5ppUVI
         CfL7NucePpwfWPKAu6zNmDtyU62Qt60h7suX0+9QisbxxsHRjCpf/7JQtIJDi3wsldQV
         LJesItgFhjxCf9NJgPwEeLvwF9Jl0Wy7bBD0pjFyQ+PpCh4emcoFk3fmbOPf5fjYHgHc
         0OBJkYaGLLD5OnTf/WfzzVJxgDTIz2jFpg59lTmq3tsSR2bTaf/e8jb6oZABkayJSXT5
         5wilAXrE2aENJeSa28UIJzToxV3mIG4uab93WWlR/0zujEPPDMjcCR7ygNcbJ2JXlpbm
         Aecw==
X-Gm-Message-State: AOAM532FbEq/XOipzfbwCE8WSIDeUCXzDED1KRgOFH7E5faV5RTVrwZx
        8O6xvDX90tcrc+9AQqmkLKktrrFoeYI=
X-Google-Smtp-Source: ABdhPJzwNanWCYgHeYooqUZUyvqJQhCvK6ABJicwHdFHtlmAVCZeLV/PNlKQQK3JYym9tlyFcTpLeg==
X-Received: by 2002:a05:600c:284:: with SMTP id 4mr20963081wmk.88.1621887517032;
        Mon, 24 May 2021 13:18:37 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id f20sm10000154wmh.41.2021.05.24.13.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:18:36 -0700 (PDT)
Subject: [PATCH 01/13] eeprom: ee1004: Use kobj_to_i2c_client to simplify the
 code
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <4ae57f09-b803-6ae3-c734-87e733a56eb8@gmail.com>
Date:   Mon, 24 May 2021 22:08:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to helper kobj_to_i2c_client() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 0950d4d9d..0613a5300 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -93,8 +93,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 			   struct bin_attribute *bin_attr,
 			   char *buf, loff_t off, size_t count)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = kobj_to_i2c_client(kobj);
 	size_t requested = count;
 	int page;
 
-- 
2.31.1


