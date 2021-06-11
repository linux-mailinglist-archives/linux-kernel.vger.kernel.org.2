Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FE3A3E11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhFKIgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhFKIf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:35:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB97C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:34:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m18so5122835wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4SLxXmaHOMr38CprTPFYOA7vJyvBpB8ARcXhFV/1hU=;
        b=UCGQPsW3tFLhXhexqANi9Wo9V9Ohn8qcLvcA2Gnvu+PsH39VKx9dzBL05+NJZPMD3f
         eyp32K8sSx3NieOqSwF5FblewXX1IJZTCzrF7Q8s5nRD3cdoccxbykVf3n7x7xEnXxuh
         z9mef3QI1SoqgIzOvb4257CxA7PuaMd7R/19XYkv9/IfC7RA0V6b7T4BNU5SRlCtk/ID
         FyEIpsDDgsUJ97YH8O2p+gg+NpL+QbyuFuSExZ2ZeTUm7z6iFEocQrMZHpiCjG+8xvxj
         YBqnbWRv5xpx6gXbq6K+hYKmiaYtXtYoHP6sgSozYFd1LFZ+9tqM7RKW7LUJtb1/qKEY
         MJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4SLxXmaHOMr38CprTPFYOA7vJyvBpB8ARcXhFV/1hU=;
        b=stPJLjQSISsOr3KbxC/LKuN4vVtX7I7B5j3KSZeI3+OyMkO7/wGQDBHPY4abUSMlMj
         A2vLKusI/snI4VqyfLu0yFVwbRU+/t+2EzvlQuy4yQ/73cgtoaW5zqZ0mdMOhUXVPttP
         upjLqU+YJ4fIIpmhBmTNYHVQNIh41T3+j9Q6/dQ7IBxxBnTsoH87H2ufbR68s/tqwDba
         VM7M5LdqdUGMoKFZryb7gmnIUyVke8wLE1hKaoQAOydwc1Ja5CZ4XHDtLwuvToaoIMuD
         wvydczheRoJa6WYptglXfQF60tHVRe4eRDs858hP1D2dEmAfrE2qUC+S2d5fTyM6B7YC
         DSgA==
X-Gm-Message-State: AOAM531U9PBQSKCsBuPUw6dgb606kPog+tVv4brUhk7UtLrpGt7W3QR0
        nJYEUxZWhe6Z3jpJhaQRsVzRGI0D7juLDQ==
X-Google-Smtp-Source: ABdhPJwar/7Arc4WM8j3j3n75D2n88SijIIpoQ95tsCppCtsNzqmRrmERvstpPFRNDl6kZU4x26Ctw==
X-Received: by 2002:a5d:540b:: with SMTP id g11mr2800764wrv.390.1623400438850;
        Fri, 11 Jun 2021 01:33:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:33:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/9] nvmem: sunxi_sid: Set type to OTP
Date:   Fri, 11 Jun 2021 09:33:45 +0100
Message-Id: <20210611083348.20170-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

This device currently reports an "Unknown" type in sysfs.
Since it is an eFuse hardware device, set its type to OTP.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index e26ef1bbf198..275b9155e473 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -142,6 +142,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 
 	nvmem_cfg->dev = dev;
 	nvmem_cfg->name = "sunxi-sid";
+	nvmem_cfg->type = NVMEM_TYPE_OTP;
 	nvmem_cfg->read_only = true;
 	nvmem_cfg->size = cfg->size;
 	nvmem_cfg->word_size = 1;
-- 
2.21.0

