Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E527407846
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhIKNaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbhIKN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A532C0613A7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m9so6873232wrb.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/E326Yc6yFUXw1Tspc0wWzMpp1fhY8mdy8EsD4ltwtA=;
        b=KxWIlqN+wTN7CyKQYswpgn4TJ4GH2N1Tzb7hyjVg0ocMngv+RFe6Ci0kYMpteuVOQi
         D5YPj6kPyerBz/jTtGEvMq/j4uNmwtCTKgjz4rcUIzGYknMEJEY/M9Z9bsF490kFTVIy
         G42sRRgfamJATNlaa9BJ+bd7SSyWIVX9z3sxUFznTRXAY60mgYRVTy87rlUJS60G3234
         ixMoreQpy4aDh7EkZMwqMyi9T1wI7w86tlXHI2SXKC9w++1WHuTbuy9sPKbsO0/OV8c4
         35YSX6fJjqYudrXNU8TkiIluVl9VOjIgYRC8WAYjQW5/PnoQAY6p/4ow0ydVOFKNTfYi
         TROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/E326Yc6yFUXw1Tspc0wWzMpp1fhY8mdy8EsD4ltwtA=;
        b=diDzNqzxDeTFUmRgXOgIsU7AWpXwdvyrNBktthQM8ZsxEwkvHC3ixsEyf0eX3jONPL
         aerJR9aB/c9oQJENqumuvqgRAOiLV0r7e+E3Gzp4zD/dDmqJuDIfRMdL9P/5tx0EYRqt
         5FlbZXfAoHVIHr63vxijyPMGWG//s9LiHC2i+KeBs+XLHGj5O8pUGQ+BxU97rSXvNzj2
         ua+ZBdlsudeh5xDo53IpmsZhSWnOz6dzZf41B69HTjFbhGeW/aEroRM2+RS7QMn8YhIn
         u3I0kYxPa6iqj811Ki1hCOXForhgPWOPyufHmi83f60PRREKJNj9sf9VbiAadm2EXf2T
         2U9Q==
X-Gm-Message-State: AOAM531LT5bhFaTCeZnAOPa53mr6OX/s9H1Y03mqXVaSM1xu/1lagsaD
        VV2d/F3QdxV4v4HtTWp8EQc=
X-Google-Smtp-Source: ABdhPJyucqwoJrP88tzKeZSD/a7ZdplTSUB54kYJTAlIJ0XxKMB7wK0JhtfC4N3Owxm34WdqVYAgRw==
X-Received: by 2002:adf:f543:: with SMTP id j3mr3175831wrp.287.1631366839074;
        Sat, 11 Sep 2021 06:27:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 16/18] staging: r8188eu: remove unused prototype ODM_InitializeTimer()
Date:   Sat, 11 Sep 2021 15:26:33 +0200
Message-Id: <20210911132635.30369-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototype ODM_InitializeTimer() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm_interface.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 2b103aecd859..c7784f540e7d 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -99,10 +99,6 @@ void ODM_delay_us(u32 us);
 
 void ODM_sleep_ms(u32 ms);
 
-void ODM_InitializeTimer(struct odm_dm_struct *pDM_Odm,
-			 struct timer_list *pTimer, void *CallBackFunc,
-			 void *pContext, const char *szID);
-
 void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer);
 
 #endif	/*  __ODM_INTERFACE_H__ */
-- 
2.33.0

