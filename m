Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE920338AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhCLLDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhCLLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:02:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5410C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f12so4550714wrx.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qrh/baXlu1cPHqbz4NOWsoneeOTFHNvhG2DUCXoFZLU=;
        b=MAV1jPRf0fzetiDweOTl6O+TsygFlS9dfGSulTwS4Obx5K3l18R8Ie5Vz5sfMiKI0v
         UymAebZopAbRPdmmKCEvnGZvP2B/CkS8z9RzJ/cDqHExGK7aZatJA/Kwx7GscxdA9WYm
         4e1sSnQ+ytdlgP1qZXCyzAX1BmZA+fq2kHhaPrH9Ak5Cf/jOk+XPUhNl7scJTlT1GOWB
         1tEAJ88af1zPUvLA7uosjLuRXumnqrvQovdKO04cyRmFH2vBZuBZ5t6r3W/vJO0WedbP
         PvxOWZVG07iez46MF6jAruO/S0ESEs6Ui0bp+n1X5YhR5JEV1PrvC9O1jV7M6zSdjOEN
         mIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qrh/baXlu1cPHqbz4NOWsoneeOTFHNvhG2DUCXoFZLU=;
        b=Uy4qqLR5X6jaP3DljNXSsctx5ImXS37SYnnTkMs8c+RQOG+lOC7e1AaKjPADO9YVMK
         85YAc2z4FBREKnZuWrKZuqJ3PgJdHlTYAdirKBFQggjzLw+7l1rLvldKxG6LFdpW25fz
         MSlG81hL1DLO84lu+neYOfuTRTNAt/okFw7zeH3e9NJLHEhbNXvuCW5ZsbsStuG0nZfb
         M1dCaBisd7aG0XECeAcBEIvBdf6i2f9Le3571y9Cqs3EpmPAm7nGFYD9KqCNnLX1h6Ag
         4z2QAiX8WdmktrkV9pa1J9yZ/RR7PZQUyMNtRZ3n01y39btBsU9U3JSTzLtBZtvze/rz
         +cyA==
X-Gm-Message-State: AOAM532522lOMJV0iqEGva2y4OSVJ6N75eGZNNByRg6GTFeik/eHoSf5
        DH0sTnPLltp1RX8HdDeacd9M3A==
X-Google-Smtp-Source: ABdhPJwAL3EUS5XkHs59zf0axdqDTmLNzfR/B16+tMSiQtsga8uCEphOjfLEDom8Yn6MIQgfeFauDA==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr13287124wre.386.1615546967568;
        Fri, 12 Mar 2021 03:02:47 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id w131sm1761318wmb.8.2021.03.12.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        dahinds@users.sourceforge.net
Subject: [PATCH 6/6] pcmcia: rsrc_nonstatic: Fix call-back function as reference formatting
Date:   Fri, 12 Mar 2021 11:02:39 +0000
Message-Id: <20210312110239.2220197-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110239.2220197-1-lee.jones@linaro.org>
References: <20210312110239.2220197-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pcmcia/rsrc_nonstatic.c:349: warning: Function parameter or member 'value' not described in 'do_validate_mem'
 drivers/pcmcia/rsrc_nonstatic.c:349: warning: Excess function parameter 'validate' description in 'do_validate_mem'
 drivers/pcmcia/rsrc_nonstatic.c:407: warning: Function parameter or member 'value' not described in 'do_mem_probe'
 drivers/pcmcia/rsrc_nonstatic.c:407: warning: Excess function parameter 'validate' description in 'do_mem_probe'
 drivers/pcmcia/rsrc_nonstatic.c:407: warning: Excess function parameter 'fallback' description in 'do_mem_probe'

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: dahinds@users.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pcmcia/rsrc_nonstatic.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 55f9fed478eba..bb15a8bdbaab5 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -343,9 +343,9 @@ static int checksum(struct pcmcia_socket *s, struct resource *res,
  */
 static int do_validate_mem(struct pcmcia_socket *s,
 			   unsigned long base, unsigned long size,
-			   int validate (struct pcmcia_socket *s,
-					 struct resource *res,
-					 unsigned int *value))
+			   int (*validate)(struct pcmcia_socket *s,
+					   struct resource *res,
+					   unsigned int *value))
 {
 	struct socket_data *s_data = s->resource_data;
 	struct resource *res1, *res2;
@@ -398,12 +398,12 @@ static int do_validate_mem(struct pcmcia_socket *s,
  * function returns the size of the usable memory area.
  */
 static int do_mem_probe(struct pcmcia_socket *s, u_long base, u_long num,
-			int validate (struct pcmcia_socket *s,
-				      struct resource *res,
-				      unsigned int *value),
-			int fallback (struct pcmcia_socket *s,
-				      struct resource *res,
-				      unsigned int *value))
+			int (*validate)(struct pcmcia_socket *s,
+					struct resource *res,
+					unsigned int *value),
+			int (*fallback)(struct pcmcia_socket *s,
+					struct resource *res,
+					unsigned int *value))
 {
 	struct socket_data *s_data = s->resource_data;
 	u_long i, j, bad, fail, step;
-- 
2.27.0

