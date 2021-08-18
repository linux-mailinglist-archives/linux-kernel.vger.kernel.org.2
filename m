Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E753F0EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhHRXns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbhHRXng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:43:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A745FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:43:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f13-20020a1c6a0d000000b002e6fd0b0b3fso3918081wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRHsFyG+KbjfUh5r00Rp6bfSF1Hm1Ce+9V7/VyM+71M=;
        b=hWfd7dLAfbd07i+9G/dPymA8rZT3vgrih0XEPRU/DMrBnRcadRREI4+QIp3O3KWw1O
         J1uNg6EBFyTKXgeT4RBHcQc0GJVeKxwTb9/yOv2tYoVv9QNj/7V97MgQo+YHDZss2bZ5
         zftTMj9Axp5cxxw4IrWGsIt8HlI2dOwRZqrlMI6WRfXSGCeFjK4votiHctafElxgXR7p
         +vf6ZPkClvzOvyzbUiLpBxXaLZ5nXot9e36H9DtXfPl3nMWDjJKNjJNeNHmgpVuP7JOR
         oXhhVC3udc4wt/APwcy//hefGgzvRvOjStYlLrIaOHGh3Ur/o7rgJPQQhsyrGBNqCzfp
         mnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRHsFyG+KbjfUh5r00Rp6bfSF1Hm1Ce+9V7/VyM+71M=;
        b=Zip6partbZDBkZnIehTc1MmhbDdnag4JcG7HIg9bHMJj0vlnu+IYxPot/lqxQiPW/d
         0Rm3QEnpiXRFp8d6SbyeNZbQnpQxz4NF2bPveQ2PFAMMfOLARGu/IcJqUr7v6U4Tg1Tx
         SzvY7Sal+7SC60shfjwxZ/c2wZ+1xeO5/v+6opc9PDa0LgVKn7KCwVb9MwZfiAf01Wxj
         u0jKjmDZCJ1THiwbz229RhL+56DuAwlf9+A/rSE8GatFLk6Z5L61suW4M6pcDbp5sXri
         KljY9eshfQf1RdqgL3TIriUMJh3id9Wcnv8nnqo754N/5szSMDOr6uprVNwes9ZGNMgH
         W5Kg==
X-Gm-Message-State: AOAM533YyTDdOCyX7rfjz5GB7sM4M0vFkF898/FMhGD9luIvPW2+Wwy8
        avvEfjcPJQIFlCI+VU7IIsk5NQ==
X-Google-Smtp-Source: ABdhPJwWuB8IlWvlCy37ytssPdog8rputLzWW/eloI8MqBt3oHcAnhUgvvy7Pt/d7kJqoMarO7/3Og==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr10958063wmc.150.1629330179275;
        Wed, 18 Aug 2021 16:42:59 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1194926wrt.77.2021.08.18.16.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:42:58 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 6/6] staging: r8188eu: remove free_xmit_priv field from struct hal_ops
Date:   Thu, 19 Aug 2021 00:42:53 +0100
Message-Id: <20210818234253.208271-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234253.208271-1-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove free_xmit_priv function pointer field from struct hal_ops definition
in include/hal_intf.h, as it is now no longer used anywhere in the driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 8a2420095b84..fa252540e596 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -139,7 +139,6 @@ struct hal_ops {
 	u32	(*inirp_deinit)(struct adapter *padapter);
 
 	s32	(*init_xmit_priv)(struct adapter *padapter);
-	void	(*free_xmit_priv)(struct adapter *padapter);
 
 	s32	(*init_recv_priv)(struct adapter *padapter);
 	void	(*free_recv_priv)(struct adapter *padapter);
-- 
2.31.1

