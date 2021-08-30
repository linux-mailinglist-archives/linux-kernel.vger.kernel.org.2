Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78273FB5DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhH3MRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbhH3MQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F487C061764
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so22097319wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUNc+8qOd4ajvWM/OEIrPhkDwrj3YE9cjHuomOPXBzI=;
        b=rRbnYXQ5kXpBufM1R/4cySspS7BM4bvj50xz7aiLPVNrpq5epQJ1ZlvPxWL8hrTY+r
         qnsnA5jKbBUL98O2IP5iOwdoveiQqfFqEfPxDqDGmJO5l4O93ZQb7XOKRmnV5pfUPhcS
         UuXUs6RgLZFsm6ZeDPTIoOYboITtuv6crpfchJ7xXiRKl59tkPoCnvj647656JEC4oyl
         jr0hDu4hdlZ16Xz7qXVn9QAYQ3OsISMpVz3hKH8HVx+OnOpdsMB/G1AM97WggImluiUb
         +fe1ofxtp8uEWZXetdry0yIe//SGuiXofPeNr9fvBnXXEDjFiQksRWJsF1lEGEW2vsyJ
         0ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUNc+8qOd4ajvWM/OEIrPhkDwrj3YE9cjHuomOPXBzI=;
        b=Pfrpk2JeJ19g5uPXC5lAxvc2cGXMbmzWKNsWtxam9bIV1kRPj8zc9cRG6Xe2148FEy
         AqvNpcWWnbWOUdmYHIcO4Kf/dGjqqYIDVqWNa9bzy9IBdySQg7bKjeNjaiqdqL6ovklB
         sokgzFuBte9cb3mg8RBVHzY9y6FU9qWAq4NU+QHSD5GkpX7gz0DCGTj7IVhJGN1hFIW4
         L/28io2qx7lyAHfUKFozN5/YhzG80RO4diL/SXXrf110lB6ADzZOCmAQ8xnZX1P9WhY2
         ote/5xzvJvAD1B/jutfH08pnwK0I4ObdQBMLqBhIahlajYVnaClzgLLM7Es+TM4mIZ74
         Mn7g==
X-Gm-Message-State: AOAM532KdBpBylERpZNCTwhA+Hm8mOispiuWcaA+3MKhsTuEnFmLBor7
        pMYXp9peqMm6r8yxit8RcqQ=
X-Google-Smtp-Source: ABdhPJyuW+fj0yXGx3zbL679xht8cWxAR7xD+OJgGGnVo9gd4cTgzxgIe+AJzEkYhuZX1djjTkl/xw==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr25044113wrn.303.1630325750307;
        Mon, 30 Aug 2021 05:15:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm15492116wro.83.2021.08.30.05.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:15:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 7/8] staging: r8188eu: add missing blank line after declarations
Date:   Mon, 30 Aug 2021 14:15:07 +0200
Message-Id: <20210830121508.6411-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830121508.6411-1-straube.linux@gmail.com>
References: <20210830121508.6411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing blank line after declarations in rtw_macaddr_cfg()
to clear a checkpatch warning.

WARNING: Missing a blank line after declarations

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index c37358be631f..f76c762ccd4b 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1021,6 +1021,7 @@ u8 key_2char2num(u8 hch, u8 lch)
 void rtw_macaddr_cfg(u8 *mac_addr)
 {
 	u8 mac[ETH_ALEN];
+
 	if (!mac_addr)
 		return;
 
-- 
2.33.0

