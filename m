Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB1421B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhJEAma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhJEAmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:42:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94ADC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:40:30 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so23847227otj.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TiRGZLUInk+VSQWONfICAgJSHgQvyAp1kctuS/n49Ns=;
        b=Hq2rDL+66nlcqP1eSxP/gbReMlSqYoigXiUyCvxKV+0gFtNA6js/fEbN5d+K9BZvQT
         lpLK+95n0GFj46bjcmUKVD8pdmj1BaTaLwNJZYaOzfmBpiYFJ9YWYwD9J8aV/NDVI/uu
         2XuqM72ISUyxl1K66qI64w0nHpKIqO702aSk4emQv/Cm1wXiamCOLvXfQd15vntdbEgI
         iAVhFWP4oRMrcajxZ//v4zXcNjs4mSdTa9KckBRoh90g9aFsIOShxyXGgRCa6hHkUgHh
         3uQ9MRCA3C40j7uwx7ikRcHGWDTsaKYGcg6Xct735YLYceBTi9lC9fxBk5cpDnCdPRp0
         +BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TiRGZLUInk+VSQWONfICAgJSHgQvyAp1kctuS/n49Ns=;
        b=CtddvJikGnmdRwPJfd0eByR5NXJgAXuCI3ZeRePkCycjeSaUtv2KTCvpF7yYnnU4PI
         jqC9392NylwHd3EFEBkL1YY0J+vMgwwT3jNSeuVIIO6cBytY3ClYovKjJs6OUpBjNZ8F
         3668zOJVBBqR9ArR46LLdu4hKlRsbGyOkgs+GeKa+Zi5C9LKmA66wfoQaqo+P28jjKo+
         ouuINlY8l0f6roeOYlBwDzUvy/JuEZcZU5pkij+zBqGr6p6K3587HY8XYFqOW3m3eTkN
         MqlyFUfb5pw48xGYIp3wiQXroYSqQGRvHsY6zVWnMW6qHa12cHgZl+HlAYz+PxL9Wn5i
         MGTg==
X-Gm-Message-State: AOAM533vFmtkhflZ9JQpsT7rSFT5nmON9vR1nOIEVQlphdZ3YGs485w0
        u/TdehuemzDDDBl7nyf3qQ==
X-Google-Smtp-Source: ABdhPJwAKm5e9/qpn9qxfPHfD+pcg1OH0h8iMTg9zbtHI1K9LonLeasrXsh0F1yfInevE8lFiUUvDg==
X-Received: by 2002:a05:6830:455:: with SMTP id d21mr12020459otc.300.1633394430022;
        Mon, 04 Oct 2021 17:40:30 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id s29sm3202416otg.60.2021.10.04.17.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:40:29 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:1ce5:3fb4:8fe9:30d1])
        by serve.minyard.net (Postfix) with ESMTPA id 985851800F9;
        Tue,  5 Oct 2021 00:40:26 +0000 (UTC)
From:   minyard@acm.org
To:     openipmi-developer@lists.sourceforge.net
Cc:     Andrew Manley <andrew.manley@sealingtech.com>,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Corey Minyard <minyard@acm.org>
Subject: [PATCH 5/5] ipmi: Add docs for the IPMI IPMB driver
Date:   Mon,  4 Oct 2021 19:40:19 -0500
Message-Id: <20211005004019.2670691-6-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005004019.2670691-1-minyard@acm.org>
References: <20211005004019.2670691-1-minyard@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Describe how to use the IPMI IPMB driver, including it's quirks.

Signed-off-by: Corey Minyard <minyard@acm.org>
Tested-by: Andrew Manley <andrew.manley@sealingtech.com>
Reviewed-by: Andrew Manley <andrew.manley@sealingtech.com>
---
 Documentation/driver-api/ipmi.rst | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/driver-api/ipmi.rst b/Documentation/driver-api/ipmi.rst
index c9cb5669bc4c..e224e47b6b09 100644
--- a/Documentation/driver-api/ipmi.rst
+++ b/Documentation/driver-api/ipmi.rst
@@ -591,6 +591,45 @@ web page.
 The driver supports a hot add and remove of interfaces through the I2C
 sysfs interface.
 
+The IPMI IPMB Driver
+--------------------
+
+This driver is for supporting a system that sits on an IPMB bus; it
+allows the interface to look like a normal IPMI interface.  Sending
+system interface addressed messages to it will cause the message to go
+to the registered BMC on the system (default at IPMI address 0x20).
+
+It also allows you to directly address other MCs on the bus using the
+ipmb direct addressing.  You can receive commands from other MCs on
+the bus and they will be handled through the normal received command
+mechanism described above.
+
+Parameters are::
+
+  ipmi_ipmb.bmcaddr=<address to use for system interface addresses messages>
+	ipmi_ipmb.retry_time_ms=<Time between retries on IPMB>
+	ipmi_ipmb.max_retries=<Number of times to retry a message>
+
+Loading the module will not result in the driver automatcially
+starting unless there is device tree information setting it up.  If
+you want to instantiate one of these by hand, do::
+
+  echo ipmi-ipmb <addr> > /sys/class/i2c-dev/i2c-<n>/device/new_device
+
+Note that the address you give here is the I2C address, not the IPMI
+address.  So if you want your MC address to be 0x60, you put 0x30
+here.  See the I2C driver info for more details.
+
+Command bridging to other IPMB busses through this interface does not
+work.  The receive message queue is not implemented, by design.  There
+is only one receive message queue on a BMC, and that is meant for the
+host drivers, not something on the IPMB bus.
+
+A BMC may have multiple IPMB busses, which bus your device sits on
+depends on how the system is wired.  You can fetch the channels with
+"ipmitool channel info <n>" where <n> is the channel, with the
+channels being 0-7 and try the IPMB channels.
+
 Other Pieces
 ------------
 
-- 
2.25.1

