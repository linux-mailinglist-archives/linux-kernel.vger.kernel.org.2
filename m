Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E142357492
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348576AbhDGSu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbhDGSu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:50:57 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534AFC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:50:47 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s17so5791095pls.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dqDD41JostnIm+5y/7MqI3OZhpg7yT/Ds6kd9YTd5p8=;
        b=V6qtOQFNTM8SvBnpDbHVJOUk9A/Y1MlH+gwu+i0fp2Uhl4xf6A8Muhkdr6DqS0gyg2
         Lx9z/iXySzVYWIteNxCMtLcJtbJjb4VSlukj3WZr+D6vAcHAzf7FaEu/tus8JSWcI3oP
         uchDpqksWIyKy1kWELyrl81rqPwz9kQaNqE7OCsaKKtuO9SkJ4Fj+lm5mBmPNZ06lHJa
         Rn6Id6s3YyfPoBYU42NfiVBwoBnYLTix3SW9sRq8Uyq4W08jphMfBg0wKeDdnBJKwm1H
         djjkVrPt+iGyExNgSQj4S99PPFRu86IvHk1ybjulSMkx3H/SIsAzupgkQqG1ThOl5cZc
         nMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dqDD41JostnIm+5y/7MqI3OZhpg7yT/Ds6kd9YTd5p8=;
        b=LO2csTZtPZN8NUb0MTwa3lmtZgolWYm8ejL2NQIVB+/sP2Jbzpeunw0PatA4gUr9ob
         fd0J1yJaPDNwxGT/R9lCgokCpFcIWRv/9UiNDZzd8bhsdJxpDiDcwwefW7pQx6TWtK3b
         f9PFS016m0fV+O2FolTQhibcWPwHEK3BV4ougcW2ILjm3Qt/0lWRA1fUy6zcbNAmUxQi
         VweFiR1VaiuZEHT7ZhytOmvUUWr8yLxnzb+CdazwvNGuCmJ3R0F+Lh+mj7nI9Nlmxyjv
         qUSWQ0TQLvK+djYDs4xy7YY9xjOWwCoZF/GbACH5WqSlR1DBxCufSoHrR8k26FFVTGFT
         wLGg==
X-Gm-Message-State: AOAM531dIkf6/w6Kj45L2Noj+1HU0/cghkG3JseN4B5jx0AD3wJrpssY
        kI1jAqzqUtpJfqGflazq7TaYfhVxZ6A=
X-Google-Smtp-Source: ABdhPJwcfgtPigjtbMFrXtAYH7cJZKm/YtGrt45cVvCx8ohPcxcCTAQhVTsdBUYFxOLebvyNwOkBetKj/A0=
X-Received: from legoland2.mtv.corp.google.com ([2620:15c:211:1:c151:20a4:9e4a:b11e])
 (user=varmam job=sendgmr) by 2002:a17:902:c3cb:b029:e9:706a:1a5c with SMTP id
 j11-20020a170902c3cbb02900e9706a1a5cmr2797468plj.58.1617821446775; Wed, 07
 Apr 2021 11:50:46 -0700 (PDT)
Date:   Wed,  7 Apr 2021 11:50:38 -0700
In-Reply-To: <20210407185039.621248-1-varmam@google.com>
Message-Id: <20210407185039.621248-2-varmam@google.com>
Mime-Version: 1.0
References: <20210407185039.621248-1-varmam@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v1 1/2] dt-bindings: i2c: add "dev-name" property to assign
 specific device name
From:   Manish Varma <varmam@google.com>
To:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Manish Varma <varmam@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C devices currently are named dynamically using
<adapter_id>-<device_address> convention, unless they are instantiated
through ACPI.

This means the device name may vary for the same device across different
systems, infact even on the same system if the I2C bus enumeration order
changes, i.e. because of device tree modifications.

By adding an optional "dev-name" property, it provides a mechanism to
set consistent and easy to recognize names for I2C devices.

Signed-off-by: Manish Varma <varmam@google.com>
---
 Documentation/devicetree/bindings/i2c/i2c.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index df41f72afc87..6fb03f464b81 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -130,6 +130,11 @@ wants to support one of the below features, it should adapt these bindings.
 - wakeup-source
 	device can be used as a wakeup source.
 
+- dev-name
+	Name of the device.
+	Overrides the default device name which is in the form of
+	<busnr>-<addr>.
+
 Binding may contain optional "interrupts" property, describing interrupts
 used by the device. I2C core will assign "irq" interrupt (or the very first
 interrupt if not using interrupt names) as primary interrupt for the slave.
-- 
2.31.1.295.g9ea45b61b8-goog

