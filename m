Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6D3636D2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 18:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhDRQsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 12:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhDRQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 12:48:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67820C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 09:48:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 31so7122465pgn.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jAaKUfUcTBzN1eaNKA5kBWKVSugP5XYulKpJt/IIaLw=;
        b=a4VUMesj+ViRkIufmRfiVXZJ1iH/1y5wMI8p2r0h3dGgMtlbMlo7//DMGEqc8EdfjM
         zlgD0wxQ1MsskRWXAuUlfPHcT/DXf0qbOgbalqPE28IGHbH9+bgiRse6FiW2ZUyvsRDX
         5deZqtnrAZVQQXuzCfTPvQZcdkufY8kw/ATngw5v9404GEsf91qC2JL5jORmVfsRHmJK
         k7H62jdm/+uZtheuLkE8gJRqaPiRq1P6/eS0ZO7H/8I4DZ0C+61lDppbP1VMwLSqN3l4
         JqeMs2CWtBjtQIZ9cgULOJfRI5i/SWNQKQRFPjqAE6LS9iK5wRP3ZLuUwPoR6TwW44zz
         tDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jAaKUfUcTBzN1eaNKA5kBWKVSugP5XYulKpJt/IIaLw=;
        b=AFSNdr9pLbPQeJ87hUGV1b9N10vARoMlq0kVWnYSuQRg92GfNUl5sEcHJ/DPWF4BmS
         GhP82YRDYEgIuz7FH0QLxuvbRpLzYw91uA/KUHxG0gAW3HaEsCLD/DYWNh3NxHAUVQQU
         FP4/5HDEOJECfeyXHRcpKhN6//w50jfUy3zoFedX1PPfLdwbfy50oYm0bANrL9GsMMZR
         GwNfYkNOkUWAkZsN3/RmcESmb7bGfwzqzbo8jYWF+r8elNAu4UPfDTWRHxpjLMZNmhEu
         tEts8HBBU2FcAvb0MYaaL1+hfi1qU+NpAM7+bKC/W0UUyF9TlH5A5JWW9KQg8f4p5gXX
         hvyA==
X-Gm-Message-State: AOAM5306GLTVrQ6rkmC7YXoiozYaXtKespekM/gNW/d2trduUcwCbhZR
        nc878yXtCo4ctRzTEy4GqnY=
X-Google-Smtp-Source: ABdhPJwT6b8Z5YM57KwecCttty/jNOlzjGmIpvYV4XVZuoyF/ASzfgfDLDFf3OYx+ylAFz0UryylnQ==
X-Received: by 2002:a62:3892:0:b029:250:4fac:7e30 with SMTP id f140-20020a6238920000b02902504fac7e30mr16436281pfa.81.1618764501691;
        Sun, 18 Apr 2021 09:48:21 -0700 (PDT)
Received: from user ([2001:4490:4409:d07c:b4ac:39e7:e05c:f39b])
        by smtp.gmail.com with ESMTPSA id n52sm10354260pfv.13.2021.04.18.09.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 09:48:21 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
X-Google-Original-From: Saurav Girepunje <saurav.girepunje@google.com>
Date:   Sun, 18 Apr 2021 22:18:13 +0530
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        john.oldman@polehill.co.uk, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: os_dep: remove unneeded variable ret
Message-ID: <20210418164813.GA57451@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/staging/rtl8723bs/os_dep/os_intfs.c:1156:5-8:
Unneeded variable: "ret". Return "0" on line 1199

Signed-off-by: Saurav Girepunje <saurav.girepunje@google.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 1f34cb2e367c..920ec25c9a4f 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1153,7 +1153,6 @@ int rtw_suspend_common(struct adapter *padapter)
 	struct pwrctrl_priv *pwrpriv = dvobj_to_pwrctl(psdpriv);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	int ret = 0;
 	unsigned long start_time = jiffies;
 
 	DBG_871X_LEVEL(_drv_always_, " suspend start\n");
@@ -1196,7 +1195,7 @@ int rtw_suspend_common(struct adapter *padapter)
 
 exit:
 
-	return ret;
+	return 0;
 }
 
 static int rtw_resume_process_normal(struct adapter *padapter)
-- 
2.25.1

