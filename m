Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527293912FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhEZIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhEZItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69710C06134D
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r10so173296wrj.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mk39BS0/bKimRA7KpxocWhMuIWwoKnA1Ws/AOAzTtyE=;
        b=F83SNWDnHwB7+ws9/cQ+MN1t2ZK2kH/TWos08Uuvhx2JU/ruWUKb0/RjR+IlV21Qjt
         vANYuFpbO7DR6UIYm/EMRpfAzs3o3II9EjG7efYeb/pg7CnhiyzREKrCvULgSHP1j9hF
         1HoyA0r+X89u4aPtmZWEAGfshkdfexDMHCviK9t4abizzhgd+qLqPToejfxfBYbOxxh7
         AjqH4EBjQ5E1fLOUKgKUjFaLiTNBI9QwkE2t9QIEKT/lR93XQMblyiDBYfGY2l37APjh
         bHQnYINFMl8aG6Vh7crGI5UrrzNS9ACvRUlztbtd0wYef0TELk5EPOCaDoRoGdJKwJBL
         q8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mk39BS0/bKimRA7KpxocWhMuIWwoKnA1Ws/AOAzTtyE=;
        b=W3lDnaGfnr0ElOp/G0w/p9jcvL51trZF3WrpqTFl8/MR0rGhv/EtBkQ8bsiW/NTf7v
         gq823qekhifTVOPcIHbYDr5vlii0qnITD0HFDhjagGh70ahTi6//Um1MrPPFC/Dh4ggl
         1uBautiLMN8ZNp6xr24XYQHDHqBRqkJOFxHUAW0JsCey5a6dEBbum2syrhQ+L9KG35tf
         lF6PlCrdAMeJac6XDkurfoNhLFVyXY0GnGToDLujNsV65ZaaGW8I8qPEu6uGKQvzGaka
         GfPqR0lFD3qr11Mmd0RxKZNqcleEfPCzRhYdUc8fxsKYUkTMtwNHowq+dQDcSL+bMTTK
         RHVg==
X-Gm-Message-State: AOAM530KETyTa+KKTCWBoxafGJoYFHTCJBahx4MbaC5W40Jw2/Ghopd6
        Ml8TqJIVj6jjP3ehKiQtfVVy5w==
X-Google-Smtp-Source: ABdhPJwVAvubdGgOEZI8ZUI8qa5TkmAx603bh4EpbHmk50fjs/c9A2+jhDcdXZBTe2n8CmuN1pAoXA==
X-Received: by 2002:a05:6000:4d:: with SMTP id k13mr32323103wrx.98.1622018881029;
        Wed, 26 May 2021 01:48:01 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:48:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 29/34] drm/panel/panel-sitronix-st7701: Demote kernel-doc abuse
Date:   Wed, 26 May 2021 09:47:21 +0100
Message-Id: <20210526084726.552052-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/panel/panel-sitronix-st7701.c:42: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 4d2a149b202cb..320a2a8fd4592 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -38,7 +38,7 @@
 #define DSI_CMD2_BK1_SPD2		0xC2 /* Source EQ2 Setting */
 #define DSI_CMD2_BK1_MIPISET1		0xD0 /* MIPI Setting 1 */
 
-/**
+/*
  * Command2 with BK function selection.
  *
  * BIT[4, 0]: [CN2, BKXSEL]
-- 
2.31.1

