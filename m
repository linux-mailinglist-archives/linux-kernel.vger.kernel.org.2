Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B2245CBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbhKXSN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:13:56 -0500
Received: from mail.pr-group.ru ([178.18.215.3]:54992 "EHLO mail.pr-group.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350348AbhKXSNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=e6TOCjRJbJandG+35LvQLQPU70j05e55WPIfdzIeEcI=;
        b=ixRWon7Aihsy9Hoj3wK7pH7QxdGYjPt0m2n2HGvkDf1MVaO6yJmxP7St/uWRxiV77VlHK3LWT+GWk
         IbB/cbTOwzRJu6AlX0A0QcpaZDQ0hdQqqeWanf3NRwajqekcY6KzZx1dPsyR6OXUuCCQ4OfyKONak7
         dhSwkxpF2hRJolp3Cco9GaasS4MoR2OeCyvvEL79lR/6x2Hdl4LJOOgYaY/R8wn3l3PwCim4lvd0PR
         fVDz1P9MtKy0bbb04A5jy3O6n9DOjlDv8fLeQ3JYowPP7LxX4T0hzc+Qe4PCTZgm0Eyq7wiC+1XHBx
         eo7REBBDoC1/cmjDe7GNyraRik7yCFg==
X-Spam-Status: No, hits=0.0 required=3.4
        tests=BAYES_00: -1.665, CUSTOM_RULE_FROM: ALLOW, TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.66.213.198])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 24 Nov 2021 21:10:19 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, system@metrotek.ru,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] bus: imx-weim: optionally enable continuous burst clock
Date:   Wed, 24 Nov 2021 20:55:40 +0300
Message-Id: <20211124175542.2772-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce option to enable continuous burst clock, if burst clock itself
is enabled.

Changelog:
  v1 -> v2:
    * documentation about this option added to
      Documentation/devicetree/bindings/bus/imx-weim.txt

Ivan Bornyakov (2):
  bus: imx-weim: optionally enable continuous burst clock
  dt-bindings: bus: imx-weim: add words about continuous bclk

 .../devicetree/bindings/bus/imx-weim.txt       |  5 +++++
 drivers/bus/imx-weim.c                         | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.32.0


