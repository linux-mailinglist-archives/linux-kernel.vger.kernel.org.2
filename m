Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3B43016C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbhJPJN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbhJPJN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:13:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42986C061764
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:11:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a25so47851401edx.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2uW/uDJiVzmx6sq5G95XgEuBsqcyd3YnNIT04Tmx5U=;
        b=Em7GtEOUv8tKJyX5/o2e3+Zs3o8HF35CU9eCxOTE2OeSS+3DtXV5dkjwrSSj5VGKSk
         MWPCrDRHGTay3R+NKcrPdIz7EV8kWBsRX4A5ReYOD43JeZs+cUo8lhz8CCvAmaNCLSNd
         zl6aMw/FZUcUEPb5TYnFTdXW5ZZqB+lf721rcTCUxn+m/Z8L+U3koEPlcN3/mY/SESkL
         nNqvM6b1mMAemuF/8nzXaDxdfjJiJXxqFJCrRYJO3CETFnPTQHOaRfrMchVywZf3HjZT
         XwxlwYjT0u2Bprqxv9ere2zD3Th1QxNn8ZWz+yHWIvtlQvK6ZAch9yP/nPz97lFCz5mE
         77bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2uW/uDJiVzmx6sq5G95XgEuBsqcyd3YnNIT04Tmx5U=;
        b=WlAbz77DK03Q5h08STsofeytZT3qIrGBs1PeskJ4Hhyliezjyk+cMYiAsf5NOHAi+t
         yb3As4tVXidM2UeS3ApaRa5fi5ve0QSyfSeNss5xTjAgP4l78abD/HvhdTIAulbpRn6D
         85IGTjb1eKo3zKXKsbvRBfqLNgxCX5rMZD6nwiNAPQHdPty4WzjWp87q3MnnNvhFDdM4
         OeV45q6CrxzDD2koVDmnpDwIdxgCOLUHrKCBjOWLHWDvr3Rn2Xx+V4lP8M9EIpGEpG4f
         YGwbGIYxQEmVCmplSkqhfAnrSzl79FO7yn57OY8TD/lBKcmVvklRHoy/91wnGNloa8zz
         UzUA==
X-Gm-Message-State: AOAM530fxYGjxXyCv1PK0BSw6lJ8V/nfoqCjhNFZLv/bVK336SSk/Y8M
        HxPeU3jMuoLk4sDj3yBvSlo=
X-Google-Smtp-Source: ABdhPJw0wiNzR9wde0NKgiJEc9rUrDy41Fh2S/bT+PBgLxC16PXoTPYOCam3k9D8E4BYsgZKwZjEAw==
X-Received: by 2002:a50:c31a:: with SMTP id a26mr24450970edb.193.1634375476795;
        Sat, 16 Oct 2021 02:11:16 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id o15sm5934723ejj.10.2021.10.16.02.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:11:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: Remove redundant 'if' statement
Date:   Sat, 16 Oct 2021 11:10:42 +0200
Message-Id: <20211016091042.19614-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211016091042.19614-1-fmdefrancesco@gmail.com>
References: <20211016091042.19614-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a redundant 'if' statement.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 2900c31d8ec9..2263e35b45cb 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -255,12 +255,6 @@ int rtw_cmd_thread(void *context)
 		if (wait_for_completion_killable(&pcmdpriv->enqueue_cmd))
 			break;
 
-		if (padapter->bDriverStopped ||
-		    padapter->bSurpriseRemoved) {
-			DBG_88E("%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
-				__func__, padapter->bDriverStopped, padapter->bSurpriseRemoved, __LINE__);
-			break;
-		}
 _next:
 		if (padapter->bDriverStopped ||
 		    padapter->bSurpriseRemoved) {
-- 
2.33.0

