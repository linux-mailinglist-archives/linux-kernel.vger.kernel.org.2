Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF342387AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbhEROJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244785AbhEROJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:09:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE0FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:07:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v6so11727536ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ow2wyNdh8+R7ARRDomTcJEbmQCdAIpt9ovmT4PgzrPU=;
        b=Suu9SlFUO1cccxn8PAskTRJbdD6hSPAOTK4UAG0SmfQlJI+nzEU7uqN2NjZ7V+fz7o
         RQ/VOep7gSNjAInEkwjhMu2Er5AnRBUJW7RI7yPJ8PTJ6wUjaUyx4aghAWtCGtnWwNDi
         fWZ6NSoE5o36QgwZZtmkfV7vucmdGYMLEpJEuJNKBs/odLqB6Pb1zn7c/xlU7qBzYXOg
         YTHEUYlJ/ILfe+0tY8euHToUNxQWSWk5ubU9BL5AweXX0UfgaMAJu1kPmRZORAnOezj7
         xwpcjN146ubr6jEabSoCXIIIRvRBkQxVNw90ugRt245wYCrVb3OodSdDa76pgpS4CUSf
         8GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ow2wyNdh8+R7ARRDomTcJEbmQCdAIpt9ovmT4PgzrPU=;
        b=Szu0Uod8whY6AGAjVC/fSFN9hZIqGsE8ets4kq+b31xyavXYK9k8jQWT9+hPKOOkV+
         MqUEMKuHT1uGxABUTDSMiDqUgepOmxMCwaieBqPhSawU8ETzFctYrfrSJmtDJ3qrmgWu
         9s1I7ZNyYk2TGKOqPuQF19JD5lncy26cCDweUNh6hOtD4STr2CxL1j8569c6U+zCgfbe
         hsQetPq7OhkAdFT4SaPcJuODGr+heMT5oCZKcNhHHPSn6EKnpDyU6j3dkK5ad06aoDMt
         j1Nja/qO/Lv+UzEsUXKSHBkWWnJcDDaFY55ubz97osVInvy8EXwcK0ad/jVhcgs8VVxf
         Kv3g==
X-Gm-Message-State: AOAM532+D7mItwaZhebyPf70pzpj3xUVa6uofQc8JqpE2wCZ87r10/JJ
        eO/av/J9WpJoQSBbvFzgH10g3g==
X-Google-Smtp-Source: ABdhPJzbJcXoc7QDCM7Cj6m32IgC47xj05fl/UacJqsf0szAy8dR6eken7FJz9gqDBV6rWp8y6CExA==
X-Received: by 2002:a2e:b5a7:: with SMTP id f7mr4239030ljn.509.1621346862067;
        Tue, 18 May 2021 07:07:42 -0700 (PDT)
Received: from pdkmachine.localdomain (91-123-191-9.gigainternet.pl. [91.123.191.9])
        by smtp.gmail.com with ESMTPSA id a26sm904940lfi.255.2021.05.18.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:07:41 -0700 (PDT)
From:   Patryk Duda <pdk@semihalf.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, Patryk Duda <pdk@semihalf.com>
Subject: [PATCH v2] platform/chrome: cros_ec_proto: Send command again when timeout occurs
Date:   Tue, 18 May 2021 16:07:58 +0200
Message-Id: <20210518140758.29318-1-pdk@semihalf.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210518090925.15480-1-pdk@semihalf.com>
References: <20210518090925.15480-1-pdk@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes kernel is trying to probe Fingerprint MCU (FPMCU) when it
hasn't initialized SPI yet. This can happen because FPMCU is restarted
during system boot and kernel can send message in short window
eg. between sysjump to RW and SPI initialization.

Cc: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Patryk Duda <pdk@semihalf.com>
---
Fingerprint MCU is rebooted during system startup by AP firmware (coreboot).
During cold boot kernel can query FPMCU in a window just after jump to RW
section of firmware but before SPI is initialized. The window was
shortened to <1ms, but it can't be eliminated completly.

Communication with FPMCU (and all devices based on EC) is bi-directional.
When kernel sends message, EC will send EC_SPI* status codes. When EC is
not able to process command one of bytes will be eg. EC_SPI_NOT_READY.
This mechanism won't work when SPI is not initailized on EC side. In fact,
buffer is filled with 0xFF bytes, so from kernel perspective device is not
responding. To avoid this problem, we can query device once again. We are
already waiting EC_MSG_DEADLINE_MS for response, so we can send command
immediately.

Best regards,
Patryk
v1 -> v2
- Removed message about timeout
 drivers/platform/chrome/cros_ec_proto.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index aa7f7aa77297..a7404d69b2d3 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -279,6 +279,15 @@ static int cros_ec_host_command_proto_query(struct cros_ec_device *ec_dev,
 	msg->insize = sizeof(struct ec_response_get_protocol_info);
 
 	ret = send_command(ec_dev, msg);
+	/*
+	 * Send command once again when timeout occurred.
+	 * Fingerprint MCU (FPMCU) is restarted during system boot which
+	 * introduces small window in which FPMCU won't respond for any
+	 * messages sent by kernel. There is no need to wait before next
+	 * attempt because we waited at least EC_MSG_DEADLINE_MS.
+	 */
+	if (ret == -ETIMEDOUT)
+		ret = send_command(ec_dev, msg);
 
 	if (ret < 0) {
 		dev_dbg(ec_dev->dev,
-- 
2.31.1.751.gd2f1c929bd-goog

