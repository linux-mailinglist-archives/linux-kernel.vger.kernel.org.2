Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494F83535B6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 00:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhDCWsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbhDCWsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 18:48:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A8C061756
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 15:48:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso6155013pji.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 15:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eQbPmNKd6q5cxqNb392vci+n3O0DxCpP0TsR6lsd/sk=;
        b=OYpvcSH1s7ZZJJ9eOhyf9KT6eNy2WRAjx3+1TjP3yrZ2B09h5QWtkPg/25Nt9dhCyY
         D5U7Ei74aAkuThc5n4u3gIcIhOylM0Li13LtDF2SlKjgMkyuiPThHlYwV5DXFpUgpUDO
         sdSZyYwPb6Y7wJa0mCnR4uPiAXZ5xHM5pioOTqSpCgh3+AGPPsUN0GPSMCisi5KKPqGO
         SJ0eZJeHFiKLYny2x8kqisvmibAns9ki4C8Lu/yZUOgiWk/avpeUDZyx33kQlTo+7wIX
         KxJKBH8BM+ILHQUMtfi5GCUYGSkv3gzl+/JAag/c1bpvnK//MuCTq1G9nc6A5F4wwtrP
         HbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eQbPmNKd6q5cxqNb392vci+n3O0DxCpP0TsR6lsd/sk=;
        b=liYQgp6tsDZLfcUk8xSr27htjbSDvFUa/ySnKgPO6ieZ4oY7gb76c+T4IppprppgPv
         4EW57NqadbaJcw3zc3Kcl022Zb3/pOXOOQKYFvaQsOqHVbF1vedFbLUn9WT6xSf161OC
         xSYQjeHhx7ZUvil3yBFjxSep8G0FQDQRgRySyGK5hILkV3wmYFbGrXD2k0yoIA5kcya5
         o0SrRcKnVADuu5YfkxP6WLMBcctZF/Jv2DFgdcvaO1YvCNaNx0WVCHBr+Efqtz0dudOh
         KuRaxeypRFVDqS4A+YIjyXR+I6c1Jt+Hmxw/Pmb9w16md3GKsOCNOdI0HnOkPkyXhzM2
         B/3A==
X-Gm-Message-State: AOAM531UFiQJlyZCvbM3bEIo+1+zKdLXYH+k2suwawvuzS3700NPlXA9
        IGAEE+OiRkmoJ5gW5SuEtkM=
X-Google-Smtp-Source: ABdhPJy529vGLncdfl+vY4IzTj+IXFhtqKX0Vo9u+NiZYVySjTb+c0modWlY1BS6IL7oDi/Ld7Gyeg==
X-Received: by 2002:a17:903:2284:b029:e7:1490:9c60 with SMTP id b4-20020a1709032284b02900e714909c60mr18300487plh.62.1617490081197;
        Sat, 03 Apr 2021 15:48:01 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id mr5sm11703665pjb.53.2021.04.03.15.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 15:48:00 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, insafonov@gmail.com,
        rahul.blr97@gmail.com, anant.thazhemadam@gmail.com,
        suryashankardas.2002@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH] staging: rtl8188eu: core: replace spaces with a tab
Date:   Sat,  3 Apr 2021 15:47:38 -0700
Message-Id: <20210403224738.28957-1-deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To conform to Linux kernel coding style, a tab replaces the two spaces
that were previously used to indent brackets.  Identified by the
checkpatch warning: WARNING: please, no spaces at the start of a line.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index da26a3c705f8..617f89842c81 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -425,9 +425,9 @@ static const unsigned short Sbox1[2][256] = {  /* Sbox for hash (can be in ROM)
 	0x2DB6, 0x3C22, 0x1592, 0xC920, 0x8749, 0xAAFF, 0x5078, 0xA57A,
 	0x038F, 0x59F8, 0x0980, 0x1A17, 0x65DA, 0xD731, 0x84C6, 0xD0B8,
 	0x82C3, 0x29B0, 0x5A77, 0x1E11, 0x7BCB, 0xA8FC, 0x6DD6, 0x2C3A,
-  },
+	},
 
-  {  /* second half of table is unsigned char-reversed version of first! */
+	{  /* second half of table is unsigned char-reversed version of first! */
 	0xA5C6, 0x84F8, 0x99EE, 0x8DF6, 0x0DFF, 0xBDD6, 0xB1DE, 0x5491,
 	0x5060, 0x0302, 0xA9CE, 0x7D56, 0x19E7, 0x62B5, 0xE64D, 0x9AEC,
 	0x458F, 0x9D1F, 0x4089, 0x87FA, 0x15EF, 0xEBB2, 0xC98E, 0x0BFB,
@@ -460,7 +460,7 @@ static const unsigned short Sbox1[2][256] = {  /* Sbox for hash (can be in ROM)
 	0xB62D, 0x223C, 0x9215, 0x20C9, 0x4987, 0xFFAA, 0x7850, 0x7AA5,
 	0x8F03, 0xF859, 0x8009, 0x171A, 0xDA65, 0x31D7, 0xC684, 0xB8D0,
 	0xC382, 0xB029, 0x775A, 0x111E, 0xCB7B, 0xFCA8, 0xD66D, 0x3A2C,
-  }
+	}
 };
 
 /**
-- 
2.17.1

