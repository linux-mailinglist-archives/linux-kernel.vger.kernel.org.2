Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D833A132D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhFILry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbhFILrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:47:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E05DC061789
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z8so25088186wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JCtkr0FGIEXKuw/IKBQwL2IYtCBmYOG1gCclNZ1TnYU=;
        b=y/mvR0subgYPyYXBYPaJexgznZC0QLJjB3kL6lFfxVkhCZfjFHK8LLO40xa3Gbxd+y
         /u7jn/7ay9PnzimGWsJpuEGms488GU7Ol0o2xsqtoXCXYVQG6HkQmP1QgSZOJRRKhY7R
         q1easU4gl4Uy/KAO9vANmO5w8rK2/XbYz21LvzTXYY6NZ/3EL84KsVd3VsaP3uLh+E6h
         LIWKt2gp332pQnvclx1UoEaUXeX9+M+/8Kb4WMte7Fe1uBHM5VRv9W3jyEu/o+FRZ9NR
         DQ/fLTAy2UNgdQeb9+1n7ffChGIgFzjkCNFJQ7lTQvuk4n9fIif8jHDa9U4msORNctCM
         xkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JCtkr0FGIEXKuw/IKBQwL2IYtCBmYOG1gCclNZ1TnYU=;
        b=VtwRaDDdrUrkmwrNsXBD5NhLDXgnYdIkYXRHENWtsNm+wY+R2aTNEnyRELReuSHNvL
         CavMVat6LrZ+X9QjxLPX58kUumiGxmrGs/EIIzFqxUUDT2kS4EXqMTzrU+aDE4MARo2Y
         /Ysf+nZsWQ/2nxRp5k7j3hcf74yJEHs7oypBb/Ba7PklKcRItWLMcwXZdwB1xssa+Ma5
         JKghDta8wyAA2IZ+jqjOqMYea2KhTyaSqVv9RQIb3sEdV2rl7kwOVa7OzI2yPlvkL69i
         Jx2ez8QsMMjiQHiVEW3szrfMakCKPdJo+bgba/xSg5I2G7lPWVBHO2UWhUaVCw9c982w
         c6JA==
X-Gm-Message-State: AOAM531Ik7xPPSzCMR6UDtJ5rVk0O37ZKFGALPNPArdF5Vfh833CbcZO
        GtttCuhN+vm0VA0kgiEBPJBq2E3Zrh/ABmok
X-Google-Smtp-Source: ABdhPJzH/elHnu+qP+OUwArp737SBD9wh0zDvmqjdX04gYArHrXqKSpb+WnzgxrytDf54IQjAZ3BNA==
X-Received: by 2002:a5d:46c4:: with SMTP id g4mr28852302wrs.308.1623239155524;
        Wed, 09 Jun 2021 04:45:55 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id 6sm21231031wmg.17.2021.06.09.04.45.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:55 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 20/31] arm64: zynqmp: Remove can aliases from zc1751
Date:   Wed,  9 Jun 2021 13:44:56 +0200
Message-Id: <475a60fc4d01ba9c61579801fb84620b6905dcad.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Networking subsystem is not using aliases that's why remove them for can
devices. There is also no any other Xilinx ZynqMP DT file with them.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 4b4c19034fe1..cd61550c52e5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -19,8 +19,6 @@ / {
 	compatible = "xlnx,zynqmp-zc1751", "xlnx,zynqmp";
 
 	aliases {
-		can0 = &can0;
-		can1 = &can1;
 		ethernet0 = &gem2;
 		i2c0 = &i2c0;
 		rtc0 = &rtc;
-- 
2.31.1

