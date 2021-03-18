Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C683403A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCRKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhCRKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:40:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4700C061764
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso5106347wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YeqXEpROOp+iMp8r4X/XCNvaZ1Q9W0JDqwahteeA6AI=;
        b=MzKuC6YnZurZf0L4f2hzTY8fKELqD9l8PjwaxpCOd9JxaDHWDQE/qpt74TPeOPX2Zn
         Xk//2XeHA0jI2tcWPiftkGf/8iIiPCQCkcmy5JUEbThY6pFjrUkd0nLGTdeO0pH0aSNF
         znJ6A7t8Z84suozRc6yHxZDiDMqnQNTG4kFlsaustDOuSqoNQ26psemHCBK4oqY8lhEL
         D6eU6CwBtD8pLRPlV2P15XgfgM5qVNHyLs67wDnvRwkyEQSA8WgnFFmdtwwD1qYaSnUJ
         rKP5KPZVkjN/S415+Bp8p+KNQb/txxip2PgRXmjni5DCv8oGfqZFV95yuUAGCBPqbZPS
         /z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YeqXEpROOp+iMp8r4X/XCNvaZ1Q9W0JDqwahteeA6AI=;
        b=JhYTWqIUcEq38HAaYtRIBpUTNzITdNUGUwIDPUaYqZS74Hsi8ZpO+WAcFjmb22fHMx
         Nt4yrpFbC4FV9+/ZwA/W/VI+nW6EA6unefpdJdfxcr3C3sWnYFYoDwGXz7O6Z5GgSrhR
         p2bVFlPEflALoDoUwCG3KAq4rHH1ISu8/4hZ3JQNtcJKGquwAnl5ItLcRvZkdzIGQk+O
         F0QqMzTHcBTcVOMituuTGzGrKrODHZ64ldtrvJeQY59ZauLFoIwem+VJby690tec9Rfx
         Xq3BrhlhorQC7g3kjArQA5cu8M+vkSiA6liz7vFNpDvvrV3t7+6co3cEmSMBoRTs6ToG
         1igw==
X-Gm-Message-State: AOAM5309Rpcwyq6yJIb/Sdtt5bMpoevpWHdBrwDEE1uWoRCEW0vzPhPA
        DaXjYwTnyiQfOX2shtnH4GGbHw==
X-Google-Smtp-Source: ABdhPJzW1MNHQw5/b2G8K0upazSv+a5i+rQsabgUnXUoFC/kZAwv2SHREiGWb7z58KsAoeqZV2TygA==
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr3044552wmf.148.1616064051464;
        Thu, 18 Mar 2021 03:40:51 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id z1sm2426033wru.95.2021.03.18.03.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:40:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 08/10] of: of_net: Provide function name and param description
Date:   Thu, 18 Mar 2021 10:40:34 +0000
Message-Id: <20210318104036.3175910-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318104036.3175910-1-lee.jones@linaro.org>
References: <20210318104036.3175910-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/of_net.c:104: warning: Function parameter or member 'np' not described in 'of_get_mac_address'
 drivers/of/of_net.c:104: warning: expecting prototype for mac(). Prototype was for of_get_mac_address() instead

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/of_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
index 6e411821583e4..bc0a27de69d4c 100644
--- a/drivers/of/of_net.c
+++ b/drivers/of/of_net.c
@@ -79,6 +79,9 @@ static const void *of_get_mac_addr_nvmem(struct device_node *np)
 }
 
 /**
+ * of_get_mac_address()
+ * @np:		Caller's Device Node
+ *
  * Search the device tree for the best MAC address to use.  'mac-address' is
  * checked first, because that is supposed to contain to "most recent" MAC
  * address. If that isn't set, then 'local-mac-address' is checked next,
-- 
2.27.0

