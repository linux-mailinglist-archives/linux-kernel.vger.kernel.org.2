Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C138AF54
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbhETM4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbhETMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F31C068D9F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v12so17445141wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmeP4shEVUxm4nddO+VtqF0TjdiZ1wqBtvFWZQrVcCM=;
        b=VFUbdnEU9roYcgKMSj5KtGYsAsWELwhD/2PY47Uelx6kBq8s1vo6MyF2tgDcLJugUK
         i8I7/pmo3jfKVNqT+7fb8B25E6LGdDQbJVmHZ8v/MCccytJy8dgUmztzn9kOJVzO+Elb
         ASH18xJ0kBkU7gOIOUWg0mFpE4FEdOOUAiOeDEaBvBOkKbgJkbcs4WEVxnQM4UoAyU+D
         bOZXKENMGoUP/wk4sH8NGXxcWJbUT+GNQJ2BPiC5tmsyBSKZuP6x8E73wxPqpcayD20y
         /yenJo6rKedvRHeUvwt1YT88fyieaflTPC18ReA16VCalBsRfHQh3TH2vGvLmpAbtCni
         hR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmeP4shEVUxm4nddO+VtqF0TjdiZ1wqBtvFWZQrVcCM=;
        b=NuMaTQbgmquFBHwRrCi9vINAfMBx8PT3FEAA/v2GFqBOr4NXgbyErLAPFwf9Hj4I5O
         1PI9UqGpaDH4ecotu/uY22IJPCh8stXBfY1jBpksSjWBMUva9ygywSROXzIR75Rtq8gd
         5YX9M1+lIUcF/IzmKDAwpbvI0QEEk8nbBxZlUi4g7bUIpSpWiRyISrI0XB7fktvcwwKa
         NVV9AuWpmoxI/9SnxGG76owaXmwr4m7nZGSNvcxWzVcNGaYpDZYXeMkIKNxtq2gfIXaz
         tNU5UFKKIcZR1xqiz3yiviJx4VRz9sqm+m55tDuWBkxBxa9RzmO7DPQU0L0NlvlHKftw
         V1Gg==
X-Gm-Message-State: AOAM531S/mAGIDxAcLzP0IBPA5PzYSLmkROPgsRJ+K4e1g5YnKoq9wci
        fvObHWNb/G9XaJdhrNVK0inMxG8GvCh1cA==
X-Google-Smtp-Source: ABdhPJwAg5UVC6IKD5IO2IZTM6ssAdX8Or3toK/cYiDcqHBSTfzrSwCz0nHdmJWsMsFg7loWQdEI+Q==
X-Received: by 2002:a5d:498c:: with SMTP id r12mr4018497wrq.31.1621513159689;
        Thu, 20 May 2021 05:19:19 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 10/11] tty: n_gsm: Fix function naming and provide missing param descriptions
Date:   Thu, 20 May 2021 13:19:05 +0100
Message-Id: <20210520121906.3468725-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/n_gsm.c:525: warning: expecting prototype for gsm_stuff_packet(). Prototype was for gsm_stuff_frame() instead
 drivers/tty/n_gsm.c:1608: warning: expecting prototype for gsm_dlci_control(). Prototype was for gsm_dlci_command() instead
 drivers/tty/n_gsm.c:2561: warning: Function parameter or member 'cookie' not described in 'gsmld_read'
 drivers/tty/n_gsm.c:2561: warning: Function parameter or member 'offset' not described in 'gsmld_read'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/n_gsm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index bd24dc0d7e967..e907b7a5cab58 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -512,7 +512,7 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
  */
 
 /**
- *	gsm_stuff_packet	-	bytestuff a packet
+ *	gsm_stuff_frame	-	bytestuff a packet
  *	@input: input buffer
  *	@output: output buffer
  *	@len: length of input
@@ -1594,7 +1594,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 }
 
 /**
- *	gsm_dlci_control	-	data arrived on control channel
+ *	gsm_dlci_command	-	data arrived on control channel
  *	@dlci: channel
  *	@data: block of bytes received
  *	@len: length of received block
@@ -2557,6 +2557,8 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
  *	@file: file object
  *	@buf: userspace buffer pointer
  *	@nr: size of I/O
+ *	@cookie: unused
+ *	@offset: unused
  *
  *	Perform reads for the line discipline. We are guaranteed that the
  *	line discipline will not be closed under us but we may get multiple
-- 
2.31.1

