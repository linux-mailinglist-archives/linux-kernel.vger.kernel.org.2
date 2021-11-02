Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A13B442C7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhKBL2s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Nov 2021 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhKBL2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:28:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6BC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:26:12 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhrve-0001ZK-MB; Tue, 02 Nov 2021 12:26:10 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhrve-0048Qf-00; Tue, 02 Nov 2021 12:26:10 +0100
Message-ID: <4beea5f252b056ba21f5e447e78cca17fbbf0e88.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: Add GPIO-based reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 02 Nov 2021 12:26:09 +0100
In-Reply-To: <4303204a-12a0-e81b-395e-14b3dc7f64ee@seco.com>
References: <20211018234923.1769028-1-sean.anderson@seco.com>
         <20211018234923.1769028-2-sean.anderson@seco.com>
         <4303204a-12a0-e81b-395e-14b3dc7f64ee@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Mon, 2021-10-25 at 14:17 -0400, Sean Anderson wrote:
[...]
> ping?
> 
> Philipp, should I be CCing anyone else? MAINTAINERS only lists you and vger...

That is still correct. Maybe it is time to request a dedicated reset
driver mailing list for better visibility.

I was on vacation for a bit, but thankfully Rob already pointed you in
the right direction. I would like this to live in the core and continue
to use the established reset-gpios bindings.

I'm not sure whether adding a full reset_controller_dev for GPIO resets
is necessary. Maybe there is a good reasond for it, but I found adding a
gpio_desc pointer to struct reset_control and implementing non-shared
GPIO resets in the core would be trivial - I prototyped this at some
point (untested, see below).

To support shared resets, the already requested gpio_desc would have to
be found and used to retrieve the corresponding requested reset_control
from a list. This could probably be achieved by exporting gpiod_find()
from gpiolib.

----------8<----------
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 61e688882643..b82acb38deb5 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -7,6 +7,8 @@
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -26,6 +28,8 @@ static LIST_HEAD(reset_lookup_list);
  * struct reset_control - a reset control
  * @rcdev: a pointer to the reset controller device
  *         this reset control belongs to
+ * @gpio: a pointer to the gpio_desc controlling the
+ *        reset line, alternative to rcdev and id.
  * @list: list entry for the rcdev's reset controller list
  * @id: ID of the reset controller in the reset
  *      controller device
@@ -41,6 +45,7 @@ static LIST_HEAD(reset_lookup_list);
 struct reset_control {
 	struct reset_controller_dev *rcdev;
 	struct list_head list;
+	struct gpio_desc *gpio;
 	unsigned int id;
 	struct kref refcnt;
 	bool acquired;
@@ -330,7 +335,8 @@ int reset_control_reset(struct reset_control *rstc)
 	if (!rstc)
 		return 0;
 
-	if (WARN_ON(IS_ERR(rstc)))
+	if (WARN_ON(IS_ERR(rstc)) ||
+	    WARN_ON(rstc->gpio))
 		return -EINVAL;
 
 	if (reset_control_is_array(rstc))
@@ -458,7 +464,14 @@ int reset_control_assert(struct reset_control *rstc)
 
 		if (atomic_dec_return(&rstc->deassert_count) != 0)
 			return 0;
+	}
+
+	if (rstc->gpio) {
+		gpiod_set_value(rstc->gpio, 1);
+		return 0;
+	}
 
+	if (rstc->shared) {
 		/*
 		 * Shared reset controls allow the reset line to be in any state
 		 * after this call, so doing nothing is a valid option.
@@ -551,6 +564,11 @@ int reset_control_deassert(struct reset_control *rstc)
 		}
 	}
 
+	if (rstc->gpio) {
+		gpiod_set_value(rstc->gpio, 0);
+		return 0;
+	}
+
 	/*
 	 * If the reset controller does not implement .deassert(), we assume
 	 * that it handles self-deasserting reset lines via .reset(). In that
@@ -559,7 +577,7 @@ int reset_control_deassert(struct reset_control *rstc)
 	 * return -ENOTSUPP.
 	 */
 	if (!rstc->rcdev->ops->deassert)
-		return 0;
+		return -ENOTSUPP;
 
 	return rstc->rcdev->ops->deassert(rstc->rcdev, rstc->id);
 }
@@ -609,8 +627,10 @@ int reset_control_status(struct reset_control *rstc)
 	if (WARN_ON(IS_ERR(rstc)) || reset_control_is_array(rstc))
 		return -EINVAL;
 
-	if (rstc->rcdev->ops->status)
+	if (rstc->rcdev && rstc->rcdev->ops->status)
 		return rstc->rcdev->ops->status(rstc->rcdev, rstc->id);
+	if (rstc->gpio)
+		return gpiod_get_value(rstc->gpio);
 
 	return -ENOTSUPP;
 }
@@ -796,9 +816,11 @@ static void __reset_control_release(struct kref *kref)
 
 	lockdep_assert_held(&reset_list_mutex);
 
-	module_put(rstc->rcdev->owner);
+	if (rstc->rcdev) {
+		module_put(rstc->rcdev->owner);
 
-	list_del(&rstc->list);
+		list_del(&rstc->list);
+	}
 	kfree(rstc);
 }
 
@@ -935,19 +957,66 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 	return rstc;
 }
 
+static struct reset_control *__reset_control_get_gpio(struct device *dev,
+						      const char *id,
+						      bool optional,
+						      bool acquired)
+{
+	struct reset_control *rstc;
+	struct gpio_desc *gpio;
+	char prop[32];
+
+	if (id)
+		snprintf(prop, sizeof(prop), "%s-reset", id);
+	gpio = gpiod_get_optional(dev, id ? prop : "reset", GPIOD_ASIS);
+	if (IS_ERR(gpio))
+		return ERR_CAST(gpio);
+	if (!gpio)
+		return optional ? NULL : ERR_PTR(-ENOENT);
+
+	rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
+	if (!rstc) {
+		gpiod_put(gpio);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Set the reset GPIO to output, deasserted, unless the GPIO is already
+	 * set to output, asserted.
+	 */
+	if (!(gpiod_get_direction(gpio) == GPIOF_DIR_OUT &&
+	      gpiod_get_value(gpio) == 1))
+		gpiod_direction_output(gpio, 0);
+
+	rstc->gpio = gpio;
+	rstc->refcnt = 1;
+	rstc->acquired = acquired;
+	rstc->shared = false;
+
+	return rstc;
+}
+
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
 					  int index, bool shared, bool optional,
 					  bool acquired)
 {
+	struct reset_control *rstc = ERR_PTR(-ENOENT);
+
 	if (WARN_ON(shared && acquired))
 		return ERR_PTR(-EINVAL);
 
 	if (dev->of_node)
-		return __of_reset_control_get(dev->of_node, id, index, shared,
+		rstc = __of_reset_control_get(dev->of_node, id, index, shared,
 					      optional, acquired);
+	if ((rstc == NULL || PTR_ERR(rstc) == -ENOENT) && index == 0 &&
+	    shared == 0)
+		rstc = __reset_control_get_gpio(dev, id, optional, acquired);
+
+	if (rstc == NULL || PTR_ERR(rstc) == -ENOENT)
+		rstc = __reset_control_get_from_lookup(dev, id, shared,
+						       optional, acquired);
 
-	return __reset_control_get_from_lookup(dev, id, shared, optional,
-					       acquired);
+	return rstc;
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
---------->8----------

regards
Philipp
