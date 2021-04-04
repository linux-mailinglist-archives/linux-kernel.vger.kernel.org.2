Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA2353852
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhDDOKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhDDOKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519FEC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:09:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so4472326wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVLSD6TsWDnyVwfKOiwMsJMVRC8hKmFN/FvLWADHKVg=;
        b=i+oLZ2SWvghTyp5CK70LCoOflb9OJrNJO0xhxTyAfPy9hmtH+QY4AdFf0OrrR9T4dX
         mQ3TW4JJXkSVenFI6IauMmQRmESB9lIJp6vRntkwN3QWnhJwnRIBUf+pVZihFj2bYWCC
         4N9Wgpyggs2F83VIMo4p0+P7sSl2+WzANvrU/pLCDoIUGyxmUZ7dITTK1s7DLUqDnjKl
         P7qpsPW345TJVTTD2rdPxk/RZRbEwW4aIjahZA1JxLQIjcJVOTzt2HhMBCZwENeJqDfE
         fKW6GSjrmcaW9Wie+z6fa3h4Xy85pJkzdijKHRRz6bmfX+ZQulLPLVtTbnO48BgiDGBr
         0C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVLSD6TsWDnyVwfKOiwMsJMVRC8hKmFN/FvLWADHKVg=;
        b=N/YaDuT1ALX/UcLtUB1yjNjo/hEzmpmMWTTe5x5/0LngV6l4DQySzicsZ8j/qVRvas
         da8ZxHy9O13C+jlPTUeDVmjVx06ZE3Xh5ImyEsBD4AnVhAbz2Yzo0kcObURxLcZtJ8aj
         fmWFdTACMjRdrV+aWGiMQLE3RrYXxLxx8Z5jDt5o2dAV+pSNrjbLaWCRjMjLXagcbtFH
         o7qFnc2jL1Ush8VrglL376Sihdv/tkiofcyOvlz+yZ7Aqj21cB/aXQO6x6dL4d85V5K2
         Cl9ttKLcnqJK4rSp32VM1gCYkOVwFgRL/l44WvRBzGua387wJfa7bpXlEPNXhyL7cLYq
         ZpCQ==
X-Gm-Message-State: AOAM532krUDnntAwqXTqkMJthfIYxkHEpafg6+ps6siXAwnCyR4iXC0l
        nRqKoHrk+XM7oUI7zn7t1bK3jN72kGeDlw==
X-Google-Smtp-Source: ABdhPJyHrYHiY8iMLyZM9HGNrH+PHDFdqcZUOPwIZKctDm6WVdW0ZQGhfMu5mpsfz90AD5mbtrKekQ==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr21369149wmi.186.1617545394102;
        Sun, 04 Apr 2021 07:09:54 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id 61sm12616126wrn.25.2021.04.04.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:09:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 02/30] staging: rtl8723bs: fix condition in if statement in core/rtw_xmit.c
Date:   Sun,  4 Apr 2021 16:09:18 +0200
Message-Id: <45793b555f46312ea3c9cd285886dec22f3a1131.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issue:

CHECK: Using comparison to true is error prone
71: FILE: drivers/staging/rtl8723bs/core/rtw_xmit.c:565:
+		((padapter->securitypriv.sw_encrypt == true) ||
		 (psecuritypriv->hw_decrypted == false)))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index beee87db85a5..957d7e3a4d4a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -562,7 +562,7 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 		memcpy(pattrib->dot118021x_UncstKey.skey, psta->dot118021x_UncstKey.skey, 16);
 
 	if (pattrib->encrypt &&
-		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false)))
+		((padapter->securitypriv.sw_encrypt) || (!psecuritypriv->hw_decrypted)))
 		pattrib->bswenc = true;
 	else
 		pattrib->bswenc = false;
-- 
2.20.1

