Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04533AF27
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCOJpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhCOJpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:45:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41821C061574;
        Mon, 15 Mar 2021 02:45:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p21so20128110pgl.12;
        Mon, 15 Mar 2021 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vc/r1SZf2IZ7nV1bAr2irLNTXEi+St+bipRP8ivkBr0=;
        b=mAwko/Z2vttz/Z6QGP81Nm9mRMZycCrh0cJU/W1l/tMAvyHH6f8BBYq5Vn8O4/Wmbt
         6m0FyMXpe23+7h2gHSfMpGvs5F/sDDxr8LPXh3gyFZUJ4wYT0/iDKEbYL9IlSHs4eDfK
         5NbRlrt5SWhxIRRzb31cUIYHgA17f3wiLDeqiUp0gsnKTDnpErDDLH0gTlXB3Oc3EMob
         L9aQrtGuFkT4ChJouVsk7JXTleFUoKjWofxCewTknChsU6NWl4mVDCTK+jsRr3fBHme5
         XeMgIBFGxlWot1gDkj5FwXVPBs/u2BrM9KWEKzkgZAvsOyDpjVQ1rJ/YDnAIWG4f1KgI
         LU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vc/r1SZf2IZ7nV1bAr2irLNTXEi+St+bipRP8ivkBr0=;
        b=YXOvFqXll3mKiklGDAFHhjr35bPuKKQZKCgFXGq/x7dJq+3JLBtoBExK04VTmxk53r
         FeWws1zxEd+XDmQCetrdvfgyJnaGQ3WpGkHrxarVyCVAc0eXAcNO2wSBdjAFgM7rPDKa
         mHaGe/dhSGdXN801vFKDpbYD+EgdT5rcs+vE/gv7OWfwMtQ6F0BRvrhNxSxdTMynFwwv
         tsxyAtuI54bOCgbXtumROZ2vO/aoX7MaD1YlQyRZo9gmedzTW9en1DTYKy7cLx2lp6gN
         0GYFhjpSGDwDrZ4lvJvNS1hR46IrYcL6q511RIISsqIiNaXY7m14ZZPTinydvr33bZnJ
         jT+Q==
X-Gm-Message-State: AOAM533FZWCp6K1B6oHy7lHUMcLZe1RBEl1pYslq/4cI0MyWmBskBItF
        s3+GTnIO/UUFEnO99BZ3H9g=
X-Google-Smtp-Source: ABdhPJwnxFoUd14+ss2MjGW9SbdJHcFT0w85HPSLEIKgurPZyn3MyEfV5upYi00EnPgwQ7Ehb2sMwg==
X-Received: by 2002:a63:c4c:: with SMTP id 12mr14612152pgm.320.1615801520863;
        Mon, 15 Mar 2021 02:45:20 -0700 (PDT)
Received: from localhost.localdomain ([120.245.122.54])
        by smtp.gmail.com with ESMTPSA id 14sm12780811pfy.55.2021.03.15.02.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:45:20 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@st.com, erwan.leray@foss.st.com,
        linux-serial@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 7/9] ARM: stm32: Add a new SOC - STM32H750
Date:   Mon, 15 Mar 2021 17:43:54 +0800
Message-Id: <1615801436-3016-8-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

The STM32H750 is a Cortex-M7 MCU running at 480MHz
and containing 128KBytes internal flash, 1MiB SRAM.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/mach-stm32/board-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index 011d57b488c2..a766310d8dca 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -17,6 +17,7 @@
 	"st,stm32f746",
 	"st,stm32f769",
 	"st,stm32h743",
+	"st,stm32h750",
 	"st,stm32mp157",
 	NULL
 };
-- 
1.9.1

