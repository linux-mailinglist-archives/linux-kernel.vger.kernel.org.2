Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1E333220
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhCIX7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 18:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCIX72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 18:59:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46B7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:59:21 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bm21so33149393ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 15:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2WhejGjnK8sMoS/tecepSxoXfkat4NS0mQukaiqpFPg=;
        b=LFrNeDwv6K4d+NLedzn8+BVcb4MafFWClex+hmBtCnQxc0tTaTes7384g+P+DcKfvm
         qKAl4vt3boB1G9l0hje7MTheTXz/+ueGXcPj4QwP3ERd9yGfVBONXqz/bqVxvjhsBjZ/
         IqUpWwPOlLlyfOkE+rwUHyKmaCaQ8527/dG3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2WhejGjnK8sMoS/tecepSxoXfkat4NS0mQukaiqpFPg=;
        b=AL9zeeBPRtZVGW1fQCyivcpKq7o6JLL/q74UeiM0Iy2TBEQ9KEoHwWf06v2Ab0lUmC
         grv6bB+ibTnFSvxvu/X+GmIjSaASjVAyKH0It9jKoumMt/EAhM6m9fzR5fhHFzoB3tr6
         AWI5AINSGDL3KPAJudbGWPT5lnk/zTp2kUASQUZCUlrzWM5LdcXaGcHWmnONJUxvujXe
         2mRUqTf00LJaefnzs6bD22LMdCXBQwO8HVi2OLfzQTtsR/51BNHnY1aNO0CPr2+mWky+
         CtxyP9jO7TTU0lbz+p0STUgVBQr9g9V1TwonUUvsFZZH/vshDOoMJNRS1H6eZF+6Rn+s
         6erg==
X-Gm-Message-State: AOAM533RPSM5dc05cSV9guOfzCjth1V1REDMduLb73D+OKP3YqMCeS+8
        YzB638IA3WWzW5jUvgw9MvOvZw==
X-Google-Smtp-Source: ABdhPJwgf6XutNaTlJB3QXQjqpr0Jlo3XDDztsZoiJnB8nrOHrPT4s9qDEiWZl/+cex/g5M0L+JWkw==
X-Received: by 2002:a17:906:1dc2:: with SMTP id v2mr613660ejh.350.1615334360494;
        Tue, 09 Mar 2021 15:59:20 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id m14sm2045893edr.13.2021.03.09.15.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 15:59:20 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] devres: better type safety with devm_*_action()
Date:   Wed, 10 Mar 2021 00:59:17 +0100
Message-Id: <20210309235917.2134565-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a little MacroMagic(tm), we can allow users to pass a pointer to
a function that actually takes the type of the data argument, instead
of forcing the function to have prototype void (*)(void *). Of course,
we must still accept such functions.

This can provide a little more type safety in that we get fewer
implicit casts to and from void* - as a random example,
gpio_mockup_dispose_mappings in drivers/gpio/gpio-mockup.c could take
a "struct gpio_mockup_chip *chip" directly.

Moreover, when the action is some "external" API, there will in many
cases no longer be a need for a trivial local wrapper -
e.g. drivers/watchdog/cadence_wdt.c could just use
clk_disable_unprepare directly and avoid defining
cdns_clk_disable_unprepare.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/devres.c  | 32 +++++++++++++++++++++++---------
 include/linux/device.h | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index fb9d5289a620..97ebd26bc44a 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -728,15 +728,25 @@ static void devm_action_release(struct device *dev, void *res)
 }
 
 /**
- * devm_add_action() - add a custom action to list of managed resources
+ * __devm_add_action() - add a custom action to list of managed resources
  * @dev: Device that owns the action
  * @action: Function that should be called
  * @data: Pointer to data passed to @action implementation
  *
  * This adds a custom action to the list of managed resources so that
  * it gets executed as part of standard resource unwinding.
+ *
+ * Do not call directly, but use the the macro wrapper
+ * devm_add_action, whose "prototype" is
+ *
+ * devm_add_action(struct device *dev, void (*action)(T *), T *data)
+ *
+ * This allows use of type-correct callbacks and can avoid wrapping
+ * external APIs. For example, if the data item is a "struct clk *", one
+ * can use clk_disable_unprepare directly as the action instead of
+ * creating a local wrapper taking a "void *" argument.
  */
