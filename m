Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF73DC6D8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 18:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhGaQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaQJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 12:09:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468AC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 09:09:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso1358200wmq.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5YngqDa9OtSmTxiUAuX4H0sFXwzCxz50QJ1BeJG4Tfg=;
        b=s3RGNfZeTwyHnkEZtYqKpM0Xqfm/QXpmZIkIRcqxIbicD15qo/LrqW+kfBfsnePm8t
         ZRCKa9VXJHZQ/Ujm/LHQrKmej3jN/WVqdd836u7SKiBhne58UMo+7vdBaKIVggk9c2jy
         ntJVY/giGXiwjhwUOtG53dmkTM3s3yrMH1muBs2eSltQuLZ4WgvR7k2WQKbcngIedBre
         YUVNf/AXoVcWjGudC3ueMOZQgwhJvpvKXGAPhuRsh+nZu3ZNd0BGwLAHUVzX5JPPxUCT
         +/6x9vHmX2lpJssMuLpKGGghq+2hhyNxX6O0ucXer0QSlktHyevbW+xkSRtV33++Hf1e
         jbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5YngqDa9OtSmTxiUAuX4H0sFXwzCxz50QJ1BeJG4Tfg=;
        b=PewR4JLobO+9xjYynIsjW7IUEePNqddNx1BmxGe6hpOTYLBdYb6YXpgSbYMUgqfkbP
         YBzh8vsL2E1vwqwXyXfDi9/BZj7P0YX+MUmY2ZH+KqHXboxBXnPrI1eQ5RQfk7HJzKWR
         YfKGwKUmnMk8P4FhWL7uH28XerP/OQ8PChNP9I3N5nfGDcZFYEMiotzKDaKqMQBOj/N+
         tk7W8aGnkEaHpAf9rk7KdjDarOWFX3JAJ2JiLCEJOA2Jj0g42ily0hDxFMuYCOOdpdz4
         fyp+AxtSl+v6xZH+Qpv0z96uMlr0GerG/yz4iOM3tzUwk9xQlAhitw5PPMw5w7DGyQnP
         lOtw==
X-Gm-Message-State: AOAM533rRbrAA7oe8DMF//vJ9jbS7qytmKDlgxZLvpLxQ5Llb3mavW8R
        /GPjGJ/8R6PlhzAWQM7ZGbY=
X-Google-Smtp-Source: ABdhPJzVl8fbQNsHwMYJLRCQHtaHtHqyiCWS81wv9Zi1jOFqpLB9UIweWsF6c3KIsd/klThdIAggQA==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr8738377wmj.100.1627747781536;
        Sat, 31 Jul 2021 09:09:41 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id t15sm5405634wrx.17.2021.07.31.09.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 09:09:41 -0700 (PDT)
Date:   Sat, 31 Jul 2021 17:09:38 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Brother Matthew De Angelis <matthew.v.deangelis@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Safonov <insafonov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tablet: acecad: update the reference count of the usb
 interface structure
Message-ID: <20210731160938.GA909566@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following documentation usb_get_inf(), use usb_get_intf()
and usb_put_intf() in order to update the reference count of the usb
interface structure.

Documentation of usb_get_inf():

[quote]
Each live reference to a interface must be refcounted.

Drivers for USB interfaces should normally record such references
in their probe methods, when they bind to an interface, and release them
by calling usb_put_intf, in their disconnect methods.
[/quote]

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Change since v1:
	Modification of the description

 drivers/input/tablet/acecad.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index a38d1fe97334..85fe134a30ee 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -151,7 +151,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 		goto fail2;
 	}
 
-	acecad->intf = intf;
+	acecad->intf = usb_get_intf(intf);
 	acecad->input = input_dev;
 
 	if (dev->manufacturer)
@@ -236,6 +236,9 @@ static void usb_acecad_disconnect(struct usb_interface *intf)
 	input_unregister_device(acecad->input);
 	usb_free_urb(acecad->irq);
 	usb_free_coherent(udev, 8, acecad->data, acecad->data_dma);
+
+	usb_put_intf(acecad->intf);
+
 	kfree(acecad);
 }
 
-- 
2.25.1

