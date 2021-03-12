Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2603B338AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhCLLDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhCLLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:02:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE18C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 61so1532899wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3/YST6elxYpWcRNjCVyHfOQncoojnRh7CHpbLNAlEc=;
        b=lvBYdXEHBnSddSXqemll1fR0iNM3jG5M42nSDt6BN/7+uOGGccpByU81t9APQLIxZW
         eyeB+ik6buNzHrUyT3ETuCKRXrJ1aHzchAoVxbC2vmbdgu1boPFBryo7v6vxH1VG2n8L
         NmSSu+AxXdlLb/myviJRzxVQ3t/fOwTd6nXDkU56+056faamB3BWXE9Eu46QIL79jLOC
         l2gt02RV+qXns1vQMI7gzeT8AcnptzG4pjd6iPG4xaDhnIxd8oGQMI1qE+PM08w4CZoU
         Igk0gwdA4XzdZnyj34WNMg1cdfJT7vXP6WyJY4DSZDT14Qt0qXapin/yKVCdNDwGuFSq
         i1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3/YST6elxYpWcRNjCVyHfOQncoojnRh7CHpbLNAlEc=;
        b=t+HGYOsEc7I+z8AECjkGUYjT27zeIhsg6znk5/Ud32ZtaJGPya/6RaQAV5nAFocSi8
         qTNamzMeD1a2I5lrLd7qeSTES/5OXi8LvhfyjS8GiLeYz0o4d1HidpQ25gq0cPJsvyF5
         Jsyg1lbP91HGdJ2dXzrfNiy3fIvWxnGzoWX4blpl0IJ86zp/o3ORpFURR4OYsVTWfHMf
         wujPnnmPrBKfE+J+Jz6p8O9DVp69qYRR7CYlpLQnpAmzQmQYO0vJhd3XmXCJrLT5V2IY
         a+dFgCMbdDASmcLWajEY6LOhDxuq+5+nVMVC3FcpC7LO3HbhVdgMxbqS/mpv4yiYt419
         MYBw==
X-Gm-Message-State: AOAM5333z81Zwfc9cIOrDZBEpw3yQielDyVdgfNE+egX7LaZsqBSNvLf
        wn1xYxlwC8nUz4XMhp2kOULFMg==
X-Google-Smtp-Source: ABdhPJzGWwAeFL4PLi4aKFULqqTNG++7Nwo8yH1inP3xR+E79Jxavp4gtAy0X5vmjkASySvwenrW9w==
X-Received: by 2002:a5d:526b:: with SMTP id l11mr13255150wrc.385.1615546966848;
        Fri, 12 Mar 2021 03:02:46 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id w131sm1761318wmb.8.2021.03.12.03.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        dahinds@users.sourceforge.net
Subject: [PATCH 5/6] pcmcia: pcmcia_resource: Fix some kernel-doc formatting/disparities and demote others
Date:   Fri, 12 Mar 2021 11:02:38 +0000
Message-Id: <20210312110239.2220197-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110239.2220197-1-lee.jones@linaro.org>
References: <20210312110239.2220197-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pcmcia/pcmcia_resource.c:160: warning: Function parameter or member 'p_dev' not described in 'pcmcia_access_config'
 drivers/pcmcia/pcmcia_resource.c:160: warning: Function parameter or member 'where' not described in 'pcmcia_access_config'
 drivers/pcmcia/pcmcia_resource.c:160: warning: Function parameter or member 'val' not described in 'pcmcia_access_config'
 drivers/pcmcia/pcmcia_resource.c:160: warning: Function parameter or member 'accessf' not described in 'pcmcia_access_config'
 drivers/pcmcia/pcmcia_resource.c:194: warning: Function parameter or member 'p_dev' not described in 'pcmcia_read_config_byte'
 drivers/pcmcia/pcmcia_resource.c:194: warning: Function parameter or member 'where' not described in 'pcmcia_read_config_byte'
 drivers/pcmcia/pcmcia_resource.c:194: warning: Function parameter or member 'val' not described in 'pcmcia_read_config_byte'
 drivers/pcmcia/pcmcia_resource.c:207: warning: Function parameter or member 'p_dev' not described in 'pcmcia_write_config_byte'
 drivers/pcmcia/pcmcia_resource.c:207: warning: Function parameter or member 'where' not described in 'pcmcia_write_config_byte'
 drivers/pcmcia/pcmcia_resource.c:207: warning: Function parameter or member 'val' not described in 'pcmcia_write_config_byte'
 drivers/pcmcia/pcmcia_resource.c:728: warning: Function parameter or member 'p_dev' not described in 'pcmcia_setup_isa_irq'
 drivers/pcmcia/pcmcia_resource.c:728: warning: Function parameter or member 'type' not described in 'pcmcia_setup_isa_irq'
 drivers/pcmcia/pcmcia_resource.c:793: warning: Function parameter or member 'p_dev' not described in 'pcmcia_setup_irq'

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: dahinds@users.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pcmcia/pcmcia_resource.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index e3a6b6c8a5b01..c1c1972921114 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -144,7 +144,7 @@ static int alloc_io_space(struct pcmcia_socket *s, struct resource *res,
 }
 
 
-/**
+/*
  * pcmcia_access_config() - read or write card configuration registers
  *
  * pcmcia_access_config() reads and writes configuration registers in
@@ -184,7 +184,7 @@ static int pcmcia_access_config(struct pcmcia_device *p_dev,
 }
 
 
-/**
+/*
  * pcmcia_read_config_byte() - read a byte from a card configuration register
  *
  * pcmcia_read_config_byte() reads a byte from a configuration register in
@@ -197,7 +197,7 @@ int pcmcia_read_config_byte(struct pcmcia_device *p_dev, off_t where, u8 *val)
 EXPORT_SYMBOL(pcmcia_read_config_byte);
 
 
-/**
+/*
  * pcmcia_write_config_byte() - write a byte to a card configuration register
  *
  * pcmcia_write_config_byte() writes a byte to a configuration register in
@@ -720,7 +720,8 @@ static irqreturn_t test_action(int cpl, void *dev_id)
 
 /**
  * pcmcia_setup_isa_irq() - determine whether an ISA IRQ can be used
- * @p_dev - the associated PCMCIA device
+ * @p_dev: the associated PCMCIA device
+ * @type:  IRQ type (flags)
  *
  * locking note: must be called with ops_mutex locked.
  */
@@ -785,7 +786,7 @@ void pcmcia_cleanup_irq(struct pcmcia_socket *s)
 
 /**
  * pcmcia_setup_irq() - determine IRQ to be used for device
- * @p_dev - the associated PCMCIA device
+ * @p_dev: the associated PCMCIA device
  *
  * locking note: must be called with ops_mutex locked.
  */
-- 
2.27.0

