Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8842FFE2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbhJPDZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239736AbhJPDYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:24:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A7EE60F9D;
        Sat, 16 Oct 2021 03:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634354544;
        bh=T6/kZ40mW3xUpYbbHsU2TYb0pOsp3BMjsL9hE9AMFIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTyQc1dnYk8LtKXzotya/s2dFyrrlGqgFo24nzMHFmK5+7wV7lMJwteLSQwT/UmUf
         tpblBpxSdu/KAZVbNWm2Lm68eDDPYHB3xb1JTd0TKawlQVsluggGNGkd6iP/urD5vj
         3xi6Rvhi7zJOt/1IEQsWQqffrItK9wX5zeKiUnuSutVzVTSK1Ge3aoK0AutcxM0WPD
         dCH2pRK428vPyJl+a86TfEkBnyLyTW5nz6yeXd4QEwmyBypSmSr83LQPzDmwL//BAw
         jQ2zFGPT2NLuTIdNMilcnLGvCCjYOniA2j6Ekhuc5Pd9m+pr4O49oXqgploLIy0ZE7
         if+RhhLDLzxQw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        heiko@sntech.de, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 3/3] dt-bindings: vendor-prefixes: add T-Head Semiconductor
Date:   Sat, 16 Oct 2021 11:22:00 +0800
Message-Id: <20211016032200.2869998-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211016032200.2869998-1-guoren@kernel.org>
References: <20211016032200.2869998-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add vendor prefix for T-Head Semiconductor [1] [2]

[1] https://github.com/T-head-Semi
[2] https://www.t-head.cn/

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102c35..f532a8830693 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1169,6 +1169,8 @@ patternProperties:
     description: Terasic Inc.
   "^tfc,.*":
     description: Three Five Corp
+  "^thead,.*":
+    description: T-Head Semiconductor Co., Ltd.
   "^thine,.*":
     description: THine Electronics, Inc.
   "^thingyjp,.*":
-- 
2.25.1

