Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD6350A65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhCaWoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhCaWnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:43:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D17C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:43:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a12so57649pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FGiGH5+ml2VgPHsxZs7b2NPl4+G+lB9mceSj+p7XzF8=;
        b=U26e19lwfmllaO35ttkmS5Q9GUoXvorxglHB11m/WKuLNdhFDwEtcfJzEY5n14zAix
         680wmmGXS3n5yDrhmR90ygfciS5Ntimh6D701yPq13FRDikCpUu3xUQ3/juATCLkj+hO
         NTujkaeoGtFZc91cOpZBzPHUVlzlYJ2vBD2RytvBtjVkWdqoTMiuOMk2J/E9ZXuFpIdH
         ImXVxydqcCoTqTL2l1jSHwFZfmYMxKnO53ecqZ3JCLabBVWJAJFZUQZdVdbQqQs234U1
         chK/EpN71lmh2ZB3pnLUdij4oYmtsRASbHG0g5a94Mj4S7Ns6DlnPwuzPmaGbjOZ6xXl
         Nf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FGiGH5+ml2VgPHsxZs7b2NPl4+G+lB9mceSj+p7XzF8=;
        b=pVzC0ezd+gTn7XX3KhqrbgkeJIQsg6ElG9WsCoE8J0xTN52wPmGmMhwuNFV+ooVUiQ
         tiq1ITz06SAAr+bnZC3T6e5NCOqYEgPu3PxKh+Dky8XjP7OaCWq6NSgduxRRs0G7VZat
         0XFKTANQDyf09bua9DdijVdDQQqT51CuZYKHDxr6IZxd2IW9WzE9/u/8yXQXRyd3S7CN
         HNOx8uSFlZ2YduG7euaksmMIWcQzL99fJDM5o/jUzWWVegPNLswYSqm4Ly/Jb77gtp4w
         frxJsxGBu6f6bfD/I5Xwfenxe67dqjhhsASrxZRBzkzd5IWJ+Da9jTHyRPHc9kz5X5WQ
         EM+g==
X-Gm-Message-State: AOAM5300gpUZBsJmvKhbJ/0YxAvnMCr1WYXa9w2n3yRGUhuZD1o/LAFy
        gtKxyeefOKIXpBwZYPFTY/Y=
X-Google-Smtp-Source: ABdhPJyVOksN7qTo5ZX/8ggaGWoUjeQRjKfHd/mNDBghRzJ/kAj76voWenrwwe4oaKRUHd3J+5xDFQ==
X-Received: by 2002:a62:76c5:0:b029:1f2:e6af:e2ab with SMTP id r188-20020a6276c50000b02901f2e6afe2abmr5159679pfc.10.1617230621174;
        Wed, 31 Mar 2021 15:43:41 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id h19sm3338830pfc.172.2021.03.31.15.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:43:40 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH v2 3/3] staging: rtl8723bs: core: remove empty comment
Date:   Wed, 31 Mar 2021 15:42:31 -0700
Message-Id: <2362c76457b94895f0b62b59889e80349bb69d8f.1617229359.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
References: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
References: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty comment because it provides no information.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index cb8d19e4dd3c..3fc4ea02bf15 100644
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

