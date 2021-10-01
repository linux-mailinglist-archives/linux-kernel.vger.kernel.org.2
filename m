Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93B41F64A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355275AbhJAU1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhJAU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:27:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE82C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 13:26:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v18so37990187edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOFCqjCsaIkGC0GztDDOH3O6ih5px6ECSue53rP82kU=;
        b=NnJZafKHRYxx2UF8EtQz8KtZ+o/7ZURng4/muTjwBgZ8zD9dj7NlQ0JwAtSY/2VOvw
         wM7Kw6eU16QuiCvmkGJaijk0lvLXmFA31i06/tgJ6L90DgPe4za5K+57nukhr7nKaLm7
         vYWaRmJ/cuPGSonNiARKS0MeZ3tFuP4R29QFlIq/cpfnf+07kpnBMtP53mXIS0F4Me8T
         nm89lfGCc61AmxT/izSC65Dp1Hb0Vej8MyAtaZKBcQAC4wZBdNCtJ2ogPEPAjJ2/geQG
         gULyoutc8yO1IOhOY4StSZanr996MLZoz1Jkylm9rM7QuMLLUq3kGlk6+BHaojF/xXwA
         KisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOFCqjCsaIkGC0GztDDOH3O6ih5px6ECSue53rP82kU=;
        b=w6eNAIcykj7s5KY0cC82hHardEewXMzC4KDfOX2Ij+sbPZODTMyw8GtbDKnF8+brmZ
         QB3GvRHFM1VJdDVqllvmr5/dqIhTJ13R3D6m/I5sGrArTyxzm99rAEUX/GBxuSQ5T1xq
         BhyxdJ6OAR97gYr+S03mK+xnd7xilHuMxm2yw2Qd8ilBaQsgogIZPe8NwwYnn7YM0RrP
         7xVSsHIr2P/el+ew/dV6BG0lbUmmgfjg6OKLNzjpLu0FWPRmGRD4RNwtvWhBwnoMiO75
         GpqiyHY9NS7/7EdRSzyfTGvf24IeJCXe3QpGcm2FFqezuPEHwFP7qQV5ejGfHk9YZNek
         h6gg==
X-Gm-Message-State: AOAM533IKDjLIMaojTWKlfRZFWwam1ZyYtvTtqeV+ZV8Aa8BQ4TTqf5P
        6BbMfXJD8Of7FZI0wD5xD3g=
X-Google-Smtp-Source: ABdhPJwpRaSQY40ta/5LIKqezd8FR2LGmiFwLQg1NWYet4VWq6TUi1fqZObBubZ3rCIPPFU65swW4A==
X-Received: by 2002:a17:906:b14d:: with SMTP id bt13mr8429247ejb.39.1633119961954;
        Fri, 01 Oct 2021 13:26:01 -0700 (PDT)
Received: from tom-desktop.station (net-5-94-68-71.cust.vodafonedsl.it. [5.94.68.71])
        by smtp.gmail.com with ESMTPSA id b13sm4800317ede.97.2021.10.01.13.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 13:26:01 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: fix camelcase in pbyCxtBuf
Date:   Fri,  1 Oct 2021 22:25:01 +0200
Message-Id: <20211001202504.410383-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camel case variable name for variable pbyCxtBuf
with snake case equivalent, in mac.h

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/staging/vt6655/mac.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 9797eddaea01..3043d2813074 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -886,8 +886,8 @@ void MACvSetLongRetryLimit(struct vnt_private *priv, unsigned char byRetryLimit)
 
 void MACvSetLoopbackMode(struct vnt_private *priv, unsigned char byLoopbackMode);
 
-void MACvSaveContext(struct vnt_private *priv, unsigned char *pbyCxtBuf);
-void MACvRestoreContext(struct vnt_private *priv, unsigned char *pbyCxtBuf);
+void MACvSaveContext(struct vnt_private *priv, unsigned char *cxt_buf);
+void MACvRestoreContext(struct vnt_private *priv, unsigned char *cxt_buf);
 
 bool MACbSoftwareReset(struct vnt_private *priv);
 bool MACbSafeSoftwareReset(struct vnt_private *priv);
-- 
2.25.1

