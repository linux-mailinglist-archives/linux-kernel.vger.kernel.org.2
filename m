Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468DA3A9203
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFPGZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:25:17 -0400
Received: from mx-relay34-hz1.antispameurope.com ([94.100.133.210]:50837 "EHLO
        mx-relay34-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhFPGZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:25:11 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jun 2021 02:25:11 EDT
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay34-hz1.antispameurope.com;
 Wed, 16 Jun 2021 08:17:55 +0200
Received: from EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) by
 EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 16 Jun 2021 08:17:42 +0200
Received: from ws067.eckelmann.group (2a00:1f08:4007:e035:172:18:35:1a) by
 smtp.eckelmann.de (2a00:1f08:4007:e035:172:18:35:5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 16 Jun 2021 08:17:42 +0200
From:   Thorsten Scherer <t.scherer@eckelmann.de>
To:     <u.kleine-koenig@pengutronix.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>,
        <t.scherer@eckelmann.de>
Subject: [PATCH v2 0/1] siox: Introduce dev_err_probe helper
Date:   Wed, 16 Jun 2021 08:17:35 +0200
Message-ID: <20210616061736.3786173-1-t.scherer@eckelmann.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay34-hz1.antispameurope.com with 9338F1C9AC7
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security-Digest: cfeea059b6cdcc5544d3c400eaf4cb86
X-cloud-security: scantime:1.996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=from:to
        :cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=hse1; bh=xwm6b/Ykvlxv
        cFiQjBtAc8/Sfow4IcjSHtzojUKhZHM=; b=htnsNsJaUCr2p7oGuQIICZsVlJvB
        YgBkGTU6u7YC18zOhP8f/JpghlyMZLBv8i9kuIG781SmtCwEZhXqR9ktQe1X6mEU
        yVtMzEd0qoD65qiooB5Pk0TIIOZ+IMMKe4G3I7K3Cne86t5fIBrKymsdfvvCBlTE
        lYfJmiDTGeQzo8doqqgY+fmbl2qAuVm8++vSN0wcq4Fc+1Ftvlopsw9p7Gadu0VD
        cFFsmFtmU5YNRiGIasYDanJ0i+MQRFD6twOJpeU7P8jd8y3J8xMoNm6Ts6jSkBeH
        4F+N/9g0R4A0n8UJGbufWnk+FqjROy1R/wAv8vVBn5TuEkDQMKbqwjsKzA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces dev_err_probe helper in siox-bus-gpio.c

Changes from v1:

- fix commit message according to checkpatch.pl
- remove company footer
- fix whitespace issues

Thorsten Scherer (1):
  siox: Simplify error handling via dev_err_probe()

 drivers/siox/siox-bus-gpio.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)


base-commit: 009c9aa5be652675a06d5211e1640e02bbb1c33d
-- 
2.29.2

