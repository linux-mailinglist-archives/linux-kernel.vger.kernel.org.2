Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB63545AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhDEQui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhDEQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:50:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE0C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:50:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so5909136wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwoHEE8hHryiGOd3Mhwepcll5gXefGpIh1T+3gwkYJA=;
        b=tqeE2euWnKJ4LxJlLnz/7r0IDiJgQNlZJ8eVaQpBBXg6Z5IgffojYfxIylNdq7T1Wo
         rVaOqRm8or4A4D7eZK0iKtOKUMLl58Ky94xSJElTS2mUvLzmOv2v9yGg+ymW9YvtZcF9
         lgzWzMPw2wPOUpRCw7fmUd2ArfEjyRAMWGKrXAC6qw82OMLhL2GDXH+hFPjnjmFaj/DT
         zTcIUxxk1oslxX3jt0xcc5kXF/GCtahv/STmYLKY1AirWn/dV4aOzXpyiJNSDQUmE1hR
         SxWEIA8aDkM5qUg+H+ImS7p8dyyGIphvTu3vohTIa8VDmDY70gNDAO9Gc34upTP6PDHr
         Aedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwoHEE8hHryiGOd3Mhwepcll5gXefGpIh1T+3gwkYJA=;
        b=D++CRkXWJe3p7JVOBXjtSQB2RGlUOUR6WrGC5jVDSvcIc4rYG/FOQIL6R7pjMwPV43
         fNVhYQbTYfprUzGLc30tAmr7Uq3OhGWykR1iUpS9BETSizImk0CNf5fRWucSHDI7ikEy
         q3q68+HVrZca0siwcLeF0YsRSkD0XfOzfafPjKiXUY44GP33+bpWOYjfhN/QmiK658rJ
         Uz2nkwvDZbQOCDWvSjbx+Uy9CUPxQFSz2BfWeKnmyIff/e954sr3Ly24HGsF6WofEFPX
         389ccf8Y0eDD484f46G+w+3KdvoUVYHCa+1+Sh0Xeunda24m6bHCbL+MK4kGEZKnb2nl
         dciA==
X-Gm-Message-State: AOAM531KE2ZS2oUFnCgKJhRKAKVVW+LVv5qAl6+qdPrtZhpudtG+SfPt
        Wc+SZGMfK8Pyrn+TxMB5AUU=
X-Google-Smtp-Source: ABdhPJxY7qv5aB9NnvH0CerBlsu3vuoBBShY9Ell9Z8KHFjiqo8KdwZOxWNOjZgCpfx5MvK1vtv6PA==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr26064wmq.141.1617641426524;
        Mon, 05 Apr 2021 09:50:26 -0700 (PDT)
Received: from agape ([5.171.72.58])
        by smtp.gmail.com with ESMTPSA id s8sm28366511wrn.97.2021.04.05.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 09:50:26 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 07/10] staging: rtl8723bs: place constant on the right side of the test
Date:   Mon,  5 Apr 2021 18:49:54 +0200
Message-Id: <8a6967abaef8b2edad6dc829dd232a7f048899d2.1617640221.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617640221.git.fabioaiuto83@gmail.com>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-hook checkpatch issue:

WARNING: Comparisons should place the constant on the right side of the test
85: FILE: drivers/staging/rtl8723bs/hal/sdio_halinit.c:676:
+	if (_FAIL == ret)

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index cec72abc983c..5553246fa80b 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -673,7 +673,7 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 /* 	rtw_hal_disable_interrupt(padapter); */
 
 	ret = _InitPowerOn_8723BS(padapter);
-	if (_FAIL == ret)
+	if (ret == _FAIL)
 		return _FAIL;
 
 	rtw_write8(padapter, REG_EARLY_MODE_CONTROL, 0);
-- 
2.20.1

