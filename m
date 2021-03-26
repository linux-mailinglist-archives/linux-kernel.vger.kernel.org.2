Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32634A9FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCZOf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhCZOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D73C0613B9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso5032245wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gK4GBHDnYjUKGItp7Cpn1OqRPa6zrE034rZiLZ47Q+0=;
        b=FQgVhM/HPmIVSaTR75VGvplCpT7A/KPgSILda5lhc4gG8cVL8wV363q2YP+MKT6ofS
         qtp1/el3hpW/j7iCBAJnS61kbgUgdf/9XFnERQE32l8LoSMOY8ri5jNb36Tot+BIOwNQ
         xlCPwO2nXo6Bi2SF43RlOTlky0nw+kpPePRZYzYf4SaMuO+8wCOIM7DUUTUGCTi4qmAn
         LIpeeZtt6Bv3HMyZIWAsnwhGUHc7Azqyr0+o3nWqO1YNp4t61K4IgTQCWCOHrlHaYzC+
         22caIlgT+ccj+M1xjj3O2lfz+JDBIMpb6YzfdPO4TTHt2TTtEM7c97cPEigXlYbQsCoJ
         Kg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gK4GBHDnYjUKGItp7Cpn1OqRPa6zrE034rZiLZ47Q+0=;
        b=dndJ0VNJmYaMQvkNTNi35/b1TIscq4lUmroFojcF40qt8DcUbS2GSdOADjLfjzzE9F
         gPmu4RbAs/sRNFI/ICIPVnUOLLPOzDffSvf6r3kEltI05gbCv/hq8b6TUsVeLfIhwJdI
         eiL1Bpn041cj+SaEpjvzyhjUGqPc7O8McxDVMjgHe88N9EZDw0vED0uly6TplnHkGajx
         yYJ/PMhbPXru6hVxkUAzbskDGjnxKT25XgoVntzf2sbcedVy3Tp9Hlcj5/itg05+0pX3
         5drUJgWouwGQrNr0NL8iCjjLwMQ7LNd4KZSp5artFD6odhpEck6EjQACOEZunrubWtHD
         sADg==
X-Gm-Message-State: AOAM531575KBB9Pv0swDHk4LMD4GM0xaFKbWsMBrDAWRP8/DFId5MYkK
        1lVQxMjnKqhqRgoFYKxOI3mRvg==
X-Google-Smtp-Source: ABdhPJw+y6RAQUFh0yOSkeayDQx3lR4W+C9cJD48v/0NkLQc6flNcqartCxarA+D9tpVMmL5IMFB7w==
X-Received: by 2002:a05:600c:1553:: with SMTP id f19mr13397053wmg.33.1616769312057;
        Fri, 26 Mar 2021 07:35:12 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 10/25] HID: intel-ish-hid: Fix potential copy/paste error
Date:   Fri, 26 Mar 2021 14:34:43 +0000
Message-Id: <20210326143458.508959-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/hid/intel-ish-hid/ishtp-hid.c:11:
 drivers/hid/intel-ish-hid/ishtp-hid.c:263: warning: expecting prototype for ishtp_hid_probe(). Prototype was for ishtp_hid_remove() instead

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index 393bed0abee99..14c271d7d8a94 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -254,7 +254,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
 }
 
 /**
- * ishtp_hid_probe() - Remove registered hid device
+ * ishtp_hid_remove() - Remove registered hid device
  * @client_data:	client data pointer
  *
  * This function is used to destroy allocatd HID device.
-- 
2.27.0

