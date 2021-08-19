Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3D33F1503
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhHSITH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbhHSISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:18:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AF0C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so6834589pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kCf9usHbQVqNC8f9TMv7s7ItULCXlHodiSiSF2nw00=;
        b=tHEBKtEPeEPTZBKx+FPRkTwHOZIKAnZZHwUfLWfNOcbPTZD/xa7w09Q2DapUuzrUJr
         vvmg0dLTNpm5RVsIxxKh7Jk20Hmcky5y8KYgnjjPsUlAe9se1rJEnhHY5XIH8BoFnW6w
         zT9l0Ke253ktQThU96Kx3EJlkMDo4iQFjqoacWHnSXYFBfl8vt8M+Y/Y6s38O6bcmhpr
         knd5lLYu4vJ1+q3cUileSx2+xP9zJqcMyyhH7XCknWlCeEneHaJqX7MmPxzrnWydhQBo
         GgJliDjkQCawZN7peVidSEa60NO1LjGxV619ahEEB/DD9K1MvBE6m1YYtygrFn1H4DOp
         Z8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kCf9usHbQVqNC8f9TMv7s7ItULCXlHodiSiSF2nw00=;
        b=rxaRQeMHWCctuU+NcA3FWfP1I/S23P259T/04T8hjXDus03sqRyeSL+USf9x+4JMfV
         KClb2oD/d0LmoylH2hlHi4p54cqX0QU2f/8s0iD0KUN1NDko65M0Jc2unYEwAaTUW2C9
         gVtKfwTv05vFF9GzAtHAVbBANKh63jk3nv9yrnHsYBGwvtcT08yukv3+HIRK5C1QnL1b
         vvxQO0xKGs6BTpW5wrMK06nhFhwUhsqJbPxtEhl1mhP3bDde3SyDVttg7Roq/XwyWt+A
         34zm6oFIWS7dPKHhrv64xY6tPM/BBOK+wEVwgJZwtTh3ZWZsNh4P9Ysd351+C0DqVURE
         MpLg==
X-Gm-Message-State: AOAM5319MCp+w1n5HlEOUd1irV1x7Uhd04gbqz6PObOrlm6SzKsOKOEN
        Btt+nQY6TZfQ6EpgBXVKu2s=
X-Google-Smtp-Source: ABdhPJyUqp0ax9CCNYoObUzBBwuxVr0iKJRPRfGprzv/2OC77ECKxk6USdnFxYDduv9/UgFZ0GiQTg==
X-Received: by 2002:a17:90b:1c8e:: with SMTP id oo14mr14013967pjb.108.1629361098034;
        Thu, 19 Aug 2021 01:18:18 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id gb17sm1531129pjb.26.2021.08.19.01.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:18:17 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] staging: r8188eu: incorrect type in assignment
Date:   Thu, 19 Aug 2021 13:47:57 +0530
Message-Id: <6fa4a97fd0c2f0e3be6066ab6f059097e8cd29af.1629360917.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629360917.git.aakashhemadri123@gmail.com>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:516:57: warning: incorrect type in assignment
    (different base types)
> rtw_br_ext.c:516:57:    expected unsigned short
> rtw_br_ext.c:516:57:    got restricted __be16 [usertype]

*pMagic expects unsigned short not __be16, so remove htons and cast
MAGIC_CODE as unsigned short

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 14b2935cab98..600a38330579 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -513,7 +513,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 
 						/*  insert the magic_code+client mac in relay tag */
 						pMagic = (unsigned short *)tag->tag_data;
-						*pMagic = htons(MAGIC_CODE);
+						*pMagic = (unsigned short)MAGIC_CODE;
 						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN, ETH_ALEN);
 
 						/* Add relay tag */
-- 
2.32.0

