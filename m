Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F2C3F3B5F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhHUQTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhHUQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:19:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F04DC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id o2so12317357pgr.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUnHtBDWwuZ6b4H5N4cag1F+1r7RGxZOLo0C7Dxdnss=;
        b=m4hf8PxIPaYiYfwAXIfKngFRpG/ZIZgSCzh/UCqUl/tsN4kTc2xlZ7WkEhX9lWMaJY
         /KA1+z8H+jkebU6vccS56LE0LKn8cwBmWummFuR5TQc26G3KCFZV6h8PznlPwDyQHc55
         jbuKiYQdZOCC3+EP8uxA4GdaXUH6W28KxnLX0Ocpg6w3C5ErSMPuHbzkN0cOfs3jc9Eb
         QVYdwlaTWlGCGnsIpfrFqh2wx6wNC2nyU9ZLuTMq4TSj8GZWTXUvz92I7suDA+slUha2
         FJPy4rXSBM+zMNHS8nIqLCAXeEy7xMv3ceOK7d83co0GFs/j/UiG0dCFluErUAMGs2tI
         C2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUnHtBDWwuZ6b4H5N4cag1F+1r7RGxZOLo0C7Dxdnss=;
        b=MkAuFs3FrJFQa06jj87yf/H2y5ITKUWkMxFhuW1va+BlQgPjBfe8eTaJ9+SQBfVco8
         Ca1AFHFBBjXErUPDjBSFt3ceH+BOZV9sM3w1l8aw4N5+dfg2hRJRc7lXxlRzjpGmviAt
         FU2j5cCVKq6qX0M92WjYhlAWqYHYy94P0NuiDbGTTrCwpoTWfi1kvRHuwh7ia0LZhL46
         EXp0dZHKFEpTMXGW2Dmi6LnBgJugcqvfuVy4lGWgcbzI4nQ2Nz+R7YYwK2LGeabNGknw
         3vXiTQjvu2vtTgR6fGUj7HcskjvjZ0WhUlg2Wg1x+FKbnDHJ7AYpYjoFG5Cp0ahQ46l+
         Vm1g==
X-Gm-Message-State: AOAM532oqmGQ3z5JGASLfxiBhiOf6h92+J5ZEFsV/+B5eJRAbJRzh6Pw
        96kY62heJv8NU8FJR5BbQdIftCUwxRte7gIO
X-Google-Smtp-Source: ABdhPJzK0U3AekmxkSH1AfuH/lKiE+8/IXCcCxAod00PuzhXx9jF1aFsW+5FdfB2EZ6jqc3S4H3s4w==
X-Received: by 2002:a62:8491:0:b029:3dd:a29a:a1e4 with SMTP id k139-20020a6284910000b02903dda29aa1e4mr25268000pfd.13.1629562720637;
        Sat, 21 Aug 2021 09:18:40 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id y27sm4227011pfa.29.2021.08.21.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 09:18:40 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] staging: r8188eu: restricted __be16 degrades to int
Date:   Sat, 21 Aug 2021 21:48:28 +0530
Message-Id: <7572c80d90b499df7e9feb4781c07967fa31bf88.1629562355.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629562355.git.aakashhemadri123@gmail.com>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:73:23: warning: restricted __be16 degrades to integer

Here tag->tag_len is be16, use be16_to_cpu()

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index ee52f28a1e56..f6d1f6029ec3 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
 	int data_len;
 
-	data_len = tag->tag_len + TAG_HDR_LEN;
+	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
 	if (skb_tailroom(skb) < data_len) {
 		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
 		return -1;
-- 
2.32.0

