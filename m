Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467983F1501
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhHSISx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbhHSISu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:18:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367EAC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y23so5159063pgi.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2iHDz4WdAlIttHKXC2r6vcKog0rKGgMBuUThR+IjQHE=;
        b=Nzul7zIzR7+9HRNxi7dXZNGF2Klx1fcWrF/Hclj9WLqvYJQZyzCpd5DYzTriH6LPcR
         2dlq+y1S+iKTsAv064PLdWLToCOIeHkAt4iXWOcsGmPn8jfL7tKtfFT+uzbeJeeZ/Wwp
         ch2vhlPWhKh9v7hDYGkxsQRvBJH8AC9FWZGS9cciW5VlbPy4x4HkFHw90F3bKP/zxbE+
         mIeQgQOWcy4CoDMUtJTNn67Snw7Zw5j4T5Ez9UnHsb2mNnylyWZlq4d/9RvYNNRmgswU
         C4u9SQzO6X03wRBjdV6ajwHNHjToYXpuNyrdGOaldel9wB6rzCqvVnOdPvKRj+yaLkSW
         M8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2iHDz4WdAlIttHKXC2r6vcKog0rKGgMBuUThR+IjQHE=;
        b=MHbKy5oYcGnU0jPe8mGDax0KV2QBvjS8VTapxm0NaFyo2vV/2olpEKYxZ62A4u67ab
         3DynBg6M9D0ARyPgUbsM7PtJ43jQ39N26eSTkjl7/IObQ6pJ2Wzx2Rj3yB0XQIhN7Aic
         wYU/PWqUzQMrSw+feZ8Hh3D5DFf30OJHLbPTZ5RaJ1/TTFIYGRmI0aCywvSBirtrLfFJ
         DkMnDsYu/PcVikz5WXKoduw+8xB0nlbmUxmduFgp/EXH5IWLIAkqmKI99M2VVrVl9ntR
         VUAolG++6/MlAJcwsBGByCfYb8dQJ2p02bycsw6SmewAPVqaoesrwp/FjEtSaPdLZc/D
         w10A==
X-Gm-Message-State: AOAM532rbQBDlf3pIvvkSVOKiPbE/NhWZK+a2kwUmR44VXQAyGvgWASS
        wKaHUag95gZ3AR7NEPBErZs=
X-Google-Smtp-Source: ABdhPJwOEw06IKS5hagcj1D5n74ODui50xvlQYZ4th/bvxjMFMbwHA3b6JbN6rx0rDUEmeH5P2Tagg==
X-Received: by 2002:a05:6a00:a8a:b029:356:be61:7f18 with SMTP id b10-20020a056a000a8ab0290356be617f18mr13531044pfl.29.1629361093756;
        Thu, 19 Aug 2021 01:18:13 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id gb17sm1531129pjb.26.2021.08.19.01.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:18:13 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] staging: r8188eu: incorrect type in csum_ipv6_magic
Date:   Thu, 19 Aug 2021 13:47:55 +0530
Message-Id: <8bc15e51751c26fd19428f3b4976b7495feecd34.1629360917.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629360917.git.aakashhemadri123@gmail.com>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
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

csum_ipv6_magic and csum_partial expect int len not __be16, use ntohs()

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 6a0462ce6230..d4acf02ca64f 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -615,9 +615,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						struct icmp6hdr  *hdr = (struct icmp6hdr *)(skb->data + ETH_HLEN + sizeof(*iph));
 						hdr->icmp6_cksum = 0;
 						hdr->icmp6_cksum = csum_ipv6_magic(&iph->saddr, &iph->daddr,
-										iph->payload_len,
+										ntohs(iph->payload_len),
 										IPPROTO_ICMPV6,
-										csum_partial((__u8 *)hdr, iph->payload_len, 0));
+										csum_partial((__u8 *)hdr, ntohs(iph->payload_len), 0));
 					}
 				}
 			}
-- 
2.32.0

