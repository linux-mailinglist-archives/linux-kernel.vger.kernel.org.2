Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5D35EF63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350050AbhDNISF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350031AbhDNISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:18:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:17:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j5so17985465wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyKB46K3ypu2aXeRH7albc1z58567mfbml07nO1sgOo=;
        b=HS9I2ZyD+DjA11BE75D6pAP4oLe1mmo4yWYDiwgRrBuY8h3XJQRbMsYjE/+Et5NdaP
         YeYVVQXNkGPXPth7tuNiiKui+BAm8Nfyq4vurYWoLJJv6O9KIyLSQNth48TvpAQR+j/Y
         W4jOGMCkCcA7LzgRusWcFUFdhNQ63EDEXTrXxemW2VCNzkmz/z863L/cogV+LbDFS+3s
         V+7zAxRFG0cNUwoTKnNXdgMEEy0gYJuh02tyPj+bkH22clyyOHyiwi9sIRXgCjqRQE7f
         c0JcZG2u4BR1oL6pcvR7wby3auz/l5wOYMccweF/4YHGkV8ciAqVewI7ibA1gVKVC+y0
         u8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyKB46K3ypu2aXeRH7albc1z58567mfbml07nO1sgOo=;
        b=kkvYKvadRXzUR8p3MqRx5hiwvFXXShKv21julx8uv/UcZpmNe0ZctcfaD6qYnI3YZG
         KjVXlKAyJkGUBodlJ8XpbP+szViv5NARtJ12zEaaAhfyLqjxhaCiNa+yB8fC81ukRjv/
         GFHzitT8Tr3IlFEZrkp+Ept/9VeaD9MqkTJVWNDI05H60NlGcE78yznJMHHQM/XeSONb
         HHKJHJGHO2YGMey8VCKf8KRsKp3vvo0QXcMRxgmiIq8sH1YEtvgNOjNFQ4dqR/XQX+4q
         v1edsbD1UJpNzy7Dzj5o5g8a9EVt1CHMZehHXdx+ik++F6JfnGGs54FuN6R3EbeGk9VE
         Be8Q==
X-Gm-Message-State: AOAM530ibMsZg/8NMzB295/zG+LGvF0vsrxM4P6n0rVODub99mojY7B/
        ZSaiKk0flGHlfFff1NYvQn/gtoyugX8=
X-Google-Smtp-Source: ABdhPJx2/Mvd2ETJCC6X7S3be8bRA59ZG8QpqD20+dWQh+z+jr4JsE19PTDzf5EPsGJs+SioVefGag==
X-Received: by 2002:a5d:5291:: with SMTP id c17mr42232373wrv.110.1618388261701;
        Wed, 14 Apr 2021 01:17:41 -0700 (PDT)
Received: from agape ([5.171.25.35])
        by smtp.gmail.com with ESMTPSA id q10sm770204wmc.31.2021.04.14.01.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:17:41 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix indentation issue introduced by long line split
Date:   Wed, 14 Apr 2021 10:17:39 +0200
Message-Id: <20210414081739.2990-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210413145712.GH6021@kadam>
References: <20210413145712.GH6021@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix indentation of last line in if condition.

Fixes: af6afdb63f17 (staging: rtl8723bs: split long lines)
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index f19a15a3924b..4cdc5802798d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -621,7 +621,7 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 _issue_probersp:
 		if ((check_fwstate(pmlmepriv, _FW_LINKED) &&
 		     pmlmepriv->cur_network.join_res) ||
-		     check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
+		    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
 			issue_probersp(padapter, get_sa(pframe), is_valid_p2p_probereq);
 	}
 
-- 
2.20.1

