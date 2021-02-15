Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE43631BEA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 17:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhBOQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 11:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhBOPec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:34:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 242D464D73;
        Mon, 15 Feb 2021 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613403079;
        bh=dACru+gUfduSOq5EB+QEW9TH3jOVxOqbtC9N461KR3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IicVZT+Fhkn0eg64Yw+YUpZxeGvEq6/JtJVr3svCwnOAkzZbAQNTslttYfhso2wFf
         PpQxoQBo4ofsvglStktyOPltoAurXmSQ0mnC8QdM/AuePyehoAVxZBncILTwr8Zeki
         ahybPvdDpgYsoBP+CvD1IYV+Trimda0cTJtdvoTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 5.10 002/104] Revert "dts: phy: add GPIO number and active state used for phy reset"
Date:   Mon, 15 Feb 2021 16:26:15 +0100
Message-Id: <20210215152719.537396822@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210215152719.459796636@linuxfoundation.org>
References: <20210215152719.459796636@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

commit 3da3cc1b5f47115b16b5ffeeb4bf09ec331b0164 upstream.

VSC8541 phys need a special reset sequence, which the driver doesn't
currentlny support.  As a result enabling the reset via GPIO essentially
guarnteees that the device won't work correctly.  We've been relying on
bootloaders to reset the device for years, with this revert we'll go
back to doing so until we can sort out how to get the reset sequence
into the kernel.

This reverts commit a0fa9d727043da2238432471e85de0bdb8a8df65.

Fixes: a0fa9d727043 ("dts: phy: add GPIO number and active state used for phy reset")
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -90,7 +90,6 @@
 	phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id0007.0771";
 		reg = <0>;
-		reset-gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
 	};
 };
 


