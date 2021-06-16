Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C33AA622
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 23:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhFPV2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 17:28:51 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:46727 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhFPV2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:28:50 -0400
Date:   Wed, 16 Jun 2021 21:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1623878769;
        bh=/1nRiRUX9axadqDnig3IJyEGOizd/7oBJbG9RUFxBfE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=asPDH5pF0zcGtWP3tfIQDKCKQ/T96uBt/xYxkbdpYlBaiuzZgUtj4qZynsaFAf1D6
         5rljawhcKHEQR6m5LHke7cAazHgfnRiz0BdkmGl4ArKjAWDvYQ+7b9k5bk7uTXaJOf
         9uIoM6v68jsTKYxzkguZQrDEyusgfDnNhqRiznWY=
To:     gregkh@linuxfoundation.org
From:   "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Reply-To: "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Subject: [PATCH] staging: ks7010: Wrap macro definitions in parenthesis
Message-ID: <20210616212552.117604-1-calebdsb@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the definition of TX_RATE_* constants in parenthesis to prevent
incorrect casting during expansion, as recommended by checkpatch.pl.

Signed-off-by: Caleb D.S. Brzezinski <calebdsb@protonmail.com>
---
 drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks=
_hostif.h
index 39138191a..c62a494ed 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
 #define TX_RATE_FIXED=09=095
=20
 /* 11b rate */
-#define TX_RATE_1M=09(u8)(10 / 5)=09/* 11b 11g basic rate */
-#define TX_RATE_2M=09(u8)(20 / 5)=09/* 11b 11g basic rate */
-#define TX_RATE_5M=09(u8)(55 / 5)=09/* 11g basic rate */
-#define TX_RATE_11M=09(u8)(110 / 5)=09/* 11g basic rate */
+#define TX_RATE_1M=09((u8)(10 / 5))=09/* 11b 11g basic rate */
+#define TX_RATE_2M=09((u8)(20 / 5))=09/* 11b 11g basic rate */
+#define TX_RATE_5M=09((u8)(55 / 5))=09/* 11g basic rate */
+#define TX_RATE_11M=09((u8)(110 / 5))=09/* 11g basic rate */
=20
 /* 11g rate */
-#define TX_RATE_6M=09(u8)(60 / 5)=09/* 11g basic rate */
-#define TX_RATE_12M=09(u8)(120 / 5)=09/* 11g basic rate */
-#define TX_RATE_24M=09(u8)(240 / 5)=09/* 11g basic rate */
-#define TX_RATE_9M=09(u8)(90 / 5)
-#define TX_RATE_18M=09(u8)(180 / 5)
-#define TX_RATE_36M=09(u8)(360 / 5)
-#define TX_RATE_48M=09(u8)(480 / 5)
-#define TX_RATE_54M=09(u8)(540 / 5)
+#define TX_RATE_6M=09((u8)(60 / 5))=09/* 11g basic rate */
+#define TX_RATE_12M=09((u8)(120 / 5))=09/* 11g basic rate */
+#define TX_RATE_24M=09((u8)(240 / 5))=09/* 11g basic rate */
+#define TX_RATE_9M=09((u8)(90 / 5))
+#define TX_RATE_18M=09((u8)(180 / 5))
+#define TX_RATE_36M=09((u8)(360 / 5))
+#define TX_RATE_48M=09((u8)(480 / 5))
+#define TX_RATE_54M=09((u8)(540 / 5))
=20
 static inline bool is_11b_rate(u8 rate)
 {
--=20
2.31.0


