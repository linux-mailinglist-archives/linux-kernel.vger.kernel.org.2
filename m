Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C03522B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhDAWQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbhDAWQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:16:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E777AC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:16:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a12so2424437pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y67WIBj6mBIl1Wp751rFrF2l12F5d/MqUqEWEaYV53g=;
        b=fx4VPA8okP1oGSngsHs6mosUQnkJAtCA714LP1AnHVisvlJU8j9EPH/uLeUyyUf6nm
         IDednCvGELB9CILV3BLreT7bkDSWjFVQDLDwOMooydNk4buy+7SHNFDu82K+8gdWCjeK
         deKseZF5AEhl+6K/LBB9TWtQ4VaPneXHqxTaEQiwig8pohu3jQ6rqeztqd99rLDEVHKv
         vDmwn22KLVtcg40L/ufqBGNDF/0InCi+IVWlbbt+Y2mE0IBj/iWZ0JyZZFx6E4osSjWf
         7n69PGzjlHtVcSRjR8LXFGJYNm5Dsw7YQDb2g+TGAyNqwBNc/S9XGaUDsAK1qZwnT/TI
         bItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y67WIBj6mBIl1Wp751rFrF2l12F5d/MqUqEWEaYV53g=;
        b=HJ1VSMrsPgLIEq4gH/NF+kppjB8D7WTi02mptyZZ0gAH4MPqKdGyx488n85ERIosKx
         nZ9rHS2yeZN9KbgFitWakf0mXM40ieFZOZ2auG+eeuK7tlXrdT3hCuigroqXwb7nPfbq
         2jHWbr4AwFQryJAACoK8vl++RSnYfxivtG6NOIKrYDMMt50slIWRNQaRPIXNicgaGFL+
         RBmheFDP8b18fi6RAu7CBDxa6tqj8GXXI3LcEoDgh/E4YKhlqujqa24LdTJReKcdXFxg
         xRfDfPOjjDbRxzatsB6fiwzZCJJ3Kf7aG9TCcAaeFmtYVBZUrQi6A3dna3TeEfxZbIdd
         NYew==
X-Gm-Message-State: AOAM5327i0fBcTYLWvZdRXJ88fVrs67G/Eok4IVx5qzB/zupV/pXyhng
        1jMlADdYGcUURGAAoT433gI=
X-Google-Smtp-Source: ABdhPJy/K6Tbq0lKal/Vqh26SB57XMZpH865zhinWyBVMsuQ7m0t+aQTweKMi6fL4v2ny+wakjb7yw==
X-Received: by 2002:a62:cd4d:0:b029:216:8c86:bf5c with SMTP id o74-20020a62cd4d0000b02902168c86bf5cmr9173867pfg.27.1617315391559;
        Thu, 01 Apr 2021 15:16:31 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id d13sm6671494pgb.6.2021.04.01.15.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:16:31 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH v3 3/3] staging: rtl8723bs: core: remove empty comment
Date:   Thu,  1 Apr 2021 15:15:42 -0700
Message-Id: <afe3c8846c555e1852ae1a760b73a19daaf1dc82.1617314121.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617314121.git.deborahbrouwer3563@gmail.com>
References: <cover.1617314121.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617314121.git.deborahbrouwer3563@gmail.com>
References: <cover.1617314121.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty comment because it provides no information.

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

