Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9B3A215D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFJAYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFJAYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:24:33 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DE7C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 17:22:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s23so165205oiw.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 17:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqda7Y7VY751qiHwi67sa4oN0nY0qPs95IMKdq6kzvM=;
        b=hyD8x/fW6GsldHTArxMhnA3R2kAL+eRuDK38kF7nsv5rweEFUVlvRsFIq6YnB/7G7U
         uCY0EuD3R3D/Sq/7xCriTow2Z7n/EMAG1FrdVT/hthzlVPFZxKrrzzhzsNaBqqtrudiY
         OcE1q4nf7JwnnYlB0lO2frXfbpbs52WiGebqGZXaM8Q6i7iL/naSM8D6ZgJ+un3L+sfS
         WM1ETk/18IMXsa/7NKdO6HtTIBrljKQCE4WngS4rmUhG67CpTvNK22OnCkOu02jXjJxu
         pvkwKHxYTTVj/0YMDyz1cJxj4tS9qWJswwXS24ml9AurGJXhCX2qRUlNQHyUmtYdTHNk
         sFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqda7Y7VY751qiHwi67sa4oN0nY0qPs95IMKdq6kzvM=;
        b=QzZegicAgw7HZva9BAy2d6YVM2iJ2oef4xCt0d5xsMp1enyxDaKvux0TOpg+0f6SFh
         wKLwebRgm3BUyQKOvY35a2T1Ukh6YbFufLJLUkXCBPjktlIWzmPlAHSxZa4Cnh4BmPsg
         /cgAedcNSAYnpccDCw7IdNBdGQrGYcxjkDVaYhchrDC0kIii/05f5A986TZhMszXn5OG
         aWuy4HqZW/Uk/Y1bcKOfsi9G/zG8wjGKPQLSABnI+wdoHqBjBoad/vyNuWjbQob3y/GY
         xa9GGbHqQdcGFDWKqLBWRTmjsG0i+ER5bw5Qwr/R50pKG86nODc8Mgo3JAKQOf6rGvfM
         mxgg==
X-Gm-Message-State: AOAM530MJN6OEdQvDhhWTsiNSexh8KF+ZkbzejWFjlS8e9gT/qD5OVMC
        FhVUSUFK1pU7aJAT5TqGGAkzfw==
X-Google-Smtp-Source: ABdhPJyNWi8kzQXPfxhp1H+j0xAp/kCFS4t+JKbUxUDX2zvHdnv+7i0GONlblnouQYxwNWuqlC0Kzg==
X-Received: by 2002:aca:3e06:: with SMTP id l6mr1521121oia.147.1623284541085;
        Wed, 09 Jun 2021 17:22:21 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z19sm319048oth.20.2021.06.09.17.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 17:22:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: typec: mux: Fix copy-paste mistake in typec_mux_match
Date:   Wed,  9 Jun 2021 17:21:32 -0700
Message-Id: <20210610002132.3088083-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the copy-paste mistake in the return path of typec_mux_match(),
where dev is considered a member of struct typec_switch rather than
struct typec_mux.

The two structs are identical in regards to having the struct device as
the first entry, so this provides no functional change.

Fixes: 3370db35193b ("usb: typec: Registering real device entries for the muxes")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Don't touch the typec_switch part of mux.c...

 drivers/usb/typec/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 664fb3513f48..c8340de0ed49 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -246,7 +246,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				mux_fwnode_match);
 
-	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
+	return dev ? to_typec_mux(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
 /**
-- 
2.29.2

