Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D691338AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhCLLDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhCLLCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:02:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DBFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z2so1533660wrl.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2LFyxkPQSdhv3OL0/SxhD1F9pMCg3AGCwp/aYiULU4=;
        b=CQhe1Ec36cI4eQQUWdVisPajQyOVV9/eV/G5zgsJGConT9Hn3jNcjifmxHbb4H9T2N
         StstE8mYnyMBoMBEUs34ZCth3gLQZ4iQ5o7Lh9AF85Kp54oP2BNYn8aBi4UB1+GMmjkJ
         YUSQtv40xGCflMbsCK95n2ZURZ/gsLolmlvuE4cLre+JFMGiWC7FVoJyu0pIDkqDhYUd
         p3BYwEq0eI6+7rD7s53dszKmMcb6O2Sy1f5kXJ2PO8yj6hFPCLfsG9G/YQjIvuiiWkkm
         R+wxoKbhpWJIUZzKFqcbCzFqQv39F58gG3fsorsXBFSLAjjT/BNc12brWb3vUX/5LNLC
         Aexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2LFyxkPQSdhv3OL0/SxhD1F9pMCg3AGCwp/aYiULU4=;
        b=Ops+QyEUcs5gPsMbWRN4pZoESW1v1YCjr537IbGr8AT5WiIJysHOdydHUg2q/nu6/n
         CV0Qyrihk5AksGXna0oyOWQaoRaau5N+EKZ/wnu4ar/XmaAeyBjP+rJZC9fyIdvrvXDO
         ZQRtVXBBN2dr8ueqcek6zkkn3FaBRHkl+KV20ktRx1RbtVE3S7ozDj+RVXtLRrYiv6A5
         oJtXs5Jxyl8EF45cCDGtkMsSlkh7GyhPee5xPvAgfUw1+PdBAQzb5Nwl2yszq4YrZ7qH
         U/VRfQUMBG1TXvQZJx1ZrKB2SrKujS4lPtPbwzOhgsMGZhNIWmx8Kn8/qePkiSv3sjHF
         3qNA==
X-Gm-Message-State: AOAM532pPkNiDz6lOHl2J527XfEsqnZKYz7HMvnhA5/PJVSwNKq/bvWF
        SUNVKZA+UApwcJcDy6ujORJB8DemM20N3g==
X-Google-Smtp-Source: ABdhPJwI0DqjWtrQrCXtOM6Bz3YId52CP3GjTkMGcwIFfru+xFMkoNGjrwcg7qCAJd5RWk2Oz0IzXQ==
X-Received: by 2002:a5d:468e:: with SMTP id u14mr13530464wrq.359.1615546964946;
        Fri, 12 Mar 2021 03:02:44 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id w131sm1761318wmb.8.2021.03.12.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        dahinds@users.sourceforge.net
Subject: [PATCH 3/6] pcmcia: pcmcia_cis: Demote non-conforming kernel-doc headers to standard kernel-doc
Date:   Fri, 12 Mar 2021 11:02:36 +0000
Message-Id: <20210312110239.2220197-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110239.2220197-1-lee.jones@linaro.org>
References: <20210312110239.2220197-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pcmcia/pcmcia_cis.c:129: warning: Function parameter or member 'flags' not described in 'pcmcia_io_cfg_data_width'
 drivers/pcmcia/pcmcia_cis.c:154: warning: Function parameter or member 'tuple' not described in 'pcmcia_do_loop_config'
 drivers/pcmcia/pcmcia_cis.c:154: warning: Function parameter or member 'parse' not described in 'pcmcia_do_loop_config'
 drivers/pcmcia/pcmcia_cis.c:154: warning: Function parameter or member 'priv' not described in 'pcmcia_do_loop_config'
 drivers/pcmcia/pcmcia_cis.c:300: warning: Function parameter or member 'tuple' not described in 'pcmcia_do_loop_tuple'
 drivers/pcmcia/pcmcia_cis.c:300: warning: Function parameter or member 'parse' not described in 'pcmcia_do_loop_tuple'
 drivers/pcmcia/pcmcia_cis.c:300: warning: Function parameter or member 'priv' not described in 'pcmcia_do_loop_tuple'
 drivers/pcmcia/pcmcia_cis.c:351: warning: Function parameter or member 'p_dev' not described in 'pcmcia_do_get_tuple'
 drivers/pcmcia/pcmcia_cis.c:351: warning: Function parameter or member 'tuple' not described in 'pcmcia_do_get_tuple'
 drivers/pcmcia/pcmcia_cis.c:351: warning: Function parameter or member 'priv' not described in 'pcmcia_do_get_tuple'
 drivers/pcmcia/pcmcia_cis.c:399: warning: Function parameter or member 'p_dev' not described in 'pcmcia_do_get_mac'
 drivers/pcmcia/pcmcia_cis.c:399: warning: Function parameter or member 'tuple' not described in 'pcmcia_do_get_mac'
 drivers/pcmcia/pcmcia_cis.c:399: warning: Function parameter or member 'priv' not described in 'pcmcia_do_get_mac'

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: dahinds@users.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pcmcia/pcmcia_cis.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/pcmcia_cis.c b/drivers/pcmcia/pcmcia_cis.c
index e4c4daf92038c..d2d0ed4b27c8f 100644
--- a/drivers/pcmcia/pcmcia_cis.c
+++ b/drivers/pcmcia/pcmcia_cis.c
@@ -122,7 +122,7 @@ static int pccard_loop_tuple(struct pcmcia_socket *s, unsigned int function,
 }
 
 
-/**
+/*
  * pcmcia_io_cfg_data_width() - convert cfgtable to data path width parameter
  */
 static int pcmcia_io_cfg_data_width(unsigned int flags)
@@ -143,7 +143,7 @@ struct pcmcia_cfg_mem {
 	cistpl_cftable_entry_t dflt;
 };
 
-/**
+/*
  * pcmcia_do_loop_config() - internal helper for pcmcia_loop_config()
  *
  * pcmcia_do_loop_config() is the internal callback for the call from
@@ -289,7 +289,7 @@ struct pcmcia_loop_mem {
 			   void *priv_data);
 };
 
-/**
+/*
  * pcmcia_do_loop_tuple() - internal helper for pcmcia_loop_config()
  *
  * pcmcia_do_loop_tuple() is the internal callback for the call from
@@ -337,7 +337,7 @@ struct pcmcia_loop_get {
 	cisdata_t **buf;
 };
 
-/**
+/*
  * pcmcia_do_get_tuple() - internal helper for pcmcia_get_tuple()
  *
  * pcmcia_do_get_tuple() is the internal callback for the call from
@@ -386,7 +386,7 @@ size_t pcmcia_get_tuple(struct pcmcia_device *p_dev, cisdata_t code,
 EXPORT_SYMBOL(pcmcia_get_tuple);
 
 
-/**
+/*
  * pcmcia_do_get_mac() - internal helper for pcmcia_get_mac_from_cis()
  *
  * pcmcia_do_get_mac() is the internal callback for the call from
-- 
2.27.0

