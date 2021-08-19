Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F003F1502
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhHSIS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbhHSISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:18:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510ABC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g14so4782341pfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MVAcGAWVJZY+dW4MAhBQUW0lRs4hWBqQtrXxGIoLlU=;
        b=qj2x8hx9Z5DZ/HaOQDyzzweWcrBY8cJ6PXWP+JMOVcsWWGvdFimyysOLUaWYfOAa2P
         5hXylvlvQRkWBAvB7RiZP3XLXej9rXG7wA4fAtlKVcwniA2BHLW8lXLzq7uSJb/mTOh/
         X6xHAIu8THNYZj8CvLgl0EW+pM9lfid4kEjEapR0ANHnm47MimsE8fkPmmvy6A7C/HfP
         YLYgxF5IkLVju8dL8PQfQS6PICH/kKqZH8Q0UFGAIUHkbkleb6ws9eSqEyrNKST9sZmO
         o6dAhVZtbDGN8K/cy+z3RjGBWNdgqpVYF/hBW3IcSEDbxjCCPb4BFoo7OZmgTWPiE8SL
         F4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MVAcGAWVJZY+dW4MAhBQUW0lRs4hWBqQtrXxGIoLlU=;
        b=OJ8mfji9g5hyytzR+DGGACpZqwMqh/wjlCKDpoTmyg7L66TX5X7e/B/vUpoPK004Xg
         rycHk2mhqh1LbZFKjiSWbr3DQXgBWU7s/Ot5LqJ1j2rJ0VnwOVSuMsefl2JQPoUqjJ3u
         Dpc4K3lk50qpLEiKpODWKG7uNFfZSGwIwnj0jW8X9gf6Q/CI2YTSSAeoVCfSX7mSeuVO
         eOt9hKqxrz81ADJI5ncmiE3NJRRzbS2V2jHFiYPZwBA5ogSRzxB56laHV7TFLyQwuD+W
         s6aHuQqsJfWjt6IdgptFjW0jDySSOnf+oTZHxh/AvXdl7aQ7lci3NYTCtpccjsXJw0me
         aAnw==
X-Gm-Message-State: AOAM530PBXaVaGSqd11CoiR8Bp+q+AjtLSkwakU0KLDQBqyw3ad/jc2K
        vRrxbHAwhGpTqOPnxvH6Ep0=
X-Google-Smtp-Source: ABdhPJwVgRdqe4ny//bPUATMYZzbb6gwHcn4niyvHD6nH63rnETbCVpIwMrphbuunD0qIwP5ErGxnQ==
X-Received: by 2002:a65:690c:: with SMTP id s12mr13052807pgq.401.1629361095914;
        Thu, 19 Aug 2021 01:18:15 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id gb17sm1531129pjb.26.2021.08.19.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:18:15 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] staging: r8188eu: restricted __be16 degrades to int
Date:   Thu, 19 Aug 2021 13:47:56 +0530
Message-Id: <bd63137c645ecc20dc446a6cfa7f7d3461a642d7.1629360917.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629360917.git.aakashhemadri123@gmail.com>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:839:70: warning: restricted __be16 degrades to integer
> rtw_br_ext.c:845:70: warning: invalid assignment: |=
> rtw_br_ext.c:845:70:    left side has type unsigned short
> rtw_br_ext.c:845:70:    right side has type restricted __be16

dhcp->flag is u16, remove htons() as __be16 degrades.

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index d4acf02ca64f..14b2935cab98 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -674,13 +674,13 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 					u32 cookie = dhcph->cookie;
 
 					if (cookie == DHCP_MAGIC) { /*  match magic word */
-						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
+						if (!(dhcph->flags & BROADCAST_FLAG)) {
 							/*  if not broadcast */
 							register int sum = 0;
 
 							DEBUG_INFO("DHCP: change flag of DHCP request to broadcast.\n");
 							/*  or BROADCAST flag */
-							dhcph->flags |= htons(BROADCAST_FLAG);
+							dhcph->flags |= BROADCAST_FLAG;
 							/*  recalculate checksum */
 							sum = ~(udph->check) & 0xffff;
 							sum += be16_to_cpu(dhcph->flags);
-- 
2.32.0

