Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF242354146
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhDEKto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhDEKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:42 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045D3C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:37 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id n44so189176qvg.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzL8vdXPjQmOyUpH6g9C5hBoe1rKYLajXq92s91Qu6U=;
        b=ORdCdw/JVwJmUxxGXtwIri6y5FyfLaaEqfiVykYV3lmJqvHMsMdpicNdosRb4/+tet
         oaUzZMnPXzgOp9Yv8e7CJZQWZDIAkPPg4SNt+7OULMHYb6CqOaAADzhNVEvCBqQju0wK
         QlxTPBf7sR5kQq/rogiIAd6gqj2YhM2TPHqlIk47q36djj1CO/xxwBoD9A6tEzei9j0E
         8OX1S5iZabaYWt7YW3RLAgCRTh9Px95CQA52Tt5eTGxDS9CKbqdcr8vDho5N/HjIh7qt
         Z9Ptr+nn8v3WTO72rPgiPAQ8RPmiHgoucgj+9Tx7MbN0rfa+jrwgeSN12rI8gvgnldv1
         Yspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzL8vdXPjQmOyUpH6g9C5hBoe1rKYLajXq92s91Qu6U=;
        b=FAMlrv4SkqfdSTrwxHawdi9/6rSfmT0QgEwIqANeaYQnXCax3PGf2Cwylhyps/U5xf
         sb26Rn932E5aa0pKZXK9X6MJUqir/Qq1Q/8i1nMTHa1WUedd7AwMge6RrR9pgs2Yemb2
         zuIQ9yVS2Ka6pnllsYxZmfh6syzzv6k/MOFqXjR5ekReDn2EJU5AJONst5eWWqIzb5Wz
         TtNE1H+8y7TzrDUVsFNBs45jjrEb3/p8En9Leo2bVVAj0JZ5RTnrVpacjOZWEtfFuhHv
         Q+BFY5kjb2D91aE6FKM6AQYXQWJ/ILTpD/4DWILnpu6YFUrHrAdlD9n95HBBDAP5b+6t
         P6UA==
X-Gm-Message-State: AOAM5318TENE1mORno2lt56Ux80b2t4nHrsAZOCZMfzgWyVK2rJXdm43
        y8egXOXSKsLYj3DPHc/Zjm4=
X-Google-Smtp-Source: ABdhPJxoN4bhL3crc22W4evIFJ36j0z/xkW0y87Vk+8RSpyrcK6Ro/sYTYoZ9brZf73791CGI8MoMA==
X-Received: by 2002:ad4:4ae6:: with SMTP id cp6mr22460531qvb.43.1617619776289;
        Mon, 05 Apr 2021 03:49:36 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:36 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 5/9] w1: ds2438: fixed a coding style issue in vdd_read
Date:   Mon,  5 Apr 2021 07:50:05 -0300
Message-Id: <20210405105009.420924-6-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets
are required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index eeb593294fbd..56e53a748059 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -380,9 +380,9 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0) {
+	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0)
 		ret = snprintf(buf, count, "%u\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

