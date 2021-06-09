Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A513A1333
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhFILsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbhFILsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F9C061795
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:46:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l2so25156665wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJFcESfNmuqpnzQeAxiF3OgzwQNYMvErOvMnIEXFWso=;
        b=0m6BMX+hvJl2iXhnYa7iPaGeS4es8Kt3pe3NumpAq4uCFqrPsVn2LwkKHM/PAI9VeD
         YA9zpilalIW2iMXDCtef3p1JwJV5uEduadwiVm4SBpQAIpjIf9rwobQxgWl706DLrpgK
         ZUptGOuem+gWhNI9aT4LRxbDVh8fv7LhnO1ImwZmYy25lzMssvgAMTUbdCO3t8vWaPXP
         he+uuEhW8dyBneqZ4FmyLujwSP81VbN1S0e5FvX3z17XhTjJrSC2IXXwK+2uy49oZicL
         qMe1lMAXvADLTU+9/TOk1H1qlkrffKM9er/Du0QzKmPUWNfDWeHJ+vr7/GRkQDS4dLXX
         E+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nJFcESfNmuqpnzQeAxiF3OgzwQNYMvErOvMnIEXFWso=;
        b=lq9wDIHLdecrs2EYWmDDHHzGKp9DQsBEeVJkAmMOq38nOvwEiTzPK4y0ZHkKy0EJRg
         34X2U56Gnf1n5LZ6ZpsI4lJKnC6jA3xXuy1VnAdl7mBO95cHhfg045ZhFV9x9RvVQguu
         f1WiBv3R+IVOFiUNvYQ3gxPvWFJQMCRYy8pGP/+SI6AjHK54qjaX+S/TjRpJcZWr4q6K
         2OG8Vz49q4ebd38VZHyjF9PGz101Guwki2hZCHheEQrb/J9c9AkMpkUroG08hwyX9OYb
         18OQV+JxB22+L2M+OHn0JJD+7HmJeXKan3oa9gOjJApfbN7tBQKfUqKXO6J95Hg3UMOW
         AU/g==
X-Gm-Message-State: AOAM533SfqCA+QK00zRfMRLJ0Y4F5S9C4MAqYZlMERSQXxMc63Bs0tCQ
        gFucXUgYoEd67tJTcIYfGQ21SkpcmWM5UQly
X-Google-Smtp-Source: ABdhPJwCyL97mdno19WFYlv8tJ9mnEcNXdfLVtVESfF8bMDKokS9YwVTG4/6DySDpifCcxHhsRG2ug==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr27755410wrw.57.1623239165804;
        Wed, 09 Jun 2021 04:46:05 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id m22sm5659459wmq.21.2021.06.09.04.46.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:46:05 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 26/31] arm64: zynqmp: Move rtc to different location on zcu104-revA
Date:   Wed,  9 Jun 2021 13:45:02 +0200
Message-Id: <d836bc85e64610fba148c66154f97f4aff49388d.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move it the same location as is on zcu104-revC for easier comparison.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 84c4a9003e2e..048df043b45c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -417,10 +417,6 @@ conf-tx {
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &psgtr {
 	status = "okay";
 	/* nc, sata, usb3, dp */
@@ -441,6 +437,10 @@ flash@0 {
 	};
 };
 
+&rtc {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 	/* SATA OOB timing settings */
-- 
2.31.1

