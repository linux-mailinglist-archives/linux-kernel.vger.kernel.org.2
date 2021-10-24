Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B1C438632
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 03:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhJXBfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 21:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231376AbhJXBff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 21:35:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A116B60F5D;
        Sun, 24 Oct 2021 01:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635039195;
        bh=g4gEYjcVDjH/Hy84JDSZ3sa+hoCIBLedLlux21Gvh2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wqs5CqXqnD4/ZRDPyJJppnNz2NrL+Jwf0DJO2tEy4KDfP8/9R9hh9gjgHF6SEOGKd
         ZoftxpQA8MbvPeKcKCd+F9eIH0/FOtwz8BDUOzyEGMZi5SKeYpuZHY5viuNF8qhFO/
         omGYAdoTBXlMl3xe7fN77Ym1GN6wA/gkqR7zw2U6nSPhEvWgIS6Z6NrEPZIyjCIenr
         /z7T7/qEzj/0/7/rTHTvrD0hY9AubOLKSrrEPRnKaa/BZFfsWHAyWc3k742uE57MUt
         tX6TQ6nfb9Y46dfoOXJmHFCQcT4JFulc0z/d2rPgYznTtOcfXtw4BTGePqvAw07RRG
         0wWlmd8hszNUQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        heiko@sntech.de, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH V5 1/3] dt-bindings: vendor-prefixes: add T-Head Semiconductor
Date:   Sun, 24 Oct 2021 09:33:01 +0800
Message-Id: <20211024013303.3499461-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024013303.3499461-1-guoren@kernel.org>
References: <20211024013303.3499461-1-guoren@kernel.org>
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
Cc: Rob Herring <robh+dt@kernel.org>
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

