Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE171313E37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhBHS41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhBHRKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:10:46 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A64C061793
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:10:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lg21so26095699ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fcxfvlPp7TZmF4CwK9STJiD+qz+M+quoSHm+tIoORKc=;
        b=lF2KqALGf3iYucDOMIQ75O0nZFn03w0BoEw2ZobKvy35LjB+U4p2/mfwdSx0KTzaDH
         wQ1PWphX4ooUUqNFlwEv6rqhjZAvToXvANa4MHdKYjKYfvoOJWrZldZ7yO3mK9KVIa5I
         NQy+AoYPsHYmK0m7JcjtueYRcR7FrzlCaHRJHzKnkN7oetKj27N97ti4/GB/9Xh4BXi/
         3QpMAZbZ6y1gGEZkkbPFi2p5bb+b6h32AbTZaK1gxFhz3rT5PR2nADVbMu0gkcy9LVAI
         p4DJ1sPm40Ap5iTqKWlSjfeBT0EquGTdo92m/4Ni0W6hV6Q78j+VOr8iouAM+TLZMHue
         U/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcxfvlPp7TZmF4CwK9STJiD+qz+M+quoSHm+tIoORKc=;
        b=Teu0N9hbbqSzE0u+9A/6X+a52XdZLRGOcJhVri2jc1IgdGFzTNXG9ruQ/wzC7h5sKC
         zNv9YdQDVVHLRfpH76ibWayzmJ/jLrJTfJb3U22DQ7LEJa0GOC8DjpirYskyVbTOGcBb
         WYT6gLD8uVAvZUfof/j+IG5OenohmNq1txsTXszWNRA0rw66EHN2cWjBKLHw+HNI3Zhq
         lkBICNgmIqccyi8/oRkFWi7DUKMx1s+NeUkedyRBFywrJgy+F2fPe7L9LNIwaJLUkUHo
         eCeOcj4MDxRdJ7VBasR9pgFALC5nRC0qWCI5bvWQFbqK6dDddQhWoZ/aygfhOJ1ZzZE9
         Sn4g==
X-Gm-Message-State: AOAM531aEkOYX3uoKrTvMFmHAU5g/ez8i7lucNklfLdjGyUYyq02GTq4
        soZYl3vYgg1LCTbrcwWeLgc=
X-Google-Smtp-Source: ABdhPJwgnsLmHACZ0GCBM09+9tCQxdVCIq/BjkM/aY7Q7YuxYl2RIY35QgQ/c5RcacJf6hzLUHdF2w==
X-Received: by 2002:a17:906:6145:: with SMTP id p5mr7580527ejl.185.1612804205209;
        Mon, 08 Feb 2021 09:10:05 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id m10sm9834479edi.54.2021.02.08.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:10:04 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/3] bus: fsl-mc: add the dpdbg device type
Date:   Mon,  8 Feb 2021 19:09:48 +0200
Message-Id: <20210208170949.3070898-3-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208170949.3070898-1-ciorneiioana@gmail.com>
References: <20210208170949.3070898-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

A new object type was recently added in MC.  This has to be added in the
fsl-mc bus device type list so that it can be properly listed.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 70f4b69556f5..0c8bf020ba43 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -388,6 +388,11 @@ struct device_type fsl_mc_bus_dpdmai_type = {
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdmai_type);
 
+struct device_type fsl_mc_bus_dpdbg_type = {
+	.name = "fsl_mc_bus_dpdbg"
+};
+EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdbg_type);
+
 static struct device_type *fsl_mc_get_device_type(const char *type)
 {
 	static const struct {
@@ -409,6 +414,7 @@ static struct device_type *fsl_mc_get_device_type(const char *type)
 		{ &fsl_mc_bus_dpaiop_type, "dpaiop" },
 		{ &fsl_mc_bus_dpci_type, "dpci" },
 		{ &fsl_mc_bus_dpdmai_type, "dpdmai" },
+		{ &fsl_mc_bus_dpdbg_type, "dpdbg" },
 		{ NULL, NULL }
 	};
 	int i;
-- 
2.30.0

