Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F57453247
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhKPMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKPMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:37:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F94C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:34:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d5so37278023wrc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xb3TVlaOH3XPJ9Opw87QokeP9OXAVcEgjsjxkjzezIk=;
        b=yII4nOsmDxHStIDt/LMAfBW6r0LomDLf7g/3dzRmPJR4iUutnLq9RsmLh/vfYOx3ho
         yu6AzYc2Sz9Su1nXS9jg2VTkavL1rGTD1hpAHmyd/IhdYixUveAepyb7imQz5IJEcIri
         iOobizAyiFPK2W4rHv2u4BYcXAcWBzv/AVtDv+nqoCqYlxXAumBzcteGMGEiR8sGxTgB
         8sFPAPavr7UFV5K/UGadTijYNJ9AG7Uku9l15q90sYcDPNivHVrNXZitnWoMzwpaHogq
         jBa6TvtmfHZq/kVvP7RJzTY3DHDeSl052Kba5ve0gBKS4AM3KV9qeqV3o7ggSiUPRDBJ
         Lpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xb3TVlaOH3XPJ9Opw87QokeP9OXAVcEgjsjxkjzezIk=;
        b=2xHs4aBtg7vDivXWnQg8hsc7hZevCvxjzzH3MAxzJbMI83NNIG1zgkYcbsNeuhWmiG
         6wpfM9BtZKtPAG7WCIcYgw+RecbUqGIlBs1Niwx8BatYOjmAKwSvNnGspt/G+MqhNmCG
         kNIO3grQqD1O9GLIXudGMuO4SsowwfQ0LWtSHETfBynm6nw7G5sVctDuTj2R9a7Pmkyp
         /ZMkAwLFuMLKQ8mkAhk+QSz5WUjvT8zF7TwWfUN0osfv9+G9BH1QZJpkAH4oQwqvxkQz
         hHKADh5TeiS5SMevSIOqQpFQcR8LO0jpTnzo3UcBrwZVc5zMXUivJoIakyk08qktplIi
         cDFQ==
X-Gm-Message-State: AOAM530HPy+68nE06XUxaQwCVm01TNMSE7FjpQO3iq3RWHCerZw2ydMB
        n72sKJIwZ8W+m5jlWgECXlq7Fg==
X-Google-Smtp-Source: ABdhPJxckVDPlqLE9FqD1c+xZBJjVupNMJ9ZfAWX5804dLeeeJcBYcU8Km6M0y9ci5PB0rDYg8ioBA==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr8829083wrx.173.1637066094887;
        Tue, 16 Nov 2021 04:34:54 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f12sm2982140wmq.0.2021.11.16.04.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:34:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] genirq/irqdesc: Add state node to show if IRQ is enabled
Date:   Tue, 16 Nov 2021 12:34:47 +0000
Message-Id: <20211116123447.23902-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging some issues with SoundWire WakeUp interrupt,
I did not find a way to figure out if the interrupt is really enabled
or disabled.

So I have added an new state entry in the sysfs to dump the current
interrupt state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

While debugging I found this patch very useful, specially in SoundWire Wakeup
usecase where we dynamically enable Low Power Wakeup interrupt.

Sending this out, hoping that it will be useful for others as well.

--srini


 Documentation/ABI/testing/sysfs-kernel-irq |  7 +++++++
 kernel/irq/irqdesc.c                       | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-irq b/Documentation/ABI/testing/sysfs-kernel-irq
index 8910d0c4bcd8..d858ed133ba2 100644
--- a/Documentation/ABI/testing/sysfs-kernel-irq
+++ b/Documentation/ABI/testing/sysfs-kernel-irq
@@ -58,3 +58,10 @@ KernelVersion:	4.17
 Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Description:	The wakeup state of the interrupt. Either the string
 		'enabled' or 'disabled'.
+
+What:		/sys/kernel/irq/<irq>/state
+Date:		November 2021
+KernelVersion:	5.16
+Contact:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+Description:	The state of the interrupt. Either the string
+		'enabled' or 'disabled'.
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 2267e6527db3..60c69978ea45 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -265,6 +265,21 @@ static ssize_t actions_show(struct kobject *kobj,
 }
 IRQ_ATTR_RO(actions);
 
+static ssize_t state_show(struct kobject *kobj,
+			  struct kobj_attribute *attr, char *buf)
+{
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+	ssize_t ret;
+
+	raw_spin_lock_irq(&desc->lock);
+	ret = sprintf(buf, "%s\n",
+		      irqd_irq_disabled(&desc->irq_data) ? "disabled" : "enabled");
+	raw_spin_unlock_irq(&desc->lock);
+
+	return ret;
+}
+IRQ_ATTR_RO(state);
+
 static struct attribute *irq_attrs[] = {
 	&per_cpu_count_attr.attr,
 	&chip_name_attr.attr,
@@ -273,6 +288,7 @@ static struct attribute *irq_attrs[] = {
 	&wakeup_attr.attr,
 	&name_attr.attr,
 	&actions_attr.attr,
+	&state_attr.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(irq);
-- 
2.21.0

