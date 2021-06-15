Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BB43A72F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhFOAUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:20:32 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]:37582 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhFOAUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:20:31 -0400
Received: by mail-qv1-f44.google.com with SMTP id x6so16550223qvx.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQfhkXhE/iuDnswhNjfS1GLLOtEBx+9GLNQGszgVa1c=;
        b=wmGPfI5gPED9bJz0Hv35AXc33tgATiJyC/5Pzqpon6FDKL2eyBggnuqtMb2Oo4C5qy
         lRTKKCrRNjfnq9OH7y64smVJaEvcnYdT1Xorj3PIaOayTt+L2JIjGBietfNcLxfQycSK
         1svCdAo9L/FdcahB74oF5DEsdwjNGQux8q9SUixH0DUbYp4DFcYwBC7yeOLL+e48VZ+M
         zJG2L4OUcLbR8/W+hx8In/An1+0jNMIsdTtmGrsw6eFRtilaMmHHRTVick5doHgJLWIa
         NvTTrk/RtmBYK9QEGIZAoa+WXDBji91zx7iTvHevTRCrGd663AKMstV3UElu1m9A8EV9
         K8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQfhkXhE/iuDnswhNjfS1GLLOtEBx+9GLNQGszgVa1c=;
        b=tLgzn+BG4za9qH/GoYd3mJqjBqksiDsfjwvZZYKcPAvLJHF8WDA+iY9QFpkWDJWXaO
         zbs6+BvrLMYs1u46JH5I8cePH3ClZui5kemh87o6XXDAORAFTFfZOHCI27xfGC9PQP9s
         pvIpzTEo8u2UMraQCFgZmEQ2ijZAzWu976pr3n6adsGRfdB7uTTcDxzZul9X0m7T23it
         QxTI0UoUqVC8/vBdxEogcZ0i3pcvJB9+blXuEQDSvXeVE3G8ZeGDZFzfyxCBlGXW0RKp
         uFKciIVHpa4DwkUWdhsQoryJ8ohTR6XASlXXpyvL3vpF35H9KOB4vcipzm5wC/pROwOY
         O24Q==
X-Gm-Message-State: AOAM530tmQ070bAp4oJgAg1RvaY6qIUvEFj3zq9B10GB78gnKp5UKiq0
        5n29bEbSHx21stcEzgEMywNgyHyp0ivlRJSN
X-Google-Smtp-Source: ABdhPJwUHa312sQLUimo3XvsGzZcGF9tw6AP3lYsA9fRZw1V4lx77ukgf7xYMJr/SJualTv5L6Vyrg==
X-Received: by 2002:a05:6214:f2f:: with SMTP id iw15mr264649qvb.33.1623716234270;
        Mon, 14 Jun 2021 17:17:14 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:17:14 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 26/28] staging: rtl8188eu: remove converted netdev_dbg calls from core/rtw_sta_mgt.c
Date:   Tue, 15 Jun 2021 01:15:05 +0100
Message-Id: <20210615001507.1171-27-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all previously converted netdev_dbg calls from core/rtw_sta_mgt.c,
as these were originally DBG_88E macro calls, and therefore of dubious
necessity to begin with.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 16bbba6247f4..cd48e6f2a6f6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -113,21 +113,12 @@ u32 _rtw_init_sta_priv(struct sta_priv *pstapriv)
 inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 {
 	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
-	struct net_device *pnetdev = stapriv->padapter->pnetdev;
-
-	if (!stainfo_offset_valid(offset))
-		netdev_dbg(pnetdev, "invalid offset(%d), out of range!!!\n", offset);
 
 	return offset;
 }
 
 inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
 {
-	struct net_device *pnetdev = stapriv->padapter->pnetdev;
-
-	if (!stainfo_offset_valid(offset))
-		netdev_dbg(pnetdev, "invalid offset(%d), out of range!!!\n", offset);
-
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
-- 
2.30.2

