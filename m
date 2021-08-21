Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A223F3B61
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhHUQTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhHUQTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:19:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2BAC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so9364188pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zce+9GoPNcPtTE5VIu9hPdavcSu/ZdMiHk8wj8U5mA0=;
        b=XBS4YXiXGazjmOvBCTVJ8gM/PtNueExXI6FBqFAqhMG89Ir8VnL/XcZ515wsorFtX+
         V0EgPZrIt5MpEhk4aO7BZHvPETPKe0pKganeZN8RTi48b+xC0VFeVBdoVJfjTnrA9sjO
         M0TI1KpNJ09CJyOQ5llhhSbPPB4Ja4SrwxmegK+9qlADdxfgsGa2/58ASpt3UwKchMe3
         eRky5Lnf0Xq/GJlVsnYGnyHB25PSeRsmFavhclV9/f4aoGCcr8WFp9S0Qui0Z7hb5L7n
         Fyk5fGR78wdJ0UNVT+PC2igK3QAzqYmyEJYUbiFKRgRgoocVagWdDji+hghkrzmQm3Os
         7G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zce+9GoPNcPtTE5VIu9hPdavcSu/ZdMiHk8wj8U5mA0=;
        b=gk+HYjFZsl38VAEhXsnmrTONqlXX3zGA//DvOZsZSzCGWfh7A8m3SU9/13brQ9UPOm
         e6h1ChqKrFXCly3Vw/TZOJFsJ/zjxMN8yTA1MHwpcDCFFIZibsGRJ17WOr682wfmyG2Q
         Q0/L0RPfY2/AaTKNy4l4hLzYuxhUipWTs/HTHZXxIv5ORJ5NXDVv4vmHoWRiOJYtz16H
         YeSq7ALBPovf3jWG0Oiwj+t3tLMeaF8Y+Yy5M37lz8wntO+m19Lb8Yd02BTU87i4qQO3
         GSX2SzjomBcKiJmlkCCLszmfqX9wZaf7pB12p87Hg1Gk5CyMLlSeWqaeAxROt4X7/Zj/
         17Fg==
X-Gm-Message-State: AOAM5318Xt42oliA0DIu8MFTFfEVeo5Sf0PPww11fXFKBq85XswxTH+v
        UmrIMThwQvvmHmn1I7j4ZCk=
X-Google-Smtp-Source: ABdhPJxyimGdSVVr90/SzrbfeqN00sl2YTY7nO366IuwK9IYni62ddyW5RlB2yRk024D2obCG5D1Ng==
X-Received: by 2002:a17:90a:e010:: with SMTP id u16mr10630328pjy.111.1629562724715;
        Sat, 21 Aug 2021 09:18:44 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id y27sm4227011pfa.29.2021.08.21.09.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 09:18:44 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] staging: r8188eu: incorrect type in csum_ipv6_magic
Date:   Sat, 21 Aug 2021 21:48:30 +0530
Message-Id: <392082864befe91bb03d16ff7ca5e57ba2a8e549.1629562355.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629562355.git.aakashhemadri123@gmail.com>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:771:84:    got restricted __be16 [usertype] payload_len
> rtw_br_ext.c:773:110: warning: incorrect type in argument 2
    (different base types)
> rtw_br_ext.c:773:110:    expected int len
> rtw_br_ext.c:773:110:    got restricted __be16 [usertype] payload_len

csum_ipv6_magic and csum_partial expect int len not __be16, use
be16_to_cpu()

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index f65d94bfa286..26606093a3c3 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -615,9 +615,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						struct icmp6hdr  *hdr = (struct icmp6hdr *)(skb->data + ETH_HLEN + sizeof(*iph));
 						hdr->icmp6_cksum = 0;
 						hdr->icmp6_cksum = csum_ipv6_magic(&iph->saddr, &iph->daddr,
-										iph->payload_len,
+										be16_to_cpu(iph->payload_len),
 										IPPROTO_ICMPV6,
-										csum_partial((__u8 *)hdr, iph->payload_len, 0));
+										csum_partial((__u8 *)hdr, be16_to_cpu(iph->payload_len), 0));
 					}
 				}
 			}
-- 
2.32.0

