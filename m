Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67133DC207
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhGaAjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbhGaAjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66FC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u15so6960789wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCgskwqPbTbe8zjqvIB45iWyLT95wxbQES202Eafyt8=;
        b=LNLV3qGYyuZbbs3XO4TvP4ubXFI2AATA/JPPRJvLOb2kdcA3mfLWDbNJoza+Ksim+K
         p58Tcgu3o6Ps/Q++YsISXfxvad2pLVBtW8LwTUU4IoQ+tj6q1xYpoJbmNxRJbjWQpPgB
         v0+egIbl+/SDKSrby9njIiti94LWxvW2TuWGo/77RDajsMrY1O1sBTnBiW/VmNIzOpQ2
         iHRDSL4Q0j9sNa+bjOeJw05brgGqezDj3mNT+aik1x7r11cBQmWYxVEgOog9bX8BbGyn
         lM1ULnLYiqaf9XZR0KWM1aozuNHU2zSuOLdNIiHMBXiirfys5NCZ8dIQAeHlDySwK8Ho
         oolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCgskwqPbTbe8zjqvIB45iWyLT95wxbQES202Eafyt8=;
        b=Jt8OLrx/w24wfRiyyt2i3cvJPhDq7sS3fUg1JvQapw4mHlU1+FUOTa86zslZtmx3Lz
         Q6bfDpRXSFoyrKE7B7XRaiGWF/q6OP2OKq/Xhzkhs+7kCU0Sr6Min6838HBAODHRiQpj
         TqNIUDaZsST5yxXUFfQ4aqPdDaGkGV29UjFz8rEFS2O2tjUNTaP0LGkA3xG1j75jYxuh
         IEN3zgk71VWHL8RrE5jz1Odl/78BI/fE/8weIaPfvcZeO8VvK3vyJ4tFnuv0AkgHxbEB
         aOh2Irakc0EUBZ8ndcJJ7OKMFqZ5Z51I1L4zVdp26nQehK3hYCirnk4mU0WBb808tXzk
         wUrg==
X-Gm-Message-State: AOAM533mj8/yzlM5Br6A8Uhv0sY7V6m/LVjZPY/QJcHhmWAvR0toDjq+
        RLadUaV/GSud9J4uwD1FGOlVYl+gT2t4KmvAIeI=
X-Google-Smtp-Source: ABdhPJzJk6UpvsTPUAu/lU46b4wtzgeRTM0yMxas/uoyq7+jj5JmHuEAZrxqyCP9TVIzciXOAK/TQA==
X-Received: by 2002:a1c:6245:: with SMTP id w66mr5760019wmb.143.1627691980815;
        Fri, 30 Jul 2021 17:39:40 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:40 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/14 resent] staging: r8188eu: remove ODM_dbg_* macro definitions
Date:   Sat, 31 Jul 2021 01:39:25 +0100
Message-Id: <20210731003937.68615-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731003937.68615-1-phil@philpotter.co.uk>
References: <20210731003937.68615-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_dbg_* macro definitions from include/odm_debug.h, as
they are called from nowhere and are therefore superfluous.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/odm_debug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index 53ab6debb6f3..73fdea598707 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -104,9 +104,6 @@
 		RT_PRINTK fmt;						\
 		ASSERT(false);						\
 	}
-#define ODM_dbg_enter() { DbgPrint("==> %s\n", __func__); }
-#define ODM_dbg_exit() { DbgPrint("<== %s\n", __func__); }
-#define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
 
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
 
-- 
2.31.1

