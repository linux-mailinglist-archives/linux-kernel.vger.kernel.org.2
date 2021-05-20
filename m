Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D27638AF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbhETMzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbhETMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4FFC068D93
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so5286118wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3DwBe4oMa+c399bPWMaVpMdOYsKAOxTJ9c7WG7ZYa0=;
        b=iVk2sy+u3aSV8LnRO4wiGnGGfSgsaQWDWqE5WRpftGq4s7hezfl4gytEoKBpzfHh2F
         0Pf0lJfDkmg+wGDgR+syrgOQ2pFLYFA96EDYjD3sFEaiwITAz9KbDEkSN7rihtaWb19n
         ryAS3dYYebaWH6jeVmSb8jp7cY48qcBcDgxh0vGaEtl5rI2Por492nuNOvT12uNMmrzA
         jurpWBsZaRgSwmUSuIOcr4qDD4oBjtsroZdfIPKuDe16PUJW90Gl8EmUfkf6lQ8RBXK7
         uqOTZ5bJ5cK/6AuR1UsSzXUu9uTxjntUHTdAPWPQT8SrfpNWR88RHzXRqoAX+bDCyQ5+
         eaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3DwBe4oMa+c399bPWMaVpMdOYsKAOxTJ9c7WG7ZYa0=;
        b=Bqj2cdnICOADCt/sqAABrKrVX56pLsjLLlHVjPUPFvmzxQAuVMwZByGR53nH7pjxjA
         QVYc/tTbc7Qa+2zKADSHVTnH3+7KKePiTLhMap45uCrazP5wV3UzNfMhiBKsX4klzcog
         8PMRcvZpAGfvDkUysq0YIt7dNM194iGAwTq7z1ImJxUeGQ6pHwONW5JwhVoONpOUfWOi
         2lUHXNSqf34FeXZkK13m/06ojsmO1OPWMX0R3bqot+REhjIm06mcV2gHGVatoe+Mp7Rh
         AJEj584/X5skArgmtMT/TFNpiBZUB6qAtsnTV7iovQCaY9u1/1eYpyZ/kcwWodhlped1
         0XsA==
X-Gm-Message-State: AOAM533pIauWiGKqeiY5IF4zcny3/bdPEVhJ7LMhPcmXcXmSfgKMpoOW
        9GARRZOU8T3qCuPs0fsYW9XLhA==
X-Google-Smtp-Source: ABdhPJy6hFNmLj/DnnOZWYz1B0a+To6XghvJRli047FGws5EA+S2le4pYAcEUgzBOzCoFOfZ3zw99w==
X-Received: by 2002:a1c:a5c3:: with SMTP id o186mr2952005wme.6.1621513154042;
        Thu, 20 May 2021 05:19:14 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        processes-Sapan Bhatia <sapan@corewars.org>
Subject: [PATCH 04/11] tty: n_tty: Fix some misdocumented functions
Date:   Thu, 20 May 2021 13:18:59 +0100
Message-Id: <20210520121906.3468725-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/n_tty.c:623: warning: expecting prototype for process_echoes(). Prototype was for __process_echoes() instead
 drivers/tty/n_tty.c:1109: warning: expecting prototype for isig(). Prototype was for __isig() instead
 drivers/tty/n_tty.c:1268: warning: expecting prototype for n_tty_receive_char(). Prototype was for n_tty_receive_char_special() instead
 drivers/tty/n_tty.c:2132: warning: Function parameter or member 'kbuf' not described in 'n_tty_read'
 drivers/tty/n_tty.c:2132: warning: Function parameter or member 'cookie' not described in 'n_tty_read'
 drivers/tty/n_tty.c:2132: warning: Function parameter or member 'offset' not described in 'n_tty_read'
 drivers/tty/n_tty.c:2132: warning: Excess function parameter 'buf' description in 'n_tty_read'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Andrew J. Kroll" <ag784@freenet.buffalo.edu>
Cc: processes-Sapan Bhatia <sapan@corewars.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/n_tty.c  | 10 +++++-----
 drivers/tty/tty_io.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0ec93f1a61f5d..56d3b43d8a3a4 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -596,7 +596,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
 }
 
 /**
- *	process_echoes	-	write pending echo characters
+ *	__process_echoes	-	write pending echo characters
  *	@tty: terminal device
  *
  *	Write previously buffered echo (and other ldisc-generated)
@@ -1092,7 +1092,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 }
 
 /**
- *	isig		-	handle the ISIG optio
+ *	__isig		-	handle the ISIG optio
  *	@sig: signal
  *	@tty: terminal
  *
@@ -1248,7 +1248,7 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 }
 
 /**
- *	n_tty_receive_char	-	perform processing
+ *	n_tty_receive_char_special	-	perform processing
  *	@tty: terminal device
  *	@c: character
  *
@@ -2042,11 +2042,11 @@ static int job_control(struct tty_struct *tty, struct file *file)
 }
 
 
-/**
+/*
  *	n_tty_read		-	read function for tty
  *	@tty: tty device
  *	@file: file object
- *	@buf: userspace buffer pointer
+ *	@kbuf: userspace buffer pointer
  *	@nr: size of I/O
  *
  *	Perform reads for the line discipline. We are guaranteed that the
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index defea9cc20ce9..7431c9e0c2bfe 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1090,7 +1090,7 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 
 
 /*
- *	tty_write		-	write method for tty device file
+ *	file_tty_write		-	write method for tty device file
  *	@file: tty file pointer
  *
  *	Write data to a tty device via the line discipline.
-- 
2.31.1

