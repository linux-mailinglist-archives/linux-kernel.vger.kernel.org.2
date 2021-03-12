Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59427338AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhCLLDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhCLLCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:02:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516F4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b9so1537038wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSRARMr0ge8RrABxxQL2bgi2ducPKnjZ+PfLYn7zsdQ=;
        b=NXBe04FNIMgsMBf7EyA1NZM8TgdIRc8JUsKVk+gy5SlQstvAwKj/ndx1gC3H9YOG9z
         uHHWRS8Z92Qi2iVzMhYVdPlZL8/1WSn9rKLZtZbWMELF671jNj2jlXf1iMM87gwyLgQO
         gC6cLZ5imJ5CeGyXtcjVTao04A1g6cUrt3WAwn31s/6seQwXqZBoUuzHOcl8n21bGpFw
         hOtO+MyW9oHlycTAMQ03i9qg995uetjRSPY7L9va5UKJhDQywm3jhaF7GzF7+7O71B63
         TKtmpIPLk4CPB2KVWmiaQQqYrT5kR0AgxeohODt2o9hJ+VYvy4WJakmdJF9N/4ZJw1Ch
         aImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSRARMr0ge8RrABxxQL2bgi2ducPKnjZ+PfLYn7zsdQ=;
        b=poPfZ6u+DD650LVuGSs9GERIH+RH9isjKVWtp7QXLZ7Dd7HcdWyek37fd16L/9bU9W
         MUR76ttwAlW32oscGbENRaWQFBmHIkgUPr8Y/j9g9WLuGo6ZQbLKVro42SJWx3HCppm5
         ZueS6r7KQ3uJGfrjl4l44mdgdePHrjy0CJ4a5erLQskvFK0uJ1fcug2UwZGf6gh3/jYq
         Uo+h8hTju0k6L/XxEZat+SgqsTrkg+w6uv8MBOxv8r3Wogq3y1E8lJa3uxLILA88aDO7
         8wqtoMDM6g3c+YHrWs7zoB5NG6eiE+Zi/R1iDFrU4ML9kigXdxzy+QJ5cG8Q+CXUHhNJ
         ed+Q==
X-Gm-Message-State: AOAM532dOqHmww1E9UyXPz3HcYamZdjcwl7yoACuN/38MsiOllYPA5Ps
        DeIciQD/vZcvgC3WdO5Lb+XWsfjVavWQfw==
X-Google-Smtp-Source: ABdhPJwT2sw1aRMQ4lI0SurbAYsVvX6q/OFZjHqL3/nNCBEP9D8ffO9PJeEV3EkCi54ZkzwvFtxKVA==
X-Received: by 2002:adf:e482:: with SMTP id i2mr13365868wrm.392.1615546964051;
        Fri, 12 Mar 2021 03:02:44 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id w131sm1761318wmb.8.2021.03.12.03.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Tian Tao <tiantao6@hisilicon.com>,
        dahinds@users.sourceforge.net
