Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6B45A066
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhKWKmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235604AbhKWKmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:42:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0E0F60D42;
        Tue, 23 Nov 2021 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637663954;
        bh=5L2EChCF+2eZBEBc/8ksAUoVWsgVyaLrhW586vDNNC0=;
        h=From:To:Cc:Subject:Date:From;
        b=Xp4mKv0FZ7B945r3i7SXURxoqFNE+FRsJ1k1ZmDl+u1rbLsLeLDg3UEt9AEFaYn5U
         Dr5CVx3lhVuxRAJmMqG7q/sjKBhIBKGnfxJC8DAItvpZaAOytOH8hi0/3kTf1yM4B5
         wYNePrj5F0cx0BlQVkwrrwMd+8QFWurG8I90zADNX76zX+Z+UWmPeyhzDUiwLG3kp3
         jfa8eulyb2Pi09SeCthjaDl/XDCUZVokgt7kITt3SJr2zn+50lrJSVeGy1/ThEHpB5
         JlnJ7XInvU6zNCrvkDQruw0Z74shsHh3B8/zU0dFMmpe8mLWfWJf40s/XVthK1CMTR
         eSA55DgRmsMTA==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Date:   Tue, 23 Nov 2021 12:39:06 +0200
Message-Id: <20211123103908.14220-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

This series adds GPMC and ELM controller nodes.

cheers,
-roger

Roger Quadros (2):
  arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
  arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.17.1

