Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF53F49E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhHWLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbhHWLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:34:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC4DC061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:33:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id q3so25737544edt.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2okYUf1AtblKbXwagU9YAK3CN+7qGUOMB9Z5HBBHko=;
        b=A+Ladic4SYAhhQwxbEd6g9Zl+UDI2GpD0djH9z3bsHqLihU08PgqEj53L22qkk1595
         2hNEFm6lUpTJmjcRd+lNu9KJ3eAWga8UwRTxhSeq/4R8WoR/WOiHE7JAtIXCClQvHulY
         xODStzP/LuWGcIhIR+GCljJ1FFt+bOYqntEQe41zo9PapW+aIBupXaShv0TJIJ0FqExs
         nhz+nL8HrLoXwabDSTiXxF84X3HluqH627NjG2APmcylAs/jLxT5H2P+EbMJR/Mmz7SZ
         BVzCxg1j655HKbiR/7RgTDdGclBlZg7uMw1OFITgM7jC+j1ssffILbANKyOQZ2NSmooZ
         A6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=C2okYUf1AtblKbXwagU9YAK3CN+7qGUOMB9Z5HBBHko=;
        b=Z3Sc66kLVtiR8VVT0TXubbJ1GDW0uZmLhhNLJF7Nqloke/YU9QIbOAPcWhj/S9WClr
         8ySWhnjlYHZOuMU78fFN1T08gwqyqDdExExjA2Cf33o6MfDwkxuTjLvp143JsD+fT8kq
         PAZxWChnlQ5RjelT3joe3w2qNTVOJXOIIcjgW3q4o4pcCxcMBWAh9ew8oR8lHcEMymG4
         sa54HQut0qVnhT3+8VuwiP4scca4eC9Ok9QgicWvgKxXTSWbyG9vEeTwsVo5YNI9OWRl
         bUiXv6jQBMFfZ7H7k8kmQMzuYd3OQl8WNZTpjF+eDgt7tU7hWAXRuKShalaFORIEdWIw
         Tc0Q==
X-Gm-Message-State: AOAM532wzh7e2FdROqwqnnCeHU3QxOSBdVgDd2Du1CjmlStvjN+J2qzL
        Qde4uMFC4ZzmayJFLyJAJwYkp2iJDracRbFO
X-Google-Smtp-Source: ABdhPJyPqe+s/qFujaqzUWX1M4ldSixz6qi10KOX3mjL3/Q1Xe70hxlcXOID7+5ApG++uzAz9Tx0rA==
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr8536169edz.171.1629718432382;
        Mon, 23 Aug 2021 04:33:52 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id v23sm9014840edy.21.2021.08.23.04.33.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Aug 2021 04:33:52 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, sboyd@kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: zynqmp: Fix kernel-doc format
Date:   Mon, 23 Aug 2021 13:33:47 +0200
Message-Id: <26526e144296373b2c75e75865dd023158f9bfc7.1629718424.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align structure and function names with definitions.

Issues are reported by kernel-doc script as:
drivers/clk/zynqmp/clk-gate-zynqmp.c:24: warning: expecting prototype for
struct clk_gate. Prototype was for struct zynqmp_clk_gate instead
drivers/clk/zynqmp/clk-gate-zynqmp.c:75: warning: expecting prototype for
zynqmp_clk_gate_is_enable(). Prototype was for zynqmp_clk_gate_is_enabled()
instead

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/clk/zynqmp/clk-gate-zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
index 695feaa82da5..565ed67a0430 100644
--- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -12,7 +12,7 @@
 #include "clk-zynqmp.h"
 
 /**
- * struct clk_gate - gating clock
+ * struct zynqmp_clk_gate - gating clock
  * @hw:		handle between common and hardware-specific interfaces
  * @flags:	hardware-specific flags
  * @clk_id:	Id of clock
@@ -66,7 +66,7 @@ static void zynqmp_clk_gate_disable(struct clk_hw *hw)
 }
 
 /**
- * zynqmp_clk_gate_is_enable() - Check clock state
+ * zynqmp_clk_gate_is_enabled() - Check clock state
  * @hw:		handle between common and hardware-specific interfaces
  *
  * Return: 1 if enabled, 0 if disabled else error code
-- 
2.33.0

