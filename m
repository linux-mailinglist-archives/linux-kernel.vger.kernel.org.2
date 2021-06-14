Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC03A6A41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhFNPaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:30:01 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:38789 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbhFNP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:01 -0400
Received: by mail-ej1-f48.google.com with SMTP id og14so17361868ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnEYReqR+cI+gE+ju6owVofmrTcM+yCqxJZibfOKDI4=;
        b=13RepUwTqjCzq+bQVIvqoVIfpKo4+cF4//gn31kXJKDfzmm6ts7VAXn4RcR+2Lg8fH
         doPvBOSC3HtXSpbSi21IMyrSqngmkLOFFk/pid9fiitv5fshJI6BYGLVXrLexGn06fWM
         JTaGUDzwC/USyRx60+sv5FX8fI0xdNU4jsZ+yeaC/SpMuHkzdqID4CWPWHLwCUkptzV2
         Q8fqnq4gO9VtOnkuMRIoJwMvNdmrsmTkPsMyYPESupyRL/UPyzWqu+JUVjzR4LMAk2l+
         iBv6DpDMOyV3dJBQc7SuyMcfL3hhesuljj5JaFhJUnoAWPWuwBIGzmAU0WAHSW7MFq72
         cqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jnEYReqR+cI+gE+ju6owVofmrTcM+yCqxJZibfOKDI4=;
        b=gVGTMYz+tqSCMcYvH0PgcwejX/Qb3qwyGCw/HxLdTVMDNkPBB2k08IgyTqhUEncD9Q
         mXz9U7DMF9eYCOfPw/26a6PJ5BED29Yfs2skSzC9gfXM1i4XoujYo4EGn33jAdU8yhEz
         Dl8VOtjJYhuFXEuEriJ7mSdhM98wjFByxUOJUNoD0OcH4v9X5JeIMP4COh2U831rLYxY
         n22nOpDsoVF986DXHZvoMRAd/pbSmHhyr996ceOZg1DTWCevdFSG89jBBlPN68PDnZFd
         /w/XDbD8jewQoYO5bY1DrDTeOLsUj6cJ4hLvmcIsHY9WE1ICMf+uI66egrnwiVY6r0lL
         AlSw==
X-Gm-Message-State: AOAM5319tSHFw50nUELRtGrfNAQYTAKyJNZxI18l2Sr5KSQbpb5obTeI
        oPk472cyZs+TErkKj7DB6h4QuTiIvHzVvRNf
X-Google-Smtp-Source: ABdhPJz7pz9chO4ptu/kSV6wj52lKKbfEFleZclTccODH2NAqPpy+vbAUsGkKuGBX8XeAUPjxhZLAA==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr15687869eja.275.1623684357894;
        Mon, 14 Jun 2021 08:25:57 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id l11sm8813696edb.3.2021.06.14.08.25.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:25:57 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/33] arm64: zynqmp: Disable WP on zcu111
Date:   Mon, 14 Jun 2021 17:25:18 +0200
Message-Id: <88e41d4f5c6a7353762bd5ad38b92ce352c3a123.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this board there is SD slot without WP connected.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 0bf29ff9c714..e646246a3b14 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -796,6 +796,7 @@ &sdhci1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	no-1-8-v;
+	disable-wp;
 	xlnx,mio-bank = <1>;
 };
 
-- 
2.32.0

