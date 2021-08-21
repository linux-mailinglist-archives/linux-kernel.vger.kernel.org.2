Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599023F3B62
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhHUQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhHUQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:19:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397FEC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so9272771pjl.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzRDVj8kh2b1JZfWSLoz1YXoIow59eKZovHPJUZMpVE=;
        b=QpGloXqfJhiLxmJuJZD9iPEr6+Xkuzp3hLhDOIc0m1UsFeZYBhYqmX0Oegg8gP+Ccs
         zea4M6Az7ZKcB2LmZTb0VLTsIz4DZpKNzuptK7EzrycPfimZveOIsISO1bROJ3PlzBC3
         DAkJeMFRtHLXHANnyjXJ+P138lasIEnuhL9upnzCo2ugtvakByO4aXF/520kmD18pL2v
         7CxVINMxfkNS+tc4nKdEVKIVz3adyt1I3rRnSPrz6/Lht+D7LoB09M7cKdGlgCOwjiv6
         iAwEW1uz66FmAs2SuCNt9RsdjuBTXmyIDTcUbjrE7B5E7y7CcOZr9QCuepxKF7iPv7KM
         yz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzRDVj8kh2b1JZfWSLoz1YXoIow59eKZovHPJUZMpVE=;
        b=e2YTutetViqKtxizLKtdUr6CPm51EnlrvHjBfzOfCOBHCQ5Rjala6KsCKLegbJuzcQ
         LXXbm3r5H96tV23UYeNZywM7Hrgu/cmIyvZ/I0LoWhq5ShHkIQCzjOVUi8wINZk3+w2C
         o9DKTzSCfQRtWm5oAsgDWWAFKP48CDyIWSTCUWAnjG5ta9J9qcg89jusGWUo/4vtBI8m
         O5d7Hm3Vfk9zeC2BorRcA7WwzIwiRAXxqPUQ7v9VXDSuThKIwo51Xik8sXNsH9p1nkV4
         Oc6BNwmcRHMs7qkvNiETTJ4yylVJ5lnVfrJiZOUxBb0DC+pQ3eglJgMD4FX+92+UKNjL
         VSxg==
X-Gm-Message-State: AOAM533dUP7MWdneUjdPdYOOlQEhuQkbkzA8mgikGJa0u9VNJrS+hEt2
        /jrKiotdh67D3PJJcO1d/3w=
X-Google-Smtp-Source: ABdhPJwpfIwVWwbBYn5nj+I+o2rKEr2X6F8u0SHnkDbSyTU0VnawOYQZTJNnMvGWySIuas01o72adA==
X-Received: by 2002:a17:90a:44:: with SMTP id 4mr10392350pjb.130.1629562726785;
        Sat, 21 Aug 2021 09:18:46 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id y27sm4227011pfa.29.2021.08.21.09.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 09:18:46 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] staging: r8188eu: restricted __be16 degrades to int
Date:   Sat, 21 Aug 2021 21:48:31 +0530
Message-Id: <464cbdb48b238d6b3aca435ef4f0bd05d48e01c6.1629562355.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629562355.git.aakashhemadri123@gmail.com>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
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

dhcp->flags is be16, so change its type to that.
Change htons() to cpu_to_be16() for clarity.

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 26606093a3c3..83a4594a4214 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -641,7 +641,7 @@ struct dhcpMessage {
 	u_int8_t hops;
 	u_int32_t xid;
 	u_int16_t secs;
-	u_int16_t flags;
+	__be16 flags;
 	u_int32_t ciaddr;
 	u_int32_t yiaddr;
 	u_int32_t siaddr;
@@ -674,13 +674,13 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 					u32 cookie = be32_to_cpu(dhcph->cookie);
 
 					if (cookie == DHCP_MAGIC) { /*  match magic word */
-						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
+						if (!(dhcph->flags & cpu_to_be16(BROADCAST_FLAG))) {
 							/*  if not broadcast */
 							register int sum = 0;
 
 							DEBUG_INFO("DHCP: change flag of DHCP request to broadcast.\n");
 							/*  or BROADCAST flag */
-							dhcph->flags |= htons(BROADCAST_FLAG);
+							dhcph->flags |= cpu_to_be16(BROADCAST_FLAG);
 							/*  recalculate checksum */
 							sum = ~(udph->check) & 0xffff;
 							sum += be16_to_cpu(dhcph->flags);
-- 
2.32.0

