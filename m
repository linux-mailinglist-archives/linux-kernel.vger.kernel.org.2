Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836F3331F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhCIGPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCIGP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:15:27 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1CEC06174A;
        Mon,  8 Mar 2021 22:15:27 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ba1so6062442plb.1;
        Mon, 08 Mar 2021 22:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h0V3wBFl3kNZPYPG7AS8Khc2hPMWTT8SBUvX31L2qP4=;
        b=Qs5LsWrd8mscXEkGxyUEmjKVnRx/HBcQrekMTetDzYIcViuQKY/fbMz+sOvb0pw4ZA
         dawrz6PPXGlU93zcWYMTDi9PZlzTC5e1S1mv9D2SsL5wbecERkacPwo1uR4ismuLB1yb
         K0V1gjbmV4o1MdeeT277+pZFBHfC4iBailkNTNG8fpu1L9yjz763lzuw4eWjbvn4PBL0
         h3UWFJGWOsVJaz3grWjaqo2QMLFgN99ngJEiNrAlPKZgYc4aIYLtghW4j2lsys1kfNjk
         oc+kwC/12+S+3fqmGPDI6zBIxVFEabpwX/eYRDRdcqyz8WbeeCMceDt5yyD6qHvsU3Qr
         0WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h0V3wBFl3kNZPYPG7AS8Khc2hPMWTT8SBUvX31L2qP4=;
        b=jB4FTJ6flk1ScbqFMr9gIBsxFhks1a7GuY1uSRMDe9CGymv1+a+W3zqQmSlGZVTpTc
         V3JUOAI4kCn2qacG1XWus9umA74uwBNkT1A7E1MQkPPlrdwd1QYGAcZroIwGTtUFsmWB
         zXYGgCrVO/Ao0xlzg2cRiRbOS85yRcOvUpb9UZ3H2jK/tNU6J5+S6lHgEDw5f72jPdnL
         hUqgHjIgagPGg16zGgmW6qGVSmTLPGjqAhMLmfbKLMWf0VdDhs2/642Ln2R3rDo6Enur
         ltSw6XiTmD98GnYVYpsdFdKU2NSGTsD+wB1+9RPYbwLEcbt0ZJ6iZvVZiyMh0bE/OnBP
         tG3w==
X-Gm-Message-State: AOAM531AYNUiq8xAqP7ARucDcPk0kx6TfTdK1YSjSzD+ipuM6x4UKbf3
        MPZGC8FosuOkQ17qfvz+5Kg=
X-Google-Smtp-Source: ABdhPJwSRZbzz+AVt8TbyDZgwFErguWWWxwNBWeXZyWZKnSGNiaqAd5Iq14Pd7UUe8zVRGp+ulGNmg==
X-Received: by 2002:a17:90a:5b0b:: with SMTP id o11mr2964605pji.150.1615270527003;
        Mon, 08 Mar 2021 22:15:27 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id r23sm1464613pje.38.2021.03.08.22.15.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 22:15:26 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        parthiban@linumiz.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH] ARM: dts: imx6ull: fix ubi mount failed on MYS-6ULX-IOT board  
Date:   Tue,  9 Mar 2021 14:15:19 +0800
Message-Id: <1615270520-16951-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch intend to fix ubi filesystem mount failed on MYS-6ULX-IOT board,
from Micron MT29F2G08ABAEAWP's datasheets, we need to choose 4-bit ECC.

Table 18: Error Management Details

Description					Requirement

Minimum number of valid blocks (NVB) per LUN	2008
Total available blocks per LUN			2048
First spare area location			x8: byte 2048 x16: word 1024
Bad-block mark					x8: 00h x16: 0000h
Minimum required ECC				4-bit ECC per 528 bytes
Minimum ECC with internal ECC enabled		4-bit ECC per 516 bytes (user data) + 8
						bytes (parity data)
Minimum required ECC for block 0 if PROGRAM/
ERASE cycles are less than 1000			1-bit ECC per 528 bytes

dillon min (1):
  ARM: dts: imx6ull: fix ubi filesystem mount failed

 arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts | 1 +
 1 file changed, 1 insertion(+)

-- 
2.7.4

