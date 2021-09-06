Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A131B401256
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbhIFBDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhIFBCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E96C061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q26so6354813wrc.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaJZrVBTvj6UOGOwwJhOi48onzQqMeFKGn9Q/X6QLVQ=;
        b=Vz1xOW7U5+cxlIwDK+kpBOehFQ21cNoScFlfCutXQF1VSso4TuDN2YVkBmNdOHLyJi
         HkrvNFXnMg0mZbnaTuYqa3nNJg+eqtTV9C5M2GsIPLoi7/7S/PhSvddg8Efil3QOsT6e
         35sw6oMM1ap2OQc7VceVEIkuk363d18pN2kaRjEwuyJmii84zLPqfXx7BGKrscNdejxA
         I4ndbl5HYMdvMWLU+HxpsveTHsgTorsCKvrHh7cXZ/n/Dx5Tk1V6lEWXSL1sDMIV8ksd
         Px+fk9Df2+9PGq/mBpZW6Bc/1++nw9htJOyiBWuOL0bk/cHsR+dX/PDNtunt9lbEGkBi
         Ll9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaJZrVBTvj6UOGOwwJhOi48onzQqMeFKGn9Q/X6QLVQ=;
        b=ssKksMBXP3sumRpxtT8bVIz2ixliZXcjRA0eoyqEEF+no8U5eL30u1yUtJbpxKPZdU
         FCuRr7f6kkG/YWSEOdybDyS1jyZ136899qF5a86ONZf7Y6bQ5E/+juqAKrvqw6SWqXKe
         TKttjiw6s4CFGYQUff5Sk4eAtVdfWLMtJVusIi3txqyAhqrJoqcueMg63vMR/KiVmXmO
         N1JOxX7ebiYXkDQD2L+Gs1ux3DIo5T/SvJkUT46eTYIYWCgnbJigAVoXNTwA/LKgJ7Le
         xgOwPUHAXkUguhX+AEdff0T1n2FPPXwFeHQm26YizUvXonsbqTE3Rkjeu+XsPM/Y58r6
         A1DQ==
X-Gm-Message-State: AOAM531Wr350TdtojWDpu/P1hmfg0tpdRiHjUixZwTqTsnCaCScKJTWo
        uVkQ2aB6ZCB+vkjCJvM/D91LDw==
X-Google-Smtp-Source: ABdhPJwxFknlODuD0DhIam2cYXI0zB1niQpoBdAesgMy2u3m7DeVCWM2OArGNo8rCjpl8ri7Qdd2xw==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr10362555wrx.293.1630890078729;
        Sun, 05 Sep 2021 18:01:18 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:18 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 12/14] staging: r8188eu: remove Efuse_PgPacketWrite_BT from struct hal_ops
Date:   Mon,  6 Sep 2021 02:01:04 +0100
Message-Id: <20210906010106.898-13-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Efuse_PgPacketWrite_BT function pointer from struct hal_ops, as it
is unused.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index b47fcdcf2027..002bcb338cab 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -229,8 +229,6 @@ struct hal_ops {
 	u8	(*Efuse_WordEnableDataWrite)(struct adapter *padapter,
 					     u16 efuse_addr, u8 word_en,
 					     u8 *data, bool bPseudoTest);
-	bool	(*Efuse_PgPacketWrite_BT)(struct adapter *padapter, u8 offset,
-					  u8 word_en, u8 *data, bool test);
 
 	void (*sreset_init_value)(struct adapter *padapter);
 	void (*sreset_reset_value)(struct adapter *padapter);
-- 
2.31.1

