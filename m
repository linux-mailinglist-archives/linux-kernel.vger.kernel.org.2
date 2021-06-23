Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BC93B2419
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFWXvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFWXvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:51:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78748C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:17 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g14so3510978qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyXiGbUTPVepoHZ7bOHMdBXo5lqZpc/ltE3OmxZPO70=;
        b=pbBDD54JQp6KUz53Bh0Vws/9OxnhRAZP2Z/hKkxcDdQaH7yIVJuxsqlthhgC8XpM1s
         BxyicpxmTFq0f08zur/6XAe27BXoQxh1a1GEltx3EmFdBRrdWsHG9SREX895cAnsHYTW
         vV9/5DXSo4r8IVRvwRANeu88K2O9zD30FGe0NC3tEVmkcspamATABpd/nQhGIEOdT5NP
         IdXH3eS1j9neCkXrUaYa5tIy4RhcCV8KjrakVjXYsjKNluErqEtffYgfc27SR1yqAiUP
         GGCMMjTtJlkTSHJKMr7qswkNvM3BmEHMAxAAG+sJbV/NxsKnZOXhjx1QSuA7ITEBWWBb
         vdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyXiGbUTPVepoHZ7bOHMdBXo5lqZpc/ltE3OmxZPO70=;
        b=Q1Xc/s1KfExd8GbIFHmPr5C/R8rMXFWLRTVnYlB+Plmb4JaaYrsvmdcU+0pnOXJio/
         QnTGaBisZJHhwxoeeY5vjxcs1+N2fCN2kfKfdWgvy5YmglenXxIYanNARH7BUNihhIMr
         a6eWn0AGLixGf6y4JXjSbBByjZq26oFFLkE5BtLsdrodh1KvH7/8wDyJ0VVc9Yam9Ubo
         PDEIlcDXh2G4bCzolRNwy7oBfzNKZFwYnA1DcJB6a5Wi93PF7mj5BJ/xTnBuMko81CmN
         vhcrlKWv5eyYmAFF9Zs3WaulSx6+BW7i9iKId1Ewx3niRgd+/g3cPtFcyQ9z0yYOf72U
         TA6w==
X-Gm-Message-State: AOAM533Zrlgm9JQRuER7hZuNzI+xaKRf5/KnlrVwC6RD0p0Oi8hCi9Pg
        c8oLoLw7g0gHtE+/p1MatCFPpDYL5WkcOg==
X-Google-Smtp-Source: ABdhPJyk+GnUxV3CKcJGp6Fh9gDdpmhDiRwJ/E65pwjPaJgogmw9J7+eKbscSuSJiMcMMf/KWktc8g==
X-Received: by 2002:a05:622a:c6:: with SMTP id p6mr2387802qtw.99.1624492156590;
        Wed, 23 Jun 2021 16:49:16 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id w2sm992387qto.50.2021.06.23.16.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:49:16 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 7/9] staging: rtl8188eu: remove MSG_88E call from hal/odm.c
Date:   Thu, 24 Jun 2021 00:49:00 +0100
Message-Id: <20210623234902.7411-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623234902.7411-1-phil@philpotter.co.uk>
References: <20210623234902.7411-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove MSG_88E call from hal/odm.c as this macro is unnecessary,
and this call is dubious in terms of necessity. Removing all calls
will ultimately allow the removal of the macro itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/odm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 9febdc91b66a..73b63e2ea0ff 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -827,7 +827,6 @@ void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm)
 	pDM_Odm->RFCalibrateInfo.TXPowercount = 0;
 	if (*pDM_Odm->mp_mode != 1)
 		pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true;
-	MSG_88E("pDM_Odm TxPowerTrackControl = %d\n", pDM_Odm->RFCalibrateInfo.TxPowerTrackControl);
 
 	pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true;
 }
-- 
2.31.1

