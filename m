Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B622E38B69F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbhETTDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbhETTC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:02:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C4C06134C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so18681167wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tw5+56hf443Vf716IbHMHHdpmu0BDAxPT8Nh8kodesg=;
        b=Givmf1V6oT1LmtODaR0j3BF9pMsQ54O30msgDTjz7pvVA/XDtAe7u82QqmdHSrtdV3
         23eDMfT5ksUeQ3nHWPc1FcZBBdl4vIOADI6UkN0O5kkhmFATRxM+zRjt8faNhtkLOKrS
         Dz0CI9XtvLf74IH1RVlKINeSIDXPpD/pcWlOasO4P6YKoASUbtKnZjtPfvuC764a/8k9
         ETlitj6pk/BcxCOc5EaZV7HzWvFpyRGBh1ksUccRZeSbGA2ZkqavF520eOUzmLOJFI0t
         +9zL88+ZQ82w90NJKyC9XJY8ZibQZbjHBKyCjUuPw2LxhE99ISFz7INQy7TFYtmpEOE3
         QXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tw5+56hf443Vf716IbHMHHdpmu0BDAxPT8Nh8kodesg=;
        b=ZFMFRmjf2jC7B0JjRak7pgQzOlfuqjillHylQHwL1dwUKiZa4zhMNGDaRx1fIEQtYc
         33l+1CbBwoE4X7CQ/bjpF6kHXNskXNxOBaOkej2sfZhWg0NhASxomIOeNo6oQzOO8DQC
         EX7+gShjU2r+ikzNLVozDnZSAtoYUf3bykviNfynqJ+0YJ9CfQ0oi80dbHgcsgusHkZK
         jGQFXx/ZG+gi+XuzuSLDeNxLBzw3OhB3v00sNS3arJll9FfXW+v2gQ+vwJi3nLKRP1sg
         YPus1WTRhaACLObfqb8zbBgevOsyssoD/oX+8A2X58kr5DbOCwgcMnEMqgqe62HeGz6A
         svag==
X-Gm-Message-State: AOAM531pOXES5TL1AVXevcuPoTy1KgmrJwUDxzL+G++Kl4EOlD148Ots
        zG9FMeeJ2zAHvitT7pAAEeFMRvpmU4ihoi2f
X-Google-Smtp-Source: ABdhPJz8G5wdN+AcbyimyHYbWjNvQKyBMB+vX1to3miiKDBigAxdaA3gRJQLzVOw0VfbimKt1UiPgw==
X-Received: by 2002:a5d:6b43:: with SMTP id x3mr5750647wrw.263.1621537286301;
        Thu, 20 May 2021 12:01:26 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p20sm9011899wmq.10.2021.05.20.12.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:01:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wolfram Sang <wsa@kernel.org>,
        Shariff Md <smohammed@nvidia.com>, linux-i2c@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 15/16] i2c: busses: i2c-tegra-bpmp: Demote kernel-doc abuses
Date:   Thu, 20 May 2021 20:01:04 +0100
Message-Id: <20210520190105.3772683-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520190105.3772683-1-lee.jones@linaro.org>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/i2c/busses/i2c-tegra-bpmp.c:86: warning: Function parameter or member 'i2c' not described in 'tegra_bpmp_serialize_i2c_msg'
 drivers/i2c/busses/i2c-tegra-bpmp.c:86: warning: Function parameter or member 'request' not described in 'tegra_bpmp_serialize_i2c_msg'
 drivers/i2c/busses/i2c-tegra-bpmp.c:86: warning: Function parameter or member 'msgs' not described in 'tegra_bpmp_serialize_i2c_msg'
 drivers/i2c/busses/i2c-tegra-bpmp.c:86: warning: Function parameter or member 'num' not described in 'tegra_bpmp_serialize_i2c_msg'
 drivers/i2c/busses/i2c-tegra-bpmp.c:86: warning: expecting prototype for The serialized I2C format is simply the following(). Prototype was for tegra_bpmp_serialize_i2c_msg() instead
 drivers/i2c/busses/i2c-tegra-bpmp.c:130: warning: Function parameter or member 'i2c' not described in 'tegra_bpmp_i2c_deserialize'
 drivers/i2c/busses/i2c-tegra-bpmp.c:130: warning: Function parameter or member 'response' not described in 'tegra_bpmp_i2c_deserialize'
 drivers/i2c/busses/i2c-tegra-bpmp.c:130: warning: Function parameter or member 'msgs' not described in 'tegra_bpmp_i2c_deserialize'
 drivers/i2c/busses/i2c-tegra-bpmp.c:130: warning: Function parameter or member 'num' not described in 'tegra_bpmp_i2c_deserialize'
 drivers/i2c/busses/i2c-tegra-bpmp.c:130: warning: expecting prototype for The data in the BPMP(). Prototype was for tegra_bpmp_i2c_deserialize() instead

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Wolfram Sang <wsa@kernel.org>
Cc: Shariff Md <smohammed@nvidia.com>
Cc: linux-i2c@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-tegra-bpmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra-bpmp.c b/drivers/i2c/busses/i2c-tegra-bpmp.c
index 3680d608698b1..ec0c7cad42401 100644
--- a/drivers/i2c/busses/i2c-tegra-bpmp.c
+++ b/drivers/i2c/busses/i2c-tegra-bpmp.c
@@ -65,7 +65,7 @@ static void tegra_bpmp_xlate_flags(u16 flags, u16 *out)
 		*out |= SERIALI2C_RECV_LEN;
 }
 
-/**
+/*
  * The serialized I2C format is simply the following:
  * [addr little-endian][flags little-endian][len little-endian][data if write]
  * [addr little-endian][flags little-endian][len little-endian][data if write]
@@ -109,7 +109,7 @@ static void tegra_bpmp_serialize_i2c_msg(struct tegra_bpmp_i2c *i2c,
 	request->xfer.data_size = pos;
 }
 
-/**
+/*
  * The data in the BPMP -> CPU direction is composed of sequential blocks for
  * those messages that have I2C_M_RD. So, for example, if you have:
  *
-- 
2.31.1