-int devm_add_action(struct device *dev, void (*action)(void *), void *data)
+int __devm_add_action(struct device *dev, void (*action)(void *), void *data)
 {
 	struct action_devres *devres;
 
@@ -751,18 +761,20 @@ int devm_add_action(struct device *dev, void (*action)(void *), void *data)
 	devres_add(dev, devres);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(devm_add_action);
+EXPORT_SYMBOL_GPL(__devm_add_action);
 
 /**
- * devm_remove_action() - removes previously added custom action
+ * __devm_remove_action() - removes previously added custom action
  * @dev: Device that owns the action
  * @action: Function implementing the action
  * @data: Pointer to data passed to @action implementation
  *
  * Removes instance of @action previously added by devm_add_action().
  * Both action and data should match one of the existing entries.
+ *
+ * Use the macro wrapper devm_remove_action, see __devm_add_action for details.
  */
-void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
+void __devm_remove_action(struct device *dev, void (*action)(void *), void *data)
 {
 	struct action_devres devres = {
 		.data = data,
@@ -772,10 +784,10 @@ void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
 	WARN_ON(devres_destroy(dev, devm_action_release, devm_action_match,
 			       &devres));
 }
-EXPORT_SYMBOL_GPL(devm_remove_action);
+EXPORT_SYMBOL_GPL(__devm_remove_action);
 
 /**
- * devm_release_action() - release previously added custom action
+ * __devm_release_action() - release previously added custom action
  * @dev: Device that owns the action
  * @action: Function implementing the action
  * @data: Pointer to data passed to @action implementation
@@ -783,8 +795,10 @@ EXPORT_SYMBOL_GPL(devm_remove_action);
  * Releases and removes instance of @action previously added by
  * devm_add_action().  Both action and data should match one of the
  * existing entries.
+ *
+ * Use the macro wrapper devm_release_action, see __devm_add_action for details.
  */
-void devm_release_action(struct device *dev, void (*action)(void *), void *data)
+void __devm_release_action(struct device *dev, void (*action)(void *), void *data)
 {
 	struct action_devres devres = {
 		.data = data,
@@ -795,7 +809,7 @@ void devm_release_action(struct device *dev, void (*action)(void *), void *data)
 			       &devres));
 
 }
-EXPORT_SYMBOL_GPL(devm_release_action);
+EXPORT_SYMBOL_GPL(__devm_release_action);
 
 /*
  * Managed kmalloc/kfree
diff --git a/include/linux/device.h b/include/linux/device.h
index ba660731bd25..c924612bfefd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -250,11 +250,39 @@ void __iomem *devm_of_iomap(struct device *dev,
 			    resource_size_t *size);
 
 /* allows to add/remove a custom action to devres stack */
-int devm_add_action(struct device *dev, void (*action)(void *), void *data);
-void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
-void devm_release_action(struct device *dev, void (*action)(void *), void *data);
 
-static inline int devm_add_action_or_reset(struct device *dev,
+/*
+ * +0 forces the expression to decay to a function pointer. We cannot
+ * just put an & in front as callers may already include that.
+ */
+#define devm_action_typecheck(action, data)				\
+	static_assert(__same_type(action + 0, void (*)(void *)) ||	\
+		      __same_type(action + 0, void (*)(typeof(data))))
+
+#define devm_add_action(dev, action, data) ({				\
+	devm_action_typecheck(action, data);				\
+	__devm_add_action(dev, (void (*)(void *))action, data);		\
+})
+#define devm_remove_action(dev, action, data) ({			\
+	devm_action_typecheck(action, data);				\
+	__devm_remove_action(dev, (void (*)(void *))action, data);	\
+})
+#define devm_release_action(dev, action, data) ({			\
+	devm_action_typecheck(action, data);				\
+	__devm_release_action(dev, (void (*)(void *))action, data);	\
+})
+
+
+int __devm_add_action(struct device *dev, void (*action)(void *), void *data);
+void __devm_remove_action(struct device *dev, void (*action)(void *), void *data);
+void __devm_release_action(struct device *dev, void (*action)(void *), void *data);
+
+#define devm_add_action_or_reset(dev, action, data) ({			\
+	devm_action_typecheck(action, data);				\
+	__devm_add_action_or_reset(dev, (void (*)(void *))action, data); \
+})
+
+static inline int __devm_add_action_or_reset(struct device *dev,
 					   void (*action)(void *), void *data)
 {
 	int ret;
-- 
2.29.2

