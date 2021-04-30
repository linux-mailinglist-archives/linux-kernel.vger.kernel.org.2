Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06936FD09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhD3O6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhD3O6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E72C06138F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y26so3354449eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDyKLq5fjyeL62hL+6feutXGTzuTSzr50xAs4CUIRQM=;
        b=qQwdmm/oJ4xW0/ljbyf2t0jFxgYntfMDrrS8//mKMyhMYsdWqhwXefvqhUxT/lkBcp
         jnJ++Oe/gErS+uXHdG9U50REpDk/A0mrTbNMjiG75xAEQ8Zf1L4Nlax18IM8IbwtHic2
         72f9lhL3/6QYj3q41H9581tPwi/8Gv3WfavThwjtDo/xiYFS7KvpcQSg5l676JJN16tH
         JAO8Fs3d8SKLmCYg5bdXQvxrXpkutgfi5KilIz/Lh9UYiEyfjqSymmHfbYraWirqaUk6
         tI28vzmEjHbeJH8wjBFAKNHtLsBrLHj6YNjPhbJ6isMziq+hQm+97ghSlcwrHI0vqfNm
         fRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDyKLq5fjyeL62hL+6feutXGTzuTSzr50xAs4CUIRQM=;
        b=EQglXW0YIyiFUjMC3UwmCcj5bM7YmDC5ejnvEoy3M7QluU2qgv7X1hRAv+kvyZRBnJ
         a/6rPK4x0DBDnuipcdE+iiJ9kCvUQqcMyZqkhvI7m8ZUjYjq85WbcwIkmFO5dML/99UT
         ER02BLi/FWorGYvtTFBZKPNcGeMtXTswJHJ1tNQJIo1vXC3EimrCL38M/wjI8t6Bme3+
         6crlLxxHgF4K/Hpc176zlQpP9/HlgfdaIzA8tiyoRa/t2Z4A4o2fGpOwa4i7CwaX5a9h
         /rjGJgJRJRzjGGw0dXUbvg0FLqSRTpiuIR5BCVvVElpgtB0NiHcBilfIl4lh1fIsJlDS
         QiYA==
X-Gm-Message-State: AOAM5330Uyx8s3v7G6N9DkUlDi+uRtNHdIO1hgWgpH5Ga2kCzTX2Mldw
        s04y3zGMWOu+Ebp24BpAPsFztxs+rIE=
X-Google-Smtp-Source: ABdhPJzH44clthiIihsWVNBEhRtG0Aqvaz87qdAP9CWP3eJC8c+8PzqasqJ9h3/JTSa31pua3ULNZA==
X-Received: by 2002:aa7:d806:: with SMTP id v6mr6519006edq.309.1619794652922;
        Fri, 30 Apr 2021 07:57:32 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id cq12sm1432640edb.87.2021.04.30.07.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/43] staging: rtl8723bs: remove unused ASSERT macro
Date:   Fri, 30 Apr 2021 16:56:38 +0200
Message-Id: <f13bc57cc3a821c40443dddc38258b87962774a7.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused do nothing ASSERT macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 8ae9948fb0c6..78b9b4548dcb 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -92,7 +92,6 @@
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
 #ifndef ASSERT
-	#define ASSERT(expr)
 #endif
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

