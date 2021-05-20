Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF538AF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbhETMzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbhETMyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B35C068D8F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n2so17527244wrm.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N99o2mchRp6BDZwqTtgfkSHrMpqbg+gTNNTFZk/BScA=;
        b=Xy5BGa/UcUMedwvTL3ohQjiOT2/Yfd579ISCzcqUS2e4DTXFnYeG1tltS3YJkIg/K2
         x3NyRBHIDJe4wj+S7ocFJkTFRY8To/ve3G52JvTqubrr4AZURqqmSBpjZtC2SXhSFJSH
         MtX0zY9EALpXN8G6uO6Q1VK3T0QkE6MIS6M3Z8pSoy0x29Y5fqrCM8B8AXYHM+soKrNT
         rY+Jnj814ygT83/8m2yFoJaSZaRsggtE1lq3J8KThPWrvRNhAi+G2pHHEgOjqReWLKPH
         DY/i0m8NJJFcHcVDzUukjU1gTWPMQDfsVh5VbLOqYcRLrpMOOT9K6gS369xhZWCZpT0j
         IBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N99o2mchRp6BDZwqTtgfkSHrMpqbg+gTNNTFZk/BScA=;
        b=psljF/15nQ63GDvcwhtcEKv7CsrMpDNDqL/TtLmepsrx+GiJEhYS14eQrvB1MmDDoH
         Rz4g1P83jkHbPUnfvodMkI0fI5e54ozAct2Slw84P5ve4XhoeHme1u1SE3xfS2Qn6jJK
         STgj+t+5VJuFX045+jBxzATiRFmoOWCajXvZtH8GmAL7qSpf9trulNkPzgUS5sj8eCSE
         y5ZFhd/De4GfU4SAwIhLtEHwSxZ3QLW91v52HH+/xk5DDiK9+EZnLl/taQHeUfge7zub
         3EeTslNCt7sfZTTlH9P/I5o0Zjq/smbR3JJrB0TGLMZeP5jJ3REX3eQori8nstnmrSSb
         XjOg==
X-Gm-Message-State: AOAM530YdWw6KSP72OlfERYKfAOWMch8ctdE1yOlql8dRtz8lC8WKKYc
        S4s+a6cdEGI6a9jAv+R71YEJ40hacd3slg==
X-Google-Smtp-Source: ABdhPJyAS8jBeeklDLgfYv9r89uaEHP9t6L/CZ/+cXmVSfKE2SQLWN8O/BQGdMqhfEFvWPHKFngCKw==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr3946414wrs.314.1621513150662;
        Thu, 20 May 2021 05:19:10 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 01/11] tty: vt: selection: Correct misspelled function sel_loadlut()
Date:   Thu, 20 May 2021 13:18:56 +0100
Message-Id: <20210520121906.3468725-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/vt/selection.c:119: warning: expecting prototype for set loadlut(). Prototype was for sel_loadlut() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/vt/selection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index bcb6bc5731cc4..f7755e73696e7 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -109,7 +109,7 @@ static inline int inword(const u32 c)
 }
 
 /**
- *	set loadlut		-	load the LUT table
+ *	sel_loadlut()		-	load the LUT table
  *	@p: user table
  *
  *	Load the LUT table from user space. The caller must hold the console
-- 
2.31.1

