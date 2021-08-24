Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B69B3F5C91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhHXK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236432AbhHXK7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:59:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E208B61245;
        Tue, 24 Aug 2021 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629802746;
        bh=Vawa6oNf/qywpUeZOPhFbgeDbnaj70yMhZjtk5Y35p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RR3N3RB/bbWrGQGQoiAq2tIZ4qobdPE9NDxWPgYy/TcMpHCvdmOvdgYcNBvxGajGI
         DKXfayNfzmTkHlMrI3UvxymWKn9a+NkqUBcIGzMenDjAdmWkfiJloaPhR9MOX6auV6
         aqeXXQ7UftBHqjXkms7j9sbcicvNRXG/ZUKnNbI5Iwga+Z7KedQQ2oVu9RQFC6iMjz
         xDWvS8Wfe+/6gtMy1rLtRssB6AzY7/rW484HJ2H8aJKkNv9Dvu8jgOYlJPz9+G4j9l
         88f4cJzl7UwlnJXDEOnHwAWmxfR1bEg6beMcQFYPttK6Mvi6wcubrg9BCer+H+xM3P
         uOZ7LOU7Rr4Vw==
From:   Roger Quadros <rogerq@kernel.org>
To:     ssantosh@kernel.org
Cc:     nm@ti.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/2] ARM: dts: keystone-k2g-evm: Fix dss node status to "okay"
Date:   Tue, 24 Aug 2021 13:58:58 +0300
Message-Id: <20210824105858.19496-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824105858.19496-1-rogerq@kernel.org>
References: <20210824105858.19496-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Device Tree Specification [1], the status parameter of nodes can
be "okay", "disabled", etc. "ok" is not a valid parameter.

U-boot Driver Model does not recognize status="ok" either and treats
the node as disabled.

[1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index d800f26b6275..57680323e202 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -534,7 +534,7 @@
 &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = <&vout_pins>;
-	status = "ok";
+	status = "okay";
 
 	port {
 		dpi_out: endpoint {
-- 
2.17.1

