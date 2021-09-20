Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC62411B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbhITQ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244826AbhITQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632156850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zzlABCzc1z/h8/5FAcURoAK3fN+JbZCA63Q184+5bRE=;
        b=DYXQvRvjdaqBGMtGnB22fWfyHLkmAcaW2ZoiyBs4Lir9dddKBzWmxmGHfcG4v7RJXf3ZZr
        J+MIieXT6RkqOeJiinxKRIHvMrDayH8ql6PNI4qS1YTapX4r5HqaFVhKVRLk9mAc3YsrfM
        mzVkePhcMkb8O/L/gyvku6dYncIyEXQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-Lu8EWcTvNyiSb7feXRWVjA-1; Mon, 20 Sep 2021 12:54:08 -0400
X-MC-Unique: Lu8EWcTvNyiSb7feXRWVjA-1
Received: by mail-oo1-f69.google.com with SMTP id d18-20020a4a9cd2000000b0029afc2f9586so6653747ook.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzlABCzc1z/h8/5FAcURoAK3fN+JbZCA63Q184+5bRE=;
        b=m9MlD0zQ2L/fan4MBkbg3EeWkGYDrIwYWLDbre6F4dR/D/4oD2Fp/pUS75pgBXuEFA
         bNOqc6n89EQxk+PDi98+L1dNjpVIdXyexpPnCSLaeF9pTIw23va2EAVAdg/PuRtOPZjq
         pu2yYKKFnYeij6QrGy8tz+mQ8Z7yv0Ca5OARzZ2P7/PucV7lgv8pyI14bLnb0blnDPwn
         vIS8bPOCUsHAdssdXu82D8vObuXfhuaXamL8rNmzbtpO+Tr/aPzgDnIHPNlkqV07UMqd
         t2wLcO19C3cbjz+vArcX0D1kd/FOlvafmawQUtvUN5PayTybrUuGHNGX9vAm33kXPGi5
         TItQ==
X-Gm-Message-State: AOAM530tKa3YW2J2KlIeLQIw+MI16DCrfZiWgCc8wQZ2ZFFocliIGCkg
        LKKwB2zS7vVL2pCNvC//8o8ql2pHFAmI2luJ6eTxYXbsCAULqQXYnWOpJiCQXqrJ/5IJwJljFpf
        h9eCPRSe+sU/DVowb1r86x5ap
X-Received: by 2002:a9d:730f:: with SMTP id e15mr9610552otk.260.1632156848201;
        Mon, 20 Sep 2021 09:54:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygBfy+NDy+BtEjDMWKR++vLlpw334lp+eSEKAbxnS8Kvxh8fx/uF1qqFopyFLbZUtFviSxKg==
X-Received: by 2002:a9d:730f:: with SMTP id e15mr9610531otk.260.1632156847992;
        Mon, 20 Sep 2021 09:54:07 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r23sm3502079otu.54.2021.09.20.09.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:54:07 -0700 (PDT)
From:   trix@redhat.com
To:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, kuba@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, schalla@marvell.com, vvelumuri@marvell.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] octeontx2-af: fix uninitialized variable
Date:   Mon, 20 Sep 2021 09:53:47 -0700
Message-Id: <20210920165347.164087-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Building with clang 13 reports this error
rvu_nix.c:4600:7: error: variable 'val' is used uninitialized whenever
  'if' condition is false
                if (!is_rvu_otx2(rvu))
                    ^~~~~~~~~~~~~~~~~

So initialize val.

Fixes: 4b5a3ab17c6c ("octeontx2-af: Hardware configuration for inline IPsec")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index ea3e03fa55d45c..70431db866b328 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4592,7 +4592,7 @@ static void nix_inline_ipsec_cfg(struct rvu *rvu, struct nix_inline_ipsec_cfg *r
 				 int blkaddr)
 {
 	u8 cpt_idx, cpt_blkaddr;
-	u64 val;
+	u64 val = 0;
 
 	cpt_idx = (blkaddr == BLKADDR_NIX0) ? 0 : 1;
 	if (req->enable) {
-- 
2.26.3

