Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B981931EB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBROzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhBRMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:54:19 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA233C0617A9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:42:33 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id p8so1108552wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=12xH3yyVOIuqoskf7QIx7KU01U1JfoKfQv8+ls70s5Y=;
        b=CyA8njneqzwx2QyxmhsXyAbAj6GktuUw2eXrjvynifGNMjgoD6ihUmf5ciLkaJelpg
         8mU2Ld78RXoaSrF3pl11AKBVFMldWipzz14CMefIocrk+nzHOz3kvIAlu6UZh3W5mhZW
         us1wcIyJUZYkYnOcALoaoe9FOu5MPpV7GEC5owLBDvv3iEgcXzCXtaycTIYttQZbkFww
         Ku2MIfXssrHvrBFmQkNrcglySF9UBK+jcKeXwC9pSNxV0ifpLnaQn2bubwfrWnXI2ZDz
         K8WJ8O+3KFZuA3Y9i+eyIdvLdTjrHlr7NZ69eSGjI/xIhuqgQEU3hJBu5VQ4GTQ5kinU
         ySLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=12xH3yyVOIuqoskf7QIx7KU01U1JfoKfQv8+ls70s5Y=;
        b=s21E6qANqH+owKRQy5xj+jku5In3tqzvVlEpZyVr/fK4cWiLSgoFGN1qSTonvWfOTJ
         W401b3m2Kt0TAW90qOtqBW/LwdEfJHuYTBFUe0vcopfq/zFhnDgklbAgYgby7dW45Brd
         qXsxMbCZfQp6cQFS0IWqpSCNqkQAOjbUnD/MOyG96D3mffdC/h8aQNH1ltbgDzckqf/y
         Z1dIslXlSLbyUOAGahUIbZWxJBEZwdWfxYSMq1BIkwZ+/GunCIJX3ChLpLUe1AY8Oo1W
         GpW0R8S4iAUF9q3H/CYjgKCgyczRjHnrVPeB+coKDhaUEQ4NayxI7a1DVIDBk4aVuGBe
         Lc7A==
X-Gm-Message-State: AOAM531yspVsIzuF5pokG6LB/bM6UHXYrdcPd5w3OfApVEQAf656G/U3
        aLZyjdt2lDe8KMokuOuT2d0wqLDtfJw=
X-Google-Smtp-Source: ABdhPJyiVzxI0YDISQjX2JBs62xB/E9eeIJjHXfwdsQddnhZzCp5OUmTVJXXsb4k3DDzpTQSBkI+6N7B50k=
Sender: "gmouse via sendgmr" <gmouse@gmouse.zrh.corp.google.com>
X-Received: from gmouse.zrh.corp.google.com ([2a00:79e0:42:200:f532:e78:dab6:4447])
 (user=gmouse job=sendgmr) by 2002:adf:ec82:: with SMTP id z2mr4277790wrn.16.1613652152566;
 Thu, 18 Feb 2021 04:42:32 -0800 (PST)
Date:   Thu, 18 Feb 2021 13:25:46 +0100
Message-Id: <20210218122546.3546582-1-gmouse@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] ARM: dts: nuvoton: Fix flash layout
From:   gmouse@google.com
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "Anton D. Kachalov" <gmouse@google.com>, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Anton D. Kachalov" <gmouse@google.com>

This change satisfy OpenBMC requirements for flash layout.

Signed-off-by: Anton D. Kachalov <gmouse@google.com>
---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 28 +++++++----------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index bd1eb6ee380f..741c1fee8552 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -182,8 +182,8 @@ bbuboot2@80000 {
 				reg = <0x0080000 0x80000>;
 				read-only;
 				};
-			envparam@100000 {
-				label = "env-param";
+			ubootenv@100000 {
+				label = "u-boot-env";
 				reg = <0x0100000 0x40000>;
 				read-only;
 				};
@@ -195,25 +195,13 @@ kernel@200000 {
 				label = "kernel";
 				reg = <0x0200000 0x400000>;
 				};
-			rootfs@600000 {
-				label = "rootfs";
-				reg = <0x0600000 0x700000>;
+			rofs@780000 {
+				label = "rofs";
+				reg = <0x0780000 0x1680000>;
 				};
-			spare1@D00000 {
-				label = "spare1";
-				reg = <0x0D00000 0x200000>;
-				};
-			spare2@0F00000 {
-				label = "spare2";
-				reg = <0x0F00000 0x200000>;
-				};
-			spare3@1100000 {
-				label = "spare3";
-				reg = <0x1100000 0x200000>;
-				};
-			spare4@1300000 {
-				label = "spare4";
-				reg = <0x1300000 0x0>;
+			rwfs@1e00000 {
+				label = "rwfs";
+				reg = <0x1e00000 0x200000>;
 			};
 		};
 	};
-- 
2.30.0.478.g8a0d178c01-goog

