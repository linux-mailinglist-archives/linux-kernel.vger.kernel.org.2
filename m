Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CC3352E64
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhDBRbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhDBRaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D09C061794
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i18so1836663wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XTNpFKePUpupflX0dLUf675z1Pas224B6agSkT6pgU=;
        b=UrQjwenA7WxWylxoVILYo797M8gt7WuRfZnPwtRi4pAXjHNQCKoBpZwL4Qy4oBKs+O
         yuUCFnwi6TZ7nFTdboeFeCk6LkKdZKdfxPEe4XP3eueHM1vxM6/Ifu6YfrsqIWS+cOCl
         3IOwghH9VAUJLTJgbtU1qnUSfJ013uTj90su5A0gIqGM3/XKpfcdxnrOAixkFIB8PA3g
         zoZRwXW8x4wZIB1awAx4ASgXvlcRUk59f5u/e85oRigBXjp2Qw4yGddSA739Enoly23k
         4Kjt8LoXvvCkNclHzkjIJ7jt+RipdRkrQ5weJgknvFhXlLMb6a+39S9kCIRXGdtwJVOx
         FevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XTNpFKePUpupflX0dLUf675z1Pas224B6agSkT6pgU=;
        b=S+O72gD5PLTJioPWCFLX38fuuNj8jghu1j3iEUuJd8pwyEJLBotJDpB6OAKm5y9oTC
         fFGZMNweUDXgy3Klrb6jMzPqIkcJ4S2Xj4d7/iWaJO1+1UUPWtDp1fzP6DNGQXu2OYIX
         ao8adbYLtCHAypBjsTSpomHB8Y33pMC7g136lOfONquny1Qa5hPhaJwO/HBNHMzeXmDJ
         5HdHfJLRo73HrYIBFv1OvdjmvSQwLPaT6k3krxWXq+Z0DJDq1SiXmsqcF7/F6//IKvrZ
         F0eHZTtfBH6ggm2E2MgbRff3ClYnULFsdTsCU0+p0qOLHA82x/ggqCirdnGPY/HPKBxC
         0W+w==
X-Gm-Message-State: AOAM533F/9MZp1k60m4oc+FacLLl0WPljWpKjmn1BsczGPr+SItZ2WuK
        ihEetwMaBDTmxqjFFVxggLQ=
X-Google-Smtp-Source: ABdhPJxDnes/uol6ZOFcLq36EUEQt4F3qBr/8qC3QOtsjUwQGa4T6U8oQjjlCQbOyC0IJ0lwH+jUQw==
X-Received: by 2002:adf:f005:: with SMTP id j5mr15956882wro.423.1617384653134;
        Fri, 02 Apr 2021 10:30:53 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id b15sm15516114wmd.41.2021.04.02.10.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:52 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 22/30] staging: rtl8723bs: remove unnecessary parentheses
Date:   Fri,  2 Apr 2021 19:30:04 +0200
Message-Id: <79185dc9fb8b7c31932e12bdbca494b127fac561.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit checkpatch issue:

CHECK: Unnecessary parentheses around
'psecuritypriv->bcheck_grpkey == false'
24: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:381:
+				if ((psecuritypriv->
				bcheck_grpkey == false) &&
+				    (IS_MCAST(prxattrib->ra)
					 == true))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index c8a13d733c98..cd4324a93275 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -378,7 +378,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			} else {
 				/* mic checked ok */
-				if ((psecuritypriv->bcheck_grpkey == false) &&
+				if (psecuritypriv->bcheck_grpkey == false &&
 				    (IS_MCAST(prxattrib->ra) == true))
 					psecuritypriv->bcheck_grpkey = true;
 			}
-- 
2.20.1