Subject: [PATCH 2/6] pcmcia: cistpl: Demote non-conformant kernel-doc headers to standard comments
Date:   Fri, 12 Mar 2021 11:02:35 +0000
Message-Id: <20210312110239.2220197-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110239.2220197-1-lee.jones@linaro.org>
References: <20210312110239.2220197-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pcmcia/cistpl.c:88: warning: Function parameter or member 's' not described in 'set_cis_map'
 drivers/pcmcia/cistpl.c:88: warning: Function parameter or member 'card_offset' not described in 'set_cis_map'
 drivers/pcmcia/cistpl.c:88: warning: Function parameter or member 'flags' not described in 'set_cis_map'
 drivers/pcmcia/cistpl.c:136: warning: Function parameter or member 's' not described in 'pcmcia_read_cis_mem'
 drivers/pcmcia/cistpl.c:136: warning: Function parameter or member 'attr' not described in 'pcmcia_read_cis_mem'
 drivers/pcmcia/cistpl.c:136: warning: Function parameter or member 'addr' not described in 'pcmcia_read_cis_mem'
 drivers/pcmcia/cistpl.c:136: warning: Function parameter or member 'len' not described in 'pcmcia_read_cis_mem'
 drivers/pcmcia/cistpl.c:136: warning: Function parameter or member 'ptr' not described in 'pcmcia_read_cis_mem'
 drivers/pcmcia/cistpl.c:217: warning: Function parameter or member 's' not described in 'pcmcia_write_cis_mem'
 drivers/pcmcia/cistpl.c:217: warning: Function parameter or member 'attr' not described in 'pcmcia_write_cis_mem'
 drivers/pcmcia/cistpl.c:217: warning: Function parameter or member 'addr' not described in 'pcmcia_write_cis_mem'
 drivers/pcmcia/cistpl.c:217: warning: Function parameter or member 'len' not described in 'pcmcia_write_cis_mem'
 drivers/pcmcia/cistpl.c:217: warning: Function parameter or member 'ptr' not described in 'pcmcia_write_cis_mem'
 drivers/pcmcia/cistpl.c:289: warning: Function parameter or member 's' not described in 'read_cis_cache'
 drivers/pcmcia/cistpl.c:289: warning: Function parameter or member 'attr' not described in 'read_cis_cache'
 drivers/pcmcia/cistpl.c:289: warning: Function parameter or member 'addr' not described in 'read_cis_cache'
 drivers/pcmcia/cistpl.c:289: warning: Function parameter or member 'len' not described in 'read_cis_cache'
 drivers/pcmcia/cistpl.c:289: warning: Function parameter or member 'ptr' not described in 'read_cis_cache'
 drivers/pcmcia/cistpl.c:372: warning: Function parameter or member 's' not described in 'verify_cis_cache'
 drivers/pcmcia/cistpl.c:412: warning: Function parameter or member 's' not described in 'pcmcia_replace_cis'
 drivers/pcmcia/cistpl.c:412: warning: Function parameter or member 'data' not described in 'pcmcia_replace_cis'
 drivers/pcmcia/cistpl.c:412: warning: Function parameter or member 'len' not described in 'pcmcia_replace_cis'

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Tian Tao <tiantao6@hisilicon.com>
Cc: dahinds@users.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pcmcia/cistpl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index e6939103991ba..948b763dc451e 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -75,7 +75,7 @@ void release_cis_mem(struct pcmcia_socket *s)
 	mutex_unlock(&s->ops_mutex);
 }
 
-/**
+/*
  * set_cis_map() - map the card memory at "card_offset" into virtual space.
  *
  * If flags & MAP_ATTRIB, map the attribute space, otherwise
@@ -126,7 +126,7 @@ static void __iomem *set_cis_map(struct pcmcia_socket *s,
 #define IS_ATTR		1
 #define IS_INDIRECT	8
 
-/**
+/*
  * pcmcia_read_cis_mem() - low-level function to read CIS memory
  *
  * must be called with ops_mutex held
@@ -206,7 +206,7 @@ int pcmcia_read_cis_mem(struct pcmcia_socket *s, int attr, u_int addr,
 }
 
 
-/**
+/*
  * pcmcia_write_cis_mem() - low-level function to write CIS memory
  *
  * Probably only useful for writing one-byte registers. Must be called
@@ -277,7 +277,7 @@ int pcmcia_write_cis_mem(struct pcmcia_socket *s, int attr, u_int addr,
 }
 
 
-/**
+/*
  * read_cis_cache() - read CIS memory or its associated cache
  *
  * This is a wrapper around read_cis_mem, with the same interface,
@@ -365,7 +365,7 @@ void destroy_cis_cache(struct pcmcia_socket *s)
 	}
 }
 
-/**
+/*
  * verify_cis_cache() - does the CIS match what is in the CIS cache?
  */
 int verify_cis_cache(struct pcmcia_socket *s)
@@ -401,7 +401,7 @@ int verify_cis_cache(struct pcmcia_socket *s)
 	return 0;
 }
 
-/**
+/*
  * pcmcia_replace_cis() - use a replacement CIS instead of the card's CIS
  *
  * For really bad cards, we provide a facility for uploading a
-- 
2.27.0

