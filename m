Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E233634A7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhDRKhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 06:37:45 -0400
Received: from mout02.posteo.de ([185.67.36.66]:55287 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhDRKhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 06:37:42 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 882EE2400E5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 12:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618742232; bh=SAqTuehql45q0JuTWZy7CNkejtygzl6s6w7GoFO9cYk=;
        h=From:To:Cc:Subject:Date:From;
        b=QTx6x+wTZdmP/Ziz65TkISroKprZ7yx7srVE5lpX1MMaFA/eQnSQ7LdJeLkTbNvZ7
         aTpeLN1YUU1xXxyDGKeg/QUF7RjkmmjKi8OjxlwldhwO4Cx3SMQMBBqEcMaXE9lf7K
         SFVtu6uO4TiLzC3FWfh4LAeHH1BT052GlRktTfjoH/nin6Nxnid3vPHcQO9X+XEmn1
         UnDvHcC3xKrnhyyw8jmBfc5wKIEy66VD7BU4mgAo6Bs4sP53U0iqhP9PbkYrLxC3ne
         TkaLn0hZ8yhNpTZZWMA1EG8j643d5hblIaDuqrelb18PG2dfgfzVdo5DB+4aFrIC4a
         V3lL+Rf5n/4sw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FNRGH3q8yz6tmK;
        Sun, 18 Apr 2021 12:37:11 +0200 (CEST)
From:   Sebastian Fricke <sebastian.fricke@posteo.net>
To:     linux-media@vger.kernel.org
Cc:     Sebastian Fricke <sebastian.fricke@posteo.net>,
        Helen Koike <helen.koike@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: rkisp1: rksip1-capture.c: Improve comments and fix typos
Date:   Sun, 18 Apr 2021 10:34:25 +0000
Message-Id: <20210418103425.45525-1-sebastian.fricke@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the wording of the function description to increase readability.

Fix three typos:
s/during processing a frame/while processing a frame/
s/it also update/it also updates/
s/there's not buf in shadow/there's no buffer in a shadow register/

Replace the abbreviation 'buf' with the full word buffer, the
abbreviation 'config' with the verb configure, and 'regs' with registers.
The goal of this change is to ease the reading flow of the comment.

Signed-off-by: Sebastian Fricke <sebastian.fricke@posteo.net>
---
Side-note:
I also believe there should be a description for the abbreviation FE, as
it is not described anywhere. I think it means frame end, right?.
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 5f6c9d1623e4..9643bdd05b7b 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -830,8 +830,8 @@ static void rkisp1_return_all_buffers(struct rkisp1_capture *cap,
 }
 
 /*
- * Most of registers inside rockchip ISP1 have shadow register since
- * they must be not be changed during processing a frame.
+ * Most registers inside the rockchip ISP1 have shadow register since
+ * they must not be changed while processing a frame.
  * Usually, each sub-module updates its shadow register after
  * processing the last pixel of a frame.
  */
@@ -847,14 +847,14 @@ static void rkisp1_cap_stream_enable(struct rkisp1_capture *cap)
 	spin_lock_irq(&cap->buf.lock);
 	rkisp1_set_next_buf(cap);
 	cap->ops->enable(cap);
-	/* It's safe to config ACTIVE and SHADOW regs for the
+	/* It's safe to configure ACTIVE and SHADOW registers for the
 	 * first stream. While when the second is starting, do NOT
-	 * force update because it also update the first one.
+	 * force update because it also updates the first one.
 	 *
-	 * The latter case would drop one more buf(that is 2) since
-	 * there's not buf in shadow when the second FE received. This's
-	 * also required because the second FE maybe corrupt especially
-	 * when run at 120fps.
+	 * The latter case would drop one more buffer(that is 2) since
+	 * there's no buffer in a shadow register when the second FE received.
+	 * This's also required because the second FE maybe corrupt
+	 * especially when run at 120fps.
 	 */
 	if (!other->is_streaming) {
 		/* force cfg update */
-- 
2.25.1

