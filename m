Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFBA35333A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhDCJPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbhDCJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13869C061794
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 12so3451746wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XTNpFKePUpupflX0dLUf675z1Pas224B6agSkT6pgU=;
        b=CNIAVLyL25ley6I8RSugU6rL98P7zwsqcXK+s/tws8nntiUyxeJhyswKyiFZpev1V1
         /F2MotsdHi35I6WOTTiB4JvXKNtYpvNcC7HecOJr3cSYdbHyPVOBxh8Rnjq8CZ5eGi50
         QZ6+va+b1WFbQQE51DsPf5FRFh3TACrzk/+hUNK75hWo2/W0AXAVIP2lfnkekIN9etTF
         eAMTsU2oFmslTju93M0X8RcUhCoG9xv5BD3uaxJvbItKOZTBmOuYWc+OvXCi1hXveRh5
         LDReOpEtRfrH3leE0UNbzB/i5r2Y1KGRST0UPAOXbWHpinJTtUkt/RhPaiA2ruY8Ghl7
         dELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XTNpFKePUpupflX0dLUf675z1Pas224B6agSkT6pgU=;
        b=iS1mZ08JDMBz/fFgxbbHUtZUCtYSHbnPI0MgTBLxJi03z/s+dqBOiPY8GHvnQrrCp+
         oJ6GYSPLRFTNxDaNA1NuRElT9f3kIZfniGn/YG2qshOXnlTFJbji7zMemY0TnCwPOaNM
         zr8H8U8VtR/bmtKFl2QqEuBYwkv9Y2b1ikDsfZc3kEP6JGw3F3PS14nG+mSwiYOBEWsd
         EfGMOSasWHLslGUlByCw9Ek4zUPWrnXuwCAAn1uHdAV3+hT3rTkWOnjC2dRO5dCFtBFo
         EV9t0t9QGgGiQtXhFBJORf8qAwKicuqcecQshGMo9iH3Dg8JrF+DzJ6mggjUBVhgm8cj
         g+CA==
X-Gm-Message-State: AOAM531GxbnrFLXZKpRTiBIx6HYHlLaTiVxrkIcZLxLv01s17SbpjZhy
        UEQnvP84tbB2/GLdns+TrTQ=
X-Google-Smtp-Source: ABdhPJw81yvZaGD14BRyqFaQns6Jg2pVht/XpSVtqc4xmisf9P2Ug93+cCSCaop+YReOPEOAPYr1Tw==
X-Received: by 2002:a1c:1fc7:: with SMTP id f190mr365321wmf.64.1617441288905;
        Sat, 03 Apr 2021 02:14:48 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id m14sm15045666wmi.27.2021.04.03.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 22/30] staging: rtl8723bs: remove unnecessary parentheses in core/rtw_recv.c
Date:   Sat,  3 Apr 2021 11:13:44 +0200
Message-Id: <a12ab53aff4dbef02957457f7fdfa8a51e7fb84a.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
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

