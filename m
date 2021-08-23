Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE703F4EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhHWRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhHWRBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:01:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71622C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n12so27206872edx.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrVKmrMNGmYrnLOt8MnaYQpufc6zYgpvwecmFAsExMo=;
        b=RPHCxu+3v+zW1cMEza2jd7MbvinIgr5YZo0byGiWrZSwbEXeoQg2pleKosJt7ceO9t
         cIn5+0RLOJYgVDN99uSrLzeFB0xJcsNN4gcMwjBlkx6YRZhXllaFAmIVsI4BCgN8Y08N
         vbzj6Dc436GlWEoI+HBShoo9wxnsM/RHXiZ5nopyUVjQT5+dGYMWNk94O1BkrovzqfFp
         kIzcVw0ww1fCQ92xcFO4/lkKUtngVn08S6UQLP6DKldVR3Y4dtedvYza8KoqcKitmYsO
         uIOZMhKaUuUTYwjK2E9EL/mG4hp2jISXjglwBpdHZynv8o+Px4xt4WTusFSQkdyHGaFS
         6KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrVKmrMNGmYrnLOt8MnaYQpufc6zYgpvwecmFAsExMo=;
        b=L044dYBB4ESzWSmPCivw5CMP2zI/XzY8zHGYDQZxeYAhe9rr2yvWhhuUSQTe5i01KG
         enyt95po+0j3AoF6RcrA0BBgDgUZZ+mkz/nV8sTboM+t9bbazsRYglRG2SKjHdZsu6f9
         gwgj9YgpLDjXSVIa/sP/0QDCZN5KrJkalQllV79F/SFJPbO1n+WJZdev2QqYC9KO7YBb
         kaZl7AmJapAE10qEfgrIRU1PXtGQ47ontZa2qhdgI5eESX2tHD8do/goFsH8ELxRFcCa
         1wtTpp55uQjucbCKMpT0+MC+FtMw+G05PIUZrc+Vm4p7h3TF3W/hHHJ0wVRvSCySd9qs
         Sjhw==
X-Gm-Message-State: AOAM53116JaXWqsk7OUuriQgmxP/MzDhMDdtL9vIt/8+hgUuG84OnHi/
        fZChOKfy/G5eM3AVde8ea8s=
X-Google-Smtp-Source: ABdhPJyIQCCUlf6o4J1leGtiYdyQX+qMZ9xUa9sAGVlNdl+Ur7XKnVPDUrlGshAQF4gJ9z35a0XV4w==
X-Received: by 2002:a05:6402:51c7:: with SMTP id r7mr38085232edd.65.1629738047034;
        Mon, 23 Aug 2021 10:00:47 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id b18sm1633188ejl.90.2021.08.23.10.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:00:46 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] staging: r8188eu: cast to restricted __be32
Date:   Mon, 23 Aug 2021 22:30:27 +0530
Message-Id: <50439a81aca7ce8c3c97ec1c7247f4cd03f645a5.1629563318.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629563318.git.aakashhemadri123@gmail.com>
References: <cover.1629563318.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:836:54: warning: cast to restricted __be32

dhpch->cookie is be32, change it's type.

Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---

I had incorrectly removed bytsewapping without considering the hardware
runs in big endian rather change type to __be32 as sugessted by Larry.

 drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index f6d1f6029ec3..f65d94bfa286 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -649,7 +649,7 @@ struct dhcpMessage {
 	u_int8_t chaddr[16];
 	u_int8_t sname[64];
 	u_int8_t file[128];
-	u_int32_t cookie;
+	__be32 cookie;
 	u_int8_t options[308]; /* 312 - cookie */
 };
 
@@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
 					struct dhcpMessage *dhcph =
 						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
-					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
+					u32 cookie = be32_to_cpu(dhcph->cookie);
 
 					if (cookie == DHCP_MAGIC) { /*  match magic word */
 						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
-- 
2.32.0

