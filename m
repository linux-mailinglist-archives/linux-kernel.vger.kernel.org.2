Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26DB34A4E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCZJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhCZJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:49:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B1C0613B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e18so5007396wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5RGBhtc8B0CQ4lJYtxou050kNCF2DXi1TsqkNg1BZI=;
        b=u5/EJEwkxMLM1gM7JszzsoxTHw18pvP2F6utU4pnAbeMTiIPp35my2btgwCxHy5N6k
         Xt94mjKQLoMp0AziV8TpSBbM1PUYccnSy0qC/i0q9qr0atD+UcbccMWtskUz/KJiSBZJ
         LYX4+v7f17QfGTk09Up/4pQYJDOYrT+1uMog+iskmrrbgeFZRzX034CnRpsPCin4g2W3
         LZlmae6D8QoRzx6KuDmkmCuXWSvJQVm5ExVI11dsKs6QTrJbRnfyYOK8K2E7psgv3whH
         eygO9y6jZJWHb2X/tiBA6E0YVtpL+837StCbB+ORf4JUJd1ZyN3dpVWrCQ9upANaRcvG
         zopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5RGBhtc8B0CQ4lJYtxou050kNCF2DXi1TsqkNg1BZI=;
        b=MnbxS9qLAKHuKg635am+eTMXVZUWxf2+MVANEtXMi2fKcNhgWXxCHzOGS6WzsgBboG
         J0GcVPI0o7emxnejuXdUA9L0qJZXTr9KE/V8bKbDY2J/aF7Sdd+BkKNC0Q6RVSq5EQSj
         DYGI3YhAEvb/q4hII4o7DyjZUPqsw1mDk53Gipa7KmvTy3FSXvvvYuQN+Bxfip7s8fJv
         J/EViNLiWSl6k3WCq8Yu+0oZfuFfozaHSlXzFlkTUpkGgDhikyldNS8nOx/ysH20M9S2
         syrqCsvAdnwroktbtwk3dvqtJaZYI2VesQHspxEbZ+hmY1tFhN75+0uo884oGZdxVQXy
         VAYw==
X-Gm-Message-State: AOAM531wRAvB8lqDqneDh1cyCXsOOOb3/l4prq+A5BkWiletdBHy5AbD
        GtZlZ4NYa6Udoiu8eHiuXT4=
X-Google-Smtp-Source: ABdhPJx8M/2WUeGAKEU95OYY2YS+pM9yC77h4rBcthMCKhasOS18NvwMoaU0Ykq4X9Ow4jmc/eeAYQ==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr13528063wrz.74.1616752163516;
        Fri, 26 Mar 2021 02:49:23 -0700 (PDT)
Received: from lorien (home.raoult.com. [78.214.78.108])
        by smtp.gmail.com with ESMTPSA id x14sm11746009wrw.13.2021.03.26.02.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:49:23 -0700 (PDT)
Received: by lorien (Postfix, from userid 1000)
        id 6DC00140301; Fri, 26 Mar 2021 10:49:20 +0100 (CET)
From:   Bruno Raoult <braoult@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        zhaoxiao@uniontech.com, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bruno Raoult <braoult@gmail.com>
Subject: [PATCH 5/5] r8192U_wx.c: style: avoid multiple blank lines
Date:   Fri, 26 Mar 2021 10:48:35 +0100
Message-Id: <2c1f2c668d299ce1895ce97dc7fb9a67d3723e63.1616748922.git.braoult@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1616748922.git.braoult@gmail.com>
References: <cover.1616748922.git.braoult@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl check:

CHECK: Please don't use multiple blank lines
in drivers/staging/rtl8192u/r8192U_wx.c

Signed-off-by: Bruno Raoult <braoult@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index e0d32f7b0ace..203ea3bfc843 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -877,7 +877,6 @@ static iw_handler r8192_wx_handlers[] = {
 
 };
 
-
 static const struct iw_priv_args r8192_private_args[] = {
 	{
 		SIOCIWFIRSTPRIV + 0x0,
-- 
2.27.0

