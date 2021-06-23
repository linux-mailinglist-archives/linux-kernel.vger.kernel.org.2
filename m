Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75773B2416
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFWXvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhFWXvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:51:33 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85464C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:14 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m15so2373614qvc.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Hh5lYAWTUrX0DOd6hIZFo3zp9oaX/gLXEInfNqNWaA=;
        b=M4UsGJxDIE8NsJaXXlTn4brOvSs/PXLqW4EdMRz/b14wMv7WeR5Uc1y/DQKlb8/BLf
         k5QeOIFmXlrpzPQXei508I6b7VPwOGrnA1odYurAmp8Tjq9v1t0bwMdCeufsYbmLfRGR
         PIzPT6rLtmG5pzXAQa/61DxDxxOfb4Qmy0SF3w7PNMOs/SpJ45hbqDVtWf1Tw0z7lj9g
         CENZKPhHrLAGhcUJ/fQh5R4oOSS9JjZ+GrGzt8ATMA4DAwDWGgkGP+E+ASVJTMScHED2
         yY0ZmAuZ4X9gd8znB15l8DCawBMzaUH7yQJ8vSoSL7LXGfnh2J4/pjr6SqGbdFQoDqNo
         gnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Hh5lYAWTUrX0DOd6hIZFo3zp9oaX/gLXEInfNqNWaA=;
        b=R6NMcXMUxpS8+mPt2viRuwexhPzo23H8bw9cNm3Y9Y8Vfxr20p7lC2iQ8LKt9KkTVb
         s7B47RUOZwO6bSPqC+59RZXPz++zYv6NkuGRND9M++A9S34jhX0fzbvqpMZWRD2w3I3n
         DU5XsZh6BejeGo2RrKIajJwSM2jqXyg8dzTwFlznds9b5ZbbfEl1PouO8i15oviSnY7M
         OA2FmjqoJozsJYDjl6xF5SmeHlJp0fE5QFd0furEPk+b2ZpkiDiWc18sc12ll9gcmpvh
         kEZ441N1v8Zlqpu41OtD6q4bynJBMsdAcDSnbhl8Zn5SGchLhe76EE4Ih2DVrQgF/s+a
         t/Iw==
X-Gm-Message-State: AOAM530VxPsTrsxKn6lHuGRHQBmlLuuWHEjaWcWRFgTb4H7H53Z2DtAG
        VZ51FkzSVb4uvqKrs5vBGwzuMQ==
X-Google-Smtp-Source: ABdhPJwXB5y+OGjLmBrll3ANFXOQwCRk0/OKkcIV+UJlpUb9RZYh8OrfDd50wH4euiRWOGeXm395RA==
X-Received: by 2002:a05:6214:b0d:: with SMTP id u13mr2167932qvj.55.1624492153775;
        Wed, 23 Jun 2021 16:49:13 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id w2sm992387qto.50.2021.06.23.16.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:49:13 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 5/9] staging: rtl8188eu: remove all DBG_88E_LEVEL calls from core/rtw_xmit.c
Date:   Thu, 24 Jun 2021 00:48:58 +0100
Message-Id: <20210623234902.7411-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623234902.7411-1-phil@philpotter.co.uk>
References: <20210623234902.7411-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E_LEVEL calls from core/rtw_xmit.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 07c2171a42d0..2a51ea26e0ff 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -448,8 +448,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 				}
 			}
 		}
-	} else if (pattrib->ether_type == ETH_P_PAE) {
-		DBG_88E_LEVEL(_drv_info_, "send eapol packet\n");
 	}
 
 	if ((pattrib->ether_type == ETH_P_PAE) || (pattrib->dhcp_pkt == 1))
-- 
2.31.1

