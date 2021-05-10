Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB837822E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhEJKcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhEJK3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:29:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96E7461628;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=xJ1AF2vGTwChxJzqJvQieroJtpm+Zdy3DSZGcT7Fjys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trfUzKjpjW5AMGZ5zQsNzZnxY7KSt2R1sGgiHdmCg58KLbcwp8Qg3qyaLQXvVb78R
         S0vRixj11Tbl9vgrYdYCfTc4FKCt88y3jmXTnllF8J7LoWlMytumNayPdPhcCQ/xZO
         43GMNpkmpZdl9YPKIyyNkwSauY4RX+IhfG1hW2BeGc55WqWMPwCPXuMiZrNLcEab31
         rgGYk6BrQ9DaW+sS8askcEKiFS/R+PPISIDNyrpaVHagVDPUiTYNFF9GWlzveFVPhu
         TFcm8Gax2tbtwvoBt1DvYq+/qfKrtR4QIvApCwrwNHEh3bDWhMLFGbOVF3CY4Xf+uv
         FL96Slq92qLOg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UPE-0J; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Mike Rapoport <rppt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/53] docs: driver-api: iio: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:26 +0200
Message-Id: <2e88cb1503a67b617e47870ebe16cf4f86b48be0.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2014 ('—'): EM DASH

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/iio/buffers.rst           |  8 ++++----
 Documentation/driver-api/iio/hw-consumer.rst       | 10 +++++-----
 Documentation/driver-api/iio/triggered-buffers.rst |  6 +++---
 Documentation/driver-api/iio/triggers.rst          | 10 +++++-----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
index e83026aebe97..24569ff0cf79 100644
--- a/Documentation/driver-api/iio/buffers.rst
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -2,11 +2,11 @@
 Buffers
 =======
 
-* struct iio_buffer — general buffer structure
-* :c:func:`iio_validate_scan_mask_onehot` — Validates that exactly one channel
+* struct iio_buffer - general buffer structure
+* :c:func:`iio_validate_scan_mask_onehot` - Validates that exactly one channel
   is selected
-* :c:func:`iio_buffer_get` — Grab a reference to the buffer
-* :c:func:`iio_buffer_put` — Release the reference to the buffer
+* :c:func:`iio_buffer_get` - Grab a reference to the buffer
+* :c:func:`iio_buffer_put` - Release the reference to the buffer
 
 The Industrial I/O core offers a way for continuous data capture based on a
 trigger source. Multiple data channels can be read at once from
diff --git a/Documentation/driver-api/iio/hw-consumer.rst b/Documentation/driver-api/iio/hw-consumer.rst
index 76133a3796f2..75986358fc02 100644
--- a/Documentation/driver-api/iio/hw-consumer.rst
+++ b/Documentation/driver-api/iio/hw-consumer.rst
@@ -8,11 +8,11 @@ software buffer for data. The implementation can be found under
 :file:`drivers/iio/buffer/hw-consumer.c`
 
 
-* struct iio_hw_consumer — Hardware consumer structure
-* :c:func:`iio_hw_consumer_alloc` — Allocate IIO hardware consumer
-* :c:func:`iio_hw_consumer_free` — Free IIO hardware consumer
-* :c:func:`iio_hw_consumer_enable` — Enable IIO hardware consumer
-* :c:func:`iio_hw_consumer_disable` — Disable IIO hardware consumer
+* struct iio_hw_consumer - Hardware consumer structure
+* :c:func:`iio_hw_consumer_alloc` - Allocate IIO hardware consumer
+* :c:func:`iio_hw_consumer_free` - Free IIO hardware consumer
+* :c:func:`iio_hw_consumer_enable` - Enable IIO hardware consumer
+* :c:func:`iio_hw_consumer_disable` - Disable IIO hardware consumer
 
 
 HW consumer setup
diff --git a/Documentation/driver-api/iio/triggered-buffers.rst b/Documentation/driver-api/iio/triggered-buffers.rst
index 417555dbbdf4..7c37b2afa1ad 100644
--- a/Documentation/driver-api/iio/triggered-buffers.rst
+++ b/Documentation/driver-api/iio/triggered-buffers.rst
@@ -7,10 +7,10 @@ Now that we know what buffers and triggers are let's see how they work together.
 IIO triggered buffer setup
 ==========================
 
-* :c:func:`iio_triggered_buffer_setup` — Setup triggered buffer and pollfunc
-* :c:func:`iio_triggered_buffer_cleanup` — Free resources allocated by
+* :c:func:`iio_triggered_buffer_setup` - Setup triggered buffer and pollfunc
+* :c:func:`iio_triggered_buffer_cleanup` - Free resources allocated by
   :c:func:`iio_triggered_buffer_setup`
-* struct iio_buffer_setup_ops — buffer setup related callbacks
+* struct iio_buffer_setup_ops - buffer setup related callbacks
 
 A typical triggered buffer setup looks like this::
 
diff --git a/Documentation/driver-api/iio/triggers.rst b/Documentation/driver-api/iio/triggers.rst
index 288625e40672..a5d1fc15747c 100644
--- a/Documentation/driver-api/iio/triggers.rst
+++ b/Documentation/driver-api/iio/triggers.rst
@@ -2,11 +2,11 @@
 Triggers
 ========
 
-* struct iio_trigger — industrial I/O trigger device
-* :c:func:`devm_iio_trigger_alloc` — Resource-managed iio_trigger_alloc
-* :c:func:`devm_iio_trigger_register` — Resource-managed iio_trigger_register
+* struct iio_trigger - industrial I/O trigger device
+* :c:func:`devm_iio_trigger_alloc` - Resource-managed iio_trigger_alloc
+* :c:func:`devm_iio_trigger_register` - Resource-managed iio_trigger_register
   iio_trigger_unregister
-* :c:func:`iio_trigger_validate_own_device` — Check if a trigger and IIO
+* :c:func:`iio_trigger_validate_own_device` - Check if a trigger and IIO
   device belong to the same device
 
 In many situations it is useful for a driver to be able to capture data based
@@ -63,7 +63,7 @@ Let's see a simple example of how to setup a trigger to be used by a driver::
 IIO trigger ops
 ===============
 
-* struct iio_trigger_ops — operations structure for an iio_trigger.
+* struct iio_trigger_ops - operations structure for an iio_trigger.
 
 Notice that a trigger has a set of operations attached:
 
-- 
2.30.2

