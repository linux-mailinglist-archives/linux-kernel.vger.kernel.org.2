Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3283F0F96
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 02:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhHSAs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 20:48:28 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:41929 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234523AbhHSAs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:48:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0DBFD3200989;
        Wed, 18 Aug 2021 20:47:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 18 Aug 2021 20:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nbDBg9mYCKWOKiutMRQQ7517utN8j+39dIclsH3p0OA=; b=JXtImGhy
        WpkUposKZjVOio/dAQb8NpCo06qYe3j6QagXOTsEGiFpdOqVq6rONrld2BWi1wNY
        fs8F3Nd9bfUx0pkDV/Tr578vELd+ADuQdb2drYKIMU3o7DTDZevUg/dk1thv2yjS
        LgAOGiYnGVMTvAjskrrIqOmBAlBrFJTQreTDSvV9SUmknJ99SAT0wy4BFvbdvw/s
        e+rWgLLYBQNqlCw+lJq231ngch8tgmbj7JBbfwJeqGi07ob2btraAI3z1Gk7S/nQ
        GAbBTdketnEZxyWS+UYJklO6t9eKx9XJnBu/nUcUfz4m5vTIykRJmfWeQ+Yfaeyl
        TJbCEUqCMxP8DA==
X-ME-Sender: <xms:NaodYT_nWNw9QN-tURtesHwI9FQY_UYu99S63H0V6LAP6v3u-hD46Q>
    <xme:NaodYfsrp8mQWD1qFEZz-PmGVput7CfyZysrw7oARplixQx__BkGCdZjX3PEqEBUl
    48h9397IiQBfMulACI>
X-ME-Received: <xmr:NaodYRCUdTpVSRbvScc42ZWD6sDNzMNWwKVyLzlSwdM7NfaPCSnSrYfbkM6V4Wfmb-heAhaCxMaggPpnl0J9Njhz5oM8QrvF_2arZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    dtleetkeelkeekvdeujeehkefgvddtheehhfetieethfetfeeghfduheevveelleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinh
    eslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:NaodYffWuSr_LqYoWFdDRP31sbgXdpPOKtdUNfU-aOx6BOjLxhFX8w>
    <xmx:NaodYYM1OsI3BxJS16kWwW2iCxnAnARJxS448L0NR13YHvd9MBWqYw>
    <xmx:NaodYRkXh26GsV5Jp5o5XcgNy9J5islDW0q9DIdZI381CcBtDh3L5g>
    <xmx:N6odYRZQdwahIxCTbrXgzI9GoK7aFclZLnKIilczpljRkUJixsNL_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 20:47:47 -0400 (EDT)
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <44ab381741916a51e783c4a50d0b186abdd8f280.1629334014.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] powerpc/tau: Add 'static' storage qualifier to 'tau_work'
 definition
Date:   Thu, 19 Aug 2021 10:46:54 +1000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents the following sparse warning.

arch/powerpc/kernel/tau_6xx.c:199:1: sparse: sparse: symbol 'tau_work'
was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/powerpc/kernel/tau_6xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index b9a047d92ec0..8e83d19fe8fa 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -164,7 +164,7 @@ static void tau_work_func(struct work_struct *work)
 	queue_work(tau_workq, work);
 }
 
-DECLARE_WORK(tau_work, tau_work_func);
+static DECLARE_WORK(tau_work, tau_work_func);
 
 /*
  * setup the TAU
-- 
2.26.3

