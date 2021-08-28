Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929963FA556
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhH1LLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhH1LLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:11:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABF6C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:10:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so6418568pjv.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YpYD5S+oJ76Daxyrbs6z/uA8QuUaxZ/HO+lVXMytHr4=;
        b=UDReh9hRJh9D9a/clnpUro71c0Su+CO2S3YaVgxKBgWBC9VjX7ENLFrlXjSQGz6CvG
         20+OvpRpiUr4FNXkNGFn0opJIXvF2EzlHiC8221xh7CAsjlyiBqLUoze4l+3hwYMzYgp
         n3qomIbX3bufmZOOzfJuJ06W506c6hE9zVZ67gpe6+vveg2RGisty7zkII5ImFVC96bi
         0KOLR+3vR9Hn67aqELHf2alKtjwPcNZg0MzznD+6Rm4GFDZsmeMZDgWA5epSnyEOq3bc
         GgfHYDVSQuaj/GsOdpW69Qx1v68P2b+rnHaymg5wxwFiinzmjnSz/JM/hq/VnpPw9StC
         jNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YpYD5S+oJ76Daxyrbs6z/uA8QuUaxZ/HO+lVXMytHr4=;
        b=Hu6POTmelkFMtG/mxk2+PE1+tQw04tuiDOHrlDbVV4I+RUPkMEWSAK3M7xV9RN97N5
         reJ9etFg1SFeMH80q1l2DDRfpq4KoCa1fpW/O7aJdC4ULMChT5cw7SzbxBrqGcCQPwTq
         BKv2dxhXtw14+drBLkLk7iOwX2lgLRZabVrVB6TvM9so37aMaw3uobf7oVbTCnIdiRTw
         apRjwNExEvlE4GEl5HsS5TcMwyABZMrsxH7d3SDqcq5NqviAdpO485FsisKSeK7ntIDZ
         au5pM3D3EKPZvQG2miozuwso8j8/2xTjV71r1JLye8zRRdhJr4oGzgRpq6bP9ZZQE5Bm
         qZAg==
X-Gm-Message-State: AOAM533deYnRK9aCWjH2RacFITDPa1i2vg2z0ARPbGUYYDeYCxf8/pc5
        V2J0XlqkbEgtz1ddgzAOZ1Y=
X-Google-Smtp-Source: ABdhPJx45s3f+B72bbecp1Ik+pLsniM09kkGyhjz9iA2n/k5VvbxPSuTNTYVfdOaiQLMmLj7syW0gQ==
X-Received: by 2002:a17:902:e891:b029:12d:6824:9d28 with SMTP id w17-20020a170902e891b029012d68249d28mr12951548plg.23.1630149055771;
        Sat, 28 Aug 2021 04:10:55 -0700 (PDT)
Received: from xps.yggdrasil ([49.206.124.188])
        by smtp.gmail.com with ESMTPSA id y64sm10205379pgy.32.2021.08.28.04.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:10:55 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] staging: r8188eu: incorrect type in csum_ipv6_magic
Date:   Sat, 28 Aug 2021 16:40:45 +0530
Message-Id: <0b7d6e92c79a6daf55a0c3a4961df6f33a9bcf37.1630148641.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1630148641.git.aakashhemadri123@gmail.com>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
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
index aa56cd1a8490..38f1bd591da9 100644
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

