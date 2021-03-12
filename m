Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A601338AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhCLLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhCLLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:02:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62816C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e10so4549261wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5kgH4ofJObMmZVQlhcJQgNsfqmHbHR4qGRet15JsVI=;
        b=yroH5uAYaBph4GWTXmnNBdXF4xsdPTly/14RKeXlmFel5B3G7wc2y92qfMWf3+WWAb
         nFdYlaG179LOZ9SGHWcIiyEgNf3hO88tH4BEIK0A2iLYu8B2aRwsfmHnDyoazAW4OV+L
         ugjcQLXkNbTazlEO2Vt2EbW/gCulSNqjPd/jJoilqZpLdz0oQ/jjmpPBorOYm6emSNe7
         cDH99bkTYzluEgUS5kEJ7mm0+6veQ442LEXRYit5my5fvFUZWjeUxaA3XAWF9UaRWCP+
         rX4bB1UHEKEJKbV5EKsAg96v9awcNdyc3/HDJWgI8d+NsSMDE2EjCILDmIYTDHE4lY3o
         ZrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5kgH4ofJObMmZVQlhcJQgNsfqmHbHR4qGRet15JsVI=;
        b=uJSFPjzd03ocVZbVCfPxHQ+La51aOirMAT+Q0ZxCcwVZb60GL/WkpJWumENJMoFc10
         AD2cGkmpDzJ4YJOsHUluyD0lZ9zam/PpskvMYGOjdDd42EUKRxzNcKVWUbG6J1D78L+Q
         cP4sU40RyVPlKTmX7WwoJNSsedqqJmsm7ipTVARt6t+cpBCXNx/0+KA+fRgw8fysmeQv
         pg0U165RhsXIYTj0hS6Ll6gpe3/S3xGIN+ddW9+iel1sQcod6qnCgFGj+INYZLRrWBQy
         /9nl13gQ5sVANmA4N2ZIjIhkrz2KcMRGrhSBq2DgtQywfvIrvjYvkhdeXGSQ0vN4xJAz
         3J4g==
X-Gm-Message-State: AOAM531jaFthTygmnaXqqZNOquwPUIy7KWqOJqh1/3QcX4Hq5AglWwKU
        tdLAFzjwlwKpYHqgc78n03n7yg==
X-Google-Smtp-Source: ABdhPJy/tG7kQdhXXfN5czPz1NEEs4UTMFUqBhjptqndLoW31wRr88lRjX1iKh/0CjsCWJnwVGYAPw==
X-Received: by 2002:adf:c64a:: with SMTP id u10mr13368501wrg.412.1615546963139;
        Fri, 12 Mar 2021 03:02:43 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id w131sm1761318wmb.8.2021.03.12.03.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Takashi Iwai <tiwai@suse.de>, dahinds@users.sourceforge.net
Subject: [PATCH 1/6] pcmcia: rsrc_nonstatic: Demote kernel-doc abuses
Date:   Fri, 12 Mar 2021 11:02:34 +0000
Message-Id: <20210312110239.2220197-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110239.2220197-1-lee.jones@linaro.org>
References: <20210312110239.2220197-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pcmcia/rsrc_nonstatic.c:265: warning: Function parameter or member 's' not described in 'readable'
 drivers/pcmcia/rsrc_nonstatic.c:265: warning: Function parameter or member 'res' not described in 'readable'
 drivers/pcmcia/rsrc_nonstatic.c:265: warning: Function parameter or member 'count' not described in 'readable'
 drivers/pcmcia/rsrc_nonstatic.c:296: warning: Function parameter or member 's' not described in 'checksum'
 drivers/pcmcia/rsrc_nonstatic.c:296: warning: Function parameter or member 'res' not described in 'checksum'
 drivers/pcmcia/rsrc_nonstatic.c:296: warning: Function parameter or member 'value' not described in 'checksum'
 drivers/pcmcia/rsrc_nonstatic.c:349: warning: Function parameter or member 'value' not described in 'do_validate_mem'
 drivers/pcmcia/rsrc_nonstatic.c:349: warning: Excess function parameter 'validate' description in 'do_validate_mem'
 drivers/pcmcia/rsrc_nonstatic.c:407: warning: Function parameter or member 'value' not described in 'do_mem_probe'
 drivers/pcmcia/rsrc_nonstatic.c:407: warning: Excess function parameter 'validate' description in 'do_mem_probe'
 drivers/pcmcia/rsrc_nonstatic.c:407: warning: Excess function parameter 'fallback' description in 'do_mem_probe'

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: dahinds@users.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pcmcia/rsrc_nonstatic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 3b05760e69d62..55f9fed478eba 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -257,7 +257,7 @@ static void do_io_probe(struct pcmcia_socket *s, unsigned int base,
 
 /*======================================================================*/
 
-/**
+/*
  * readable() - iomem validation function for cards with a valid CIS
  */
 static int readable(struct pcmcia_socket *s, struct resource *res,
@@ -288,7 +288,7 @@ static int readable(struct pcmcia_socket *s, struct resource *res,
 	return 0;
 }
 
-/**
+/*
  * checksum() - iomem validation function for simple memory cards
  */
 static int checksum(struct pcmcia_socket *s, struct resource *res,
-- 
2.27.0

