Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F191238AF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhETM4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbhETMys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B413C068D94
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u133so9057899wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1wzD4rzWGYK0ojKhF0X0MRsVPDkthsomyuwYyyjpIrI=;
        b=mnsw0oTmfP/J0h9Vwdh/LXIaVIbwOwng0rT00GJWuQiTR1rVfYN2PVO0rpxUJRJ2Ks
         wFLO72jPJeXsCfklI5GnNgyNkBiUSSAP+wdkJh2L/zzHAYnKyveHGhwTwmy8shcO8kbu
         Ivhcla5toRdlgMygdgBX1NVv65DRTf9xcxkAzvBtG62eV3nyPfxA+hem3B/xcC/Knaqh
         NAC5a3on3sT10RCN0KjURTPmqSM/TaK5xkcUc99mYKcocbHDu1j6Y+vnizF98rjbomWM
         BN3Q5tn3JvYgZTNh+MTpeq/JIlV/gC+0L4P01ReRjOlucrjrtquxD63VVGATSR2RdvGq
         psRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1wzD4rzWGYK0ojKhF0X0MRsVPDkthsomyuwYyyjpIrI=;
        b=NTxPVGW8KAhJaoG/eBZ/y40SbKNF0zUbyZ7cnG5xZm1xccT++BcVXR6k+R6wWmm/8/
         /VkOZ6IcYcHYfL/jP1pSgMbpHfdcWE8mFr+VSZ9LxQ4RMHIe8c6bP/krF8MEnTE8xZjB
         /DrUh3jcP2Cg5tx79Yb0rdz8s502MG7sYqUJ9T/H4Smalymuy6ZDZWSukygObRNPzDth
         VvWPPK8R7eAVGU0svD0Dgi1HAYyWOvGYtKmIEd5FLjta75si13bvKqF6/LxtnKYuPDD4
         fex4FLuf3/b40F1LAwIlX12A/6a0Q7VbxlKCoeCifeOpbG5YqFRXcW0xflfhwvBeP62J
         oTNA==
X-Gm-Message-State: AOAM533RFQuFZJ1KxJOPgwIO6iwZQdqqSEqv5gv4MrYGnGuVp2F4unNi
        5BJUE179MPo/RvyR9IPlF76Meg==
X-Google-Smtp-Source: ABdhPJyZYS/CHSSe/QYyN7dtmArWH+r/nsZP7UGhj4dA5LWlMMF2F8T8oOegJ7wwxYCAsefmdh3s0A==
X-Received: by 2002:a05:600c:4f0b:: with SMTP id l11mr3718034wmq.126.1621513155063;
        Thu, 20 May 2021 05:19:15 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 05/11] tty: tty_buffer: Fix incorrectly documented function __tty_buffer_request_room()
Date:   Thu, 20 May 2021 13:19:00 +0100
Message-Id: <20210520121906.3468725-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_buffer.c:259: warning: expecting prototype for tty_buffer_request_room(). Prototype was for __tty_buffer_request_room() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index ace778ed23b91..635d0af229b72 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -244,7 +244,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 }
 
 /**
- *	tty_buffer_request_room		-	grow tty buffer if needed
+ *	__tty_buffer_request_room		-	grow tty buffer if needed
  *	@port: tty port
  *	@size: size desired
  *	@flags: buffer flags if new buffer allocated (default = 0)
-- 
2.31.1

