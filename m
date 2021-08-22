Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088853F3D7C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 06:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhHVEPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 00:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHVEPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 00:15:00 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014F6C061575;
        Sat, 21 Aug 2021 21:14:19 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4GshpJ6fHzzQk3j;
        Sun, 22 Aug 2021 06:14:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1629605655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpRlG5MqIG/F4622ScTOdfuZ4bsOknUt+3o0exi/l40=;
        b=I99RWDYF/bsIVjXTq1x3pIoRSdchsNNgkzDO9EP7TTJHuKjlTEHxeo9B95jvYPu1zKsFni
        sJDJKQWuqnoDP3DSggm1I8G/ziXaWvwpJ5bHzJqz1qRlRK7YPSOjMUF/7cLSz1sNvMHJ8R
        EcjZZqNBv6L4kkbcuYggPmzo5RZbVQxl3cR/8q5EPEJg0wEvJDSFY9kz5FPERqZLwmShwY
        wmM3xpb87DtlaqboZ6fGVTE1B4hByBFZdb2PGvNsxCdkQe6RkkzLdcE5yZVCElxD3Ouhk6
        9392+A6ZROHxe7g51TMJB3ngGPhj8mc3O8Uuijn9+/vT1XH/M9CRbCx4Dt7kUw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id rR8IlFxswEMY; Sun, 22 Aug 2021 06:14:13 +0200 (CEST)
From:   Sungbo Eo <mans0n@gorani.run>
To:     linux-mediatek@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH v3 0/1] Add MUSB for MT7623
Date:   Sun, 22 Aug 2021 13:13:32 +0900
Message-Id: <20210822041333.5264-1-mans0n@gorani.run>
In-Reply-To: <20210808123840.176738-1-mans0n@gorani.run>
References: <20210808123840.176738-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BDE161899
X-Rspamd-UID: 33c264
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for the MUSB controller on Mediatek MT7623.
Tested on Mercury RUSH-318AC Wi-Fi router.

v3:
* dt-bindings
  * remove the queued patch
* DTS
  * remove unnecessary status=okay from u2port2

v2:
* dt-bindings
  * add reviewed by Matthias
* DTS
  * rename usb3 label to usb0
  * move usb0 & u2phy1 nodes to the right sorted place
  * disable u2phy1 by default
  * correct u2port2 node name to match its reg address

Sungbo Eo (1):
  arm: dts: mt7623: add musb device nodes

 arch/arm/boot/dts/mt7623.dtsi  | 33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi |  4 ++++
 2 files changed, 37 insertions(+)

-- 
2.33.0

