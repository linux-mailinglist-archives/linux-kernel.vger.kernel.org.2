Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74143F4EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhHWRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhHWRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:01:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D9DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n27so6446452eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrJVb4x0MevIwrPVSWjR2+axB3N0g9Y5As2MZj3In2U=;
        b=bLjKa366IbRr69mpk1Y9xDwMD39ih0ee1UL1bI8hPit/dzHjAnf0KdaawQ//sGaiQP
         FVKqWnRVJfkPFms88dH22csvFRBXRZkVnNFhCrNPzpP19NyeqRuMcUT5wye1V/ujMaPs
         XXSYJoksHO35BGd2WqCm6c3u1XTpQUn0p+Lk3Grxy2ZoZaE/WaKflMWrvcYN/JY3MktS
         VfBTrSHLdQXrgICkWd5am4IltxzzuolU5pdGxMOHQ9u5vk78+fFebRTAHSmf6rEqr1b0
         KoZkBxWNjAp0WCOXHWmaRKMzEBiVKwEKVZIDHiwc9ZztrAWQ9hRI9wqxdAbIstM2FRLg
         b8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QrJVb4x0MevIwrPVSWjR2+axB3N0g9Y5As2MZj3In2U=;
        b=tQ04l8VGw62IgEFYtV5XTrdSaFneNrSbl35d0FccQyT1HvY64zJ2I88XMO1wnJpYRx
         7+CdZGYo02lY1zuPPxZto22SLekw0FUxTpkQkIaiXIpKScaHM31vwrgmQN9CfJSJCOjv
         7tdc+TgXzHNm4wHvEzx5FL9Vb1IV8m9aqHtPld8v/R/5tUEnkYMm3MbhzuJD8imwO67G
         luE2vezmolvm2QrGcNk5QmZjPac4w2UbvmedhyLQhQbAkkG2uUKBsoA8nr5Fn+pVJabL
         bSGgBO6olKN+8TbAvRGNnIkUhoqAFRdzAInLX+pZFvTIIQpqDdjtuQ3Go+h/FpQNZor1
         +0xQ==
X-Gm-Message-State: AOAM533skF7IQLXBjRAcet9je3YRZDkSUW97Yh1nB7JMCvKLJU81Qc+k
        3WfXCmZy4sAITcUJS/NB6sGSuHLyA1M=
X-Google-Smtp-Source: ABdhPJwby945NkC/QZ8MsHEugzjR+qawJPWoIB4GObBEOUMiKQhWfc4NX7fie4BuCVmduCiQijdeGw==
X-Received: by 2002:a17:906:93ef:: with SMTP id yl15mr16441921ejb.229.1629738050629;
        Mon, 23 Aug 2021 10:00:50 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id b18sm1633188ejl.90.2021.08.23.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:00:50 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] staging: r8188eu: incorrect type in csum_ipv6_magic
Date:   Mon, 23 Aug 2021 22:30:28 +0530
Message-Id: <392082864befe91bb03d16ff7ca5e57ba2a8e549.1629563318.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629563318.git.aakashhemadri123@gmail.com>
References: <cover.1629563318.git.aakashhemadri123@gmail.com>
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

No changes

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

