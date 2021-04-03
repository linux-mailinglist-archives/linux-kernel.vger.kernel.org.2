Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DBD35333C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhDCJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbhDCJO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B605C0613A8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a76so240878wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HW8zP7DoM2YfAVkpuEz006Zh/rGoWUODHC32UiI5NeU=;
        b=OHRXh5+26RnIXBkTcT3u7qvjYxGs18gFrQKrrYik5fnQx+BAYvMZusUX2DxC+HiR8R
         I+GIUCHNGe3RB88aDwori/fRKOVcfm5OtgOvraG+ui0+UaRnorsuu3A34YqITsVALJlV
         3aClGUIhtYpRCHhHmLE+RS23JihKLjFPmKEqQU80tiW4uAn7B3FWoe5p1vpIkbBOG8dO
         ZA4tc1OSzg7bvZMnnac3YE/5JJad6DnJhezA15pO/Yt7N2+bFPZunZ/tVvZGMukkwG83
         akHq9vPK+1zE58103MxXr4Z0q9ij/K7TmrsT/Ty4RL0nT3n9mI2Yi8ytv4cLZONw5Nqa
         vTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HW8zP7DoM2YfAVkpuEz006Zh/rGoWUODHC32UiI5NeU=;
        b=o+oW1M1evjjLwBTpHE2rRlTf5J5VNV6UHIIJQU8E2/dolWkarfN3fwItMVpUa09ZHL
         /RcY6sSSnurIkS+ZK8fCiQ4AGI83hPHGXeL9ZOMH15pFg+3OeUvnvcR6GhBVK+32QIeB
         EGJVkh2iQCkZApNlFucpDgGnVnB+vmzW/a1VIhY+QrFK4VHugSwg2bF1dwKfISyelLOV
         CaqWR7l2HT/1YEzAMq680KzatTdY8/+I7T2mguYdBDDj/kYVkwDlIqPvqWqUUgzRPhyv
         KYOiX6Y+WyxBgy6bzq0Bo7TzUuj6l1ZV8P+1bS0+WzC8IhFzZkbbBDq8iHk7HVwCtIoe
         r2zw==
X-Gm-Message-State: AOAM533xryOcRx3p780Jj7IbAvRfmfkDTu8YZJO3JVVGiUFfzvBnHXln
        ZCqvUGD3zRr6w5GVN1Mc3Os=
X-Google-Smtp-Source: ABdhPJx5HvirmS15z/0MhS5AZ3okG4YxAYVKgxsnFMmQEyRQ9tafwrDkVpjln0dqSnNepkAGekZRNA==
X-Received: by 2002:a1c:1f4a:: with SMTP id f71mr16391388wmf.101.1617441290342;
        Sat, 03 Apr 2021 02:14:50 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id b66sm3828776wmb.48.2021.04.03.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 23/30] staging: rtl8723bs: fix comparison in if condition in core/rtw_recv.c
Date:   Sat,  3 Apr 2021 11:13:45 +0200
Message-Id: <5acf0d9573f2d9cd5d249f928fbfeee010f5f3fc.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit checkpatch issue:

CHECK: Using comparison to false is error prone
27: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:381:
+				if (psecuritypriv->
			bcheck_grpkey == false &&

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index cd4324a93275..21949925ec77 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -378,7 +378,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			} else {
 				/* mic checked ok */
-				if (psecuritypriv->bcheck_grpkey == false &&
+				if (!psecuritypriv->bcheck_grpkey &&
 				    (IS_MCAST(prxattrib->ra) == true))
 					psecuritypriv->bcheck_grpkey = true;
 			}
-- 
2.20.1

