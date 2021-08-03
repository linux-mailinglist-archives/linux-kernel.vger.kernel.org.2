Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0773DF12C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhHCPOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbhHCPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:14:30 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9DC061757;
        Tue,  3 Aug 2021 08:14:19 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4GfJLb6TSyzQk1r;
        Tue,  3 Aug 2021 17:14:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1628003653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jpnrv079HohfYHZxHFOih7cazCqNwznCHGvgjVDV5OI=;
        b=cPSRzG5fVE5ANJTePkpxHl2VaB6rm+S7H32l68zL0PeiJ3pUG7IcAkHjCICir+jPJ+D8yp
        BwVW8r15/M6T0RJnyHVDEMIQvtVmUvPMyikjhFbxNsb1puF5Yi3zEHQJzRRsplkAvDDZC6
        MM5U41bztqUj6wFJ3P35dP/T2CWTBmwes7oZZYvFGxg76IKkrgRXqfUg8oO3OMgKdqR0kk
        P+/+EXvUPz3BmGQ0E4ogzwoyD/R9hMsrHFOoQX36+4RCUjJOPsyKYLyMGmz9S5kIOCJ/8u
        PKW/bbrPWTNrpiaa8nDBVEmlgiZ5oFyw2Oiru+sZT27nMrKZTJmeGEEKu9XCpA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id eYw7Q2qDqF7P; Tue,  3 Aug 2021 17:14:12 +0200 (CEST)
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
Subject: [PATCH 0/2] Add MUSB for MT7623
Date:   Wed,  4 Aug 2021 00:13:18 +0900
Message-Id: <20210803151320.71531-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 887F618BC
X-Rspamd-UID: ef8fb2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for the MUSB controller on Mediatek MT7623.
Tested on Mercury RUSH-318AC Wi-Fi router.

I got to know this from a BPI-R2 forum post [1], and managed to make it work on OpenWrt snapshot.
I'd like to know if this also works on BPI-R2, I can happily share the details if needed.
And I've just copy & pasted nodes from mt2701, please let me know if I missed some big differences between SoCs...

[1] http://forum.banana-pi.org/t/bpi-r2-otg-port/10551

Sungbo Eo (2):
  dt-bindings: usb: mtk-musb: add MT7623 compatible
  arm: dts: mt7623: add musb device nodes

 .../bindings/usb/mediatek,musb.yaml           |  1 +
 arch/arm/boot/dts/mt7623.dtsi                 | 34 +++++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi                |  4 +++
 3 files changed, 39 insertions(+)

-- 
2.32.0

