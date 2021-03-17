Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EEC33F4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhCQPxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhCQPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:53:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C7C06175F;
        Wed, 17 Mar 2021 08:53:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g15so1407326pfq.3;
        Wed, 17 Mar 2021 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TzJma49s+RTB6oWNuquYUH0UCK3pPi4jE74Lxa+Jkpo=;
        b=M2xkIHFoPJTgJmQWq07e2h5KZmfs+M1TNUfPR1Kuxg1ziOa9F22eZsySXV6gzcRvgw
         hVKtan54y5E04Fw2SEu60sx8HHGMAVBDILLyBnM7JQfxIrJy9yAduDbaY8q9efOsGP0h
         jL9B01lk2G3AAfW50AhkIGqrMYxIdIvhHLbGauFJVaDt8w45esStZmsBjuTyrrGaLSs1
         hWjgTFoLaHE3+7y4IIZlx0yMZ6HboJzhEfbgMI0olc5cER9zrWbxSlMj290jot112Nnw
         iMQZCN/sF6vWvDK/LCSkczbh1swGLV1EbETI9OklVYI7XiN6aWUaXHYFvg5oRVpVv9RI
         wTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TzJma49s+RTB6oWNuquYUH0UCK3pPi4jE74Lxa+Jkpo=;
        b=QEWD2ZAmJoPqEpteytmQVBCN56veROSshoktAPkvP+ap+PjXglYUiITJWermsy/ipb
         9uvYy4x7Js3ORCvacTxf4J1+B08YPfUqHFln/Un7DdEXyX+hQq6feVWSqBbgJrxeEG0H
         H7AOJhNKjWdKLkd+sDdw1gwhEGsMcrSPv+0rANEbWEgBXneERMG6Dd5VZRXlkDV92LtD
         AB+daafTwsqb6uj2VxT9O8BApuMFAyke8GuRYRPlTFm3X82oBbBw+u/u4+NyOIGNpJYA
         nVWxl+yPb1BFOxSgzYIZOhaf0wWuptIVikAbbDtXF4MMEZKl97UoTDDwRfQccqzILldj
         LnIg==
X-Gm-Message-State: AOAM533MJgLrYFNdOWIbR5OjPE83gLaRicHkQRsZwrOAtvQruXu3kEvu
        rPXYF46vkj7ZfZmudElketDOHVG7uocZUBev
X-Google-Smtp-Source: ABdhPJxqvbbEssEOM0FBw9OH1WHLCDfHiniG9neCI9UEqVCcpVj1pZXrg19TGLTSuHkNBQc5ME5EzQ==
X-Received: by 2002:a63:8f5d:: with SMTP id r29mr3026273pgn.353.1615995916556;
        Wed, 17 Mar 2021 08:45:16 -0700 (PDT)
Received: from localhost.localdomain ([204.44.111.4])
        by smtp.gmail.com with ESMTPSA id cv3sm3535796pjb.9.2021.03.17.08.45.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 08:45:15 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        parthiban@linumiz.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2] ARM: dts: imx6ull: fix ubi mount failed on MYS-6ULX-IOT board
Date:   Wed, 17 Mar 2021 23:45:08 +0800
Message-Id: <1615995909-6240-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch intend to fix ubi filesystem mount failed on MYS-6ULX-IOT board.

Hi Shawn,

Sorry for the incorrect commit message, could you help to update the part regard
to it with git commit --amend?

thanks.

Changes in v2:
just correct commit message, no code changes.

dillon min (1):
  ARM: dts: imx6ull: fix ubi filesystem mount failed

 arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts | 1 +
 1 file changed, 1 insertion(+)

-- 
1.9.1

