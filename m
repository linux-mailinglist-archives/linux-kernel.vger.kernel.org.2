Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8523531E7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhDCBYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbhDCBYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:18 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44490C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:15 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l13so4753462qtu.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzL8vdXPjQmOyUpH6g9C5hBoe1rKYLajXq92s91Qu6U=;
        b=YsX5FDBhs41oGFrHON6+ZVFxJjWlT8j5U9psa3BH50Da0V2Cu10xkKjY7D1jMA5Imr
         6h54lfdKztuHq8H7EcCr1eo7zXrCSPui9qEdegzOx9c5HZAr8dicAM5ywvy6GnpDKsow
         AbzbcsyjKoIdmyHZhZBqwNyXt0MAfzC6thbsxqLKZMNeWiIQMJtVblPaexYXZ2tLfud6
         kC7rhtexKc+rt3HIbBkgdWUywPDWMnP28m8kpfEQ7q8ZTkUlSnUycHxJUYvkK9cf4NQN
         czHm+qnbAnhV0y1RlaErVQPk1XS9uAK3y2phHzE36d3oGpEU3RGpqQsQmCaCfoGDMNGG
         nZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzL8vdXPjQmOyUpH6g9C5hBoe1rKYLajXq92s91Qu6U=;
        b=KXROxT01Uhi4SwH9DQrlD4wga6BIhe8sjP81NRp/Cgjx7WGYc7W4Fm8C1kZqZru2yX
         U5ieREOabpZywe9xy9e11vzyIhUZKO/yjnB/B7fomMS9qHNd0RBDca6yTHzQtNz/bj7V
         DBtBt4Y8428FBc19lCsIGUqkzfzUd2L7fGLvQOUwlyEt1NLyXo6D+1TYc6D4g4OX4tA6
         PfjZMPjrT63SwxGPeKQOLQ6o+vSpRl5Y9+o0S/3L8hNo0keEQ2LPl0glLiePRgAiwmDX
         OhmRT6RGel/a2vFTaWT5dJshwYFXOXKDAUrqKRvFV2utcijIOquwua/YqEV9taYJLdmf
         OPkw==
X-Gm-Message-State: AOAM5317dy4+9Z6/VacbB85P9+5XbFfz7BOnXRW3qy6TG+G47kDEhHhT
        2xlNJ6MS9H+tcnAxPRQEq5Q=
X-Google-Smtp-Source: ABdhPJybkf+RSfwV/+FlwTXjNVijdCA/mKGvtez0+9Yv2QZ3WFnI/CzECzoQajG5gkpds7/4L24ejw==
X-Received: by 2002:ac8:7747:: with SMTP id g7mr13701461qtu.144.1617413054528;
        Fri, 02 Apr 2021 18:24:14 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:14 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 5/9] w1: ds2438: fixed a coding style issue
Date:   Fri,  2 Apr 2021 22:24:42 -0300
Message-Id: <20210403012446.381516-6-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
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

