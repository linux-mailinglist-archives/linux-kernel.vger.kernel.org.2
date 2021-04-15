Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFDB3601D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhDOFoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhDOFoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:44:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A5CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 22:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cnWoWcr6rFB7LXBIZmeEM/OT8dWnWMBS028coItKxNc=; b=i7CCOpXkJqqvoRtwFsqPghl+Ui
        fv5+CsILU6Uxh0GUYTTDKwlbpKYHYszj9NigDWB9M6Fd0Li8NigN4cn1hMCC1rJxNPjJFxPU4YBC1
        KaR3qPb/P5G+wF2UUyrZs0/sCWIk7JEHhT1wvdZ2h2cGHX8uwT0KA6IPfd5JkP59VrVn3QlkjqmHB
        DFAXtw6g31X4L/X/bMKcWkZwccXnCxSdqnQ1j41Vw+tVgQLHmMweLv+JKwquCyI906OXoxd2JYSU/
        K+uO0WbtVRYKO6wlAo7gnvjdyMsWV2iT7Eb2hfMPn6OP9QIMxLg8hRKdKIp1PVHAT2IpdV7SVO6WC
        cEJzhZ3w==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWun0-00EwcC-39; Thu, 15 Apr 2021 05:43:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org
Subject: [PATCH] greybus: es2: fix kernel-doc warnings
Date:   Wed, 14 Apr 2021 22:43:38 -0700
Message-Id: <20210415054338.2223-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix these kernel-doc complaints:

../drivers/greybus/es2.c:79: warning: bad line: 
../drivers/greybus/es2.c:100: warning: cannot understand function prototype: 'struct es2_ap_dev '
es2.c:126: warning: Function parameter or member 'cdsi1_in_use' not described in 'es2_ap_dev'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org (moderated for non-subscribers)
---
 drivers/greybus/es2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20210414.orig/drivers/greybus/es2.c
+++ linux-next-20210414/drivers/greybus/es2.c
@@ -72,11 +72,11 @@ struct es2_cport_in {
 };
 
 /**
- * es2_ap_dev - ES2 USB Bridge to AP structure
+ * struct es2_ap_dev - ES2 USB Bridge to AP structure
  * @usb_dev: pointer to the USB device we are.
  * @usb_intf: pointer to the USB interface we are bound to.
  * @hd: pointer to our gb_host_device structure
-
+ *
  * @cport_in: endpoint, urbs and buffer for cport in messages
  * @cport_out_endpoint: endpoint for for cport out messages
  * @cport_out_urb: array of urbs for the CPort out messages
@@ -85,7 +85,7 @@ struct es2_cport_in {
  * @cport_out_urb_cancelled: array of flags indicating whether the
  *			corresponding @cport_out_urb is being cancelled
  * @cport_out_urb_lock: locks the @cport_out_urb_busy "list"
- *
+ * @cdsi1_in_use: true if cport CDSI1 is in use
  * @apb_log_task: task pointer for logging thread
  * @apb_log_dentry: file system entry for the log file interface
  * @apb_log_enable_dentry: file system entry for enabling logging
