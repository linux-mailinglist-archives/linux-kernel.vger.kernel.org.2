Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7132AE0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360432AbhCBWUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383536AbhCBVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:14:53 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E40C0611C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:05:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m22so33561967lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wV5vWayJH1wzoJfttdzEjQ1CkwAkLDd2k6N0moC+rQ=;
        b=MSszvyKE+Fxpt7ew/Vd9VD1v4FDykU9NFb3U1HrWy+GiNgfxqL4R4E6N08JyqAjnBk
         g0vCHMw6wCgAuFti6J1cGhjEI2hzbO3FEa9pftzuKD0YJpVHXjA8CjPjEg7aBzjNCAwM
         vRVsF+Kk5abomC/LvLQbeTQQgS4LnNZX/9Rs1dLSMV9zXXfKuLH1U1jjzCfz0Ktt+sFd
         dCqsmlPphROYXIr6Pc3j8cl9CA2jCSI+A9Q0LKCuzGWv4n7KjcSs74a16JN5kZjPkYvn
         LatI7nBGgUscGFZfMPYx9NhLXnkVWpATJI6VuuO3dZu9H9SusTB4tfSnkFDUMczHsbdX
         9kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wV5vWayJH1wzoJfttdzEjQ1CkwAkLDd2k6N0moC+rQ=;
        b=E4Mb/5Z1uGzaOE3ijU+a7rsZV9eosm83q4j1jnNPGiS0SDCtGJOA0gicZ4P8nVxFv9
         0I+vUaHG9fO9x+1fq0QQvakgLD89x4T4JWEuHrxhemP/GiE7WvxLxjJwW+adwvpyhthP
         sbc71JsUJhomvV258jq0R1CNoGIZ7X5z6YpqQ2Vgzbb2e7FQT2b182Rte8ybas1U/NYF
         3gCeXCh5AdQPRfmmffNE4CN80nYZcIkApSjH64/LE1JxobenRjQ2YyJOpF3PBFLTekh2
         UoyzhQYrahb32QtcV4ER/B+CwA4I+nwDWZeEZUhXsAO5bS7VoPlxffMzDD36NyFzTS2v
         Hp1A==
X-Gm-Message-State: AOAM532S84kwDQYM9D5ajy91XQ2pPjwMuXf26uuBIyRwAwJ9I3poFxwo
        IxGm9FCz9u4iqJurgXe9Bms=
X-Google-Smtp-Source: ABdhPJzGra903vRQ0P57kGTfVpkLCaNdWVVSNBT0DC3dFfDlOlUiaY0a6CnB93e9mV3T+kiOlxzJbg==
X-Received: by 2002:ac2:5ec1:: with SMTP id d1mr12743019lfq.48.1614719135097;
        Tue, 02 Mar 2021 13:05:35 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id k6sm1619796ljb.110.2021.03.02.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 13:05:34 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [RESEND PATCH 1/3] mfd: gateworks-gsc: Constify static struct attribute_group
Date:   Tue,  2 Mar 2021 22:05:26 +0100
Message-Id: <20210302210528.70945-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302210528.70945-1-rikard.falkeborn@gmail.com>
References: <20210302210528.70945-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of attr_group is to pass its address to
sysfs_create_group() and sysfs_remove_group(), both which takes pointers
to const attribute_group structs. Make it const to allow the compiler to
put it in read-only memory.

Done with the help of coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/gateworks-gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
index d87876747b91..8745f9d8c26f 100644
--- a/drivers/mfd/gateworks-gsc.c
+++ b/drivers/mfd/gateworks-gsc.c
@@ -150,7 +150,7 @@ static struct attribute *gsc_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group attr_group = {
+static const struct attribute_group attr_group = {
 	.attrs = gsc_attrs,
 };
 
-- 
2.30.1

