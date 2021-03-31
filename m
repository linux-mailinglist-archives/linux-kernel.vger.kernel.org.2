Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EFD3507CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhCaUHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbhCaUGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:06:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA664C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:06:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so1797009pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GMg/FFR0ECC47+tfo5vkmf+ZSs0QnHlqZW6AgseZadw=;
        b=lN+dORtkNG9cCkyJSGFHpXAsiz/Q6/h+13fjotQ6LWYeLUUHC5GeustujfD6HgNxNw
         nzdmPyx4NTcLGw1nuFacO2WCG1ykHJJTf0qUgxahC8Czw2gbcWBNNlARBl+gpag+hERD
         /wM+pxztUDyQ7YxNwqXM53vyoPa/Iyw0br2ftrXCVyHL7dPs0gtWflqIrSGb57TCjz2U
         FFBQBiKJ+J2SSALq1e518H43gFqIlNvIs4tDyQb/JHmiPBQUOi7vkDwAVCkE8TEKhpYH
         yBqzsokASb23RcFuvX/5wuvG1qgSsui2427xkHMg570wnxL6k5lrdu+UFRMOXx8Nk75h
         JOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GMg/FFR0ECC47+tfo5vkmf+ZSs0QnHlqZW6AgseZadw=;
        b=LZ90ljy98okdM7fKIqBCkP1BgbitDnNxxPyb8apLqW6e+s1b71f+nsyQbkcV1P0FFk
         titIQt9NgaHV3+lROILodJq6QLwpkW6reW/ewjKZxwzbcBwETkyUH1UWnGoCj0pU+Mt/
         n3/LhE1yTfamJqBfz+4e+o68+Yps8XQCPzdm57friseBsRv5kBUxPetCE+1+J8RavG6N
         nQvj82rhZe97TOORE82/WINURvJqz/nDknMeWRusFO2CEjSljmB5+uheWaku9zZC+mnU
         aNPh6fjR7aJ0KIIt9igGNmvftf8glAIVutfnuOItdw+plJQXlZciYI+M/fNk9LlAW1Ud
         4bAg==
X-Gm-Message-State: AOAM532YmhnCseI4rD1ivU+6U26kbrlcAIZ1OlkbMbe3ZFKi+FHDOi0B
        SwXdPcUVvpo77gBMKA3PQxis1RRUDpro0Q==
X-Google-Smtp-Source: ABdhPJyJQO9W5tM367fuFnr/0aBXWfAqS/iM0S2VBhpLiss3WR80o/HPlzj7rt4I8RvRKpaW/ogd/w==
X-Received: by 2002:a17:90b:38f:: with SMTP id ga15mr4994722pjb.149.1617221205384;
        Wed, 31 Mar 2021 13:06:45 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id d22sm2985668pjx.24.2021.03.31.13.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:06:45 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: core: remove empty comment
Date:   Wed, 31 Mar 2021 13:05:37 -0700
Message-Id: <f6be2f84ff5b29a51ca6be0d269c50d54568b2e2.1617221075.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
References: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
References: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty comment instead of fixing the checkpatch warning that it was
generating.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 428c71ce0334..7b4c0f22cd90 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -876,8 +876,6 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 					*(payload+curfragnum), *(payload+curfragnum+1), *(payload+curfragnum+2), *(payload+curfragnum+3),
 					*(payload+curfragnum+4), *(payload+curfragnum+5), *(payload+curfragnum+6), *(payload+curfragnum+7)));
 			}
-/*
-*/
 	}
 	return _SUCCESS;
 }
-- 
2.17.1

