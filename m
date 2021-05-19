Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2443893D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355271AbhESQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347677AbhESQfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:35:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0BFC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:34:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x8so14686274wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WpqqP6537736a2OzxAlJTOI8CA6Qys9ck/zh1D88FmE=;
        b=iWZHK636JJHYnCEG73oqmCSe5jmvAE0eA4OqRKHeitAMk3KgZNYajHkpzU4n+m6gzM
         0V2AIpEangf8ShkdL2t1u7tQjlaUw2Cx00XMUdLYLpwqEji4DiTRS1wFys6k+F74Y+fM
         teedjYZbvVg8PHjrRRbNZ5k00DAxBiuI4uS4fZGn+vu1TH8kpgbO0yEXFYkxSLZKJFcG
         XQ3uUB1yWGZyBMpm3Ql40+XzBp0Rd2UqvlQsd6fwp2FN44R/NIBzRDjehAMMW+Ly7ORw
         vppexeV8yOjl7gMuZB25w1w2XCxBeMnYnQ29T/okV/ABaf0kj8em6vS1212pHZnHEu5M
         QRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WpqqP6537736a2OzxAlJTOI8CA6Qys9ck/zh1D88FmE=;
        b=hygyjupeBVCnLiYVbHulvNoxfTbLmVORwHVjeSpc/VPY4wHOtVJ+o3CFwnwWGQgYoP
         2zlZUfl+dYUT/5q3XTKpcLQaBZJXGxUiOVNTYKhwObvJHceE6oNqzi+P09zcXkuRqqVq
         H9SZ4tw6nYpIU440J5JjRqURnGyTKHKwv4U016pt7hEW6+4+eyTp0PFaDkpolYdge3KK
         mZJvh3y4LcdKd3Aas+KVUzaIY/DTe8UfyexkCMl78nbO28rp/aXGu6LcV2p3vOZEpgLs
         W87L+5HkEqo0h6SanxkuuOc6JrvEWBdvSdvzTsy7xnOCA547qWSImWQSSOVSAceM6QaW
         DYXQ==
X-Gm-Message-State: AOAM5313Z4lZDqXb7nZMQ/Y1RbuU3KhtE0JmhE9P09h3tn5WbsKLfxkb
        baYFR78bYzkay5yL5SCdSwxzYDiWnMUXVA==
X-Google-Smtp-Source: ABdhPJxL9808uzmXtce5RexuNcH4aaVMcFHNvQ+vSGpLfNeS8AS8XuB8ZW+QLBnwmBh19U7gKIV60w==
X-Received: by 2002:adf:f54b:: with SMTP id j11mr10292031wrp.376.1621442070754;
        Wed, 19 May 2021 09:34:30 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:e5dc:6577:6b94:e9e7? (p200300ea8f384600e5dc65776b94e9e7.dip0.t-ipconnect.de. [2003:ea:8f38:4600:e5dc:6577:6b94:e9e7])
        by smtp.googlemail.com with ESMTPSA id d9sm24583522wrx.11.2021.05.19.09.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:34:30 -0700 (PDT)
Subject: [PATCH 1/2] sysfs: Add helper BIN_ATTRIBUTE_GROUPS
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
Message-ID: <e20db248-ed30-cf5d-a37c-b538dceaa5b2@gmail.com>
Date:   Wed, 19 May 2021 18:33:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New helper BIN_ATTRIBUTE_GROUPS() does the same as ATTRIBUTE_GROUPS(),
just for binary attributes.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/sysfs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index d76a1ddf8..a12556a4b 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -162,6 +162,12 @@ static const struct attribute_group _name##_group = {		\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 
+#define BIN_ATTRIBUTE_GROUPS(_name)				\
+static const struct attribute_group _name##_group = {		\
+	.bin_attrs = _name##_attrs,				\
+};								\
+__ATTRIBUTE_GROUPS(_name)
+
 struct file;
 struct vm_area_struct;
 struct address_space;
-- 
2.31.1


