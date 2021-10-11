Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1189D428DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhJKN06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236854AbhJKN05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:26:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F9E460F35;
        Mon, 11 Oct 2021 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633958697;
        bh=LEZbhktiDsSW+AwzStPDh+VwFomRdqomqsmfTAm2/aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8cUKprreXse2sf+Od1xtI2PwfWHJEK1o0LhxjXvuXjvtKARsNBuXxxJzowHNZh9I
         2AKJ1iEMrNNbky/N5gmhCqdWeesxYR4OzP2LMF7JSTYPVy2oqSjx92arAgil2QBZTX
         b+4UFaSi207sdMjcsVAvxcTZOEv4/QLC8kM/+T0oJqjPr14yCryQgQpx8e0JpHS+oc
         QjW5U2Tnrd9MOwGz4/8RvcpncnjpOEmGsBwVDR/K4CrfiuwhhVHCJGuWhsslCEI6dY
         t0zaEzkhF5lHCU3PUpJ4DFtHfwxb+oBeQnYk1xb+BYfDBY1xkFDxDRY26EvwLPjb21
         jHM2gP0IQZRgw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 2/2] dt-bindings: update riscv plic claim-mask-support property
Date:   Mon, 11 Oct 2021 21:24:31 +0800
Message-Id: <20211011132431.2792797-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011132431.2792797-1-guoren@kernel.org>
References: <20211011132431.2792797-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add claim-mask-support to control riscv,plic don't call
unnecessary mask/unmask operations.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@wdc.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 08d5a57ce00f..f32c1792604c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -71,6 +71,8 @@ properties:
     description:
       Specifies how many external interrupts are supported by this controller.
 
+  claim-mask-support: true
+
 required:
   - compatible
   - '#address-cells'
-- 
2.25.1

